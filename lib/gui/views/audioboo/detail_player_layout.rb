module Gui::Views::Audioboo

	# http://0.0.0.0:3000/widgets/DetailPlayerLayout

	# The detail player is made up of a playbutton, a time display and the slider
	# This Class is for positioning them
	class DetailPlayerLayout < Gui::Core::HooView

        attr_accessor :playButtonHolder, :rightSideTop, :rightSideBottom

		def initialize( args={} )
			super(args)

			# first lets divide into two columns
			colView = widgetClass('HooVerticalSplitView').new( {fixedColSide:'left', fixedColWidth:90} )
			self.addSubView( colView )

			# the left col is just the square playbutton
			@playButtonHolder = widgetClass('HooFixedSizeView').new( {width:75, height:75} )
			colView.addSubView( @playButtonHolder )

			# The right col has the time display and the slider
			rightSidelayout = widgetClass('HooHorizontalSplitView').new( {:fixedColSide=>'top', :fixedColHeight=>45} )
			colView.addSubView( rightSidelayout )

			@rightSideTop = widgetClass('HooFixedSizeView').new( {width:'100%', height:45} )
			@rightSideBottom = widgetClass('HooFixedSizeView').new( {width:'100%', height:30} )

			rightSidelayout.addSubView( @rightSideTop )
			rightSidelayout.addSubView( @rightSideBottom )
		end

		def addSubviews( viewLeft, viewRightTop, viewRightBottom )
			@playButtonHolder.addSubView( viewLeft )
			@rightSideTop.addSubView( viewRightTop )
			@rightSideBottom.addSubView( viewRightBottom )
		end

        # Mock Data
        def setupDebugFixture
			self.addSubviews( widgetClass('HooColorFill').new(), widgetClass('HooColorFill').new(), widgetClass('HooColorFill').new() )
       	end

	end
end
