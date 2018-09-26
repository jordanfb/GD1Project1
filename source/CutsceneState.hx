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
    var bg1:FlxSprite = new FlxSprite();
    var bg2:FlxSprite = new FlxSprite();
    var bg3:FlxSprite = new FlxSprite();
	var textParts:Array<String> = new Array<String>();

    // constructor for cutscene state when a data file is passed in
    public function new(file:String) {
        super();
        levelInfo = file;
    }

    override public function create():Void {
        /*// set up background animation
        bg1.loadGraphic("assets/images/scene1back.png");
        bg1.setGraphicSize(1080, 720);
        bg1.updateHitbox();
        bg2.loadGraphic("assets/images/scene1next.png");
        bg2.setGraphicSize(1080, 720);
        bg2.updateHitbox();
        bg3.loadGraphic("assets/images/scene1top.png");
        bg3.setGraphicSize(1080, 720);
        bg3.updateHitbox();*/

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
        currentText = new FlxText(350, 260, 400);
        currentText.text = textParts[i];
        currentText.setFormat("assets/fonts/Adventure.otf", 32, FlxColor.WHITE, CENTER);

        // run the clock and call cutscene function
        clock.start(8, cutsceneText, 5);

        add(bg1);
        add(bg2);
        add(bg3);
        add(currentText);
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

    // function to change the cutscene text that is currently displayed
    public function cutsceneText(timer:FlxTimer):Void {
        i = i + 1;
        if(i < textParts.length) {
            currentText.text = textParts[i];
        } else {
            var _levelState = new LevelState();
            _levelState.initializeLevel(levelInfo);
            FlxG.switchState(_levelState);
        }
    }
}