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

		_terrain = new Terrain("assets/data/test_level.txt");
		_terrain.add(this);


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