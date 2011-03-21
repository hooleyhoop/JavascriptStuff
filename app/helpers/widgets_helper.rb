module WidgetsHelper

	# make some kind of inline css utility
	def roundLeftHand( amount )
		"-webkit-border-bottom-left-radius:#{amount}px; -moz-border-radius-bottomleft:#{amount}px; border-bottom-left-radius:#{amount}px; -webkit-border-top-left-radius:#{amount}px; -moz-border-radius-topleft:#{amount}px; border-top-left-radius:#{amount}px;"
	end

	def roundRightHand( amount )
		"-webkit-border-bottom-right-radius:#{@cornerRad}px; -moz-border-radius-bottomright:#{@cornerRad}px; border-bottom-right-radius:#{@cornerRad}px; -webkit-border-top-right-radius:#{@cornerRad}px; -moz-border-radius-topright:#{@cornerRad}px; border-top-right-radius:#{@cornerRad}px;"
	end

end
