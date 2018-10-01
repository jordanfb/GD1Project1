package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import openfl.Assets;
import flixel.FlxObject;
import flixel.math.FlxPoint;
import Math;


//Contains all information about the player and it's functions
class Player extends FlxSprite
{
	public var score:Int;
	public var speed:Float;
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
	public var inStun:Bool;
	private var stunnedAtTime:Float;
	private var filepath:String;
	private var sprite:FlxGraphicAsset;
	private var hasJump:Bool;
	private var justUsed:Bool;
	private var coolDown:Int;
	private var coolDownTime:Float;
	public var cursor:Cursor;
	private var prevVelocity:FlxPoint;
	private var fallingToggle:Bool; // this is for the falling animation just deal with the hack because it's terrible
	private var isHuman:Bool;

	//Controls should be configured as: Up, Left, Down, Right, TCursor, TCursorMode, Rotate, PlaceBlock
	public function new(controls:String, artpath:String, x:Int, y:Int, characterScale:Float)
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
		justUsed = false;
		fallingToggle = false;
		stunTime = 3;
		coolDown = 1;
		coolDownTime = 0;
		filepath = artpath;
		super(x, y);
		isHuman = artpath == "assets/images/human.png";
		if (isHuman)
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
			animation.add("stun", [26, 16, 18, 17, 23, 27, 24, 1], 12 , true);

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
			animation.add("stun", [14, 13, 9, 3, 6], 8, true);
		}
		// this.scale.x = scale;
		// trace("SCALE: " + scale);
		setFacingFlip(FlxObject.LEFT, false, false);
		setFacingFlip(FlxObject.RIGHT, true, false);
		animation.finishCallback = handleNextAnimation;
		this.scale.set(characterScale, characterScale);
		this.updateHitbox();
		var oldWidth = this.width;
		// trace(scale);
		this.width = this.width/3; // halve your width probably if not more
		this.offset.x = this.offset.x+24; // (this.width - oldWidth)/2 * characterScale; // -characterScale; // this.width/2*characterScale; //
		
		if (isHuman) {
			// update the hitbox so it's not weird.
			// this.height = this.height -100;
			this.offset.set(this.offset.x, this.offset.y - 10); // test -12
			// updateHitbox();
		}
		// this.scale.y = scale;
		//makeGraphic(16, 16, FlxColor.GREEN);
		drag.x = 880;
		acceleration.y = 300;
		maxVelocity.y = 500;
		prevVelocity = new FlxPoint(0, 0);
	}

	private function handleNextAnimation(v:String):Void {
		// trace(v);
		if (v != "walk" && v != "stun")
			animation.play(v + " loop");
		// trace(animation.curAnim.name);
	}

	//Stun function that when called will stun the player
	public function stun():Void
	{
		this.inStun = true;
		this.stunnedAtTime = 0;
		animation.play("stun");
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
			velocity.y = -350;
		}
		if (isTouching(FlxObject.DOWN)/* || isTouching(FlxObject.RIGHT) || isTouching(FlxObject.LEFT)*/)
			hasJump = true;
		else
			hasJump = false;
		if (down && velocity.y < 0)
			acceleration.y += 50;
		if (isTouching(FlxObject.DOWN))
			acceleration.y = 300;

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
				cursor.setTotalPosition(this.getPosition().x, this.getPosition().y);
				cursor.revive();
				cursor.reviveSpriteList();
			}
			else 
			{
				cursor.kill();
				cursor.killSpriteList();
				animation.play("idle");
				if (!destroyOrCreate)
				{
					destroyOrCreate = true;
					cursor.swapColor(true, filepath);
				}
			}
		}
	}

	public function toggleCreate():Void
	{
		if (FlxG.keys.anyJustPressed([keys.charAt(5)]))
		{
			destroyOrCreate = !destroyOrCreate;
			cursor.swapColor(destroyOrCreate, filepath);
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
				cursor.createBlock();
			}
			else //Destroy on button press
			{
				cursor.destroyBlock();
			}
			coolDownTime = 0;
			justUsed = true;
		}
	}

	public function toggleFlag():Void
	{
		hasFlag = !hasFlag;
		setHasFlag(hasFlag);
	}

	public function setHasFlag(has:Bool) : Void {
		hasFlag = has;
		if (hasFlag) {
			speed = speed*.7;
			coolDown = 2;
		}
		else {
			speed = 10*speed/7;
			coolDown = 1;
		}
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
				if (justUsed)
				{
					coolDownTime+=elapsed;
					if (coolDownTime >= coolDown)
						justUsed = false;
					var a = (coolDownTime / coolDown);
					cursor.setAlpha(a*a*.7 + .3); // so that it fades into existence when it's ready to use
				}
				else
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