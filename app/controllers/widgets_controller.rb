class WidgetsController < ApplicationController

	def show()
		#render :text => params[:name]

		widgetToRender = params[:name]
		optionalArgs = params.reject{ |key, val| key=='name' };

		pagePresenter = Presenters::SingleWidgetPagePresenter.new( self, widgetToRender, optionalArgs );
		pagePresenter.drawPage();
	end

	def _ajaxPostTest
		puts "hello"
		render :text => 'Hello world'
	end

end
