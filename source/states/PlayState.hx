package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxCamera;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.ui.FlxAnalog;

import characters.Character;
import characters.Player;
import characters.AICharacter;
import utils.TiledLevel;
import objects.ActionObject;
import weapons.Projectile;
import flixel.group.FlxTypedGroup;

import flixel.addons.editors.tiled.TiledTile;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var player:Player;
	private var _controller:FlxAnalog;
	private var level:TiledLevel;
	private var baddieTime:Float = 0;
	private var baddieRate:Float = 5;
	private var collideGroup:FlxGroup = new FlxGroup();
	private var bulletArray:FlxTypedGroup<Projectile> = new FlxTypedGroup<Projectile>();
	private var baddieArray:FlxTypedGroup<AICharacter> = new FlxTypedGroup<AICharacter>();
	private var obstacleArray:FlxTypedGroup<ActionObject> = new FlxTypedGroup<ActionObject>();
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();

		level = new TiledLevel("assets/tiled/urban.tmx");
		add(level.backgroundTiles);
		player = new Player(30, 30, bulletArray);
		add(obstacleArray);
		add(player);
		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);
		add(baddieArray);
		add(level.foregroundTiles);
		#if ios
		_controller = new FlxAnalog(80, 340, 20);
		add(_controller);
		player.controller = _controller;
		#end

		collideGroup.add(player);
		collideGroup.add(baddieArray);
		add(bulletArray);

		for(enemy in level.enemies)
		{
			if(enemy.name.toLowerCase() == 'zombie')
			{
				var baddie:AICharacter = new AICharacter(enemy.position.x, enemy.position.y, bulletArray);
				baddie.x += -baddie.width/2;
				baddie.y += -baddie.height/2;
				baddie.setTarget(player);
				baddieArray.add(baddie);
			}
		}

		for(obstacle in level.obstacles)
		{
			var ob:ActionObject = new ActionObject(obstacle.position.x, obstacle.position.y, player);
			obstacleArray.add(ob);
		}
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
		FlxG.collide(player.weapon, baddieArray);
		FlxG.collide(baddieArray);
		FlxG.collide(player, baddieArray, characterCollide);
		FlxG.collide(collideGroup, bulletArray, gotShot);
		FlxG.collide(level.foregroundTiles, bulletArray, hitWall);
		FlxG.collide(level.foregroundTiles, collideGroup);
		super.update();

		/*if(baddieTime > baddieRate)
		{
			var _baddie:AICharacter = new AICharacter(Math.random()*200, Math.random()*400, bulletArray);
			_baddie.setTarget(player);
			baddieArray.add(_baddie);
			baddieTime = 0;
			baddieRate = 3 + (Math.random()*10);
		}
		else{
			baddieTime += FlxG.elapsed;
		}*/
	}

	public function hitWall(tile:TiledTile, bullet:Projectile)
	{
		bulletArray.remove(bullet);
		bullet.destroy();
	}

	public function gotShot(character:Character, bullet:Projectile)
	{
		bulletArray.remove(bullet);
		character.hurt(bullet.damage);
		//hurt...?
		bullet.destroy();
	}

	public function characterCollide(player:Character, baddie:Character)
	{
		baddie.collide(player);
	}
}
