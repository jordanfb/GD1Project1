package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;


class LevelLoadingTest extends FlxState {
	var stateInfo:FlxText;
	var timer:FlxText;

	var _terrain:Terrain;

	override public function create():Void {
		stateInfo = new FlxText(10, 30, 100);
        stateInfo.text = "Level Test";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);

		timer = new FlxText(475, 30, 200);
		timer.text = "";
		timer.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
		timer.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);
		add(stateInfo);
		//add(timer);

		_terrain = new Terrain();
		_terrain.setLevelFile("assets/data/test_level.txt");
		_terrain.add(this);
		// _terrain.follow();


		// flag1 = new Flag(550, 300);
		// flag2 = new Flag(550, 650);
		// add(flag1);
		// add(flag2);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            //create pause UI possibly
            FlxG.switchState(new MenuState());
		}
		//timer.text = "" + elapsed;


		if (FlxG.mouse.pressed)
		{
			// FlxTilemaps can be manually edited at runtime as well.
			// Setting a tile to 0 removes it, and setting it to anything else will place a tile.
			// If auto map is on, the map will automatically update all surrounding tiles.
			_terrain.setTile(Std.int(FlxG.mouse.x / _terrain.getTileWidth()), Std.int(FlxG.mouse.y / _terrain.getTileHeight()), FlxG.keys.pressed.SHIFT ? 0 : 1);
		}


		super.update(elapsed);
	}
}