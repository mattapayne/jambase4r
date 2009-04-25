require File.dirname(__FILE__) + '/../spec_helper'

describe JamBase4R::HttpGateway do
  
  GET_URL = "http://api.jambase.com/search?apikey=dsdfgdfg&band=Zero"
  
  before(:each) do
    @gate = JamBase4R::HttpGateway.new
    @resp = mock("Response")
    @resp.stub!(:code).and_return("200")
    @resp.stub!(:message).and_return("OK")
    @resp.stub!(:body).and_return("gdfgdfgdfgdfgfgdgdf")
  end
  
  it "should respond_to? log_error" do
    @gate.should respond_to(:log_error)
  end
  
  it "should respond_to? log_info" do
    @gate.should respond_to(:log_info)
  end
  
  it "should use the Net::HTTP::Get class to get" do
    get = Net::HTTP::Get.new(URI.parse(GET_URL).path_with_querystring)
    Net::HTTP.stub!(:start).and_return(@resp)
    Net::HTTP::Get.should_receive(:new).with(URI.parse(GET_URL).path_with_querystring).and_return(get)
    @gate.get(GET_URL)
  end
  
  it "should pass the URI path and query string for GET requests" do
    Net::HTTP.stub!(:start).and_return(@resp)
    url = URI.parse(GET_URL)
    URI.stub!(:parse).and_return(url)
    url.should_receive(:path_with_querystring).and_return("/search?apikey=dsdfgdfg&band=Zero")
    @gate.get(GET_URL)
  end
  
end