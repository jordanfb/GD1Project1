package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;
import flixel.FlxObject;
import flixel.math.FlxPoint;


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
	private var hasJump:Bool;
	public var cursor:Cursor;

	private var prevVelocity:FlxPoint;

	private var fallingToggle:Bool; // this is for the falling animation just deal with the hack because it's terrible

	//Controls should be configured as: Up, Left, Down, Right, TCursor, TCursorMode, Rotate, PlaceBlock
	public function new(controls:String, artpath:String, x:Int, y:Int, scale:Float)
	{
		//Set visible data
		score = 0;
		speed = 110;
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
		hasJump = true;
		fallingToggle = false;
		stunTime = 2;
		filepath = artpath;
		super(x, y);
		
		if (artpath == "assets/images/human.png")
		{
			loadGraphic(artpath, true, 336, 400);
			animation.add("walk", [11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24], 12, false);
			animation.add("jump", [24, 25, 26, 27], 12, false);
			animation.add("jump loop", [27], 12, true);
			animation.add("falling", [28, 29, 30, 31, 32, 33, 34], 12, false);
			animation.add("falling loop", [34], 12, true);
			animation.add("idle", [1], 12, true);
			animation.add("placing", [2, 3, 4, 5, 6, 7, 8, 9], 12, false);
			animation.add("placing loop", [8, 9], 12, true);

		}
		else
		{
			loadGraphic(artpath, true, 310, 400);
			animation.add("walk", [2, 3, 4, 5], 8, false);
			animation.add("falling", [9, 10, 11, 12, 13], 8, false);
			animation.add("falling loop", [13], 8, true);
			animation.add("jump", [6, 7, 8], 8, false);
			animation.add("jump loop", [8], 8, true);
			animation.add("idle", [14], 8, true);
			animation.add("placing", [14, 11, 12, 13], 8, false);
			animation.add("placing loop", [12, 13], 8, true);

		}
		// this.scale.x = scale;
		// trace("SCALE: " + scale);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.finishCallback = handleNextAnimation;
		this.scale.set(scale, scale);
		this.updateHitbox();
		// this.scale.y = scale;
		//makeGraphic(16, 16, FlxColor.GREEN);
		drag.x = 880;
		acceleration.y = 175;
		maxVelocity.y = 250;
		prevVelocity = new FlxPoint(0, 0);
	}

	private function handleNextAnimation(v:String):Void {
		// trace(v);
		animation.play(v + " loop");
		// trace(animation.curAnim.name);
	}

	//Stun function that when called will stun the player
	public function stun():Void
	{
		this.inStun = true;
		this.stunnedAtTime = 0;
	}

	public function movement():Void
	{
		up = FlxG.keys.anyJustPressed([keys.charAt(0)]);
		left = FlxG.keys.anyPressed([keys.charAt(1)]);
		down = FlxG.keys.anyPressed([keys.charAt(2)]);
		right = FlxG.keys.anyPressed([keys.charAt(3)]);

		//if (up && down)
		//	up = down = false;
		if (left && right)
			left = right = false;

		if (left) {
			velocity.x = speed*-1;
			facing = FlxObject.LEFT;
		}
		if (right){
			velocity.x = speed;
			facing = FlxObject.RIGHT;
		}
		if (up && hasJump)
		{
			hasJump = false;
			velocity.y = -200;
		}
		if (isTouching(FlxObject.DOWN) || isTouching(FlxObject.RIGHT) || isTouching(FlxObject.LEFT))
			hasJump = true;
		else
			hasJump = false;
		if (down && velocity.y < 0)
			acceleration.y += 15;
		if (isTouching(FlxObject.DOWN))
			acceleration.y = 175;

		if (velocity.x != 0 && velocity.y == 0){
			// trace("walking");
			animation.play("walk");
			fallingToggle = false;
		}else if (velocity.y < 0 && prevVelocity.y >= 0) {
			// trace("umping");
			animation.play("jump");
			fallingToggle = false;
		}else if (velocity.y > 0 && !fallingToggle) {
			// trace("OH MY GOOLLY GEEE WE FELL");
			animation.play("falling");
			fallingToggle = true;
		}
		else if (velocity.x == 0 && velocity.y == 0 && !usingCursor) {
			// trace("idle");
			animation.play("idle");
			fallingToggle = false;
		}
	}

	public function toggleCursor():Void
	{
		if (FlxG.keys.anyJustPressed([keys.charAt(4)]))
		{	
			usingCursor = !usingCursor;
			if (usingCursor)
			{
				animation.play("placing");
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
		prevVelocity.set(velocity.x, velocity.y);
	}
}