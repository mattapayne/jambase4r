module JamBase4R
  module Model
    
    EVENT_ID = "event_id"
    TICKET_URL = "ticket_url"
    EVENT_URL = "event_url"
    VENUE = "venue"
    EVENT_DATE = "event_date"
    ARTISTS = "artists/artist"
    VENUE_ID = "venue_id"
    VENUE_NAME = "venue_name"
    VENUE_CITY = "venue_city"
    VENUE_STATE = "venue_state"
    VENUE_ZIP = "venue_zip"
    ARTIST_ID = "artist_id"
    ARTIST_NAME = "artist_name"
    
    def get_value(element, node_name)
      return if element.blank? || node_name.blank?
      collection = element.get_elements(node_name)
      return (collection.blank? ? nil : get_element_value(collection.first))
    end
    
    private
    
    def get_element_value(element)
      element.nil? ? nil : (element.get_text.nil? ? nil : element.get_text.value)
    end
    
  end
end