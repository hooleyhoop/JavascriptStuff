$:.unshift('spec')          # hack required for rake spec:rcov
require 'spec_helper'

describe ApplicationController do

  render_views

  before(:each) do
  end


  describe "getFiles" do
	  it "should get sosme godamn files" do
		  fileArray = ApplicationController.listJavascriptFiles()
		  fileArray.count.should == 2
	  end
  end


  
end
