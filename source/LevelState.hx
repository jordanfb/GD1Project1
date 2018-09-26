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
	var player1:Player;
	var player2:Player;
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
		super.create();
		loadLevel();
		_terrain.add(this);
	}

	private function createFlxText(x:Float, y:Float, width:Float, ?startingText:String = "") : FlxText {
		var tempTxt = new FlxText(x, y, width, startingText);
		add(tempTxt);
		return tempTxt;
	}

	private function initializeCamera() : Void {
		/*
		// _terrain.follow();
		// FlxG.camera.setSize(_terrain.mapWidth * _terrain.getTileWidth(), _terrain.mapHeight * _terrain.getTileHeight());
		// _terrain.updateBuffers();
		// FlxG.camera.setScale(FlxG.camera.scaleX, FlxG.height/(_terrain.mapHeight * _terrain.getTileHeight()));
		FlxG.camera.setScale(FlxG.width / (_terrain.mapWidth * _terrain.getTileWidth()), FlxG.height/(_terrain.mapHeight * _terrain.getTileHeight()));
		_terrain.follow();
		FlxG.camera.x = -425;
		FlxG.camera.y = -285;
		trace(FlxG.camera.x);
		//FlxG.camera.x = -_terrain.mapWidth * _terrain.getTileWidth() / 2;
		trace(FlxG.camera.height);*/
		var cameraOffset = _terrain.scaleToScreen(FlxG.width, FlxG.height);
		//FlxG.camera.x = cameraOffset.x;
		//FlxG.camera.y = cameraOffset.y;
		_terrain.updateBuffers();
	}

	public function initializeLevel( ?levelDataFilename:String = "assets/data/testLevelSelect.txt" ): Void {
		_levelData = new LevelParser();
		// this is called the first time this scene loads. It sets the _terrain up, and does a bunch of other things too.
		_levelDataFilename = levelDataFilename;
		// then load the level data using the LevelParser
		_levelData.parse(_levelDataFilename);
		 // pass in tile width and tile height
		//_terrain.follow();
	}

	public function loadLevel() : Void {
		// this resets/loads a level
		_terrain = new Terrain(200, 200);
		_terrain.setLevelFile(_levelData.tileMapFile, _levelData.levelTileArt); // also set art file with this function
		_terrain.reloadLevel();
		initializeCamera();

		player1 = new Player("WASDQERF", "assets/images/godsprite.png", _levelData.player1_x, _levelData.player1_y, _terrain.scale);
		player1.cursor = new Cursor(player1.xpos, player1.ypos, FlxColor.BLUE);
		player2 = new Player("IJKLUOP;", "assets/images/human.png", _levelData.player2_x, _levelData.player2_y, _terrain.scale);
		player2.cursor = new Cursor(player2.xpos, player2.ypos, FlxColor.PURPLE);

		add(player1);
		add(player1.cursor);
		player1.cursor.kill();
		add(player2);
		add(player2.cursor);
		player2.cursor.kill();
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
		_terrain.collide(player1);
		_terrain.collide(player2);
		//trace(FlxG.camera.height);
		/*if (FlxG.keys.pressed.L) {
			FlxG.camera.x = FlxG.camera.x - 1;
		}
		if (FlxG.keys.pressed.J) {
			FlxG.camera.x = FlxG.camera.x + 1;
		}
		if (FlxG.keys.pressed.K) {
			FlxG.camera.y = FlxG.camera.y - 1;
		}
		if (FlxG.keys.pressed.I) {
			FlxG.camera.y = FlxG.camera.y + 1;
		}
		if (FlxG.keys.pressed.P) {
			trace(FlxG.camera.x + " : " + FlxG.camera.y);
		}*/
		_terrain.updateBuffers();
	}
}

enum GameMode {
		// what game mode the game is in
		holdFlag; captureTheFlag; captureTheSingleFlag;
	}