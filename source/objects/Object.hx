package objects;

import characters.Player;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import flixel.FlxG;

class Object extends FlxGroup
{
	public var x:Float;
	public var y:Float;
	
	public var main:FlxSprite = new FlxSprite();
	
	public var player:FlxSprite;
	
	public function new(X:Float, Y:Float, player:Player)
	{
		super();
		this.player = player;

		this.x = main.x = X;
		this.y = main.y = Y;
		
		add(main);
	}	
}