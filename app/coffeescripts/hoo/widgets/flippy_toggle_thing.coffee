ABoo.DebugView = SC.View.extend
	mouseDown: () ->
		console.log("!!clicky clicky doHicky!!!..")

ABoo.HackedWidget = ABoo.HooWidget.extend
	json: undefined
	id: undefined
	div$: undefined

	init:() ->
		@_super()
		if not @div$
			@div$ = $( "#"+@id )
		#@div$.remove();
		#SC.beginPropertyChanges(this);
		#@_didRenderChildViews = NO;
		#SC.endPropertyChanges(@);
		#@set('elementNeedsUpdate', NO);
		#@_notifyDidCreateElement()
		
		#¢@set( 'element', @div$.clone().wrap('<div></div>').parent().html() ) #.clone().wrap('<div></div>').parent().html()
		#@append()
		
		view2 = ABoo.DebugView.create()
		template = SC.Handlebars.compile("<div style='font-size:21px; background-color:orange'>why why why??????<div>");
		view2.set( "template", template )
		view2.appendTo( @div$ );
		
	parentDidResize:() ->
		console.log("oh reeally..")

	mouseDown: () ->
		console.log("pfft! pffft! pffft! ..")

	
ABoo.GUI_Views_Debug_FlippyToggleThing = ABoo.HackedWidget.extend
	_flippyState: no

	init:() ->
		@_super()

	setupDidComplete:() ->
		console.log("oh bisto..")		
		#@div$.bind( 'click', (e) =>
		#	@flippyFlip() )
			
	flippyFlip:() ->
		SC.RunLoop.begin()
		@set( '_flippyState', !@_flippyState )
		@updateGraphics()
		SC.RunLoop.end()

	updateGraphics:() ->
		if( @_flippyState )
			@div$.css( "background-color", "#000" )
		else
			@div$.css( "background-color", "#ff0000" )