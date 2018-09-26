package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flash.system.System;

class CreditsState extends FlxState {
    var menuB:FlxButton;
    var quitB:FlxButton;
    var bg:FlxSprite;
    var creditText:FlxText;

    override public function create():Void {
        // set up background animation
        bg = new FlxSprite();
        bg.loadGraphic("assets/images/menu background.png");
        bg.setGraphicSize(1080, 720);
        bg.updateHitbox();

        // sets up credits text
        creditText = new FlxText(75, 40, 900);
		creditText.text = "Created and Developed by:\nJordan Faas-Bush\nZach Thompson\nNicholas Smith\nAlexander Francoletti\nLeonardo Price\n\nFont Credit:\nhttp://www.pixelsagas.com/?download=adventure\n(Adventure Font Package)\n\nMusic and Sound Credit:\nhttps://www.zapsplat.com/ (Sounds & Music)";
		creditText.setFormat("assets/fonts/Adventure.otf", 32, FlxColor.BLACK, CENTER);
		creditText.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);

        // back to menu button setup
        menuB = new FlxButton(20, 620, "        Back", clickBack);
        menuB.loadGraphic("assets/images/button.png", true, 616, 198);
        menuB.setGraphicSize(250, 60);
        menuB.updateHitbox();
        menuB.label.setFormat("assets/fonts/Adventure.otf", 36, FlxColor.WHITE, LEFT);
        //menuB.label.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);

        // quit button setup
        quitB = new FlxButton(800, 620, "        Quit", clickQuit);
        quitB.loadGraphic("assets/images/button.png", true, 616, 198);
        quitB.setGraphicSize(250, 60);
        quitB.updateHitbox();
        quitB.label.setFormat("assets/fonts/Adventure.otf", 36, FlxColor.WHITE, LEFT);
        //quitB.label.setBorderStyle(OUTLINE, FlxColor.RED, 1);

        add(bg);
        add(creditText);
        add(menuB);
        add(quitB);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

    // creates new menu state on button click
	function clickBack():Void {
		FlxG.switchState(new MenuState());
	}

    // quits game on button click
    function clickQuit():Void {
        System.exit(0);
    }
}