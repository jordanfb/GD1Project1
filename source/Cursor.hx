package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxState;
import flixel.math.FlxPoint;
import Math;

class Cursor extends FlxSprite
{
	public var xpos:Int;
	public var ypos:Int;
	public var cursorColor:FlxColor;
	public var destroyColor:FlxColor;
	public var blockType:Int;
	public var cursorPoint:FlxPoint;

	private var blockList:Array<Int>;
	private var left:Bool;
	private var up:Bool;
	private var right:Bool;
	private var down:Bool;
	private var offsetList:Array<FlxPoint>;
	private var tileIndexList:Array<Int>;
	private var spriteList:Array<FlxSprite>;
	private var terrainRef:Terrain;
	private var isHuman:Bool;

	public function new(xp:Int, yp:Int, newcolor:FlxColor, descolor:FlxColor, tiles:Terrain, file:String, useHumanTiles:Bool)
	{
		isHuman = useHumanTiles;
		xpos = xp;
		ypos = yp;
		cursorColor = new FlxColor(newcolor);
		destroyColor = new FlxColor(descolor);
		// color = newColor;
		super(xp, yp);
		drag.x = drag.y = 3200;
		makeGraphic(1, 1, newcolor);
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

		setSpriteList(file);
	}

	//public function setVisible()
	//{
	//	makeGraphic(16, 16, cursorColor);
	//}

	public function swapColor(mode:Bool, filename:String)
	{
		if (filename == "assets/images/godsprite.png")
		{		
			if (!mode)
				spriteList[0].replaceColor(cursorColor, destroyColor);
			else
				spriteList[0].replaceColor(destroyColor, cursorColor);
		}
		else
		{
			if (!mode)
				spriteList[0].replaceColor(cursorColor, destroyColor);
			else
				spriteList[0].replaceColor(destroyColor, cursorColor);
		}	
	}

	public function setSpriteList(filepath:String)
	{
		spriteList = new Array<FlxSprite>();
		for (i in 0...16)
		{
			// spriteList[i] = new FlxSprite(cursorPoint.x+offsetList[i].x, cursorPoint.y+offsetList[i].y);
			spriteList[i] = new FlxSprite(0, 0);

			// var tempCoord = new FlxPoint(Math.max(0, Math.min(spriteList[i].x, terrainRef.mapWidth-1)), Math.max(0, Math.min(spriteList[i].y, terrainRef.mapHeight-1)));
			// spriteList[i].setPosition(tempCoord.x*terrainRef.scaledTileSize, tempCoord.y*terrainRef.scaledTileSize);
			//spriteList[i].makeGraphic(16, 16, cursorColor);
			spriteList[i].loadGraphic(filepath, false, 200, 200);
			spriteList[i].replaceColor(FlxColor.WHITE, cursorColor);
			spriteList[i].scale.set(terrainRef.scale, terrainRef.scale);
			var xPos = (1-terrainRef.scale)*200/2;
			spriteList[i].offset.set(xPos, xPos);
		}
	}

	public function updateCoords() : Void {
		for (i in 0...offsetList.length)
		{
			// var tempCoord = new FlxPoint(Math.max(0, Math.min(spriteList[i].x, terrainRef.mapWidth-1)), Math.max(0, Math.min(spriteList[i].y, terrainRef.mapHeight-1)));
			var tempCoord = new FlxPoint((cursorPoint.x+offsetList[i].x), (cursorPoint.y+offsetList[i].y));
			spriteList[i].setPosition(tempCoord.x*terrainRef.scaledTileSize, tempCoord.y*terrainRef.scaledTileSize);
			spriteList[i].alpha = 1;
		}
		for (i in offsetList.length...spriteList.length) {
			spriteList[i].alpha = 0;
		}
	}

	public function setAlpha(a:Float) {
		// this is for showing the player when they're able to place things
		for (i in 0...offsetList.length) {
			// this only sets the alpha of those postions that are currently being placed (i.e. they have an offset). This is because the other ones have to be 0 alpha
			spriteList[i].alpha = a;
		}
	}

	public function addSpriteList(state:FlxState) {
		for (s in spriteList) {
			state.add(s);
		}
	}

	public function killSpriteList() {
		for (s in spriteList) {
			s.kill();
		}
	}

	public function reviveSpriteList(	)
	{
		for (s in spriteList) {
			s.revive();
		}
	}

	public function generateShape():Array<FlxPoint>
	{
		blockType = blockList[Std.int(Math.random()*8)];
		offsetList = new Array<FlxPoint>();
		tileIndexList = new Array<Int>();
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
			if (isHuman) {
				tileIndexList = [204, 224, 225, 205, 162, 182, 163, 183, 176, 196, 177, 197, 16, 36, 17, 37];
			} else {
				tileIndexList = [132, 152, 153, 133, 86, 106, 87, 107, 136, 156, 137, 157, 126, 146, 127, 147];
			}
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
			if (isHuman) {
				tileIndexList = [204, 224, 225, 205, 162, 182, 163, 183, 178, 198, 179, 199, 12, 32, 13, 33];
			} else {
				tileIndexList = [132, 152, 153, 133, 86, 106, 87, 107, 138, 158, 139, 159, 126, 146, 127, 147];
			}
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
			if (isHuman) {
				tileIndexList = [204, 224, 225, 205, 176, 196, 177, 197, 58, 78, 59, 79, 200, 220, 201, 221];
			} else {
				tileIndexList = [86, 106, 107, 87, 136, 156, 137, 157, 98, 118, 99, 119, 92, 112, 93, 113];
			}
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
			if (isHuman) {
				tileIndexList = [204, 224, 225, 205, 178, 198, 179, 199, 57, 77, 56, 76, 201, 221, 200, 220];
			} else {
				tileIndexList = [132, 152, 153, 133, 138, 158, 139, 159, 97, 117, 96, 116, 87, 107, 86, 106];
			}
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
			if (isHuman) {
				tileIndexList = [14, 34, 35, 15, 54, 74, 55, 75, 33, 13, 32, 12, 16, 36, 17, 37];
			} else {
				tileIndexList = [88, 108, 109, 89, 82, 102, 83, 103, 155, 135, 154, 134, 90, 110, 91, 111];
			}
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
			if (isHuman) {
				tileIndexList = [204, 224, 225, 205, 162, 182, 163, 183, 162, 182, 163, 183, 200, 220, 201, 221];
			} else {
				tileIndexList = [86, 106, 107, 87, 86, 106, 87, 107, 86, 106, 87, 107, 92, 112, 93, 113];
			}
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
			if (isHuman) {
				tileIndexList = [56, 76, 77, 57, 176, 196, 177, 197, 178, 198, 179, 199, 58, 78, 59, 79];
			} else {
				tileIndexList = [96, 116, 117, 97, 92, 112, 93, 113, 86, 106, 87, 107, 98, 118, 99, 119];
			}
		}
		else 				//Single box
		{
			offsetList.push(new FlxPoint(0, 0));
			offsetList.push(new FlxPoint(0, 1));
			offsetList.push(new FlxPoint(1, 1));
			offsetList.push(new FlxPoint(1, 0));
			if (isHuman) {
				tileIndexList = [200, 220, 221, 201];
			} else {
				// is god
				tileIndexList = [80, 100, 101, 81];
			}
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
		updateCoords();
	}

	public function setTotalPosition(x:Float, y:Float) {
		x = Std.int(x / terrainRef.scaledTileSize);
		y = Std.int(y / terrainRef.scaledTileSize);
		cursorPoint.set(x, y);
	}

	public function createBlock():Void
	{
		terrainRef.addShape(cursorPoint, offsetList, tileIndexList);
		generateShape();
	}

	public function destroyBlock():Void
	{
		terrainRef.removeShape(cursorPoint, offsetList);
		generateShape();
	}
}