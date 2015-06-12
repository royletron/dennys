package weapons;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import characters.Character;

class Projectile extends FlxSprite
{
  private var speed:Float;
  public var damage:Float;
  private var holder:Character;

  public function new(holder:Character, Speed:Float, Damage:Float, Direction:FlxPoint)
  {
    var l:FlxPoint = holder.getMidpoint();

    super(l.x,l.y);
    speed = Speed;
    damage = Damage;
    makeGraphic(4, 4, FlxColor.PURPLE);

    velocity.x = Direction.x * Speed;
    velocity.y = Direction.y * Speed;
  }
}
