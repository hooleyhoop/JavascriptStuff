
class HooTest

 	attr_accessor :mileage;

  def initialize( args={} )
    super args
    args.each do |key, value|
      # note, this wont use the setter
      # instance_variable_set( "@#{key}", value );

      # this will call the setter mileage=
      #self.send("#{key}=", value)

      # ie the setter for foo is foo=
      setterMethodName = "#{key}="
      if( respond_to?( setterMethodName ) )
        self.send( setterMethodName, value );
      else
        instanceVarName = "@#{key}"
        instance_variable_set( instanceVarName, value );
      end
    end
  end

  #accessors
  def mileage=(x)
    @mileage = x
    puts 'cock sucker'
  end

  def mileage
    @mileage
  end


end

bimpyMcNorty = HooTest.new( { :mileage=>10 } );
#puts( bimpyMcNorty.mileage )

#bimpyMcNorty.mileage = 10;
