package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using StringTools;

class PlayState extends FlxState {
	var level1:FlxButton;
	var level2:FlxButton;
	var level3:FlxButton;
	var parser:LevelParser = new LevelParser();
	var levelScreenshots:Array<String> = new Array<String>();

	override public function create():Void {
		// get screenshot images from each file and push to array
		var screenshot1:String = parser.getScreenshot("assets/data/level1_Properties.txt").trim();
		var screenshot2:String = parser.getScreenshot("assets/data/level2_Properties.txt").trim();
		var screenshot3:String = parser.getScreenshot("assets/data/level3_Properties.txt").trim();
		trace(screenshot1);
		trace(screenshot2);
		trace(screenshot3);
		levelScreenshots.push(screenshot1);
		levelScreenshots.push(screenshot2);
		levelScreenshots.push(screenshot3);

		level1 = new FlxButton(50, 100, "", click1);
		level1.loadGraphic(levelScreenshots[0]);
		level1.setGraphicSize(300, 300);
        level1.updateHitbox();

		level2 = new FlxButton(400, 400, "", click2);
		level2.loadGraphic(levelScreenshots[1]);
		level2.setGraphicSize(300, 300);
        level2.updateHitbox();

		level3 = new FlxButton(750, 100, "", click3);
		level3.loadGraphic(levelScreenshots[2]);
		level3.setGraphicSize(300, 300);
        level3.updateHitbox();

		add(level1);
		add(level2);
		add(level3);
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            FlxG.switchState(new MenuState());
		}
		super.update(elapsed);
	}

	// all create a cutscene state with the specific level data file that was selected
	function click1():Void {
		closeSubState();
		FlxG.switchState(new CutsceneState("assets/data/level1_Properties.txt"));
	}

	function click2():Void {
		closeSubState();
		FlxG.switchState(new CutsceneState("assets/data/level2_Properties.txt"));
	}

	function click3():Void {
		closeSubState();
		FlxG.switchState(new CutsceneState("assets/data/level3_Properties.txt"));
	}
}