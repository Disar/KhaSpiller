package spiller.effects.lighting;

import kha.math.Vector3;
import spiller.SpiG;
import spiller.math.SpiPoint;
import spiller.util.SpiDestroyUtil;
import spiller.util.interfaces.ISpiDestroyable;

/**
 * The light used on the light system.
 * 
 * v1.0 Initial version
 * 
 * @version 1.0 - 24/02/2014
 * @author ratalaika / Ratalaika Games
 */
class SpiLight implements ISpiDestroyable
{
	/**
	 * The position of our light in 3D space
	 */
	private var _position:Vector3;
	/**
	 * The current attenuation of the light.
	 */
	private var _attenuation:Vector3;
	/**
	 * The current color of the light.
	 */
	private var _color:Vector3;
	/**
	 * Pre allocated to manage light point.
	 */
	private var _point:SpiPoint;
	/**
	 * The light intensity.
	 */
	private var _intensity:Float;
	/**
	 * If the light has been updated.
	 */
	private var _updated:Bool;
	
	/**
	 * Class constructor.
	 */
	public function new()
	{
		_point = SpiPoint.get();
		_position = new Vector3().add(SpiLightning.DEFAULT_LIGHT_POS);
		_attenuation = new Vector3().add(SpiLightning.DEFAULT_ATTENUATION);
		_color = new Vector3().add(SpiLightning.DEFAULT_LIGHT_COLOR);
		_intensity = SpiLightning.DEFAULT_LIGHT_INTENSITY;
		
		_updated = true;
	}

	/**
	 * Return the light attenuation as Vector3.
	 */
	public function getAttenuation():Vector3
	{
		return _attenuation;
	}
	
	/**
	 * Sets the light attenuation.
	 */
	public function setAttenuationV3(color:Vector3):Void
	{
		setAttenuation(color.x, color.y, color.z);
	}
	
	/**
	 * Sets the light attenuation.
	 */
	public function setAttenuation(X:Float, Y:Float, Z:Float):Void
	{
		_attenuation.x = X;
		_attenuation.y = Y;
		_attenuation.z = Z;
		
		_updated = true;
	}

	/**
	 * Return the light position as Vector3.
	 */
	public function getPosition():Vector3
	{
		return _position;
	}
	
	/**
	 * Return the light position.
	 */
	public function getPositionAsPoint():SpiPoint
	{
		return _point.make(_position.x, _position.y);
	}

	/**
	 * Sets the light position.
	 */
	public function setPositionV3(point:Vector3):Void
	{
		setPosition(point.x, point.y, point.z);
	}
	
	/**
	 * Sets the light position. (Keeps the current Z position).
	 */
	public function setPositionFromPoint(point:SpiPoint):Void
	{
		setPosition(point.x, point.y, _position.z);
	}
	
	/**
	 * Sets the light position.
	 */
	public function setPosition(X:Float, Y:Float, Z:Float = -999):Void
	{
		_position.x = X;
		_position.y = SpiG.height - Y; // Inverse the axis

		if(Z != -999)
			_position.z = Z;
		
		_updated = true;
	}

	/**
	 * Return the light color as Vector3.
	 */
	public function getColor():Vector3
	{
		return _color;
	}

	/**
	 * Sets the light color.
	 */
	public function setColorV3(color:Vector3):Void
	{
		setColor(color.x, color.y, color.z);
	}
	
	/**
	 * Sets the light color.
	 */
	public function setColor(R:Float, G:Float, B:Float):Void
	{
		_color.x = R;
		_color.y = G;
		_color.z = B;
		
		_updated = true;
	}

	/**
	 * Set the light intensity.
	 */
	public function setIntensity(intensity:Float):Void
	{
		_intensity = intensity;
		
		_updated = true;
	}
	
	/**
	 * Return the light intensity.
	 */
	public function getIntensity():Float
	{
		return _intensity;
	}
	
	/**
	 * If the light has been updated.
	 */
	public function needUpdate():Bool
	{
		return _updated;
	}

	/**
	 * Mark the light as update processed.
	 */
	public function updateProcessed():Void
	{
		_updated = false;
	}

	/**
	 * Destroy needed stuff.
	 */
	public function destroy():Void
	{
		_point = SpiDestroyUtil.put(_point);
		_position = null;
		_attenuation = null;
		_color = null;
	}
}