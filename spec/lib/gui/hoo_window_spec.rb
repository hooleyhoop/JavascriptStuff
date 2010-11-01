require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../../lib/gui/hoo_window')

describe "HooWindow" do

  describe "creation" do

    before(:each) do
      @window = GUI::HooWindow.new();
    end
    
    it "should not have a parent view" do
      @window.parentView.should == nil;
    end
    
  end
end
