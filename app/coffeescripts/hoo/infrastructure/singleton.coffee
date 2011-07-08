ABoo.SingletonClassMethods = SC.Mixin.create

	_sharedInstance: undefined

	sharedInstance: () ->
		if( !@_sharedInstance? )
			@_sharedInstance = @create()
		return @_sharedInstance
