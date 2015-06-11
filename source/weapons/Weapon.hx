package weapons;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import characters.Character;

class Weapon extends FlxSprite
{
  public var damage:Float = 10.0;
  public var reload:Float = 0.8;
  public var striketime:Float = 0.2;
  private var _active:Bool = false;
  private var _timer:Float = 0.0;
  private var _holder:Character;
  public var hit:Bool = false;
  public function new(holder:Character)
  {
    _holder = holder;
    super(holder.x, holder.y);
    _active = false;
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
      firing();
    }
  }

  public function firing()
  {
    _timer = 0;
    _active = hit = true;
  }

  public function striking()
  {

  }

  public function hitting()
  {

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

      if((_timer > striketime) && hit)
        hit = false;

      if(hit)
        hitting();
      else
        striking();

      if(_timer > reload)
        _active = false;
    }
    super.update();
  }
}
