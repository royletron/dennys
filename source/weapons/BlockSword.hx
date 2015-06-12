package weapons;

import characters.Character;
import flixel.util.FlxColor;

class BlockSword extends Weapon
{
  private var struck:Bool = false;
  public function new(holder:Character)
  {
    super(holder);
    striketime = 0.8;
    makeGraphic(16, 16, FlxColor.GREEN);
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
