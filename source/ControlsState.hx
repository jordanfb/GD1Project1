package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class ControlsState extends FlxState {
	var menuB:FlxButton;
	var rules:FlxText;
	var controlsG:FlxText;
	var controlsH:FlxText;
	var flag:FlxSprite;
	var god:FlxSprite;
	var human:FlxSprite;
	var bg:FlxSprite;

	override public function create():Void {
		// set up background
        bg = new FlxSprite();
        bg.loadGraphic("assets/images/menu background.png");
        bg.setGraphicSize(1080, 720);
        bg.updateHitbox();

		// back to menu button setup
        menuB = new FlxButton(10, 650, "       Back", clickBack);
        menuB.loadGraphic("assets/images/button.png", true, 616, 198);
        menuB.setGraphicSize(250, 60);
        menuB.updateHitbox();
        menuB.label.setFormat("assets/fonts/Adventure.otf", 36, FlxColor.WHITE, LEFT);

		// create flag sprite, god sprite, and human sprite
		flag = new FlxSprite(425, 0);
		god = new FlxSprite(120, 400);
		human = new FlxSprite(600, 410);
		flag.loadGraphic("assets/images/flag.png", true, 200, 200);
		god.loadGraphic("assets/images/godsprite.png", true, 310, 400);
		human.loadGraphic("assets/images/human.png", true, 336, 400);
		flag.setGraphicSize(50, 50);
		god.setGraphicSize(100, 100);
		human.setGraphicSize(100, 100);

		// writes text and UI for rules
		rules = new FlxText(100, 125, 850);
		rules.text = "Objective:\nPick up and keep hold of the statue longer than your opponent.\nTouching the statue picks it up.\nTouching your opponent when they have the statue takes it from them.";
		rules.setFormat("assets/font.ttf", 28, FlxColor.BLACK, CENTER);
		rules.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);

		// writes text and UI for controls for god player
		controlsG = new FlxText(50, 280, 450);
		controlsG.text = "Xochipilli:\nWalk Left with [A], Right with [D]\n[W] to Jump\nToggle Walking/Sculpting with [Q]\nMove Sculpting Cursor with [W], [A], [S], [D]\nToggle Placing/Destroying with [E]\nPlace/Destroy with [R]";
		controlsG.setFormat("assets/font.ttf", 30, FlxColor.RED, CENTER);
		controlsG.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);

		// writes text and UI for controls for human player
		controlsH = new FlxText(540, 280, 450);
		controlsH.text =  "Traveler:\nWalk Left with [J], Right with [L]\n[I] to Jump\nToggle Walking/Sculpting with [U]\nMove Sculpting Cursor with [I], [J], [K], [L]\nToggle Placing/Destroying with [O]\nPlace/Destroy with [P]";
		controlsH.setFormat("assets/font.ttf", 30, FlxColor.PURPLE, CENTER);
		controlsH.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);

		add(bg);
		add(flag);
		add(god);
		add(human);
		add(menuB);
		add(rules);
		add(controlsG);
		add(controlsH);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

	// creates new menu state on button click
	function clickBack():Void {
		closeSubState();
		FlxG.switchState(new MenuState());
	}
}