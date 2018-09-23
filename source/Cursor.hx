package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class Cursor extends FlxSprite
{
	public var xpos:Int;
	public var ypos:Int;
	public var speed:Int;
	public var cursorColor:FlxColor;

	private var left:Bool;
	private var up:Bool;
	private var right:Bool;
	private var down:Bool;

	public function new(xp:Int, yp:Int, newcolor:FlxColor)
	{
		xpos = xp;
		ypos = yp;
		color = newcolor;
		speed = 400;
		//drag.x = drag.y = 3200;
		super(xp, yp);
		drag.x = drag.y = 3200;
		makeGraphic(16, 16, FlxColor.BLUE);
	}

	public function setVisible()
	{
		makeGraphic(16, 16, cursorColor);
	}

	public function cursorMovement(keys:String):Void
	{
		up = FlxG.keys.anyPressed([keys.charAt(0)]);
		left = FlxG.keys.anyPressed([keys.charAt(1)]);
		down = FlxG.keys.anyPressed([keys.charAt(2)]);
		right = FlxG.keys.anyPressed([keys.charAt(3)]);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (left)
			velocity.x = speed*-1;
		if (right)
			velocity.x = speed;
		if (up)
			velocity.y = speed*-1;
		if (down)
			velocity.y = speed;
	}

	public function createBlock():Void
	{

	}

	public function destroyBlock():Void
	{

	}
	
	public function rotateBlock():Void
	{

	}
}