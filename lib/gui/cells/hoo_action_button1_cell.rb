module GUI::Cells

    # http://0.0.0.0:3000/widgets/cellRenderer?cellName=actionButton1
	class HooActionButton1Cell < GUI::Core::HooCell

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
