package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flash.system.System;
import flixel.util.FlxTimer;
import flixel.system.FlxSound;

class MenuState extends FlxState {
    var playB:FlxButton;
    var controlsB:FlxButton;
    var quitB:FlxButton;
    var godWin:FlxButton;
    var creditB:FlxButton;
    var humanWin:FlxButton;
    var startText:FlxText;
    var bg:FlxSprite;
    var levelLoading:FlxButton;
    var clock:FlxTimer = new FlxTimer();
    var images:Array<String> = new Array<String>();
    var music:FlxSound;
    var i:Int = 0;

    override public function create():Void {
        FlxG.sound.playMusic("assets/music/tribal.wav");
        FlxG.sound.changeVolume(1);

        // add all images to array
        images.push("assets/images/fancy button/1.png");
        images.push("assets/images/fancy button/1.png");
        images.push("assets/images/fancy button/1.png");
        images.push("assets/images/fancy button/1.png");
        images.push("assets/images/fancy button/1.png");
        images.push("assets/images/fancy button/1.png");
        images.push("assets/images/fancy button/1.png");
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
        images.push("assets/images/fancy button/11.png");
        images.push("assets/images/fancy button/11.png");

        // set up background
        bg = new FlxSprite();
        bg.loadGraphic("assets/images/menu background.png");
        bg.setGraphicSize(1080, 720);
        bg.updateHitbox();

        // play button setup
		playB = new FlxButton(255, 200, "", clickPlay);
        playB.loadGraphic(images[i]);
        playB.setGraphicSize(600, 300);
        playB.updateHitbox();
        playB.label.setFormat("assets/fonts/Adventure.otf", 40, FlxColor.WHITE, LEFT);
        
        // controls button setup
        controlsB = new FlxButton(400, 400, " How To Play", clickControls);
        controlsB.loadGraphic("assets/images/button.png", true, 616, 198);
        controlsB.setGraphicSize(250, 60);
        controlsB.updateHitbox();
        controlsB.label.setFormat("assets/fonts/Adventure.otf", 37, FlxColor.WHITE, LEFT);

        // quit button setup
        quitB = new FlxButton(400, 500, "       Quit", clickQuit);
        quitB.loadGraphic("assets/images/button.png", true, 616, 198);
        quitB.setGraphicSize(250, 60);
        quitB.updateHitbox();
        quitB.label.setFormat("assets/fonts/Adventure.otf", 37, FlxColor.WHITE, LEFT);

        // credits button setup
        creditB = new FlxButton(675, 650, "      Credits", clickCredits);
        creditB.loadGraphic("assets/images/button.png", true, 616, 198);
        creditB.setGraphicSize(250, 60);
        creditB.updateHitbox();
        creditB.label.setFormat("assets/fonts/Adventure.otf", 36, FlxColor.WHITE, LEFT);

        // start text information
        startText = new FlxText(425, 275, 200); // x, y, width
        startText.text = "Start";
        startText.setFormat("assets/fonts/Adventure.otf", 40, FlxColor.WHITE, CENTER);
        startText.setBorderStyle(OUTLINE, FlxColor.RED, 1);

        // run the clock and call cutscene function
        clock.start(.04, nextImage, 0);

        add(bg);
		add(playB);
        add(controlsB);
        add(quitB);
        add(creditB);
        add(startText);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

    // creates new play state on button click
	function clickPlay():Void {
        FlxG.sound.play("assets/sounds/button press.wav");
        closeSubState();
		FlxG.switchState(new PlayState());
	}

    // creates new control state on button click
    function clickControls():Void {
        FlxG.sound.play("assets/sounds/button press.wav");
        closeSubState();
        FlxG.switchState(new ControlsState());
    }

    // creates new credits state on button click
    function clickCredits():Void {
        FlxG.sound.play("assets/sounds/button press.wav");
        FlxG.sound.changeVolume(1);
        closeSubState();
        FlxG.switchState(new CreditsState());
    }

    // quits game on button click
    function clickQuit():Void {
        FlxG.sound.play("assets/sounds/button press.wav");
        System.exit(0);
    }

    // creates new level state on button click
    function clickTestLevel():Void {
        FlxG.sound.play("assets/sounds/button press.wav");
        closeSubState();
        var _levelState = new LevelState();
        _levelState.initializeLevel();
        FlxG.switchState(_levelState);
    }

    // function to change the cutscene text that is currently displayed
    public function nextImage(timer:FlxTimer):Void {
        i = i + 1;
        if(i < images.length) {
            playB.loadGraphic(images[i]);
            playB.setGraphicSize(550, 250);
            playB.updateHitbox();
        } else {
            i = 0;
        }
    }
}