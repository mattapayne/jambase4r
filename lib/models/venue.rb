module JamBase4R
  
  class Venue
    include Model
    
    attr_reader :id, :name, :city, :state, :zip
    
    def initialize(element)
      return if element.blank?
      build(element)
    end
    
    private
    
    def build(element)      
      @id = get_value(element, VENUE_ID)
      @name = get_value(element, VENUE_NAME)
      @city = get_value(element, VENUE_CITY)
      @state = get_value(element, VENUE_STATE)
      @zip = get_value(element, VENUE_ZIP)
    end
    
  end
  
end
