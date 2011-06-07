module GUI::Cells

	class HooCellProxy < GUI::Core::HooView

        attr_accessor :cell

        # Mock data
        def setupDebugFixture
            super();
        end

		# this can be used instead of a haml file
		def stringOutput

            # puts( self.window.controller )
		     # self.window.controller.render( :partial => @cell.partial(),  :object=>@cell );

	        #return @cell.insert(self, self );
       		#render :text => 'hello'
       		#'hello'
	    end

	end
end
