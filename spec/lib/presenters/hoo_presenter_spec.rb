require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../../lib/presenters/hoo_presenter')

describe "HooPresenter" do

    describe "success" do
      
      before(:each) do
        @pagePresenter = Presenters::HooPresenter.new( self );
      end
      
      it "should have a window and controller by default" do
        @pagePresenter.window.should_not == nil
        @pagePresenter.controller.should_not == nil
      end
      
      it "should draw window with controller" do
        mockWind = mock("GUI::Window");
        mockWind.should_receive("drawNow").with(@pagePresenter.controller)
        
        @pagePresenter.window = mockWind
        @pagePresenter.drawPage();
      end
      
    end

end
