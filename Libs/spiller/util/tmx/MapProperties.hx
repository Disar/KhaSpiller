package spiller.util.tmx;


/**
 * Hold all the properties of the TMX file.<br>
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/09/2014
 * @author ratalaika / Ratalaika Games
 */
class MapProperties
{
	/**
	 * The properties.
	 */
	private var _properties:Map<String, Dynamic>;

	/**
	 * Class constructor.
	 * 
	 * @param source The XML to create the properties with.
	 */
	public function new(source:Dynamic)
	{
		_properties = new Map<String, Dynamic>();
		if (source != null)
			this.readProperties(source);
	}

	/**
	 * Expand the current properties of this class.
	 * 
	 * @param source The XML to expand the properties with.
	 */
	public function readProperties(source:Dynamic):MapProperties
	{		
		// Loop throw all properties
		var keys = Reflect.fields(source);
		for (key in keys) {
			_properties.set(key, Reflect.field(source, key));
		}

		return this;
	}

	/**
	 * Returns a property if exists.
	 */
	public function get(key:String):Dynamic
	{
		return _properties.get(key);
	}

	/**
	 * Set a property.
	 */
	public function set(key:String, value:Dynamic):Void
	{
		_properties.set(key, value);
	}
}
