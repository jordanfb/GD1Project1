package;

import flixel.FlxGame;
import flixel.FlxState;
import haxe.EnumTools;
import openfl.Assets;
using StringTools;

enum Label {
    name;
    player1;
    player2;
    mode;
    tileMap;
    terrainMap;
    screenshot;
    music;
    art;
}

class LevelParser {
	public var levelName:String;
    public var player1_x:Float;
    public var player1_y:Float;
    public var player2_x:Float;
    public var player2_y:Float;
    public var gameMode:String;
    public var tileMapFile:String;
    public var terrainMapFile:String;
    public var levelScreenshot:String;
    public var levelMusicTrack:String;
    public var levelBackgroundArt:String;

    public function new() {}

    public function parse(filename:String) {
        var caseMap:Map<String, Label> = 
        ["LevelName:" => name, "Player1Spawn:" => player1, "Player2Spawn:" => player2,
        "GameMode:" => mode, "TileMap:" => tileMap, "TerrainMap:" => terrainMap,
        "LevelScreenshot:" => screenshot, "Music:" => music, "BackgroundArt:" => art];
        //var _file = sys.io.File.read("C:/Users/smithn10/HaxeFlixel/GD1Project1/source/testLevelSelect.txt", false);
        var _file:String = Assets.getText(filename);
        trace(_file);
        var lines = _file.split("\n");
        var i:Int = 0;
        while(i < lines.length) {
            //trace(caseMap.get("LevelName:"));
            lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
            //trace("Line: "+lines[i]);
            var type:Label = caseMap.get(lines[i]);
            //trace("Type: "+type);
            if(type != null) {
                i = i + 1;
                lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
                switch(type){
                    case name:
                        levelName = lines[i];
                    case player1:
                        player1_x = Std.parseFloat(lines[i]);
                        i = i + 1;
                        lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
                        player1_y = Std.parseFloat(lines[i]);
                    case player2:
                        player2_x = Std.parseFloat(lines[i]);
                        i = i + 1;
                        lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
                        player2_y = Std.parseFloat(lines[i]);
                    case mode:
                        gameMode = lines[i];
                    case tileMap:
                        tileMapFile = lines[i];
                    case terrainMap:
                        terrainMapFile = lines[i];
                    case screenshot:
                        levelScreenshot = lines[i];
                    case music:
                        levelMusicTrack = lines[i];
                    case art:
                        levelBackgroundArt = lines[i];
                }
            }
            i = i + 1;
        }
    trace(levelName);
    trace(player1_x);
    trace(player1_y);
    trace(gameMode);
    trace(tileMapFile);
    }
}
