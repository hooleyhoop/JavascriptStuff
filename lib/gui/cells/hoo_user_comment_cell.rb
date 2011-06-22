module Gui::Cells

    # http://0.0.0.0:3000/widgets/cellRenderer?cellName=hoo_user_comment_cell
	class HooUserCommentCell < Gui::Core::HooCell

		attr_accessor :commentTxt, :commentAuthor, :commentAuthorPic, :commentDate;
        attr_accessor :userBubble

		def initialize( args={} )
			super(args);

            # each time the cell is rendered it will render this shared view
			@speechBubbleClass = Gui::HooWidgetList.widgetClass('speechBubblePane');
            @userBubble = @speechBubbleClass.new();
            @userBubble.speechPosition = 'left'
            @userBubble.constructSubViews();

            @cellProxy = HooCellProxy.new();
            @cellProxy.cell = self;

            @userBubble.addSubView( @cellProxy );

		end

      #  def set_content_for( &block )
#
 #           puts Haml::Helpers.block_is_haml?( block );
  #          #puts block.yield
   #         #puts "set #{@currentIndex}"
    #        ivar = "@content_for_#{@currentIndex}";
     ##       instance_variable_set( ivar, block );
      #      #bob = yield
      #  end

#        def get_content_for()
#            ivar = "@content_for_#{@currentIndex}";
#            proc = instance_variable_get( ivar );
#            #puts Haml::Helpers.block_is_haml?( proc );
#            #str = Haml::Helpers.capture_haml({},proc)
            #proc.call
            #block.call
#        end

        # Mock Data Provider (for one instance of the cell)
        def allItems

            self.mapping = {
				"@commentTxt"       => "comment",
				"@commentAuthor"    => "author",
				"@commentAuthorPic" => "authorPic",
				"@commentDate"      => "date",
			}

            return [
                {
                'comment'   => "Old vaccines left over from the swine flu pandemic will be used to plug the shortfall in this winter's supplies, the government says, as the death toll continues to climb.",
                'author'    => "sarah",
                'authorPic' => "../images/user/sample_user10.png",
                'date'      => '2 hours ago' ,
                },

                {
                'comment'   => "I've bumped your account up to 10 minutes so we don't miss the end next time:)",
                'author'    => "gary",
                'authorPic' => "../images/user/sample_user10.png",
                'date'      => '5 days ago' ,
                },

                {
                'comment'   => "This is a shape from shading approach, which will only work if you're in the dark, with the phone as the only illumination source. If white dots are shown in different places on the screen, and assuming the phone and subject don't move during the process, surface normals can be computed from the resulting images, and once you have the normals then the shape can be approximated. Normals can be found by calculating the angle of maximum reflectance for each pixel for a series of images under different illuminations.
See this Google video for a similar technique. http://www.youtube.com/watch?v=rxNg-tXPPWc",
                'author'    => "markrock",
                'authorPic' => "../images/user/sample_user10.png",
                'date'      => '3 weeks ago' ,
                },

                {
                'comment'   => "I've bumped your account up to 10 minutes so we don't miss the end next time:)",
                'author'    => "tumble face",
                'authorPic' => "../images/user/sample_user10.png",
                'date'      => '25 days ago' ,
                },

            ];
        end

	end
end
