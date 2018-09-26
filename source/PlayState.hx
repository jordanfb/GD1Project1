package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	var stateInfo:FlxText;
	var level1:FlxButton;
	var level2:FlxButton;
	var level3:FlxButton;
	var parser:LevelParser = new LevelParser();
	var levelScreenshots:Array<String> = new Array<String>();

	var player1:Player;
	var player2:Player;
	override public function create():Void {
		// get screenshot images from each file and push to array
		var screenshot1:String = parser.getScreenshot("assets/data/testLevelSelect.txt");
		var screenshot2:String = parser.getScreenshot("assets/data/testScreenshot2.txt");
		var screenshot3:String = parser.getScreenshot("assets/data/testScreenshot3.txt");
		levelScreenshots.push(screenshot1);
		levelScreenshots.push(screenshot2);
		levelScreenshots.push(screenshot3);

		// current state information
		stateInfo = new FlxText(10, 30, 150);
        stateInfo.text = "Level Select\nState";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
		stateInfo.setBorderStyle(OUTLINE, FlxColor.ORANGE, 1);


		level1 = new FlxButton(50, 100, "", click1);
		level1.loadGraphic(levelScreenshots[0], true, 260, 160);

		level2 = new FlxButton(400, 400, "", click2);
		level2.loadGraphic(levelScreenshots[1], true, 260, 160);

		level3 = new FlxButton(750, 100, "", click3);
		level3.loadGraphic(levelScreenshots[2], true, 260, 160);

		add(level1);
		add(level2);
		add(level3);
		add(stateInfo);
		
		/*player1 = new Player("WASDQERF", "assets/images/godsprite.png", 16, 16);
		player1.cursor = new Cursor(player1.xpos, player1.ypos, FlxColor.BLUE);
		player2 = new Player("IJKLUOP;", "assets/images/human.png", 16, 16);
		player2.cursor = new Cursor(player2.xpos, player2.ypos, FlxColor.PURPLE);

		add(player1);
		add(player1.cursor);
		player1.cursor.kill();
		add(player2);
		add(player2.cursor);
		player2.cursor.kill();*/
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            FlxG.switchState(new MenuState());
		}
		//timer.text = "" + elapsed;
		super.update(elapsed);
	}

	// all create a cutscene state with the specific level data file that was selected
	function click1():Void {
		FlxG.switchState(new CutsceneState("assets/data/testLevelSelect.txt"));
	}

	function click2():Void {
		FlxG.switchState(new CutsceneState("assets/data/testScreenshot2.txt"));
	}

	function click3():Void {
		FlxG.switchState(new CutsceneState("assets/data/testScreenshot3.txt"));
	}
}