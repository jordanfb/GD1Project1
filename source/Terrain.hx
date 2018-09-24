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
    var _artFilename:String;


	public var mapWidth : Int;
	public var mapHeight : Int;

    // "?X:Float=0" means that it is optional to pass this and if its not passed then it defaults to 0s
    public function new(?tile_width:Int = 16, ?tile_height:Int = 16 ) {
        _tilemap = new FlxTilemap();
    	//_filename = filename;
        _tileWidth = tile_width;
        _tileHeight = tile_height;
        //loadMapFromText();
    }

    public function reloadLevel() : Void {
    	loadMapFromText();
    }

    public function follow() : Void {
        // this is for camera things. It may not make sense to use this, we'll see.
    	_tilemap.follow();
    }

    public function setLevelFile(filename:String, ?artfilename:String = "assets/images/test_tiles.png") : Void {
        _filename = filename;
        _artFilename = artfilename;
        reloadLevel();
    }

    private function loadMapFromText() : Void {
        //_filename = "assets/data/test_level.txt";
		_tilemap.loadMapFromCSV(_filename, _artFilename, _tileWidth, _tileHeight, OFF);
		mapWidth = _tilemap.widthInTiles;
		mapHeight = _tilemap.heightInTiles;
    }

    public function add(state:FlxState) :Void {
        // load the tilemap into the scene
        state.add(_tilemap);
    }

    public function remove(state:FlxState) :Void {
        // load the tilemap into the scene
        state.remove(_tilemap);
    }

    public function getTileWidth() : Int {
        return _tileWidth;
    }

    public function getTileHeight() : Int {
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

    public function addShape(position:FlxPoint, offsets:Array<FlxPoint>, ?types:Array<Int>) : Void {
        for (i in 0...offsets.length) {
            setTile(Std.int(position.x + offsets[i].x), Std.int(position.y + offsets[i].y), (types == null) ? 1 : types[i]);
        }
    }

    public function removeShape(position:FlxPoint, offsets:Array<FlxPoint>) : Void {
        for (i in 0...offsets.length) {
            setTile(Std.int(position.x + offsets[i].x), Std.int(position.y + offsets[i].y), 0);
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

    /*
    public function collide(p:Player) : Void {
        // does collisions with player
        FlxG.collide(p, _tilemap);
    }
    */

    /*public function pickUp(character:Player, X:Float, Y:Float) {
        // character picks up flag at (X, Y)
    }

    public function captured(character:Player) {
        // end game, the player who captured the flag first won
    }*/
}