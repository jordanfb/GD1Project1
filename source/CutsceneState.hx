package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flash.system.System;

class CutsceneState extends FlxState {
    var stateInfo:FlxText;
    var levelInfo:String;

    // constructor for cutscene state when a data file is passed in
    public function new(file:String) {
        super();
        levelInfo = file;
    }

    override public function create():Void {
        // information for players to skip cutscene or play after cutscene ends
        stateInfo = new FlxText(10, 30, 250); // x, y, width
        stateInfo.text = "Press 'ESC' to skip and play";
        stateInfo.setFormat("assets/font.ttf", 18, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.GREEN, 1);

        add(stateInfo);
		super.create();
	}

	override public function update(elapsed:Float):Void {
        // on key press skips cutscene and creates new level state
        if(FlxG.keys.pressed.ESCAPE) {
            var _levelState = new LevelState();
            _levelState.initializeLevel(levelInfo);
            FlxG.switchState(_levelState);
		}
		super.update(elapsed);
	}
}