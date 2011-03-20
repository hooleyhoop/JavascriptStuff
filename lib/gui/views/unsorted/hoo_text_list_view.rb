module GUI::Views
	class HooTextListView < GUI::Core::HooView

    	attr_accessor :allItems;
    	attr_accessor :dataSrc;
        attr_accessor :size;

		def initialize
			super();
		end

		# Mock data
		def setupDebugFixture
			super();
			self.dataSrc = self;
			self.allItems = [
				{ 'name'=>"shanty town",     		'url'=> "shabba" },
				{ 'name'=>"just a fool for",      	'url'=> "shabba" },
				{ 'name'=>"rocket",        			'url'=> "shabba" },
				{ 'name'=>"fur pine coat dog",    	'url'=> "shabba" },
			];
			self.size = 'medium'
		end


	end
end
