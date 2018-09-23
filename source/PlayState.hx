package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	var stateInfo:FlxText;
	var selectB:FlxButton;

	override public function create():Void {
		stateInfo = new FlxText(10, 30, 150);
        stateInfo.text = "Level Select\nState";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
		stateInfo.setBorderStyle(OUTLINE, FlxColor.ORANGE, 1);

		selectB = new FlxButton(500, 620, "Select", clickSelect); // (x, y, text, function call on button click)
        selectB.label.setFormat("assets/font.ttf", 10, FlxColor.WHITE, CENTER);
        selectB.label.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);

		add(selectB);
		add(stateInfo);
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}

	function clickSelect():Void {
		FlxG.switchState(new LevelState());
	}
}