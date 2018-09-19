package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;

class Terrain {

	static inline var TILE_WIDTH:Int = 16;
	static inline var TILE_HEIGHT:Int = 16;

	var _tilemap:FlxTilemap;
	var _filename:String;


    // "?X:Float=0" means that it is optional to pass this and if its not passed then it defaults to 0s
    public function new(filename:String) {
    	_filename = filename;
        loadMapFromText(filename);
    }

    public function reloadLevel() {
    	loadMapFromText(_filename);
    }

    private function loadMapFromText(filename:String) : Void{
    	_tilemap = new FlxTilemap();
		_tilemap.loadMapFromCSV(filename, "assets/images/test_tiles.png", TILE_WIDTH, TILE_HEIGHT, AUTO);
    }

    public function add(state:FlxState) :Void {
    	// load the tilemap into the scene
    	state.add(_tilemap);
    }

    /*public function pickUp(character:Player, X:Float, Y:Float) {
        // character picks up flag at (X, Y)
    }

    public function captured(character:Player) {
        // end game, the player who captured the flag first won
    }*/
}