require File.dirname(__FILE__) + '/../../spec_helper'

describe JamBase4R::Model do
  include JamBase4R::Model
  
  before(:each) do
    @elem = stub("Element", :get_text => nil)
  end
  
  it "should handle elements that do not have a text value" do
    send(:get_element_value, @elem).should be_nil
  end
  
  it "should not raise an exception if the element does not have a text value" do
    lambda {
      send(:get_element_value, @elem)
    }.should_not raise_error
  end
  
  it "should handle nil elements" do
    send(:get_element_value, nil).should be_nil
  end
  
  it "should not raise an exception if element is nil" do
    lambda {
      send(:get_element_value, nil)
    }.should_not raise_error
  end
  
end