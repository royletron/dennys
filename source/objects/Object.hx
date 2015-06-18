package objects;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Object extends FlxSprite
{
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		makeGraphic(32, 32, FlxColor.CHARCOAL);
	}	
}