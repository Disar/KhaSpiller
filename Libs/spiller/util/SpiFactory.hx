package spiller.util;

import spiller.SpiBasic;
import spiller.SpiBasic.SpiType;
import spiller.SpiGroup;
import spiller.SpiObject;

/**
 * Factory class that creates all types of Spiller objects by it's type.
 * It has an extension method you can use to add your own types!
 * <br>
 * v1.0 Initial version
 * 
 * @version 1.0 - 17/07/2013
 * @author ratalaika / ratalaikaGames
 */
class SpiFactory
{
	/**
	 * Use this to extend the functionallity with your own types and objects.
	 */
	public static var extendedFactory:SpiType->SpiBasic = null;

	/**
	 * Create a new instance of an object.
	 *
	 * @param objectType	The type of object we want to create.
	 */
	public static function create(objectType:SpiType):SpiBasic
	{
		switch (objectType) {
			case SpiType.BASIC:
				return new SpiBasic();

			case SpiType.OBJECT:
				return new SpiObject();

			case SpiType.GROUP:
				return new SpiGroup();

			case SpiType.TILEMAP:
				return null;

			default:
				if(extendedFactory == null)
					return extendedFactory(objectType);
				return null;
		}
	}
}