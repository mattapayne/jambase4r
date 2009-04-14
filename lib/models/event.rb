module JamBase4R
  
  class Event
    include Model
    
    attr_reader :id, :artists, :venue, :ticket_url, :event_url, :date
    
    def initialize(element)
      return if element.blank?
      build(element)
    end
    
    private
    
    def build(element)
      @artists = []
      @id = get_value(element, EVENT_ID)
      @ticket_url = get_value(element, TICKET_URL)
      @event_url = get_value(element, EVENT_URL)
      @date = get_value(element, EVENT_DATE)
      v = element.get_elements(VENUE)
      unless v.blank?
        @venue = Venue.new(v.first)
      end
      artists = element.get_elements(ARTISTS)
      unless artists.blank?
        artists.each {|a| @artists << Artist.new(a) }
      end
    end
    
  end
  
end
