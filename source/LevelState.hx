package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class LevelState extends FlxState {

	var _levelDataFilename:String;
	var _levelData:LevelParser;


	var stateInfo:FlxText;
	var timer:FlxText;
	var flag:Flag;
	var counter:Float = 1;
	var _terrain:Terrain;

	override public function create():Void {
		stateInfo = new FlxText(10, 30, 150);
        stateInfo.text = "Level/Gameplay\nState";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
		timer = new FlxText(0, 0, 200);
		timer.text = "";
		timer.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
		timer.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);
		add(stateInfo);
		add(timer);
		initializeCamera();
		super.create();
	}

	private function createFlxText(x:Float, y:Float, width:Float, ?startingText:String = "") : FlxText {
		var tempTxt = new FlxText(x, y, width, startingText);
		add(tempTxt);
		return tempTxt;
	}

	private function initializeCamera() : Void {
		// _terrain.follow();
		// FlxG.camera.setSize(FlxG.camera.width, _terrain.mapHeight * _terrain.getTileHeight());
		FlxG.camera.setScale(FlxG.camera.scaleX, FlxG.height/(_terrain.mapHeight * _terrain.getTileHeight()));
		trace(FlxG.camera.height);
	}

	public function initializeLevel( ?levelDataFilename:String = "assets/data/testLevelSelect.txt" ): Void {
		_levelData = new LevelParser();
		// this is called the first time this scene loads. It sets the _terrain up, and does a bunch of other things too.
		_levelDataFilename = levelDataFilename;
		// then load the level data using the LevelParser
		_levelData.parse(_levelDataFilename);
		_terrain = new Terrain(200, 200); // pass in tile width and tile height
		_terrain.add(this);
		//_terrain.follow();

		loadLevel();
	}

	public function loadLevel() : Void {
		// this resets/loads a level
		_terrain.setLevelFile(_levelData.tileMapFile, _levelData.levelTileArt); // also set art file with this function
		_terrain.reloadLevel();
		/*trace(_terrain.mapHeight * _terrain.getTileHeight());
		FlxG.camera.setSize(FlxG.camera.width, _terrain.mapHeight * _terrain.getTileHeight());
		trace("Width " + FlxG.camera.scaleY);
		FlxG.camera.setScale(FlxG.camera.scaleX, FlxG.height/(_terrain.mapHeight * _terrain.getTileHeight()));
		trace("Width2 " + FlxG.camera.scaleY);
		trace(FlxG.cameras.list.length);
		trace(FlxG.camera.height);*/
		// then also set up the flags depending on the game mode and the level spawn information
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            FlxG.switchState(new MenuState());
		}
		timer.text = "" + elapsed;
		super.update(elapsed);
		//trace(FlxG.camera.height);
	}
}

enum GameMode {
		// what game mode the game is in
		holdFlag; captureTheFlag; captureTheSingleFlag;
	}