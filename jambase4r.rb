local_path = File.dirname(__FILE__)

[ 'lib/extensions',
  'lib/errors',
  'lib/http_gateway',
  'lib/jambase4r_view_helper',
  'lib/models/model',
  'lib/models/artist',
  'lib/models/venue',
  'lib/models/event',
  'lib/api'].each { |file| require File.join(local_path, file) }
  

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
  end
  
end