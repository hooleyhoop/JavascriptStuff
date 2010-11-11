
class PagesController < ApplicationController


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

	def horizontal_list_view
		pagePresenter = Presenters::HorizontalListViewPagePresenter.new( self );
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

end
