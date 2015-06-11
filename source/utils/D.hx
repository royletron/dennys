package utils;

import flixel.util.FlxPoint;

class D
{
  public static function getDistance(P1:FlxPoint, P2:FlxPoint)
  {
  	var XX:Float = P2.x - P1.x;
  	var YY:Float = P2.y - P1.y;
  	return Math.sqrt( XX * XX + YY * YY );
  }
}
