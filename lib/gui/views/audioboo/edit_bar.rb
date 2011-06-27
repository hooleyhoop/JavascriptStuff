module Gui::Views::Audioboo

	# http://0.0.0.0:3000/widgets/editBar
	class EditBar < Gui::Core::HooView

        attr_accessor :largeButton

		# You must build your elements in initialize, even if conditional.
		# Therefor you must pass the conditional data to initialize
		def initialize( args={} )
			super(args);

			largeButtonclass =  widgetClass('largeSinglebuttonForm')
			@largeButton = largeButtonclass.new
			@largeButton.img = '../images/buttons/edit-button.png';
			@largeButton.width = 105;
			@largeButton.height = 45;
			@largeButton.label = 'edit'
			@largeButton.labelColor = '#969696'

			#horizListClass = widgetClass('paddedHorizontal');
			#@horizList = horizListClass.new();

			# configure the cell
			#buttonCell = Gui::HooWidgetList.cellClass('actionButton1').new();
			#standardCell.mapping = {
			#  "@heading"=>"BooTitle",
			#  "@subHeading"=>"BooLocation"
			#}
			#@horizList.cell = buttonCell

			#@horizList.content = [
			#	{ 'name'=>"jimmy hands",          'email'=> "sss@gmail.com" },
			#	{ 'name'=>"Taylor Woodrow",       'email'=> "asd@hotmail.com" },
			#	{ 'name'=>"Shanti",               'email'=> "ggh@yahoo.com" },
			#];

			#self.addSubView( @horizList );
		end

		# Mock Data
		def setupDebugFixture
			super();
        end

		def wasAddedToParentView
			super();
		end

	end
end
