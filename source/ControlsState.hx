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
	var stateInfo:FlxText;
	var rules:FlxText;
	var controlsG:FlxText;
	var controlsH:FlxText;
	var flag:FlxSprite;
	var god:FlxSprite;
	var human:FlxSprite;

	override public function create():Void {
		// back to menu button setup
		menuB = new FlxButton(25, 675, "Back", clickBack);
		menuB.label.setFormat("assets/font.ttf", 10, FlxColor.WHITE, CENTER);
        menuB.label.setBorderStyle(OUTLINE, FlxColor.RED, 1);

		// current state information
		stateInfo = new FlxText(10, 30, 130);
        stateInfo.text = "Controls State";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.GREEN, 1);

		// create flag sprite, god sprite, and human sprite
		flag = new FlxSprite(425, 0);
		god = new FlxSprite(120, 410);
		human = new FlxSprite(600, 410);
		flag.loadGraphic("assets/images/flag.png", true, 200, 200);
		god.loadGraphic("assets/images/godsprite.png", true, 310, 400);
		human.loadGraphic("assets/images/human.png", true, 336, 400);
		flag.setGraphicSize(50, 50);
		god.setGraphicSize(100, 100);
		human.setGraphicSize(100, 100);

		add(flag);
		add(god);
		add(human);
		add(stateInfo);
		add(menuB);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		writeRules();
		writeControlsGod();
		writeControlsHuman();
		super.update(elapsed);
	}

	// creates new menu state on button click
	function clickBack():Void {
		FlxG.switchState(new MenuState());
	}

	// writes text and UI for rules
	function writeRules():Void {
		rules = new FlxText(100, 125, 850);
		rules.text = "Objective:\nPick up and keep hold of the statue longer than your opponent.\nTouching the statue picks it up.\nTouching your opponent when they have the statue takes it from them.";
		rules.setFormat("assets/font.ttf", 30, FlxColor.WHITE, CENTER);
		rules.setBorderStyle(OUTLINE, FlxColor.GREEN, 1);
		add(rules);
	}

	// writes text and UI for controls for god player
	function writeControlsGod():Void {
		controlsG = new FlxText(50, 300, 425);
		controlsG.text = "Xochipilli:\nWalk Left with [A], Right with [D]\n[W] to Jump\nToggle Walking/Sculpting with [ ]\nMove Sculpting Cursor with [W], [A], [S], [D]\nRotate Sculpting Cursor with [ ]\nToggle Placing/Destroying with [ ]";
		controlsG.setFormat("assets/font.ttf", 28, FlxColor.WHITE, CENTER);
		controlsG.setBorderStyle(OUTLINE, FlxColor.RED, 1);
		add(controlsG);
	}

	// writes text and UI for controls for human player
	function writeControlsHuman():Void {
		controlsH = new FlxText(550, 300, 425);
		controlsH.text =  "Traveler:\nWalk Left with [J], Right with [L]\n[I] to Jump\nToggle Walking/Sculpting with [ ]\nMove Sculpting Cursor with [I], [J], [K], [L]\nRotate Sculpting Cursor with [ ]\nToggle Placing/Destroying with [ ]";
		controlsH.setFormat("assets/font.ttf", 28, FlxColor.WHITE, CENTER);
		controlsH.setBorderStyle(OUTLINE, FlxColor.PURPLE, 1);
		add(controlsH);
	}
}