require 'net/http'

module JamBase4R
  
  class JamBaseError < StandardError
    
    attr_reader :message, :response_code
    
    def initialize(message, response_code=nil)
      @message = message
      @response_code = response_code
    end
    
  end
  
  class HttpGateway
    include Utility
    
    def get(url)
      log_info("#{self.class.name} - Performing GET with URL: #{url}.")
      url = URI.parse(url)
      request = Net::HTTP::Get.new(url.path_with_querystring)
      response = Net::HTTP.start(url.host, url.port) { |http| http.request(request) }
      handle_response(response)
    rescue Timeout::Error => e
      log_error("Connection to JamBase timed out: #{e.message}")
      raise JamBaseError.new(e.message)
    end
    
    private
    
    def handle_response(response)
      case response.code.to_i
      when 200...400
        response
      else
        log_error("Unexpect response occurred. Code: #{response.code}, Message: #{response.body}")
        raise(JamBaseError.new(response.body, response.code))
      end
    end    
  end
  
end
