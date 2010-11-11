module Presenters
	class ListViewPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );

			listView = widgetClass('list1').new()
			listView.headerView = widgetClass('pullQuote1').new()
			listView.headerView.text ="What a lovely table"


			weWantToUseAHash = true
			if( weWantToUseAHash )
				listView.content = [
					{ 'BooTitle'=> "A lovely day",          'BooLocation'=> "Glengarry Glenross, Perthshire" },
					{ 'BooTitle'=> "way home boo",          'BooLocation'=> "Southwark, London, UK" },
					{ 'BooTitle'=> "tipsy topsy turvey",    'BooLocation'=> "New York, New York" },
					{ 'BooTitle'=> "The Shadow strikes",    'BooLocation'=> "Blackburn, lancashire" },
					{ 'BooTitle'=> "saturday morning boo",  'BooLocation'=> "Dark side of the moon" }
				];
			else
				listView.content = [
					Elephant.new({:name=>"steve", :email=>"a@yahoo.com"}) ,
					Elephant.new({:name=>"M knight shamalam", :email=>"a@yahoo.com"}) ,
					Elephant.new({:name=>"country jo", :email=>"a@yahoo.com"}) ,
					Elephant.new({:name=>"doc beat", :email=>"a@yahoo.com"}),
					Elephant.new({:name=>"doc beat", :email=>"a@yahoo.com"}),
					Elephant.new({:name=>"doc beat", :email=>"a@yahoo.com"})

				];
			end

			# configure the cell
			standardCell = cellClass('list1').new();
			standardCell.mapping = {
				"@heading"=>"BooTitle",
				"@subHeading"=>"BooLocation"
			}
			listView.cell = standardCell

			@window.contentView.addSubView( listView );


		end


	end
end
