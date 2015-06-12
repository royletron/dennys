package weapons;

import characters.Character;
import flixel.util.FlxColor;

class Pistol extends ProjectileWeapon
{
  private var struck:Bool = false;
  public function new(holder:Character)
  {
    super(holder);
    makeGraphic(16, 16, FlxColor.GREEN);
    striketime = 0.1;
    reload = 0.1;
  }

  override public function firing()
  {
    super.firing();
    replaceColor(FlxColor.GREEN, FlxColor.RED);
    struck = true;
    this.visible = true;
    this.alpha = 1;
  }

  override public function hitting()
  {
    this.solid = true;
  }

  override public function striking()
  {
    if(struck)
    {
      replaceColor(FlxColor.RED, FlxColor.GREEN);
      struck = false;
    }
    this.alpha = 1 - (_timer-striketime)/reload;
    this.solid = false;
  }
}
