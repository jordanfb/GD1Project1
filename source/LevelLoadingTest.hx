package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;


class LevelLoadingTest extends FlxState {

	static inline var TILE_WIDTH:Int = 16;
	static inline var TILE_HEIGHT:Int = 16;


	var stateInfo:FlxText;
	var timer:FlxText;

	var _tilemap:FlxTilemap;

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

		_tilemap = new FlxTilemap();
		_tilemap.loadMapFromCSV("assets/data/test_level.txt", "assets/images/test_tiles.png", TILE_WIDTH, TILE_HEIGHT, AUTO);
		add(_tilemap);
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
		super.update(elapsed);
	}
}