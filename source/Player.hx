package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;

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
	private var filepath:String;
	private var sprite:FlxGraphicAsset;
	public var cursor:Cursor;

	//Controls should be configured as: Up, Left, Down, Right, TCursor, TCursorMode, Rotate, PlaceBlock
	public function new(controls:String, artpath:String, x:Int, y:Int)
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
		filepath = artpath;
		super(x, y);
		loadGraphic(artpath, true, 200, 400);
		if (artpath == "assets/images/human.png")
		{
			animation.add("walk", [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24], 12, false);
			animation.add("jump", [24, 25, 26, 27], 12, false);
			animation.add("jump end", [27], 12, true);
			animation.add("falling", [28, 29, 30, 31, 32, 33, 34], 12, false);
			animation.add("falling end", [34], 12, true);
			animation.add("idle", [1], 12, true);
			animation.add("placing", [2, 3, 4, 5, 6, 7, 8, 9, 10], 12, false);
			animation.add("placing loop", [9, 10], 12, true);

		}
		else
		{
			animation.add("walk", [2, 3, 4, 5], 8, false);
			animation.add("falling", [9, 10, 11, 12, 13, 14], 8, false);
			animation.add("falling end", [14], 8, true);
			animation.add("jump", [6, 7, 8], 8, false);
			animation.add("jump end", [8], 8, true);
			animation.add("idle", [1], 8, true);
			animation.add("placing", [15], 8, false);
			animation.add("placing loop", [15], 8, true);

		}

		//makeGraphic(16, 16, FlxColor.GREEN);
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


		if (velocity.x != 0 && velocity.y == 0)
			animation.play("walk");
		else if (velocity.y > 0)
			animation.play("jump");
		else if (velocity.y < 0)
			animation.play("falling");
		else
			animation.play("idle");
	}

	public function toggleCursor():Void
	{
		if (FlxG.keys.anyJustPressed([keys.charAt(4)]))
		{	
			usingCursor = !usingCursor;
			if (usingCursor)
			{
				animation.play("placing");
				animation.play("placing loop");
				cursor.setPosition(this.getPosition().x, this.getPosition().y);
				cursor.revive();
			}
			else 
			{
				cursor.kill();
				animation.play("idle");
				if (!destroyOrCreate)
				{
					destroyOrCreate = true;
					cursor.replaceColor(FlxColor.RED, FlxColor.BLUE);
				}
			}
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
			//stun(); //TESTING THIS FUNCTION WITH THIS KEYBIND
		{
			cursor.angle+=90;
		}
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
			{
				movement();
			}
		}

		super.update(elapsed);
	}
}