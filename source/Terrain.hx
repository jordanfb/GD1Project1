package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tile.FlxTilemap;
import flixel.math.FlxPoint;

class Terrain {

	var _tileWidth:Int;
	var _tileHeight:Int;

	var _tilemap:FlxTilemap;
	var _filename:String;


	public var mapWidth : Int;
	public var mapHeight : Int;

    // "?X:Float=0" means that it is optional to pass this and if its not passed then it defaults to 0s
    public function new(filename:String, ?tile_width:Int = 16, ?tile_height:Int = 16 ) {
    	_filename = filename;
        _tileWidth = tile_width;
        _tileHeight = tile_height;
        loadMapFromText(filename);
    }

    public function reloadLevel() : Void {
    	loadMapFromText(_filename);
    }

    public function follow() : Void {
    	_tilemap.follow();
    }

    private function loadMapFromText(filename:String) : Void{
    	_tilemap = new FlxTilemap();
		_tilemap.loadMapFromCSV(filename, "assets/images/test_tiles.png", _tileWidth, _tileHeight, OFF);
		mapWidth = _tilemap.widthInTiles;
		mapHeight = _tilemap.heightInTiles;
    }

    public function add(state:FlxState) :Void {
    	// load the tilemap into the scene
    	state.add(_tilemap);
    }

    public function getTileWidth() : Float {
        return _tileWidth;
    }

    public function getTileHeight() : Float {
        return _tileHeight;
    }

    public function addTiles(tiles:Array<FlxPoint>, ?types:Array<Int>) : Void {
        for (i in 0...tiles.length) {
    		setTile(Std.int(tiles[i].x), Std.int(tiles[i].y), (types == null) ? 1 : types[i]);
    	}
    }

    public function removeTiles(tiles:Array<FlxPoint>) : Void {
    	for (p in tiles) {
    		// remove the tiles from these coordinates
    		removeTile(p);
    	}
    }

    public function setTile(x:Int, y:Int, type:Int) : Void {
        if (x >= mapWidth || x < 0 || y >= mapHeight || y < 0) {
            return; // don't do anything it's out of bounds
        }
    	_tilemap.setTile(x, y, type);
    }

    public function removeTile(pos:FlxPoint) : Void {
    	setTile(Std.int(pos.x), Std.int(pos.y), 0);
    }

    /*public function pickUp(character:Player, X:Float, Y:Float) {
        // character picks up flag at (X, Y)
    }

    public function captured(character:Player) {
        // end game, the player who captured the flag first won
    }*/
}