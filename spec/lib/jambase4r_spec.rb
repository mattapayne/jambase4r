require File.dirname(__FILE__) + '/../spec_helper'

describe JamBase4R do
  
  it "should respond_to? :configure" do
    JamBase4R.should respond_to(:configure)
  end
  
  it "should raise an exception if the api key is not set" do
    lambda{
      JamBase4R.configure do |s|
        s.api_key = nil
      end
    }.should raise_error
  end
  
  it "should raise an exception if configure is not passed a block" do
    lambda {
      JamBase4R.configure
    }.should raise_error
  end
  
end