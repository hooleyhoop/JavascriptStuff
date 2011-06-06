module GUI::Views::Lists

    # http://0.0.0.0:3000/widgets/textList1
	class HooTextListView < GUI::Core::HooView

    	attr_accessor :allItems;
    	attr_accessor :dataSrc;
        attr_accessor :size;

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
