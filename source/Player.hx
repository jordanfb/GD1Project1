package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import openfl.display.FlxSprite;

//Contains all information about the player and it's functions
class Player extends FlxSprite
{
	public var score:Int;
	public var speed:Int;
	var hasFlag:Bool;
	var usingCursor:Bool;
	var destroyOrCreate:Bool;
	var keys:String;
	var xpos:Int;
	var ypos:Int;
	
	private var up:Bool;
	private var left:Bool;
	private var right:Bool;
	private var down:Bool;
	private var stun:Bool;
	private var stunTime:Int;

	public function new(controls:String, x:Int, y:Int)
	{
		//Set visible data
		score = 0;
		speed = 30;
		hasFlag = false;
		usingCursor = false;
		destroyOrCreate = false;
		keys = controls;
		xpos = x;
		ypos = y;
		//Things only I will use
		up = false;
		left = false;
		right = false;
		down = false;
		stun = false;
		stunTime = 120;
		super(x, y);
		makeGraphic(16, 16, FlxColor.GREEN);
		drag.x = drag.y = 240;
	}

	public function stun():Void
	{

	}

	public function movement():Void
	{
		up = FlxG.keys.anyPressed([keys[0]])
		left = FlxG.keys.anyPressed([keys[1]])
		down = FlxG.keys.anyPressed([keys[2]])
		right = FlxG.keys.anyPressed([keys[3]])

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

	public function toggleCursor():Void
	{
		usingCursor = !usingCursor;
	}

	public function toggleCreate():Void
	{
		destroyOrCreate = !destroyOrCreate;
	}

	public function toggleFlag():Void
	{
		hasFlag = !hasFlag;
	}

	override public function update(elapsed:Float):Void
	{
		movement();
		super.update(elapsed);
	}


}