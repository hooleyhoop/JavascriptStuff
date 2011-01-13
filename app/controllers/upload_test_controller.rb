class UploadTestController < ApplicationController

	# Might be hlepful
	# http://archive.robwilkerson.org/2009/08/26/learning-ruby-on-rails-file-upload/index.html#comments

	# http://0.0.0.0:3000/upload_test/simple_form
	def simple_form
		optionalId = params[:id] ? Integer(params[:id]) : 0;

		pagePresenter = Presenters::UploadTestPagePresenter.new( self );
		pagePresenter.drawPage();
	end

	def upload
		#puts params

		image = params['picture']
		puts 'sheeet '+image.original_filename
		puts 'sheeet '+image.content_type

	# get_bin_root() returns File.join( Rails.root, ‘public’, ‘bin’ )
	# save_as = File.join( get_bin_root(), ‘_tmp’, uploaded_file.original_path )
	# File.open( save_as.to_s, ‘w’ ) do |file|
	# file.write( uploaded_file.read )
	# end
	# self.extension = File.extname( self.name ).sub( /^\./, ‘’ ).downcase
	# self.size      = File.size( save_as )
	# self.path      = save_as.sub( Rails.root.to_s + ‘/’, ‘’ )
	# self.uri       = get_uri_from_path()
	# self.save!
    # File.delete( File.join( Rails.root, binary.path ) ) if binary

		redirect_to :upload_test_simple_form
	end

end
