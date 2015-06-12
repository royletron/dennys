package characters;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.FlxObject;
import weapons.Weapon;
import weapons.Projectile;
import flixel.group.FlxTypedGroup;

class Character extends FlxSprite
{
  public var speed:Float = 60.0;
  public var weapon:Weapon;
  public var bulletArray:FlxTypedGroup<Projectile>;
  public function new(X:Float=0, Y:Float=0, bulletArray:FlxTypedGroup<Projectile>)
  {
    this.bulletArray = bulletArray;
    super(X, Y);
    facing = FlxObject.LEFT;
    setPhysics();
  }

  public function setPhysics()
  {
    maxVelocity = new FlxPoint(speed, speed);
    drag = new FlxPoint(speed * 4, speed * 4);
  }

  public function updateControls()
  {
      acceleration.x = acceleration.y = 0; // no gravity or drag by default
  }

  public function moveLeft()
  {
      facing = FlxObject.LEFT;
      acceleration.x = -speed * 4; // accelerate to top speed in 1/4 of a second
  }

  public function moveRight()
  {
      facing = FlxObject.RIGHT;
      acceleration.x = speed * 4; // accelerate to top speed in 1/4 of a second
  }

  public function moveUp()
  {
      facing = FlxObject.UP;
      acceleration.y = -speed * 4; // accelerate to top speed in 1/4 of a second
  }

  public function moveDown()
  {
      facing = FlxObject.DOWN;
      acceleration.y = speed * 4; // accelerate to top speed in 1/4 of a second
  }

  public function collide(into:Character)
  {

  }

  override public function update()
  {
    updateControls();
    if(weapon != null)
    {
      weapon.updatePosition();
    }
    super.update();
  }
}
