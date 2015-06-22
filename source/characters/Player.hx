package characters;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.ui.FlxAnalog;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import weapons.Pistol;
import weapons.Projectile;
import weapons.ProjectileWeapon;
import flixel.group.FlxTypedGroup;

class Player extends Character
{
  public var controller:FlxAnalog;
  
  private var standard:Int = FlxColor.BLUE;
  private var warm:Int = FlxColor.MAGENTA;
  
  public var ready(default, set):Bool; 
  
  public function new(X:Float=0, Y:Float=0, bulletArray:FlxTypedGroup<Projectile>)
  {
    super(X, Y, bulletArray);
    speed = 80;
    setPhysics();
    makeGraphic(16, 16, standard);
    weapon = new Pistol(this);
    FlxG.state.add(weapon);
  }
  
  public function set_ready(val:Bool):Bool
  {
	if (val && !ready)
	{
	  makeGraphic(16, 16, warm);
	}
	if (!val && ready)
	{
	  makeGraphic(16, 16, standard);
	}
	return ready = val;
  }

  override public function updateControls()
  {
    super.updateControls();

    var movement:FlxPoint = new FlxPoint();

    if(controller == null)
    {
      if (FlxG.keys.pressed.A)
        movement.x -= 1;
      if (FlxG.keys.pressed.D)
        movement.x += 1;
      if (FlxG.keys.pressed.W)
        movement.y -= 1;
      if (FlxG.keys.pressed.S)
        movement.y += 1;

      if (movement.x < 0)
        moveLeft();
      else if (movement.x > 0)
        moveRight();
      if (movement.y < 0)
        moveUp();
      else if (movement.y > 0)
        moveDown();

      if (FlxG.keys.pressed.UP)
      {
        facing = FlxObject.UP;
        if(weapon.isProjectile)
          weapon.fireAt(0, -1);
        else
          weapon.fire();
      }
      if (FlxG.keys.pressed.RIGHT)
      {
        facing = FlxObject.RIGHT;
        if(weapon.isProjectile)
          weapon.fireAt(1, 0);
        else
          weapon.fire();
      }
      if (FlxG.keys.pressed.LEFT)
      {
        facing = FlxObject.LEFT;
        if(weapon.isProjectile)
          weapon.fireAt(-1, 0);
        else
          weapon.fire();
      }
      if (FlxG.keys.pressed.DOWN)
      {
        facing = FlxObject.DOWN;
        if(weapon.isProjectile)
          weapon.fireAt(0, 1);
        else
          weapon.fire();
      }

    }
    else{
      acceleration.x = (controller.acceleration.x/40) * (speed*4);
      acceleration.y = (controller.acceleration.y/40) * (speed*4);
    }

  }
}
