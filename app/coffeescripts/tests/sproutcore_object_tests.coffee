module( "Sproutcore 2 Object", {
  	setup: () ->
})

# It has to be a mixin, to mix it in, no?
ABoo.AMixinTest1 = SC.Mixin.create
	_age: undefined
	init: () ->
		HOO_nameSpace.assert( this._age?, "doh" ); #_name is set before init is called		
		@_super()
		HOO_nameSpace.assert( this._age?, "doh" );
		return this
				
ABoo.SimpleInheritanceTest1 = SC.Object.extend
	_name:			undefined
	init: () ->
		HOO_nameSpace.assert( this._name?, "doh" ); #_name is set before init is called		
		@_super()
		HOO_nameSpace.assert( this._name?, "doh" );
		return this

ABoo.SimpleInheritanceTest2 = ABoo.SimpleInheritanceTest1.extend
	init: () ->
		HOO_nameSpace.assert( this._name?, "doh" ); #_name is set before init is called		
		@_super()
		HOO_nameSpace.assert( this._name?, "doh" );
		return this

ABoo.SimpleInheritanceTest3 = ABoo.SimpleInheritanceTest1.extend( ABoo.AMixinTest1,
	init: () ->
		HOO_nameSpace.assert( this._name?, "doh" ); #_name is set before init is called		
		@_super()
		HOO_nameSpace.assert( this._name?, "doh" );
		return this
)

ABoo.SimpleInheritanceTest4 = SC.Object.extend
	_age: undefined
	init: () ->
		#HOO_nameSpace.assert( this._name?, "doh" ); #_name is set before init is called		
		@_super()
		#HOO_nameSpace.assert( this._name?, "doh" );
		return this

#ABoo.SimpleInheritanceTest5 = ABoo.SimpleInheritanceTest1.extend ABoo.SimpleInheritanceTest4,
#	init: () ->
#		HOO_nameSpace.assert( this._name?, "doh" ); #_name is set before init is called		
#		@_super()
#		HOO_nameSpace.assert( this._name?, "doh" );
#		return this
				
test( "url for flash", () ->
	ob1 = ABoo.SimpleInheritanceTest1.create( {_name:"panda"} )
	equals( ob1.get("_name"), "panda", "!" )

	ob2 = ABoo.SimpleInheritanceTest2.create( {_name:"panda"} )
	equals( ob2.get("_name"), "panda", "!" )
	
	ob3 = ABoo.SimpleInheritanceTest3.create( {_name:"panda", _age:12} )
	equals( ob3.get("_name"), "panda", "!" )
	equals( ob3.get("_age"), 12, "!" )

	# you can only mix in a mixin
	#ob4 = ABoo.SimpleInheritanceTest5.create( {_name:"panda", _age:12} )
	#equals( ob4.get("_name"), "panda", "!" )
	#equals( ob4.get("_age"), 12, "!" )
	
	
)