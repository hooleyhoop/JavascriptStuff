module GUI::Cells

    # http://0.0.0.0:3000/widgets/cellRenderer?cellName=horizontalList1
	class HooHorizontalListOneCell < GUI::Core::HooCell

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
