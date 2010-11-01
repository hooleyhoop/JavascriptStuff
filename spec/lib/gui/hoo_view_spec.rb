require 'spec_helper'
require File.expand_path(File.dirname(__FILE__) + '/../../../lib/gui/hoo_view')

describe "HooView" do

  describe "creation" do

    describe "success" do
      it "should know it's partial path" do
        GUI::HooView.partial_path.should == "gui/hoo_view"
      end
    
      it "should know it's model name" do
        GUI::HooView.model_name.to_s.should == "GUI::HooView".html_safe
      end
    end
   
   describe "adding a subview" do
     
     before(:each) do
       @view = GUI::HooView.new();
       @subview1 = GUI::HooView.new();
       @subview2 = GUI::HooView.new();
       @view.addSubView(@subview1);
       @view.addSubView(@subview2);
     end
     
     it "should have ordered subviews" do
       @view.views.size.should == 2;
       @view.views[0].should == @subview1;
       @view.views[1].should == @subview2;
     end

     it "should be notified" do
       @subview3 = GUI::HooView.new();
       @subview3.should_receive(:wasAddedToParentView);
       @view.addSubView(@subview3);      
     end
     
     it "should set parent view" do
       @view.views[0].parentView.should == @view;
       @view.views[1].parentView.should == @view;
       @view.views[1].window.should == @view;       
     end
   
     it "should have a unique id" do
       @view.id.should_not == @subview1.id
     end
   
     it "should have a unique CSS id" do
       @view.uniqueSelector.should_not == @subview1.uniqueSelector
     end
      
     it "should have no string output" do
       @view.stringOutput.should == nil;
     end

   end
   
  end
end
