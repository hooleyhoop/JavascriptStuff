module GUI::Views::Audioboo

	class CroppedImgWithHeader < GUI::Core::HooView

		def initialize
			super();

            tableHeaderClass = GUI::HooWidgetList.widgetClass('tableHeader');
            croppedImgClass = GUI::HooWidgetList.widgetClass('croppedImg');

            @header = tableHeaderClass.new();
            @croppedImg = croppedImgClass.new();
		end

        # Mock Data
		def setupDebugFixture
			super();
            self.label = 'smelly wagstaff'
            self.color = 'pink';
            self.path = '../images/boo/sampleImage5.jpg';
		end

		def wasAddedToParentView
		    super();
            self.addSubView( @croppedImg );
            self.addSubView( @header );
        end

        def label=( labelTxt )
            @header.label = labelTxt;
        end

        def color=( col )
            @header.color = col;
        end

        def path=( imgPath )
            @croppedImg.path = imgPath;
        end

	end
end
