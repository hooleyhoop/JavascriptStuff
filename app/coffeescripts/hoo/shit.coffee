ABoo.FirstGo = HooWidget.extend

	_imgItems: undefined
	_view: undefined
	_count: 0
	
	init:() ->
		@_super()
		
		#find the images.
		@_imgItems = @div$.find("img")
		@_imgItems.remove()

		@._view = SC.View.create()
		@constructTemplate()
		
	parentDidResize:() ->
		@_count++
		@constructTemplate()
		
	constructTemplate:() ->

		newWidth = @div$.width()
		newHeight = @div$.height()

		@_view.remove()
		templateText = "** This text compiled from template **
		<div style='width:100px; height:100px; background-color:blue;'><div>
		"
		#templateText = templateText + "yaaaaaa"
		
		#@_imgItems.each( (ind, img) => 
		#    templateText = templateText + "yaaaaaa \n"
		#	console.log "hello"
		#)
		#console.log templateText
		
		template = SC.Handlebars.compile( templateText )
		#  //SC.TEMPLATES["helloWorld"] = template;

		@_view.set( "template", template )
		@_view.appendTo( @div$ )

		