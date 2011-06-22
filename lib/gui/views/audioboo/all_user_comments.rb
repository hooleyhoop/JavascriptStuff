module Gui::Views::Audioboo

    # http://0.0.0.0:3000/widgets/cellRenderer?cellName=hoo_user_comment_cell
	class AllUserComments < Gui::Core::HooView

		def initialize( args={} )

			super(args);
			spaced_cell_listClass = Gui::HooWidgetList.widgetClass('spacedCellList');
            @commentList = spaced_cell_listClass.new();
            @commentList.dataSrc = self;
            @commentList.cell = Gui::HooWidgetList.cellClass( 'hoo_user_comment_cell' ).new();

            @commentList.mapping = {
				"@commentTxt"       => "comment",
				"@commentAuthor"    => "author",
				"@commentAuthorPic" => "authorPic",
				"@commentDate"      => "date",
			}

            self.addSubView( @commentList );
		end

		def allItems
			return [

              {
                'comment'   => "Old vaccines left over from the swine flu pandemic will be used to plug the shortfall in this winter's supplies, the government says, as the death toll continues to climb.",
                'author'    => "nimrod",
                'authorPic' => "../images/user/sample_user6.png",
                'date'      => '10 mins ago' ,
                },

              {
                'comment'   => "I've bumped your account up to 10 minutes so we don't miss the end next time:)",
                'author'    => "shylock",
                'authorPic' => "../images/user/sample_user7.png",
                'date'      => '2 days ago' ,
                },

              {
                'comment'   => "I've bumped your account up to 10 minutes so we don't miss the end next time:)",
                'author'    => "garyfurtz",
                'authorPic' => "../images/user/sample_user8.png",
                'date'      => '17 days ago' ,
                },

			];
		end

        # this can be used instead of a haml file
		def stringOutput
		end

        # Mock Data
		def setupDebugFixture
			super();
		end

	end
end
