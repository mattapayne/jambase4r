require File.dirname(__FILE__) + '/../../spec_helper'

describe JamBase4R::Artist do
  
  def create_mock_element(expect=true)
    e = mock("Element")
    e.stub!(:blank?).and_return(!expect)
    
    id_value = mock("ID Value")
    expect ? id_value.should_receive(:value).and_return(10) : id_value.should_not_receive(:value)
    id = mock("Artist ID")
    expect ? id.should_receive(:get_text).and_return(id_value) : id.should_not_receive(:get_text)
    
    expect ? e.should_receive(:get_elements).with("artist_id").and_return([id]) : 
      e.should_not_receive(:get_elements).with("artist_id")
    
    name_value = mock("Name Value")
    expect ? name_value.should_receive(:value).and_return("Joe Artist") : name_value.should_not_receive(:value)
    name = mock("Artist Name")
    expect ? name.should_receive(:get_text).and_return(name_value) : name.should_not_receive(:get_text)
    
    expect ? e.should_receive(:get_elements).with("artist_name").and_return([name]) : 
      e.should_not_receive(:get_elements).with("artist_name")
    
    return e
  end
  
  it "should build itself from the passed in element" do
    JamBase4R::Artist.new(create_mock_element)
  end
  
  it "should return an empty object if the element passed in responds true to blank?" do
    JamBase4R::Artist.new(create_mock_element(false))
  end
  
end