package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class ControlsState extends FlxState {
	var menuB:FlxButton;
	var stateInfo:FlxText;
	var rules:FlxText;
	var controls:FlxText;

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

		add(stateInfo);
		add(menuB);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		writeRules();
		writeControls();
		super.update(elapsed);
	}

	// creates new menu state on button click
	function clickBack():Void {
		FlxG.switchState(new MenuState());
	}

	// writes text and UI for rules
	function writeRules():Void {
		rules = new FlxText(60, 60, 400);
		rules.text = "How To Play:\n\n\t1.) Earn points while holding the flag\n\t
			2.) Steal the flag from your opponent by touching them\n\t
			3.) Whoever has the most points when time runs out wins";
		rules.setFormat("assets/font.ttf", 30, FlxColor.WHITE);
		rules.setBorderStyle(OUTLINE, FlxColor.PURPLE, 1);
		add(rules);
	}

	// writes text and UI for controls
	function writeControls():Void {
		controls = new FlxText(560, 210, 450);
		controls.text = "Controls:\n\n\tPlayers share the keyboard and use {WASDQE} and {IJKLUO} to play.\n\t
			{W, I} to jump up, {A, J} to move left, {D, L} to move right\n\t
			(map other controls once set)";
		controls.setFormat("assets/font.ttf", 30, FlxColor.WHITE);
		controls.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
		add(controls);
	}
}
