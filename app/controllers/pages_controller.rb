
class PagesController < ApplicationController

	require 'test/unit'
	include Test::Unit::Assertions

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

	def index
		self.control_center()
	end

	def control_center
		pagePresenter = Presenters::ControlCenterPagePresenter.new( self );
		pagePresenter.drawPage();
  end

	def widgets
		pagePresenter = Presenters::WidgetsPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	def sample_fixed_page
		optionalId = params[:id] ? Integer(params[:id]) : 0;
		pagePresenter = Presenters::SampleFixedPagePresenter.new( self, optionalId );
		pagePresenter.drawPage();
	end

	def sample_elastic_page
		optionalId = params[:id] ? Integer(params[:id]) : 0;
		pagePresenter = Presenters::SampleElasticPagePresenter.new( self, optionalId );
		pagePresenter.drawPage();
	end

	def single_widget
		pagePresenter = Presenters::SingleWidgetPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	def grid_view
		pagePresenter = Presenters::GridViewPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	def list_view
		pagePresenter = Presenters::ListViewPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	def headless_recorder
		pagePresenter = Presenters::HeadlessRecorderPresenter.new( self );
		pagePresenter.drawPage();
	end

	def headless_player
		pagePresenter = Presenters::HeadlessPlayerPresenter.new( self );
		pagePresenter.drawPage();
	end

	def horizontal_list_view
		pagePresenter = Presenters::HorizontalListViewPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	# Better practice to use a different action for the post request
	def multiple_link_buttons_test
		pagePresenter = Presenters::ClickableDivLinksPresenter.new( self );
		pagePresenter.drawPage();
	end

	def multiple_form_buttons_test
		pagePresenter = Presenters::MultipleButtonsPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	def multiple_buttons_test_upload
		#assert request.post
		#check if ajax or form
		#puts request.inspect
		#puts request.to_yaml

		#assert( request.post? );
		#assert( request.xhr? );

		render :json =>{ :result =>'success', :random => 'scallywag' }
	end

	def test_audioboo_stuff
		pagePresenter = Presenters::AudiobooScratchPadPresenter.new( self );
		pagePresenter.drawPage();
	end

  # for ajax
  # pass a GUI:partial class name, it will be instantiated and rendered and returned as a string
  def _singlePartialViaAjaxFromParam

    classNameParam = params['urlpath'];
    classParam = classNameParam.constantize;
    anInstance = classParam.new();
    anInstance.setupDebugFixture();

	# first attempt to directly get it's string output, if it doesn't have any try to render a partial
	output = anInstance.stringOutput
    if(output==nil)
    	localVarName = classNameParam.split('::').last;
	    propName = localVarName.underscore.to_sym
    	partialAsString = render_to_string( :partial=>anInstance.class.partial_path(), :locals=>{propName=>anInstance} );
    	output = partialAsString
    end
	return render( :text =>output );

  end


	# ajax test. This can't be right? No?
	def _ajaxHTML
		#respond_to do |format|
		#	format.js {render :layout=>false}
		#end
		#render :text => "FOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		#render :js => " "
		#render :action =>"test_view", :layout=>false;

    classNameParam = params['urlpath'];
    classParam = classNameParam.constantize;

		partialAsString = render_to_string :partial => classParam.partial_path()
		#render :text => partialAsString

		#objectToRender = HooBlueView.new();

		#haml_string = "%p Haml-tastic!"
		#engine = Haml::Engine.new(haml_string)
		#hamlResult = engine.render
		render :text => partialAsString
	end

	def show_boo
		headers['Content-Length'] = '3117539'
		headers['Content-Type'] = 'audio/mpeg'
		headers['Accept-Ranges'] =  'bytes'
		send_file Rails.root.join('public/audio/test.mp3')
		#redirect_to "/audio/#{params[:filename]}.#{params[:format]}"
	end
end
