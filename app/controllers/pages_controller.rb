
class PagesController < ApplicationController

	def control_center
	end

	# try to get the content of javascript/tests dir and pass it to template so they can be linked
	def javascript_unit_tests()

		modifiedFileNames = Array.new
		jsFiles = ApplicationController.listJavascriptFiles();
		jsFiles.each do |file|
		  file = file.sub( "public/", "/")
		  modifiedFileNames << file
		end
		render :layout=>'test', :locals=>{ :jsFiles=>modifiedFileNames }

	end

	def widgets
		pagePresenter = Presenters::WidgetsPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	def single_widget
	  # just render single_widget view
  	  logger.info("just render single view");

	end

	# ajax test. This can't be right? No?
	def _ajaxHTML
		#respond_to do |format|
		#	format.js {render :layout=>false}
		#end
		#render :text => "FOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		#render :js => " "
		#render :action =>"test_view", :layout=>false;

		#partialAsString = render_to_string :partial =>"test_partial"
		#render :text => partialAsString

		objectToRender = HooBlueView.new();

		haml_string = "%p Haml-tastic!"
		engine = Haml::Engine.new(haml_string)
		hamlResult = engine.render
		render :text => hamlResult
	end

end
