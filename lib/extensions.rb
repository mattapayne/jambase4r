require 'rubygems' unless defined? RubyGems
require 'uri' unless defined? URI

#Hack URI::HTTP to include a method that gets us both the path and the querystring
#since path_query is private
module URI
  class HTTP < Generic
    def path_with_querystring
      path_query
    end
  end
end

unless Object.instance_methods.include?(:blank?)
  class Object
    def blank?
      respond_to?(:empty?) ? empty? : !self
    end
  end
end

unless Object.instance_methods.include?(:to_param)
  def to_param
    to_s
  end
end

unless Object.instance_methods.include?(:to_query)
  class Object
    def to_query(key)
      require 'cgi' unless defined?(CGI) && defined?(CGI::escape)
      "#{CGI.escape(key.to_s)}=#{CGI.escape(to_param.to_s)}"
    end
  end
end

unless Hash.instance_methods.include?(:symbolize_keys)
  class Hash
    def symbolize_keys
      inject({}) do |options, (key, value)|
        options[(key.to_sym rescue key) || key] = value
        options
      end
    end
  end
end

unless Hash.instance_methods.include?(:to_param)
  class Hash
    def to_param(namespace=nil)
      collect do |key, value|
        value.to_query(namespace ? "#{namespace}[#{key}]" : key)
      end.sort * '&'
    end
  end
end