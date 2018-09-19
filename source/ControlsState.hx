package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class ControlsState extends FlxState {
	var menuB:FlxButton;
	var stateInfo:FlxText;

	override public function create():Void {
		menuB = new FlxButton(25, 675, "Back", clickBack);
		menuB.label.setFormat("assets/font.ttf", 10, FlxColor.WHITE, CENTER);
        menuB.label.setBorderStyle(OUTLINE, FlxColor.RED, 1);
		stateInfo = new FlxText(10, 30, 130);
        stateInfo.text = "Controls State";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.GREEN, 1);
		add(stateInfo);
		add(menuB);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
	}

	function clickBack():Void {
		FlxG.switchState(new MenuState());
	}
}
