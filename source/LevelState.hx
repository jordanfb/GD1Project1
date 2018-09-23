package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class LevelState extends FlxState {

	var _levelDataFilename:String;
	var _levelData:LevelManager;


	var stateInfo:FlxText;
	var timer:FlxText;
	var flag:Flag;
	var counter:Float = 1;
	var _terrain:Terrain;

	override public function create():Void {
		stateInfo = new FlxText(10, 30, 100);
        stateInfo.text = "Level/Gameplay State";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
		timer = new FlxText(475, 30, 200);
		timer.text = "";
		timer.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
		timer.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);
		add(stateInfo);
		add(timer);

		super.create();
	}

	private function createFlxText(x:Float, y:Float, width:Float, ?startingText:String = "") : FlxText {
		var tempTxt = new FlxText(x, y, width, startingText);
		add(tempTxt);
		return tempTxt;
	}

	public function initializeLevel( ?levelDataFilename:String = "assets/data/testLevelSelect.txt" ): Void {
		_levelData = new LevelManager();
		// this is called the first time this scene loads. It sets the _terrain up, and does a bunch of other things too.
		_levelDataFilename = levelDataFilename;
		// then load the level data using the levelManager
		_levelData.parse(_levelDataFilename);
		_terrain = new Terrain(); // pass in tile width and tile height
		_terrain.add(this);

		loadLevel();
	}

	public function loadLevel() : Void {
		// this resets/loads a level
		_terrain.setLevelFile(_levelData.tileMapFile); // also set art file with this function
		_terrain.reloadLevel();
		// then also set up the flags depending on the game mode and the level spawn information
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            FlxG.switchState(new MenuState());
		}
		//timer.text = "" + elapsed;
		super.update(elapsed);
	}
}

enum GameMode {
		// what game mode the game is in
		holdFlag; captureTheFlag; captureTheSingleFlag;
	}