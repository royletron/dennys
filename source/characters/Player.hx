package characters;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.ui.FlxAnalog;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import weapons.BlockSword;

class Player extends Character
{
  public var controller:FlxAnalog;
  public function new(X:Float=0, Y:Float=0)
  {
    super(X, Y);
    speed = 80;
    setPhysics();
    makeGraphic(16, 16, FlxColor.BLUE);
    weapon = new BlockSword(this);
    FlxG.state.add(weapon);
  }

  override public function updateControls()
  {
    super.updateControls();

    var movement:FlxPoint = new FlxPoint();

    if(controller == null)
    {
      if (FlxG.keys.pressed.LEFT)
        movement.x -= 1;
      if (FlxG.keys.pressed.RIGHT)
        movement.x += 1;
      if (FlxG.keys.pressed.UP)
        movement.y -= 1;
      if (FlxG.keys.pressed.DOWN)
        movement.y += 1;

      if (movement.x < 0)
        moveLeft();
      else if (movement.x > 0)
        moveRight();
      if (movement.y < 0)
        moveUp();
      else if (movement.y > 0)
        moveDown();
    }
    else{
      acceleration.x = (controller.acceleration.x/40) * (speed*4);
      acceleration.y = (controller.acceleration.y/40) * (speed*4);
    }

    if(FlxG.keys.pressed.X)
      weapon.fire();
  }
}
