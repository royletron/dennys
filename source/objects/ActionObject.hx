package objects;

import characters.Player;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

class ActionObject extends Object
{
	private var off:Int = FlxColor.CHARCOAL;
	private var on:Int = FlxColor.GOLDEN;
	private var area:Int = FlxColor.FOREST_GREEN;
	
	private var top:FlxSprite = new FlxSprite();
	private var bottom:FlxSprite = new FlxSprite();
	
	public function new(X:Float, Y:Float, player:Player)
	{
	  super(X, Y, player);
		
	  main.makeGraphic(32, 32, off);
		
	  top.makeGraphic(32, 40, area);
	  bottom.makeGraphic(32, 40, area);
	  top.x = bottom.x = this.x;
	  top.y = this.y - top.height;
	  bottom.y = this.y + main.height;
		
	  add(top);
	  add(bottom);
	}
	
	override public function update()
	{
	  super.update();
	  FlxG.overlap(this, player, onOverlap);
	  FlxG.collide(main, player);
	}
	
	public function onOverlap(thisOverlap:FlxSprite, player:Player)
	{
	  trace(thisOverlap);
	}
}