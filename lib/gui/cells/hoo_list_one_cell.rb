module GUI::Cells
	class HooListOneCell < GUI::Core::HooCell

		attr_accessor :heading, :subHeading;

        # Mock Data Provider (for one instance of the cell)
        def allItems

            self.mapping = {
				"@heading"=>"name",
				"@subHeading"=>"email"
			}

            return [
                { 'name'=>"jimmy hands", 'email'=> "sss@gmail.com" },
            ];
        end

	end
end
