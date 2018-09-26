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
    var stateInfo:FlxText;
    var startText:FlxText;
    var bg:FlxSprite;
    var levelLoading:FlxButton;
    var clock:FlxTimer = new FlxTimer();
    var images:Array<String> = new Array<String>();
    var music:FlxSound;
    var i:Int = 0;

    override public function create():Void {
        //var snd = new WaudSound("assets/music/menu_music.mp3", { autoplay: true, loop: true, volume: 0.5, onload: playBgSound });
        //snd.play();

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

        // level button setup
        levelLoading = new FlxButton(10, 500, "     TestLevel", clickTestLevel);
        levelLoading.loadGraphic("assets/images/button.png", true, 616, 198);
        levelLoading.setGraphicSize(200, 60);
        levelLoading.updateHitbox();
        levelLoading.label.setFormat("assets/fonts/Adventure.otf", 30, FlxColor.WHITE, LEFT);
        levelLoading.label.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);

        /*
        // god win button setup
        godWin = new FlxButton(700, 600, "         God Win", clickGod);
        godWin.loadGraphic("assets/images/button.png", true, 616, 198);
        godWin.setGraphicSize(250, 60);
        godWin.updateHitbox();
        godWin.label.setFormat("assets/fonts/Adventure.otf", 30, FlxColor.WHITE, LEFT);
        godWin.label.setBorderStyle(OUTLINE, FlxColor.ORANGE, 1);

        // human win button setup
        humanWin = new FlxButton(700, 500, "      Human Win", clickHuman);
        humanWin.loadGraphic("assets/images/button.png", true, 616, 198);
        humanWin.setGraphicSize(250, 60);
        humanWin.updateHitbox();
        humanWin.label.setFormat("assets/fonts/Adventure.otf", 30, FlxColor.WHITE, LEFT);
        humanWin.label.setBorderStyle(OUTLINE, FlxColor.PURPLE, 1);*/

        // credits button setup
        creditB = new FlxButton(675, 650, "      Credits", clickCredits);
        creditB.loadGraphic("assets/images/button.png", true, 616, 198);
        creditB.setGraphicSize(250, 60);
        creditB.updateHitbox();
        creditB.label.setFormat("assets/fonts/Adventure.otf", 36, FlxColor.WHITE, LEFT);

        // current state information
        stateInfo = new FlxText(10, 30, 100); // x, y, width
        stateInfo.text = "Menu State";
        stateInfo.setFormat("assets/fonts/Adventure.otf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.RED, 1);

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
        add(levelLoading);
        add(stateInfo);
        add(creditB);
        //add(humanWin);
        //add(godWin);
        add(startText);
		super.create();
	}

	override public function update(elapsed:Float):Void {
        FlxG.sound.playMusic("assets/music/menu_music.mp3");
		super.update(elapsed);
	}

    // creates new play state on button click
	function clickPlay():Void {
        closeSubState();
		FlxG.switchState(new PlayState());
	}

    // creates new control state on button click
    function clickControls():Void {
        closeSubState();
        FlxG.switchState(new ControlsState());
    }

    // creates new credits state on button click
    function clickCredits():Void {
        closeSubState();
        FlxG.switchState(new CreditsState());
    }

    /*// creates new god win state on button click
    function clickGod():Void {
        FlxG.switchState(new GodWinState());
    }

    // creates new human win state on button click
    function clickHuman():Void {
        FlxG.switchState(new HumanWinState());
    }*/

    // quits game on button click
    function clickQuit():Void {
        System.exit(0);
    }

    // creates new level state on button click
    function clickTestLevel():Void {
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