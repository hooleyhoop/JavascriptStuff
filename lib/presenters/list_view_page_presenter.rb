module Presenters
	class ListViewPagePresenter < HooPresenter

		def initialize( controller )
			super( controller );
			
			listView = GUI::HooListOneView.new()
			listView.headerView = GUI::HooLoremIpsumView.new()
			
			weWantToUseAHash = false
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
  				Elephant.new({:name=>"doc beat", :email=>"a@yahoo.com"})
  			];
      end
			
			# configure the cell			
			standardCell = GUI::HooListOneCell.new();
			standardCell.mapping = {
			  "@heading"=>"name",
			  "@subHeading"=>"email"
		  }
			listView.cell = standardCell

			@window.contentView.addSubView( listView );
		end

		
	end
end
