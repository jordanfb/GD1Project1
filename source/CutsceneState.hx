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
    var textIndex:Int = 0;
    var sceneIndex:Int = 0;
    var j:Int = 1; // the first image we change to is image 1. (other code handles loading the first image welp...)
    var bg:FlxSprite = new FlxSprite();
    var bg2:FlxSprite = new FlxSprite(550, 0);
	var textParts:Array<String> = new Array<String>();
    var images:Array<String> = new Array<String>();

    var zoomOriginalScene = 1.2;
    var zoomOriginalSceneRate = -.01;
    var zoomFinalScene = 1;
    var zoomFinalSceneRate = .1; // times elapsed
    var zoomTimer:Float = 0;
    var middleSceneFrameTimer:Float = 0; // frame timer for the frame by frame animation in the middle
    var middleSceneFrameTime = .025; // the time per frame
    var sceneTimer:Float = 0; // the timer that keeps track of transitioning between cutscene scenes
    var timePerScene = [10, 1000000, 8]; // the middle scene length is defined based on the framerate

    var flag:Flag; // this is for the final scene animation because why not, right?

    // constructor for cutscene state when a data file is passed in
    public function new(file:String) {
        super();
        levelInfo = file;
    }

    override public function create():Void {
        for(j in 0...10) { images.push("assets/images/cutscene/cutscene000"+ j +".png"); }
        for(j in 10...81) { images.push("assets/images/cutscene/cutscene00"+ j +".png"); }

        // set up background animation
        bg.loadGraphic("assets/images/ruins.png");
        bg.setGraphicSize(1080, 750);
        bg.updateHitbox();

        bg2.alpha = 0; // hide the second image

        // information for players to skip cutscene or play after cutscene ends
        stateInfo = new FlxText(10, 30, 300); // x, y, width
        stateInfo.text = "Press 'SPACE' to skip ";
        stateInfo.setFormat("assets/fonts/Adventure.otf", 28, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.GREEN, 1);

        // add texts to textParts array
        textParts.push("Many eons ago, the Aztec people \nthrived. They were a creative people, building great temples and composing colorful murals to honor their many gods. ");
        textParts.push("Today, their civilization is no more, and their gods lie dormant. ");
        textParts.push("That is, until one unfortunate soul happened upon the long-lost \ntemple of Xochipilli, god of art \nand games. ");
        textParts.push("The ancient god was furious, but not unfair. To him, simply destroying a mere mortal was in \npoor taste.  ");
        textParts.push("So he challenged the strange traveler to a game of wits and \nwizardry. ");

        // changing text for the cutscene
        currentText = new FlxText(340, 275, 400);
        currentText.text = textParts[textIndex];
        currentText.setFormat("assets/fonts/Adventure.otf", 28, FlxColor.WHITE, CENTER);
        currentText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);

        // run the clock and call cutscene function
        clock.start(4, cutsceneText, 5);

        flag = new Flag(1080/2-15, 720);
        flag.scale.set(1, 1); // to make it larger than life
        flag.acceleration.y = 0; // so that it doesn't fall :P
        flag.alpha = 0;
        

        add(bg);
        add(bg2);
        add(flag);
        add(currentText);
        add(stateInfo);

		super.create();
	}

	override public function update(elapsed:Float):Void {
        // on key press skips cutscene and creates new level state
        if(FlxG.keys.pressed.SPACE) {
            toNextState();
		}
        sceneTimer += elapsed;
        if (sceneTimer > timePerScene[sceneIndex]) {
            sceneIndex += 1; // swap to the next scene
            sceneTimer = 0;
            if (sceneIndex == 1) {
                // load the first image pls
                bg.loadGraphic(images[0]);
                bg.setGraphicSize(1080, 720);
                bg.updateHitbox();
            }
            if (sceneIndex == 3) {
                // then swap to the next state! Load the level!
                toNextState();
            }
        }
        if (sceneIndex == 0) {
            // then update the size of the original background image for that sweet sweet zoom
            zoomTimer += elapsed;
            var zoom = zoomOriginalScene + zoomTimer*zoomOriginalSceneRate;
            // bg.setGraphicSize(Std.int(1080*zoom), Std.int(750*zoom));
            bg.scale.set(zoom*2, zoom*2);
            // bg.x = (1-zoom)*1080/4;
            // bg.y = (1-zoom)*750/3 - zoomTimer*5;
            bg.y = -zoomTimer*3;
        }
        else if((sceneIndex == 1)) {
            middleSceneFrameTimer += elapsed;
            bg.x = 0;
            bg.y = 0;
            if (middleSceneFrameTimer > middleSceneFrameTime) {
                middleSceneFrameTimer -= middleSceneFrameTime;
                if(j < images.length) {
                    bg.loadGraphic(images[j]);
                    bg.setGraphicSize(1080, 720);
                    bg.updateHitbox();
                    j = j + 1;
                } else {
                    finalScene();
                    flag.alpha = 1; // show the flag
                    zoomTimer = 0; // reset the zoom
                    sceneIndex = 2;
                    sceneTimer = 0;
                }
            }
        } else if (sceneIndex == 2) {
            // zoom the camera out?
            zoomTimer += elapsed;
            // FlxG.camera.zoom = zoomFinalScene + zoomFinalSceneRate * zoomTimer;
            var zoom = zoomFinalScene + zoomFinalSceneRate * zoomTimer;
            bg.setGraphicSize(Std.int(550*zoom)+2, Std.int(1161*zoom));
            // bg.y = -200 - (1161 - 1161*zoom)/2; // so it remains centered?
            bg.x = Std.int((550 - 550*zoom)/2);
            bg.y = -200 + zoomTimer * 80;

            bg2.setGraphicSize(Std.int(550*zoom), Std.int(1161*zoom));
            bg2.x = 550 + Std.int((550*zoom - 550)/2);
            bg2.y = -200 + zoomTimer * 80;

            flag.y = -250 + zoomTimer * 50;
        }
		super.update(elapsed);
	}

    // function to change the cutscene text that is currently displayed
    public function cutsceneText(timer:FlxTimer):Void {
        textIndex = textIndex + 1;
        if(textIndex < textParts.length) {
            currentText.text = textParts[textIndex];
        }
    }

    private function toNextState() {
        closeSubState();
        var _levelState = new LevelState();
        _levelState.initializeLevel(levelInfo);
        FlxG.switchState(_levelState);
    }

    public function finalScene():Void {
        bg.loadGraphic("assets/images/faceoff.png");
        bg.setGraphicSize(550, 1161); // 720height
        bg.y = -200; //441
        bg.updateHitbox();
        bg2.loadGraphic("assets/images/faceoff.png");
        bg2.setGraphicSize(550, 1161); // 720height
        bg2.flipX = true;
        bg2.x = 550;
        bg2.y = -200;
        bg2.alpha = 1; // show the image
        bg2.updateHitbox();
    }
}