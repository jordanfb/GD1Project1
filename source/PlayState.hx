package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
using StringTools;

class PlayState extends FlxState {
	var info:FlxText;
	var name1:FlxText;
	var name2:FlxText;
	var name3:FlxText;
	var bg:FlxSprite;
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
		levelScreenshots.push(screenshot1);
		levelScreenshots.push(screenshot2);
		levelScreenshots.push(screenshot3);

		level1 = new FlxButton(50, 100, "", click1);
		level1.loadGraphic(levelScreenshots[0]);
		level1.setGraphicSize(450, 250);
        level1.updateHitbox();

		level2 = new FlxButton(310, 400, "", click2);
		level2.loadGraphic(levelScreenshots[1]);
		level2.setGraphicSize(450, 250);
        level2.updateHitbox();

		level3 = new FlxButton(575, 100, "", click3);
		level3.loadGraphic(levelScreenshots[2]);
		level3.setGraphicSize(450, 250);
        level3.updateHitbox();

		info = new FlxText(380, 25, 300);
        info.text = " Select A Level! ";
        info.setFormat("assets/fonts/Adventure.otf", 40, FlxColor.WHITE, CENTER);
        info.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);

		name1 = new FlxText(50, 310, 300);
        name1.text = parser.getLevelName("assets/data/level1_Properties.txt") + " "; // "Time-worn Temple ";
        name1.setFormat("assets/fonts/Adventure.otf", 32, FlxColor.BLACK, LEFT);
        name1.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);

		name2 = new FlxText(310, 615, 300);
        name2.text = parser.getLevelName("assets/data/level2_Properties.txt") + " "; // "Climb To The Cloud ";
        name2.setFormat("assets/fonts/Adventure.otf", 32, FlxColor.BLACK, LEFT);
        name2.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);

		name3 = new FlxText(575, 310, 300);
        name3.text = parser.getLevelName("assets/data/level3_Properties.txt") + " "; // "Diggin' Deep ";
        name3.setFormat("assets/fonts/Adventure.otf", 32, FlxColor.BLACK, LEFT);
        name3.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);

        bg = new FlxSprite();
        // bg.makeGraphic(1080, 720, FlxColor.fromRGB(178, 219, 240));
        bg.loadGraphic("assets/images/menu background.png");
        bg.updateHitbox();

		add(bg);
		add(level1);
		add(level2);
		add(level3);
		add(info);
		add(name1);
		add(name2);
		add(name3);
		super.create();
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