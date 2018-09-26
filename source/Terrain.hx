package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.FlxObject;
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

    public var scale:Float; // this is the tile scale
    var cameraOffset:FlxPoint; // this is the camera offset when it's scaled so that we can correctly align tiles etc to the correct positions.

	public var mapWidth : Int;
	public var mapHeight : Int;

    public var scaledTileSize : Float;

    // "?X:Float=0" means that it is optional to pass this and if its not passed then it defaults to 0s
    public function new(?tile_width:Int = 16, ?tile_height:Int = 16 ) {
        _tilemap = new FlxTilemap();
        _tilemap.useScaleHack = true;
    	//_filename = filename;
        _tileWidth = tile_width;
        _tileHeight = tile_height;
        //loadMapFromText();
    }

    public function reloadLevel() : Void {
    	loadMapFromText();
    }

    public function updateBuffers() : Void {
        _tilemap.updateBuffers();
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
        for (i in 4...13) {
            _tilemap.setTileProperties(i, FlxObject.NONE);
        }
        _tilemap.setTileProperties(24, FlxObject.NONE);
        _tilemap.setTileProperties(31, FlxObject.NONE);
		
		_tilemap.setTileProperties(44, FlxObject.NONE);
        _tilemap.setTileProperties(51, FlxObject.NONE);
		_tilemap.setTileProperties(64, FlxObject.NONE);
        _tilemap.setTileProperties(71, FlxObject.NONE);
    }

    public function add(state:FlxState) :Void {
        // load the tilemap into the scene
        state.add(_tilemap);
    }

    public function remove(state:FlxState) :Void {
        // load the tilemap into the scene
        state.remove(_tilemap);
    }

    public function scaleToScreen(x:Int, y:Int) : FlxPoint {
        return this.scaleTilemap(x / (mapWidth * getTileWidth()), y / (mapHeight * getTileHeight()));
    }

    public function scaleTilemap(x:Float, y:Float) : FlxPoint {
        scale = Math.max(x, y);
        scaledTileSize = scale*getTileWidth();
        _tilemap.scale.x = scale;
        _tilemap.scale.y = scale;
        //trace("Tilemap scale " + _tilemap.scale);
        // it returns the camera offset to get the bottom left nicely centered I guess
        if (scale != x) {
            // we have to center the offset because the x is incorrect
            var pixelWidth = mapWidth * getTileWidth() * scale;
            cameraOffset = new FlxPoint(FlxG.width - pixelWidth/2, 0);
        } else if (scale != y) {
            // we have to allign to the bottom of the map because the y is incorrect
            // get the pixel height of the world using scale
            var pixelHeight = mapHeight * getTileHeight() * scale;
            cameraOffset = new FlxPoint(0, FlxG.height - pixelHeight);
        } else {
            cameraOffset = new FlxPoint(0, 0);
        }
        // _tilemap.updateHitbox();
        //_tilemap.offset.x = -cameraOffset.x;
        //_tilemap.offset.y = -cameraOffset.y;
        return cameraOffset;
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

    
    public function collide(p:Player) : Void {
        // does collisions with player
        FlxG.collide(p, _tilemap);
    }
    

    /*public function pickUp(character:Player, X:Float, Y:Float) {
        // character picks up flag at (X, Y)
    }

    public function captured(character:Player) {
        // end game, the player who captured the flag first won
    }*/
}