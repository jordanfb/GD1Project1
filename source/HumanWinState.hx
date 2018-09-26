package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flash.system.System;

class HumanWinState extends FlxState {
    var menuB:FlxButton;
    var quitB:FlxButton;
    var bg:FlxSprite;
    var winText:FlxText;
    var images:Array<String> = new Array<String>();
    var i:Int = 0;

    override public function create():Void {
        // add all images to array
        images.push("assets/images/human wins/player wins0000.png");
        images.push("assets/images/human wins/player wins0001.png");
        images.push("assets/images/human wins/player wins0002.png");
        images.push("assets/images/human wins/player wins0003.png");
        images.push("assets/images/human wins/player wins0004.png");
        images.push("assets/images/human wins/player wins0005.png");
        images.push("assets/images/human wins/player wins0006.png");
        images.push("assets/images/human wins/player wins0007.png");
        images.push("assets/images/human wins/player wins0008.png");

        // set up background animation
        bg = new FlxSprite();
        bg.loadGraphic(images[i]);
        bg.setGraphicSize(1080, 720);
        bg.updateHitbox();

        // sets up win text
        winText = new FlxText(75, 40, 900);
		winText.text = "With their victory, the magical Traveller stole away into the night. \nThey would return home with a decoration for their mantle and a story for their grandchildren. ";
		winText.setFormat("assets/fonts/Adventure.otf", 32, FlxColor.WHITE, CENTER);
		winText.setBorderStyle(OUTLINE, FlxColor.PURPLE, 1);

        // back to menu button setup
        menuB = new FlxButton(20, 620, "        Back ", clickBack);
        menuB.loadGraphic("assets/images/button.png", true, 616, 198);
        menuB.setGraphicSize(250, 60);
        menuB.updateHitbox();
        menuB.label.setFormat("assets/fonts/Adventure.otf", 36, FlxColor.WHITE, LEFT);

        // quit button setup
        quitB = new FlxButton(800, 620, "        Quit ", clickQuit);
        quitB.loadGraphic("assets/images/button.png", true, 616, 198);
        quitB.setGraphicSize(250, 60);
        quitB.updateHitbox();
        quitB.label.setFormat("assets/fonts/Adventure.otf", 36, FlxColor.WHITE, LEFT);

        add(bg);
        add(winText);
        add(menuB);
        add(quitB);
		super.create();
	}

	override public function update(elapsed:Float):Void {
        if(i >= images.length) { i = 0; }
        bg.loadGraphic(images[i]);
        bg.setGraphicSize(1080, 720);
        bg.updateHitbox();
        i = i + 1;
		super.update(elapsed);
	}

    // creates new menu state on button click
	function clickBack():Void {
        closeSubState();
		FlxG.switchState(new MenuState());
	}

    // quits game on button click
    function clickQuit():Void {
        System.exit(0);
    }
}