module GUI::Views::Unsorted

    # http://0.0.0.0:3000/widgets/info1
	class HooInfoOneView < GUI::Core::HooView

	attr_accessor :title, :text;

	def setupDebugFixture
		super();
		@title = "Police terror training increased";
		@text = "UK security chiefs have ordered an acceleration in police training to prepare for any future Mumbai-style gun attacks in public places.";
	end

	end
end
