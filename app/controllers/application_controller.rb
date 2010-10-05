class ApplicationController < ActionController::Base
  protect_from_forgery


  def ApplicationController.listJavascriptFiles()
		files = Dir.glob("public/javascripts/tests/*")
		files.each do |file|
			Rails.logger.info "found file-#{file}"
		end
		return files
	end

end
