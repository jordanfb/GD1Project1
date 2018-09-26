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
		_terrain = new Terrain();
		_terrain.setLevelFile("assets/data/test_level.txt");
		_terrain.add(this);
		// _terrain.follow();

		super.create();
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            FlxG.switchState(new MenuState());
		}

		if (FlxG.mouse.pressed){
			// FlxTilemaps can be manually edited at runtime as well.
			// Setting a tile to 0 removes it, and setting it to anything else will place a tile.
			// If auto map is on, the map will automatically update all surrounding tiles.
			_terrain.setTile(Std.int(FlxG.mouse.x / _terrain.getTileWidth()), Std.int(FlxG.mouse.y / _terrain.getTileHeight()), FlxG.keys.pressed.SHIFT ? 0 : 1);
		}

		super.update(elapsed);
	}
}