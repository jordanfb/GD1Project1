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
    tileArt;
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
    public var levelTileArt:String;

    public function new() {}

    public function parse(filename:String):Void {
        var caseMap:Map<String, Label> = 
        ["LevelName:" => name, "Player1Spawn:" => player1, "Player2Spawn:" => player2,
        "GameMode:" => mode, "TileMap:" => tileMap, "TerrainMap:" => terrainMap,
        "LevelScreenshot:" => screenshot, "Music:" => music, "BackgroundArt:" => art, "TileArt:" => tileArt];
        var _file:String = Assets.getText(filename);
        var lines = _file.split("\n");
        var i:Int = 0;
        while(i < lines.length) {
            lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
            var type:Label = caseMap.get(lines[i]);
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
                    case tileArt:
                        levelTileArt = lines[i];
                }
            }
            i = i + 1;
        }
    }

    public function getScreenshot(filename:String):String {
        var _file:String = Assets.getText(filename);
        var lines = _file.split("\n");
        var i:Int = 0;
        for(i in 0...lines.length) {
            lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
            if(lines[i] == "LevelScreenshot:") {
                return lines[i+1].replace("\r", "").replace("\n", "").trim();
            }
        }
        return "";
    }
}
