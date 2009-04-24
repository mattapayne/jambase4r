local_path = File.dirname(__FILE__)

[ 'extensions',
  'errors',
  'http_gateway',
  'jambase4r_view_helper',
  'models/model',
  'models/artist',
  'models/venue',
  'models/event',
  'api'].each { |file| require File.join(local_path, file) }
  

module JamBase4R
  
  @@api_key = nil
  @@logger = nil
  
  def self.api_key
    @@api_key
  end
  
  def self.api_key=(key)
    @@api_key = key
  end
  
  def self.logger
    @@logger
  end
  
  def self.logger=(logger)
    @@logger = logger
  end
  
  def self.configure(&block)
    raise ArgumentError.new("A block is expected.") unless block_given?
    block.call(self)
    raise ArgumentError.new("You must supply an api key.") if api_key.blank?
    if defined? ActionView
      ActionView::Base.send(:include, JamBase4R::ViewHelper)
    end
    if defined? Sinatra
      helpers do
        include JamBase4R::ViewHelper
      end
    end
  end
  
end