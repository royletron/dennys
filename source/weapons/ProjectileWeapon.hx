package weapons;

import characters.Character;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;

class ProjectileWeapon extends Weapon
{

  private var targetDirection:FlxPoint = new FlxPoint();

  public function new(holder:Character)
  {
    super(holder);
    isProjectile = true;
  }

  override public function fireAt(X:Float, Y:Float)
  {
    targetDirection.x = X;
    targetDirection.y = Y;
    super.fire();
  }

  override public function firing()
  {
    super.firing();
    _holder.bulletArray.add(new Projectile(_holder, 200, 4, targetDirection));
  }
}
