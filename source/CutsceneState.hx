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

class CutsceneState extends FlxState {
    var stateInfo:FlxText;
    var levelInfo:String;
    var clock:FlxTimer = new FlxTimer();
    var currentText:FlxText;
    var i:Int = 0;
    var j:Int = 0;
    var k:Int = 0;
    var check:Bool = false;
    var bg:FlxSprite = new FlxSprite();
    var bg2:FlxSprite = new FlxSprite(550, 0);
	var textParts:Array<String> = new Array<String>();
    var images:Array<String> = new Array<String>();

    // constructor for cutscene state when a data file is passed in
    public function new(file:String) {
        super();
        levelInfo = file;
    }

    override public function create():Void {
        // set up background animation
        bg.loadGraphic("assets/images/faceoff.png");
        bg.setGraphicSize(540, 720);
        bg.updateHitbox();
        bg2.loadGraphic("assets/images/faceoff.png");
        bg2.setGraphicSize(540, 720);
        bg2.updateHitbox();
        bg2.flipX = true;


        // information for players to skip cutscene or play after cutscene ends
        stateInfo = new FlxText(10, 30, 250); // x, y, width
        stateInfo.text = "Press 'ESC' to skip and play";
        stateInfo.setFormat("assets/fonts/Adventure.otf", 18, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.GREEN, 1);

        // add texts to textParts array
        textParts.push("Many eons ago, the Aztec people thrived. They were a creative people, building great temples and composing colorful murals to honor their many gods.");
        textParts.push("Today, their civilization is no more, and their gods lie dormant.");
        textParts.push("That is, until one unfortunate soul happened upon the long-lost temple of Xochipilli, god of art and games.");
        textParts.push("The ancient god was furious, but not unfair. To him, simply destroying a mere mortal was in poor taste.");
        textParts.push("So he challenged the strange traveler to a game of wits and wizardry.");

        // changing text for the cutscene
        currentText = new FlxText(350, 200, 400);
        currentText.text = textParts[i];
        currentText.setFormat("assets/fonts/Adventure.otf", 28, FlxColor.WHITE, CENTER);
        currentText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);

        // run the clock and call cutscene function
        clock.start(5, cutsceneText, 5);

        add(bg);
        add(bg2);
        add(currentText);
        add(stateInfo);
		super.create();
	}

	override public function update(elapsed:Float):Void {
        // on key press skips cutscene and creates new level state
        if(FlxG.keys.pressed.ESCAPE) {
            closeSubState();
            var _levelState = new LevelState();
            _levelState.initializeLevel(levelInfo);
            FlxG.switchState(_levelState);
		}
		super.update(elapsed);
	}

    // function to change the cutscene text that is currently displayed
    public function cutsceneText(timer:FlxTimer):Void {
        i = i + 1;
        if(i < textParts.length) {
            currentText.text = textParts[i];
        } else {
            closeSubState();
            var _levelState = new LevelState();
            _levelState.initializeLevel(levelInfo);
            FlxG.switchState(_levelState);
        }
    }
}