ABoo.DebugView = SC.View.extend

	firstBindingTest: "version 2 - I have no idea!!"
	normalClass: "steve"
	# remainingBinding: "Todos.todosController.remaining"
	remaining: 2

	mouseDown: () ->
		console.log("!!clicky clicky doHicky!!!..")

	flippyStateDidChange: () ->
		alert("yay! i can go home now?")

	remainingString: (() ->
		remaining = @get('remaining')
		return remaining + ( remaining==1 ? " item" : " items" )
	).property('remaining').cacheable()	# property remaining string depends on remaining

ABoo.HackedWidget = ABoo.SCView.extend
	#json: undefined
	#id: undefined
	#div$: undefined

	###
		id + json are set when created
		we could rationalise this a bit..
		sproutcore this[SC.GUID_KEY] is the same as out id
		sproutcore's element is the same as our div$
	###
	init:() ->
		#this[SC.GUID_KEY] = @id					
		@_super()

		#if not @div$				
		#	@div$ = $( "#"+@id )

		#@div$.remove()
		#SC.beginPropertyChanges(this)
		#@_didRenderChildViews = NO
		#SC.endPropertyChanges(@)
		#@set('elementNeedsUpdate', NO)
		#@_notifyDidCreateElement()
		
		#¢@set( 'element', @div$.clone().wrap('<div></div>').parent().html() ) #.clone().wrap('<div></div>').parent().html()
		#@append()



	# Hmm, this seems to be called before init?
	didCreateElement:() ->
	    this._super()

	parentDidResize:() ->
		console.log("oh reeally..")

	mouseDown: () ->
		console.log("pfft! pffft! pffft! ..")

	
ABoo.GUI_Views_Debug_FlippyToggleThing = ABoo.SCView.extend
	_flippyState: no
	view2: undefined

	init:() ->
		@_super()

	setupDidComplete:() ->
		console.log("oh bisto..")
		# a traditional jquery event - not sure if this is what we want, but phew! it appears to still work
		@div$.bind( 'click', (e) =>
			@flippyFlip() )

		# Thinking, ids must match (div and ob)
		# div class must be sc-view
		@view2 = ABoo.DebugView.create()
		template = SC.Handlebars.compile( "<div {{bindAttr class=\"normalClass\"}} style='font-size:16px; background-color:orange'>{{firstBindingTest}}<div>" )
		@view2.set( "template", template )
		#alert(@div$)
		@view2.appendTo( @div$ )
		@view2.set( 'parentView', this )

		#-- bind something here			
		@addObserver('_flippyState', @view2, @view2.flippyStateDidChange );


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