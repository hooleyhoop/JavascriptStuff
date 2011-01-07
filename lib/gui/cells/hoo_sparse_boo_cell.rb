module GUI::Cells
	class HooSparseBooCell < GUI::Core::HooCell

		attr_accessor :heading, :subHeading, :imgPath;

        # Mock Data Provider (for one instance of the cell)
        def allItems

            self.mapping = {
				"@heading"=>"name",
				"@subHeading"=>"email",
				"@imgPath"=>"imgPath",
			}

            return [
                { 'name'=>"jimmy hands", 'email'=>"sss@gmail.com", 'imgPath'=>'../images/user/sample_user10.png' },
            ];
        end

	end
end