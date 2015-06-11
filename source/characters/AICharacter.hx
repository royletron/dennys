package characters;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import weapons.Weapon;
import utils.D;

class AICharacter extends Character
{
  private var target:Character;
  public var range:Float = 80.0;
  private var brains:Bool = false;
  private var boredcolor:Int = FlxColor.CORAL;
  private var activecolor:Int = FlxColor.CRIMSON;
  public function new(X:Float, Y:Float)
  {
    super(X, Y);
    makeGraphic(16, 16, boredcolor);
  }

  public function setTarget(target:Character)
  {
    this.target = target;
  }

  override public function update()
  {
    if((target != null) && !brains)
    {
      if(D.getDistance(new FlxPoint(this.x, this.y), new FlxPoint(target.x, target.y)) < range)
      {
        brains = true;
        makeGraphic(16, 16, activecolor);
      }
    }
    if(brains)
    {
      var character:FlxPoint = new FlxPoint(this.x, this.y);
      var targetpoint:FlxPoint = new FlxPoint(target.x, target.y);
      var distance:Float = D.getDistance(character, targetpoint);
      var direction:FlxPoint = new FlxPoint((targetpoint.x - character.x)/distance, (targetpoint.y - character.y)/distance);
      acceleration.x = direction.x * (speed*4);
      acceleration.y = direction.y * (speed*4);
      if(distance > range)
      {
        acceleration.x = acceleration.y = 0;
        brains = false;
        makeGraphic(16, 16, boredcolor);
      }
    }
    super.update();
  }

  override public function updateControls()
  {

  }

}
