package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;
import Math;

class Cursor extends FlxSprite
{
	public var xpos:Int;
	public var ypos:Int;
	public var cursorColor:FlxColor;
	public var blockType:Int;
	public var cursorPoint:FlxPoint;

	private var blockList:Array<Int>;
	private var left:Bool;
	private var up:Bool;
	private var right:Bool;
	private var down:Bool;
	private var offsetList:Array<FlxPoint>;
	private var spriteList:Array<FlxSprite>;
	private var terrainRef:Terrain;

	public function new(xp:Int, yp:Int, newcolor:FlxColor, tiles:Terrain)
	{
		xpos = xp;
		ypos = yp;
		color = newcolor;
		super(xp, yp);
		drag.x = drag.y = 3200;
		makeGraphic(16, 16, newcolor);
		terrainRef = tiles;
		blockList = new Array<Int>();
		for (i in 1 ... 9) 
		{
			blockList.push(i);	
		}
		blockType = blockList[Std.int(Math.random()*8)];
		cursorPoint = new FlxPoint(0, 0);
		generateShape();
		//Do scale math to convert to points here
		cursorPoint.x = xp/(200*tiles.scale);
		cursorPoint.y = yp/(200*tiles.scale);
	}

	//public function setVisible()
	//{
	//	makeGraphic(16, 16, cursorColor);
	//}

	public function setSpriteList(x:Float, y:Float)
	{
		spriteList = new Array<FlxSprite>();
		for (i in 0...offsetList.length)
		{
			spriteList[i] = makeGraphic(16, 16, cursorColor);
		}
	}

	public function generateShape():Array<FlxPoint>
	{
		blockType = blockList[Std.int(Math.random()*8)];
		offsetList = new Array<FlxPoint>();
		if (blockType == 1)		//L
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
			offsetList.push(new FlxPoint(0, 2));
			offsetList.push(new FlxPoint(0, 3));
			offsetList.push(new FlxPoint(1, 2));
			offsetList.push(new FlxPoint(1, 3));
			offsetList.push(new FlxPoint(0, 4));
			offsetList.push(new FlxPoint(0, 5));
			offsetList.push(new FlxPoint(1, 4));
			offsetList.push(new FlxPoint(1, 5));
			offsetList.push(new FlxPoint(2, 4));
			offsetList.push(new FlxPoint(2, 5));
			offsetList.push(new FlxPoint(3, 4));
			offsetList.push(new FlxPoint(3, 5));
		}
		else if (blockType == 2)	//Backwards L
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
			offsetList.push(new FlxPoint(0, 2));
			offsetList.push(new FlxPoint(0, 3));
			offsetList.push(new FlxPoint(1, 2));
			offsetList.push(new FlxPoint(1, 3));
			offsetList.push(new FlxPoint(0, 4));
			offsetList.push(new FlxPoint(0, 5));
			offsetList.push(new FlxPoint(1, 4));
			offsetList.push(new FlxPoint(1, 5));
			offsetList.push(new FlxPoint(-2, 4));
			offsetList.push(new FlxPoint(-2, 5));
			offsetList.push(new FlxPoint(-1, 4));
			offsetList.push(new FlxPoint(-1, 5));
		}
		else if (blockType == 3) //Z
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
			offsetList.push(new FlxPoint(0, 2));
			offsetList.push(new FlxPoint(0, 3));
			offsetList.push(new FlxPoint(1, 2));
			offsetList.push(new FlxPoint(1, 3));
			offsetList.push(new FlxPoint(2, 2));
			offsetList.push(new FlxPoint(2, 3));
			offsetList.push(new FlxPoint(3, 2));
			offsetList.push(new FlxPoint(3, 3));
			offsetList.push(new FlxPoint(2, 4));
			offsetList.push(new FlxPoint(2, 5));
			offsetList.push(new FlxPoint(3, 4));
			offsetList.push(new FlxPoint(3, 5));
		}
		else if (blockType == 4) //Backwards Z
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
			offsetList.push(new FlxPoint(0, 2));
			offsetList.push(new FlxPoint(0, 3));
			offsetList.push(new FlxPoint(1, 2));
			offsetList.push(new FlxPoint(1, 3));
			offsetList.push(new FlxPoint(-1, 2));
			offsetList.push(new FlxPoint(-1, 3));
			offsetList.push(new FlxPoint(-2, 2));
			offsetList.push(new FlxPoint(-2, 3));
			offsetList.push(new FlxPoint(-1, 4));
			offsetList.push(new FlxPoint(-1, 5));
			offsetList.push(new FlxPoint(-2, 4));
			offsetList.push(new FlxPoint(-2, 5));
		}
		else if (blockType == 5) //T
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
			offsetList.push(new FlxPoint(0, 2));
			offsetList.push(new FlxPoint(0, 3));
			offsetList.push(new FlxPoint(1, 2));
			offsetList.push(new FlxPoint(1, 3));
			offsetList.push(new FlxPoint(-1, 1));
			offsetList.push(new FlxPoint(-1, 0));
			offsetList.push(new FlxPoint(-2, 1));
			offsetList.push(new FlxPoint(-2, 0));
			offsetList.push(new FlxPoint(2, 0));
			offsetList.push(new FlxPoint(2, 1));
			offsetList.push(new FlxPoint(3, 0));
			offsetList.push(new FlxPoint(3, 1));
		}
		else if (blockType == 6) //Line
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
			offsetList.push(new FlxPoint(0, 2));
			offsetList.push(new FlxPoint(0, 3));
			offsetList.push(new FlxPoint(1, 2));
			offsetList.push(new FlxPoint(1, 3));
			offsetList.push(new FlxPoint(0, 4));
			offsetList.push(new FlxPoint(0, 5));
			offsetList.push(new FlxPoint(1, 4));
			offsetList.push(new FlxPoint(1, 5));
			offsetList.push(new FlxPoint(0, 6));
			offsetList.push(new FlxPoint(0, 7));
			offsetList.push(new FlxPoint(1, 6));
			offsetList.push(new FlxPoint(1, 7));
		}
		else if (blockType == 7) //Big Box
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
			offsetList.push(new FlxPoint(0, 2));
			offsetList.push(new FlxPoint(0, 3));
			offsetList.push(new FlxPoint(1, 2));
			offsetList.push(new FlxPoint(1, 3));
			offsetList.push(new FlxPoint(2, 2));
			offsetList.push(new FlxPoint(2, 3));
			offsetList.push(new FlxPoint(3, 2));
			offsetList.push(new FlxPoint(3, 3));
			offsetList.push(new FlxPoint(2, 0));
			offsetList.push(new FlxPoint(2, 1));
			offsetList.push(new FlxPoint(3, 0));
			offsetList.push(new FlxPoint(3, 1));
		}
		else 				//Single box
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
		}
		return offsetList;
	}

	public function cursorMovement(keys:String):Void
	{
		up = FlxG.keys.anyJustPressed([keys.charAt(0)]);
		left = FlxG.keys.anyJustPressed([keys.charAt(1)]);
		down = FlxG.keys.anyJustPressed([keys.charAt(2)]);
		right = FlxG.keys.anyJustPressed([keys.charAt(3)]);

		if (left)
		{
			cursorPoint.x--;
			//if (cursorPoint.x >= 0)
			//	for (i in 0...offsetList.length)
			//	{
			//		offsetList[i].x--;
			//	}
		}
		if (right)
		{
			cursorPoint.x++;
			//if (cursorPoint.x <= terrainRef.mapWidth-1)
			//	for (i in 0...offsetList.length)
			//	{
			//		offsetList[i].x++;
			//	}
		}
		if (up)
		{
			cursorPoint.y--;
			//if (cursorPoint.y >= 0)
			//	for (i in 0...offsetList.length)
			//	{
			//		offsetList[i].y--;
			//	}
		}
		if (down)
		{
			cursorPoint.y++;
			//if (cursorPoint.y <= terrainRef.mapHeight-1)
			//	for (i in 0...offsetList.length)
			//	{
			//		offsetList[i].y++;
			//	}
		}
		cursorPoint.set(Math.max(0, Math.min(cursorPoint.x, terrainRef.mapWidth-1)), Math.max(0, Math.min(cursorPoint.y, terrainRef.mapHeight-1)));
		setPosition(cursorPoint.x * terrainRef.scaledTileSize, cursorPoint.y * terrainRef.scaledTileSize);
	}

	public function setTotalPosition(x:Float, y:Float) {
		x = Std.int(x / terrainRef.scaledTileSize);
		y = Std.int(y / terrainRef.scaledTileSize);
		cursorPoint.set(x, y);
	}

	public function createBlock():Void
	{
		terrainRef.addShape(cursorPoint, offsetList);
		generateShape();
	}

	public function destroyBlock():Void
	{
		terrainRef.removeShape(cursorPoint, offsetList);
		generateShape();
	}
}