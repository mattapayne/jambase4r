require "rexml/document"

module JamBase4R
  class API
    class << self
      include Utility
      
      API_URL = "http://api.jambase.com/search".freeze
      JAMBASE_PARAMETERS = [:zip, :radius, :band].freeze
      PARAMETER_ALIAS_MAP = {:artist => :band}.freeze
      
      #Search Options:
      #:artist = The name of an artist
      #:band = alias for artist
      #:zip = The zipcode to search
      #:radius = The distance around the zipcode to search
      #These can be combined, although I doubt that :artist combined with :radius
      #would do anything useful ;)
      def search(search_options={})
        result = jambase_search(search_options)
        return convert(result.body) unless result.blank?
      end
    
      #Additional Filters - As above, but without :artist/band
      def search_by_artist(artist_name, additional_filters={})
        additional_filters[:artist] = artist_name
        return search(additional_filters)
      end
    
      #Additional Filters - As above, but without :zip
      def search_by_zipcode(zipcode, additional_filters={})
        additional_filters[:zip] = zipcode
        return search(additional_filters)
      end
    
      protected
    
      def jambase_search(search_args)
        check_api_key
        return if search_args.blank?
        search_args = search_args.symbolize_keys
        replace_aliased_keys!(search_args)
        remove_unnecessary_params!(search_args)
        return if search_args.blank?
        query = create_query_string(search_args)
        log_info("Calling JamBase with the requested search: #{query}")
        return jambase_gateway.get(query)
      end

      def check_api_key
        if JamBase4R.api_key.blank?
          log_error("No API key has been set for JamBase. Please set it before attempting to use the service.")
          raise ArgumentError.new("No JamBase API key configured. Please configure JamBase4R before using.")
        end
      end
    
      def replace_aliased_keys!(options)
        PARAMETER_ALIAS_MAP.each do |alias_param, real_param|
          if options.key?(alias_param)
            check_for_alias_and_real_param!(options, alias_param, real_param)
            value = options[alias_param]
            options[real_param] = value
          end
        end
      end
    
      def check_for_alias_and_real_param!(options, alias_param, real_param)
        unless options[real_param].blank?
          log_error("Cannot have both #{alias_param} and #{real_param} in search.")
          raise ArgumentError.new("Cannot have both #{alias_param} and #{real_param}.")
        end
      end
    
      def remove_unnecessary_params!(options)
        options.reject! do |key, value|
          !JAMBASE_PARAMETERS.include?(key) ||
            value.blank?
        end
      end
  
      def create_query_string(search_args)
        "#{API_URL}?#{search_args.to_param}&apikey=#{JamBase4R.api_key}"
      end
  
      def jambase_gateway
        @@gateway ||= JamBase4R::HttpGateway.new
      end
    
      def convert(xml)
        begin
          results = []
          return results if xml.blank?
          doc = REXML::Document.new(xml)
          doc.elements.each("//event") do |event|
            results << Event.new(event)
          end
        rescue Exception => e
          log_error(e.message)
        end
        results
      end
      
    end
  end
end
