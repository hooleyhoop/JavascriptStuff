module Gui
	class HooWidgetList

		# Can't get this type of thing to work
		#require "gui/views/drawing.rb"

		@@layouts = {}
		@@widgets = {}
		@@cells = {}

		#	'fixedWidthSingleCol'			=>	Gui::Layouts::HooFixedSingleColView.name,
		#	'elasticColRight'				=>	Gui::Layouts::HooElasticColRightView.name,
		#	'elasticColLeft'				=>	Gui::Layouts::HooElasticColLeftView.name,
		#	'elasticColBoth'				=>	Gui::Layouts::HooElasticColBothView.name
		#}

		# To construct the widget list at runtime
		def self.registerWidget( widget )
			if registered? widget
				Rails.logger.warn "Widget #{widget.name} already registered"
			else
				@@widgets[widget.dslName] = widget
				#puts "#{widget.dslName} added to widget list"
			end
		end

		def self.registered?( widget )
			@@widgets.include? widget.dslName
		end

		def self.layoutClass( name )

			layoutName = @@layouts[name]
			if layoutName.nil?
				raise "Layout "+name+" not found!"
			end
			layoutName.constantize
		end

		def self.widgets
			@@widgets
		end

		def self.widgetNames
			@@widgets.keys
		end

		#def self.widgetPaths
		#	@@widgets.values
		#end

		def self.scanViewDir()
			thisDir = File.dirname(__FILE__)
			# just child directories
			Dir.glob( "#{thisDir}/*" ).select do |subdir|
				# recursive .rb files
				Dir.glob( "#{subdir}/**/*.rb" ).each do |f|
					f.sub! "#{Rails.root}/lib/", ''
					f.sub! ".rb", ''
					# thisClassName = f.classify - NB! classify changes plural to singular
					thisClassName = f.to_s.sub(/.*\./, '').camelize
					#puts "> Found class #{f} - #{thisClassName}"
					thisClass = thisClassName.constantize()
					if thisClass.respond_to?( 'dslName' )
						self.registerWidget( thisClass )
					end
				end
			end
		end

		@@hasScanned = false
		def self.widgetClass( name )

			#first time thru build the widget list
			unless @@hasScanned
				puts "scanning"
				self.scanViewDir()
				@@hasScanned = true
			end
			foundClass = @@widgets[name]
			if foundClass.nil?
				raise "Widget "+name+" not found!"
			end
			return foundClass
		end


		#@@cells = {
		#	'list1'					=>	Gui::Cells::HooListOneCell.name,
		#	'horizontalList1'		=>	Gui::Cells::HooHorizontalListOneCell.name,
		#	'sparseBooCell'	    	=>	Gui::Cells::HooSparseBooCell.name,
		#	'hoo_user_comment_cell' =>	Gui::Cells::HooUserCommentCell.name,
		#	'actionButton1' 		=>	Gui::Cells::HooActionButton1Cell.name,
		#	'flashReplaceTestCell' 	=>	Gui::Cells::FlashReplaceTestCell.name,
		#}

		def self.cellClass( name )
			cellName = @@cells[name]
			if cellName.nil?
				raise "Cell "+name+" not found!"
			end
			cellName.constantize
		end

	end
end
