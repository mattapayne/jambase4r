require File.dirname(__FILE__) + '/../spec_helper'

describe JamBase4R::API do
  
  it "should respond_to? search" do
    JamBase4R::API.should respond_to(:search)
  end
  
  it "should respond_to? search_by_artist" do
    JamBase4R::API.should respond_to(:search_by_artist)
  end
  
  it "should respond_to? search by zip_code" do
    JamBase4R::API.should respond_to(:search_by_zipcode)
  end
  
  it "should respond_to? search by user" do
    JamBase4R::API.should respond_to(:search_by_user)
  end
  
  it "should respond_to? log_error" do
    JamBase4R::API.should respond_to(:log_error)
  end
  
  it "should respond_to? log_info" do
    JamBase4R::API.should respond_to(:log_info)
  end
  
  describe "search" do
    
    before(:each) do
      @r = stub("Response", :status => "200", :message => "OK", :body => xml_response)
      JamBase4R::API.stub!(:jambase_search).and_return(@r)
    end
    
    it "should call jambase_search" do
      JamBase4R::API.should_receive(:jambase_search).with(:band => "monkey").and_return(@r)
      JamBase4R::API.search(:band => "monkey")
    end
    
    it "should convert the response to an array" do
      JamBase4R::API.should_receive(:convert).with(xml_response)
      JamBase4R::API.search(:band => "monkey")
    end
    
  end
  
  describe "custom methods" do
    
    before(:each) do
      @r = stub("Response", :status => "200", :message => "OK", :body => xml_response)
      JamBase4R::API.stub!(:search).and_return(@r)
    end
   
    describe "search_by_zipcode" do
      
      it "should replace the value if :zip in additional filters" do
        options = {:zip => "90210"}
        JamBase4R::API.search_by_zipcode("99999", options)
        options[:zip].should == "99999"
      end
      
      it "should call search" do
        JamBase4R::API.should_receive(:search).with({:zip => "99999"}).and_return(@r)
        JamBase4R::API.search_by_zipcode("99999")
      end
      
    end
    
    describe "search_by_user" do
      
      it "should replace the value if :user in additional filters" do
        options = {:user => "A User"}
        JamBase4R::API.search_by_user("A 2nd User", options)
        options[:user].should == "A 2nd User"
      end
      
      it "should call search" do
        JamBase4R::API.should_receive(:search).with({:user => "Mr X"}).and_return(@r)
        JamBase4R::API.search_by_user("Mr X")
      end
      
    end
  
    describe "search_by_artist" do
      
      it "should replace the value of :artists in additional filters" do
        options = {:artist => "TEST"}
        JamBase4R::API.search_by_artist("A Band", options)
        options[:artist].should == "A Band"
      end
    
      it "should call search" do
        JamBase4R::API.should_receive(:search).with({:artist => "A Band"}).and_return(@r)
        JamBase4R::API.search_by_artist("A Band")
      end
    
    end
    
    describe "convert" do
      
      it "should return an empty array if the xml passed to convert is nil" do
         JamBase4R::API.send(:convert, nil).should be_is_a(Array)
      end

      it "should return an empty array if the xml passed to convert is empty" do
         JamBase4R::API.send(:convert, "").should be_is_a(Array)
      end

      it "should convert xml passed to convert into an Array" do
         JamBase4R::API.send(:convert, xml_response).should be_is_a(Array)
      end
      
    end
    
    describe "Search" do
      
      def default_search_args
        {:artist => "Some Band", :zip => "90210", :radius => 50, :user => "Mr X"}
      end

      before(:each) do
        JamBase4R.configure do |c|
          c.api_key = "dfsffd"
        end
        @resp = mock("Response")
        @resp.stub!(:code).and_return("200")
        @resp.stub!(:message).and_return("OK")
        @resp.stub!(:body).and_return(xml_response)
        @gateway = mock('Gateway')
        @gateway.stub!(:get).and_return(@resp)
        JamBase4R::API.stub!(:jambase_gateway).and_return(@gateway)
      end

      it "should return nil from jambase_search if search args are nil" do
        JamBase4R::API.send(:jambase_search, nil).should be_nil
      end

      it "should return nil from jambase_search if search args are empty" do
        JamBase4R::API.send(:jambase_search, {}).should be_nil
      end

      it "should return nil if after cleaning the search args they are empty" do
        search_args = default_search_args.merge(
          :zip => nil, :radius => "", :artist => "", :user => "")
        JamBase4R::API.send(:jambase_search, search_args).should be_nil
      end

      it "should raise an exception if both the aliased param and the real param are set" do
        search_args = default_search_args.merge(:band => "The Monkeys")
        lambda {
          JamBase4R::API.send(:jambase_search, search_args)
        }.should raise_error
      end

      it "should call get on the gateway object with a properly constructed url" do
        url = "http://api.jambase.com/search?band=Some+Band&apikey=dfsffd"
        @gateway.should_receive(:get).with(url).and_return(@resp)
        JamBase4R::API.send(:jambase_search, default_search_args.merge(
            :zip => nil, :radius => nil, :user => nil))
      end
      
    end
    
  end
  
end