package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.util.FlxColor;

//Contains all information about the player and it's functions
class Player extends FlxSprite
{
	public var score:Int;
	public var speed:Int;
	public var hasFlag:Bool;
	public var usingCursor:Bool; //True = Cursor on False = Cursor off
	public var destroyOrCreate:Bool; //True = Create mode False = Destroy modes
	public var keys:String;
	public var xpos:Int;
	public var ypos:Int;

	private var up:Bool;
	private var left:Bool;
	private var right:Bool;
	private var down:Bool;
	private var stunTime:Int;
	private var inStun:Bool;
	private var stunnedAtTime:Float;
	public var cursor:Cursor;

	//Controls should be configured as: Up, Left, Down, Right, TCursor, TCursorMode, Rotate, PlaceBlock
	public function new(controls:String, x:Int, y:Int)
	{
		//Set visible data
		score = 0;
		speed = 300;
		hasFlag = false;
		usingCursor = false;
		destroyOrCreate = true;
		keys = controls;
		xpos = x;
		ypos = y;
		//Things only I will use
		up = false;
		left = false;
		right = false;
		down = false;
		inStun = false;
		stunTime = 2;
		super(x, y);
		makeGraphic(16, 16, FlxColor.GREEN);
		drag.x = drag.y = 2400;
	}

	//Stun function that when called will stun the player
	public function stun():Void
	{
		this.inStun = true;
		this.stunnedAtTime = 0;
	}

	public function movement():Void
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

	public function toggleCursor():Void
	{
		if (FlxG.keys.anyJustPressed([keys.charAt(4)]))
			usingCursor = !usingCursor;
		if (usingCursor)
		{
			cursor.setVisible();
		}
		else 
		{
			//cursor.kill();
			destroyOrCreate = true;
		}
	}

	public function toggleCreate():Void
	{
		if (FlxG.keys.anyJustPressed([keys.charAt(5)]))
		{
			destroyOrCreate = !destroyOrCreate;
			if (destroyOrCreate)
				cursor.replaceColor(FlxColor.RED, FlxColor.BLUE);
			else
				cursor.replaceColor(FlxColor.BLUE, FlxColor.RED);
		}
	}

	//Using this function to test stun atm
	public function rotateCursor():Void
	{
		if (FlxG.keys.anyJustPressed([keys.charAt(6)]))
			stun();
	}

	public function placement(mode:Bool):Void
	{
		if (FlxG.keys.anyJustPressed([keys.charAt(7)]))
		{
			if (mode)	//Create on button press
			{

			}
			else //Destroy on button press
			{

			}
		}
	}

	public function toggleFlag():Void
	{
		hasFlag = !hasFlag;
	}

	override public function update(elapsed:Float):Void
	{
		if (inStun)
		{
			stunnedAtTime+=elapsed;
			if (stunnedAtTime >= stunTime)
				inStun = false;
		}	//Individual player controls
		else 
		{
			toggleCursor();
			if (usingCursor)
			{
				toggleCreate();
				rotateCursor();
				cursor.cursorMovement(keys);
				placement(destroyOrCreate);
			}
			else
				movement();
		}

		super.update(elapsed);
	}
}