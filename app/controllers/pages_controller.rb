class PagesController < ApplicationController

  def controlcenter
  end

	# try to get the content of javascript/tests dir and pass it to template so they can be linked
	def javascript_unit_tests()
		modifiedFileNames = Array.new
		jsFiles = ApplicationController.listJavascriptFiles();
		jsFiles.each do |file|
		  file = file.sub( "public/", "/")
		  modifiedFileNames << file
		end
		render :layout=>'testLayout', :locals=>{ :jsFiles=>modifiedFileNames }

	end

end
