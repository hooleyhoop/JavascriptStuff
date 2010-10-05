require 'spec_helper'

describe PagesController do

  render_views

  before(:each) do
  end

  describe "GET 'javascript_unit_tests'" do

      before(:each) do
        get :javascript_unit_tests
      end

      it "should be successful" do
        response.should be_success
      end

  end

end
