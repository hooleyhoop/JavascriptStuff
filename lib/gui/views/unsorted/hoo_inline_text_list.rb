module GUI::Views
	class HooInlineTextList < GUI::Core::HooView

    	attr_accessor :dataSrc;
        attr_accessor :size;

		def initialize
			super();
		end

		# Mock data
		def setupDebugFixture
			super();
			self.dataSrc = self;
			self.size = 'medium'
		end

		# Mock Data Provider
		def allItems
			@menuItems = [
				{ 'name'=>"shanty town",     		'url'=> "shabba" },
				{ 'name'=>"just a fool for",      	'url'=> "shabba" },
				{ 'name'=>"rocket",        			'url'=> "shabba" },
				{ 'name'=>"fur pine coat dog",    	'url'=> "shabba" },
			];
		end

	end
end
