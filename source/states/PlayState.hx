package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxAnalog;

import characters.Player;
import characters.AICharacter;
import utils.TiledLevel;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _player:Player;
	private var _baddie:AICharacter;
	private var _controller:FlxAnalog;
	private var level:TiledLevel;
	private var collideGroup:FlxGroup = new FlxGroup();
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		trace('hello player');
		level = new TiledLevel("assets/tiled/urban.tmx");
		add(level.backgroundTiles);
		_player = new Player(30, 30);
		add(_player);
		add(level.foregroundTiles);
		_baddie = new AICharacter(90, 90);
		_baddie.setTarget(_player);
		add(_baddie);
		#if ios
		_controller = new FlxAnalog(80, 340, 20);
		add(_controller);
		_player.controller = _controller;
		#end

		collideGroup.add(_player);
		collideGroup.add(_baddie);
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		FlxG.collide(_player.weapon, _baddie);
		FlxG.collide(level.foregroundTiles, collideGroup);
		super.update();
	}
}
