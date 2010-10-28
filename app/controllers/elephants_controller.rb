class ElephantsController < ApplicationController

  def index
    pagePresenter = Presenters::ElephantPagePresenter.new( self );
		pagePresenter.drawPage();
  end
  
  def new
    @title = "Sign up"
  end

  def show
    #@elephant = Elephant.find(params[:id])
  end

end
