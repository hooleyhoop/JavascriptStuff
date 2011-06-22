module Gui::Views::Drawing::Menus::Items::HooTextMenuItemMixin

	#class HooTextItemAbstract < Gui::Views::Drawing::Buttons::DivButton::HooDivButtonToggleDynamicWidth

		# requires a position accessor

		#require 'gui/helpers/widgets_helper'
		include Gui::Helpers::WidgetsHelper

        # Mock Data
		# def setupDebugFixture
		#	super();
		# end

		def div_attrs
			div_attrs = { :data=>{'position'=>@position}, :style=>self.divStyle }
			if( @initialState==0 )
				div_attrs.merge!( { :disabled=>"disabled" } )
			end
			div_attrs
		end

		def divStyle
			divStyle = "background:transparent url( #{@img} ) 0 #{@size[1]*-@initialState}px; height:#{@size[1]-2}px;"
			if( @position=='left' )
				divStyle += roundLeftHand(@cornerRad)
			elsif( @position=='right' )
				divStyle += roundRightHand(@cornerRad)
			end
			divStyle
		end

		def textStyle
			textStyle = "color:#{@labelColor}; line-height:#{@size[1]-2}px;"
		end

		def anchor_attrs
			anchor_attrs = { :style=>self.textStyle };
			if( @initialState==0 )
				anchor_attrs.merge!( { :disabled=>"disabled" } )
			else
				anchor_attrs.merge!( { :href=>@action } )
			end
			anchor_attrs
		end

	#end
end
