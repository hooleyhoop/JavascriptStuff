class WidgetsController < ApplicationController

  def show()
  	#render :text => params[:name]
		pagePresenter = Presenters::SingleWidgetPagePresenter.new( self, params[:name] );
		pagePresenter.drawPage();
  end

end
