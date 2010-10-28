module GUI
	class HooListOneView < HooView

    attr_accessor :content;
    attr_accessor :cell;
    attr_accessor :headerView;

		def initialize()
			super();
		end


    # Mock data
    def setupDebugFixture
      super();

      # add the header
			@headerView = GUI::HooLoremIpsumView.new()

      # content
			@content = [
				{ 'name'=>"jimmy hands",          'email'=> "sss@gmail.com" },
				{ 'name'=>"Taylor Woodrow",       'email'=> "asd@hotmail.com" },
				{ 'name'=>"Shanti",               'email'=> "ggh@yahoo.com" },
				{ 'name'=>"The Shadow",           'email'=> "wegbdfbf@tennis.com" },				
				{ 'name'=>"Janet Jackson",        'email'=> "7hghe4fsads@bbc.com" }				
			];
			
      # cell
			@cell = HooListOneCell.new
			@cell.mapping = {
			  "@heading"=>"name",
			  "@subHeading"=>"email"
		  }
    end
    
    
	end
end
