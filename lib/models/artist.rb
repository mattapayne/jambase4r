module JamBase4R
  class Artist
    include Model
    
    attr_reader :id, :name
    
    def initialize(element)
      return if element.blank?
      build(element)
    end
    
    private
    
    def build(element)
      @id = get_value(element, ARTIST_ID)
      @name = get_value(element, ARTIST_NAME)
    end
    
  end
end