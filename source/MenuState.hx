package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flash.system.System;

class MenuState extends FlxState {
    var playB:FlxButton;
    var controlsB:FlxButton;
    var quitB:FlxButton;
    var stateInfo:FlxText;
    var levelLoading:FlxButton;

    override public function create():Void {
		playB = new FlxButton(500, 500, "Play", clickPlay); // (x, y, text, function call on button click)
        playB.label.setFormat("assets/font.ttf", 10, FlxColor.WHITE, CENTER);
        playB.label.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
        
        controlsB = new FlxButton(500, 530, "Controls", clickControls);
        controlsB.label.setFormat("assets/font.ttf", 10, FlxColor.WHITE, CENTER);
        controlsB.label.setBorderStyle(OUTLINE, FlxColor.GREEN, 1);

        quitB = new FlxButton(500, 560, "Quit", clickQuit);
        quitB.label.setFormat("assets/font.ttf", 10, FlxColor.WHITE, CENTER);
        quitB.label.setBorderStyle(OUTLINE, FlxColor.RED, 1);


        levelLoading = new FlxButton(100, 500, "TestLevel", clickTestLevel);
        levelLoading.label.setFormat("assets/font.ttf", 10, FlxColor.WHITE, CENTER);
        levelLoading.label.setBorderStyle(OUTLINE, FlxColor.RED, 1);
        add(levelLoading);

        stateInfo = new FlxText(10, 30, 100); // x, y, width
        stateInfo.text = "Menu State";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.RED, 1);
        //playB.loadGraphic("assets/images/button.png", true, 40, 80);
		add(playB);
        add(controlsB);
        add(quitB);
        add(stateInfo);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

	function clickPlay():Void {
		FlxG.switchState(new PlayState());
	}

    function clickControls():Void {
        FlxG.switchState(new ControlsState());
    }

    function clickQuit():Void {
        System.exit(0);
    }

    function clickTestLevel():Void {
        var _levelState = new LevelState();
        _levelState.initializeLevel();
        FlxG.switchState(_levelState);
    }
}