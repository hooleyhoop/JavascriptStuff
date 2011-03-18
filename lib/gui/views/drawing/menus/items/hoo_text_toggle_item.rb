module GUI::Views::Drawing::Menus::Items

	# http://0.0.0.0:3000/widgets/textToggleItem?initialState=1
	class HooTextToggleItem < GUI::Views::Drawing::Buttons::DivButton::HooDivButtonToggleDynamicWidth

		attr_accessor :position;

        # Mock Data
		def setupDebugFixture
			super();
			@position = 'left'
		end

		# we share a partial with HooTextLinkItem
		def self.partial_path
			return HooTextLinkItem.name.underscore;
		end

		def div_attrs
			div_attrs = { :data=>{'position'=>@position}, :style=>self.divStyle }
			if( @initialState==0 )
				div_attrs.merge!( { :disabled=>"disabled" } )
			end
			div_attrs
		end

		# make some kind of inline css utility
		def roundLeftHand( amount )
			"-webkit-border-bottom-left-radius:#{amount}px; -moz-border-radius-bottomleft:#{amount}px; border-bottom-left-radius:#{amount}px; -webkit-border-top-left-radius:#{amount}px; -moz-border-radius-topleft:#{amount}px; border-top-left-radius:#{amount}px;"
		end

		def roundRightHand( amount )
			"-webkit-border-bottom-right-radius:#{@cornerRad}px; -moz-border-radius-bottomright:#{@cornerRad}px; border-bottom-right-radius:#{@cornerRad}px; -webkit-border-top-right-radius:#{@cornerRad}px; -moz-border-radius-topright:#{@cornerRad}px; border-top-right-radius:#{@cornerRad}px;"
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


	end
end
