require File.dirname(__FILE__) + '/../spec_helper'

describe JamBase4R do
  
  it "should respond_to? :configure" do
    JamBase4R.should respond_to(:configure)
  end
  
  it "should respond_to? :log_error" do
    JamBase4R.should respond_to(:log_error)
  end
  
  it "should respond_to? :log_info" do
    JamBase4R.should respond_to(:log_info)
  end
  
  it "should raise an exception if the api key is not set" do
    lambda{
      JamBase4R.configure do |s|
        s.api_key = nil
      end
    }.should raise_error
  end
  
  it "should log an error if the api key is not set" do
    log = mock("Logger")
    log.should_receive(:error)
    begin
      JamBase4R.configure do |c|
        c.api_key = nil
        c.logger = log
      end
    rescue
    end
  end
  
  it "should not raise an exception when configured with an API key" do
    lambda {
      JamBase4R.configure do |c|
        c.api_key = "dffsdfsfdf"
      end
    }.should_not raise_error
  end
  
  it "should raise an exception if configure is not passed a block" do
    lambda {
      JamBase4R.configure
    }.should raise_error
  end
  
end