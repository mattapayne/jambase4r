require File.dirname(__FILE__) + '/../../spec_helper'

describe JamBase4R::Event do

  def create_mock_element(expect=true, create_venue=true, create_artists=true)
    e = mock("Element")
    e.stub!(:blank?).and_return(!expect)
    
    #id
    id_value = mock("ID Value")
    expect ? id_value.should_receive(:value).and_return(10) : id_value.should_not_receive(:value)
    id = mock("Event ID")
    expect ? id.should_receive(:get_text).at_least(1).times.and_return(id_value) : id.should_not_receive(:get_text)
    
    expect ? e.should_receive(:get_elements).with("event_id").and_return([id]) : 
      e.should_not_receive(:get_elements).with("event_id")
    
    #ticket url
    ticket_url_value = mock("Ticket Url Value")
    expect ? ticket_url_value.should_receive(:value).and_return("http://test.ca") : 
      ticket_url_value.should_not_receive(:value)
    ticket_url = mock("Ticket Url")
    expect ? ticket_url.should_receive(:get_text).at_least(1).times.and_return(ticket_url_value) : 
      ticket_url.should_not_receive(:get_text)
    
    expect ? e.should_receive(:get_elements).with("ticket_url").and_return([ticket_url]) : 
      e.should_not_receive(:get_elements).with("ticket_url")
    
    #event url
    event_url_value = mock("Event Url Value")
    expect ? event_url_value.should_receive(:value).and_return("http://test.ca") : 
      event_url_value.should_not_receive(:value)
    event_url = mock("Event Url")
    expect ? event_url.should_receive(:get_text).at_least(1).times.and_return(event_url_value) : 
      event_url.should_not_receive(:get_text)

    expect ? e.should_receive(:get_elements).with("event_url").and_return([event_url]) : 
      e.should_not_receive(:get_elements).with("event_url")
    
    #date
    date_value = mock("Event Date Value")
    expect ? date_value.should_receive(:value).and_return("10/21/2009") : 
      date_value.should_not_receive(:value)
    date = mock("Event Date")
    expect ? date.should_receive(:get_text).at_least(1).times.and_return(date_value) : 
      date.should_not_receive(:get_text)

    expect ? e.should_receive(:get_elements).with("event_date").and_return([date]) : 
      e.should_not_receive(:get_elements).with("event_date")
    
    #venue
    venues = nil
    if create_venue
      venue = mock("Venue")
      venue.stub!(:get_elements).and_return([])
      venues = [venue]
    end
    expect ? e.should_receive(:get_elements).with("venue").and_return(venues) :
      e.should_not_receive(:get_elements).with("venue")
    
    #artists
    artists = nil
    if create_artists
      artist = mock("Artist")
      artist.stub!(:get_elements).and_return([])
      artists = [artist]
    end
    expect ? e.should_receive(:get_elements).with("artists/artist").and_return(artists) : 
      e.should_not_receive(:get_elements).with("artists/artist")
    
    return e
  end
  
  it "should build itself from the passed in element" do
    JamBase4R::Event.new(create_mock_element(true, true, false))
  end
  
  it "should not build itself if the element passed in responds true to blank?" do
    JamBase4R::Event.new(create_mock_element(false))
  end
  
  it "should create a venue if there is venue XML" do
    JamBase4R::Venue.should_receive(:new)
    JamBase4R::Event.new(create_mock_element)
  end
  
  it "should not create a venue if there is no venue XML" do
    JamBase4R::Venue.should_not_receive(:new)
    JamBase4R::Event.new(create_mock_element(true, false, false))
  end
  
  it "should create artists if there is artist XML" do
    JamBase4R::Artist.should_receive(:new).exactly(1).times
    JamBase4R::Event.new(create_mock_element(true, true, true))
  end
  
  it "should not create artists if there is no artist XML" do
    JamBase4R::Artist.should_not_receive(:new)
    JamBase4R::Event.new(create_mock_element(true, true, false))
  end
  
end