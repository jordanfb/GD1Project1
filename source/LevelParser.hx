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
    backgroundFrames;
    backgroundFrameTime;
    flag1;
    flag2;
}

class LevelParser {
	public var levelName:String;
    public var player1_x:Int;
    public var player1_y:Int;
    public var player2_x:Int;
    public var player2_y:Int;
    public var gameMode:String;
    public var tileMapFile:String;
    public var terrainMapFile:String;
    public var levelScreenshot:String;
    public var levelMusicTrack:String;
    public var levelBackgroundArtFrameCount:Int;
    public var levelBackgroundArt:String;
    public var levelTileArt:String;
    public var flag1X:Int;
    public var flag1Y:Int;
    public var flag2X:Int;
    public var flag2Y:Int;
    public var levelBackgroundArtFrameTime:Float;

    // constructor
    public function new() {}

    // function to parse a text file and extract information to level information
    public function parse(filename:String):Void {
        // map of Strings and Labels to be used for enum switch
        var caseMap:Map<String, Label> = 
        ["LevelName:" => name, "Player1Spawn:" => player1, "Player2Spawn:" => player2,
        "GameMode:" => mode, "TileMap:" => tileMap, "TerrainMap:" => terrainMap,
        "LevelScreenshot:" => screenshot, "Music:" => music, "BackgroundArt:" => art, "TileArt:" => tileArt, "BackgroundFrames:" => backgroundFrames,
        "Flag1:" => flag1, "Flag2:" => flag2, "BackgroundFrameTime:" => backgroundFrameTime];
        var _file:String = Assets.getText(filename);
        var lines = _file.split("\n");
        var i:Int = 0;
        // loop to go through every line in the text file
        while(i < lines.length) {
            // strip line for perfect comparisons
            lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
            var type:Label = caseMap.get(lines[i]);
            if(type != null) { // the type is in the map
                i = i + 1;
                lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
                switch(type){ // using enum to check for each case
                    case name:
                        levelName = lines[i];
                    case player1:
                        player1_x = Std.parseInt(lines[i]);
                        i = i + 1;
                        lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
                        player1_y = Std.parseInt(lines[i]);
                    case player2:
                        player2_x = Std.parseInt(lines[i]);
                        i = i + 1;
                        lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
                        player2_y = Std.parseInt(lines[i]);
                    case flag1:
                        flag1X = Std.parseInt(lines[i]);
                        i = i + 1;
                        lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
                        flag1Y = Std.parseInt(lines[i]);
                    case flag2:
                        flag2X = Std.parseInt(lines[i]);
                        i = i + 1;
                        lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
                        flag2Y = Std.parseInt(lines[i]);
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
                    case backgroundFrames:
                        levelBackgroundArtFrameCount = Std.parseInt(lines[i]);
                    case backgroundFrameTime:
                        levelBackgroundArtFrameTime = Std.parseFloat(lines[i]);
                }
            }
            i = i + 1; // increment i for a cycle of the while loop
        }
    }

    // function to just extract the screenshot image from a text file
    public function getScreenshot(filename:String):String {
        var _file:String = Assets.getText(filename);
        var lines = _file.split("\n");
        var i:Int = 0;
        for(i in 0...lines.length) {
            // strip line for perfect comparisons
            lines[i] = lines[i].replace("\r", "").replace("\n", "").trim();
            if(lines[i] == "LevelScreenshot:") {
                return lines[i+1].replace("\r", "").replace("\n", "").trim();
            }
        }
        return ""; // return an empty string if there was no image there
    }
}
