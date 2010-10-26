
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

	def index
		render "control_center"
	end

	def widgets
		pagePresenter = Presenters::WidgetsPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	def sample_page
		optionalId = params[:id] ? Integer(params[:id]) : 0;
		#pagePresenter = Presenters::SampleElasticPagePresenter.new( self, optionalId );
		pagePresenter = Presenters::SampleFixedPagePresenter.new( self, optionalId );
		pagePresenter.drawPage();
	end

	def single_widget
		pagePresenter = Presenters::SingleWidgetPagePresenter.new( self );
		pagePresenter.drawPage();
	end

  # for ajax
  # pass a GUI:partial class name, it will be instantiated and rendered and returned as a string
  def _singlePartialViaAjaxFromParam
    
    classNameParam = params['urlpath'];
    classParam = classNameParam.constantize;
    anInstance = classParam.new();
    anInstance.debugFixture();
    
    localVarName = classNameParam.split('::').last;
    propName = localVarName.underscore.to_sym
  
    partialAsString = render_to_string( :partial=>anInstance.class.partial_path(), :locals=>{propName=>anInstance} );
	  return render :text => partialAsString;

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
