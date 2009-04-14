require File.dirname(__FILE__) + '/../../spec_helper'

describe JamBase4R::Venue do
  
  def create_mock_element(expect=true)
    e = mock("Element")
    e.stub!(:blank?).and_return(!expect)
    
    #id
    id_value = mock("ID Value")
    expect ? id_value.should_receive(:value).and_return(10) : id_value.should_not_receive(:value)
    id = mock("Venue ID")
    expect ? id.should_receive(:get_text).and_return(id_value) : id.should_not_receive(:get_text)
    
    expect ? e.should_receive(:get_elements).with("venue_id").and_return([id]) : 
      e.should_not_receive(:get_elements).with("venue_id")
    
    #name
    name_value = mock("Name Value")
    expect ? name_value.should_receive(:value).and_return("A Venue") : 
      name_value.should_not_receive(:value)
    name = mock("Name")
    expect ? name.should_receive(:get_text).and_return(name_value) : 
      name.should_not_receive(:get_text)
    
    expect ? e.should_receive(:get_elements).with("venue_name").and_return([name]) : 
      e.should_not_receive(:get_elements).with("venue_name")
    
    #city
    city_value = mock("City Value")
    expect ? city_value.should_receive(:value).and_return("Denver") : 
      city_value.should_not_receive(:value)
    city = mock("City")
    expect ? city.should_receive(:get_text).and_return(city_value) : 
      city.should_not_receive(:get_text)

    expect ? e.should_receive(:get_elements).with("venue_city").and_return([city]) : 
      e.should_not_receive(:get_elements).with("venue_city")
 
    #state
    state_value = mock("State Value")
    expect ? state_value.should_receive(:value).and_return("Colorado") : 
      state_value.should_not_receive(:value)
    state = mock("State")
    expect ? state.should_receive(:get_text).and_return(state_value) : 
      state.should_not_receive(:get_text)

    expect ? e.should_receive(:get_elements).with("venue_state").and_return([state]) : 
      e.should_not_receive(:get_elements).with("venue_state")
    
    #zip
    zip_value = mock("Zip Value")
    expect ? zip_value.should_receive(:value).and_return("90210") : 
      zip_value.should_not_receive(:value)
    zip = mock("Zip")
    expect ? zip.should_receive(:get_text).and_return(zip_value) : 
      zip.should_not_receive(:get_text)

    expect ? e.should_receive(:get_elements).with("venue_zip").and_return([zip]) : 
      e.should_not_receive(:get_elements).with("venue_zip")
      
    return e
  end
  
  it "should build itself if the element does not respond true to blank?" do
    JamBase4R::Venue.new(create_mock_element)
  end
  
  it "should not build itself if the element responds true to blank?" do
    JamBase4R::Venue.new(create_mock_element(false))
  end
  
end