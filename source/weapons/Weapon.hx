package weapons;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import characters.Character;

class Weapon extends FlxSprite
{
  public var damage:Float = 10.0;
  public var reload:Float = 2;
  public var striketime:Float = 1;
  private var _active:Bool = false;
  private var _timer:Float = 0.0;
  private var _holder:Character;
  public var hit:Bool = false;
  public function new(holder:Character)
  {
    _holder = holder;
    super(holder.x, holder.y);
    _active = false;
    makeGraphic(16, 16, FlxColor.GREEN);
  }

  public function updatePosition()
  {
    if((_holder.facing == FlxObject.UP) || (_holder.facing == FlxObject.DOWN))
    {
      x = _holder.x;
    }
    else
    {
      if(_holder.facing == FlxObject.RIGHT)
      {
        x = _holder.x + _holder.width;
      }
      else
      {
        x = _holder.x - width;
      }
    }

    if((_holder.facing == FlxObject.RIGHT) || (_holder.facing == FlxObject.LEFT))
    {
      y = _holder.y + ((_holder.height/2) - (height/2));
    }
    else
    {
      if(_holder.facing == FlxObject.UP)
      {
        y = _holder.y - height;
      }
      else
      {
        y = _holder.y + _holder.height;
      }
    }
  }

  public function fire()
  {
    if(!_active)
    {
      _timer = 0;
      _active = hit = true;
      replaceColor(FlxColor.GREEN, FlxColor.RED);
    }
  }

  override public function update()
  {
    if(!_active)
    {
      this.visible = false;
      this.solid = false;
    }
    else
    {
      _timer = _timer + FlxG.elapsed;
      this.visible = true;
      this.alpha = 1 - _timer/reload;
      if((_timer > striketime) && hit)
      {
        replaceColor(FlxColor.RED, FlxColor.GREEN);
        hit = false;
      }
      if(!hit)
      {
        this.solid = false;
      }
      else
      {
        this.solid = true;
      }
      if(_timer > reload)
      {
        _active = false;
      }
    }
    super.update();
  }
}
