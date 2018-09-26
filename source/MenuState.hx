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
    var playText:FlxText;
    var levelLoading:FlxButton;
    var images:Array<String> = new Array<String>();
    var i:Int = 0;

    override public function create():Void {
        // add all images to array
        images.push("assets/images/fancy button/1.png");
        images.push("assets/images/fancy button/2.png");
        images.push("assets/images/fancy button/3.png");
        images.push("assets/images/fancy button/4.png");
        images.push("assets/images/fancy button/5.png");
        images.push("assets/images/fancy button/6.png");
        images.push("assets/images/fancy button/7.png");
        images.push("assets/images/fancy button/8.png");
        images.push("assets/images/fancy button/9.png");
        images.push("assets/images/fancy button/10.png");
        images.push("assets/images/fancy button/11.png");

        // play button setup
		playB = new FlxButton(255, 325, "", clickPlay); // (x, y, text, function call on button click)
        playB.loadGraphic(images[i], false);
        playB.setGraphicSize(550, 250);
        playB.updateHitbox();
        playB.label.setFormat("assets/font.ttf", 30, FlxColor.WHITE, CENTER);
        playB.label.setBorderStyle(OUTLINE, FlxColor.ORANGE, 1);
        
        // controls button setup
        controlsB = new FlxButton(400, 500, "         Controls", clickControls);
        controlsB.loadGraphic("assets/images/button.png", true, 616, 198);
        controlsB.setGraphicSize(250, 60);
        controlsB.updateHitbox();
        controlsB.label.setFormat("assets/font.ttf", 30, FlxColor.WHITE, LEFT);
        controlsB.label.setBorderStyle(OUTLINE, FlxColor.GREEN, 1);

        // quit button setup
        quitB = new FlxButton(400, 600, "            Quit", clickQuit);
        quitB.loadGraphic("assets/images/button.png", true, 616, 198);
        quitB.setGraphicSize(250, 60);
        quitB.updateHitbox();
        quitB.label.setFormat("assets/font.ttf", 30, FlxColor.WHITE, LEFT);
        quitB.label.setBorderStyle(OUTLINE, FlxColor.RED, 1);

        // level button setup
        levelLoading = new FlxButton(10, 500, "            TestLevel", clickTestLevel);
        levelLoading.loadGraphic("assets/images/button.png", true, 616, 198);
        levelLoading.setGraphicSize(200, 60);
        levelLoading.updateHitbox();
        levelLoading.label.setFormat("assets/font.ttf", 30, FlxColor.WHITE, LEFT);
        levelLoading.label.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);

        // current state information
        stateInfo = new FlxText(10, 30, 100); // x, y, width
        stateInfo.text = "Menu State";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.RED, 1);

        // play button text
        playText = new FlxText(425, 400, 200);
        playText.text = "Play";
        playText.setFormat("assets/font.ttf", 40, FlxColor.WHITE, CENTER);
        playText.setBorderStyle(OUTLINE, FlxColor.RED, 1);

        add(playText);
		add(playB);
        add(controlsB);
        add(quitB);
        add(levelLoading);
        add(stateInfo);
		super.create();
	}

	override public function update(elapsed:Float):Void {
        if(i >= images.length) { i = 0; }
        playB.loadGraphic(images[i], false);
        playB.setGraphicSize(550, 250);
        playB.updateHitbox();
        i = i + 1;
		super.update(elapsed);
	}

    // creates new play state on button click
	function clickPlay():Void {
		FlxG.switchState(new PlayState());
	}

    // creates new control state on button click
    function clickControls():Void {
        FlxG.switchState(new ControlsState());
    }

    // quits game on button click
    function clickQuit():Void {
        System.exit(0);
    }

    // creates new level state on button click
    function clickTestLevel():Void {
        var _levelState = new LevelState();
        _levelState.initializeLevel();
        FlxG.switchState(_levelState);
    }
}

/* Game over state
        Who won
        Button to level select
        Button to menu
        Button to quit
*/