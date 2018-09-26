package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxCollision;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class LevelState extends FlxState {

	var _levelDataFilename:String;
	var _levelData:LevelParser;

	var stateInfo:FlxText;
	var timer:FlxText;
	var flag1:Flag;
	var flag2:Flag;
	var player1:Player;
	var player2:Player;
	var counter:Float = 1;
	var _terrain:Terrain;
	var _backgroundArt:Array<FlxSprite>;

	// UI needed for game state
	// Count down timer,
	// possesion indicator -- big screen flash -- BLAH HAS THE STATUE
	// background art. Lets do that now

	var screenBoarderWalls:FlxGroup;
	// UI Art:
	// Background art variables:
	var _backgroundArtFrame = 0;
	var _backgroundArtFrameTimer = 0.0;
	var _backgroundArtFrameTime = .1;
	// Count-down timer
	var _countdownTimer:FlxText;
	var _countdownTime:Float;
	var _levelPlayTime = 60; // the time to play the game

	var _p1ScoreDisplay:FlxText;
	var _p1Score:Float;

	var _p2ScoreDisplay:FlxText;
	var _p2Score:Float;

	override public function create():Void {
		stateInfo = new FlxText(10, 30, 150);
        stateInfo.text = "Level/Gameplay\nState";
        stateInfo.setFormat("assets/fonts/Adventure.otf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
		timer = new FlxText(0, 0, 200);
		timer.text = "";
		timer.setFormat("assets/fonts/Adventure.otf", 20, FlxColor.WHITE, CENTER);
		timer.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);
		add(stateInfo);
		add(timer);
		loadGraphics();
		super.create();
		loadLevel();
		_terrain.add(this);
	}

	private function createFlxText(x:Float, y:Float, width:Float, ?startingText:String = "") : FlxText {
		var tempTxt = new FlxText(x, y, width, startingText);
		add(tempTxt);
		return tempTxt;
	}

	private function loadGraphics() : Void {
		// this loads the background art
		var numFrames = _levelData.levelBackgroundArtFrameCount;
		_backgroundArt = new Array<FlxSprite>();
		for (i in 0...numFrames) {
			_backgroundArt.insert(0, new FlxSprite());
		}
		for (i in 0...numFrames) {
			_backgroundArt[i].loadGraphic(_levelData.levelBackgroundArt + i + ".png");
			if (i != _backgroundArtFrame) {
				_backgroundArt[i].alpha = 0;
			}
			var scale = Math.max(FlxG.width/_backgroundArt[i].width, FlxG.height/_backgroundArt[i].height);
			var xPos = -(1-scale)*_backgroundArt[0].width/2;
			// choose to either align the tops or bottoms or middle-ish by comenting out one of these lines:
			var yPos = -(1-scale)*_backgroundArt[0].height/2; // this aligns the top to the top of the camera.
			// var yPos = -(1-scale)*_backgroundArt[0].height/2 + FlxG.height - scale*_backgroundArt[0].height; // this aligns the bottom of the background art to the bottom of the camera
			// var yPos = -(1-scale)*_backgroundArt[0].height/2 + FlxG.height/2 - scale*_backgroundArt[0].height/2; // this aligns the bottom of the background art to the bottom of the camera

			_backgroundArt[i].scale.x = scale;
			_backgroundArt[i].scale.y = scale;
			// _backgroundArt[i].x = 0;
			// _backgroundArt[i].y = 0;
			// _backgroundArt[i].offset.x = 0;
			// _backgroundArt[i].offset.y = 0;
			//_backgroundArt[i].centerOffsets(false);
			_backgroundArt[i].x = xPos;
			_backgroundArt[i].y = yPos;
		}
		// _backgroundArt.loadGraphics
		addBackgroundGraphics();
	}

	private function addBackgroundGraphics() : Void {
		for (bg in _backgroundArt) {
			add(bg);
		}
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
		//_terrain.follow();
	}

	public function loadLevel() : Void {
		// this resets/loads a level
		_terrain = new Terrain(200, 200);
		_terrain.setLevelFile(_levelData.tileMapFile, _levelData.levelTileArt); // also set art file with this function
		_terrain.reloadLevel();

		addBackgroundGraphics();
		_terrain.add(this);
		initializeCamera();
		// FlxG.worldBounds.set(0, 0, _terrain.mapWidth*_terrain.getTileWidth()*_terrain.scale, _terrain.mapHeight*_terrain.getTileHeight()*_terrain.scale);
		screenBoarderWalls = FlxCollision.createCameraWall(FlxG.camera, 10, true);

		// initialize the players
		player1 = new Player("WASDQERF", "assets/images/godsprite.png", _levelData.player1_x, _levelData.player1_y, _terrain.scale);
		player1.cursor = new Cursor(player1.xpos, player1.ypos, FlxColor.BLUE, FlxColor.ORANGE, _terrain, "assets/images/outline.png");
		player2 = new Player("IJKLUOPH", "assets/images/human.png", _levelData.player2_x, _levelData.player2_y, _terrain.scale);
		player2.cursor = new Cursor(player2.xpos, player2.ypos, FlxColor.PURPLE, FlxColor.RED, _terrain, "assets/images/outline1.png");

		add(player1);
		add(player2);
		add(player1.cursor);
		add(player2.cursor);
		player1.cursor.addSpriteList(this);
		player2.cursor.addSpriteList(this);
		player1.cursor.kill();
		player1.cursor.killSpriteList();
		player2.cursor.kill();
		player2.cursor.killSpriteList();
		/*trace(_terrain.mapHeight * _terrain.getTileHeight());
		FlxG.camera.setSize(FlxG.camera.width, _terrain.mapHeight * _terrain.getTileHeight());
		trace("Width " + FlxG.camera.scaleY);
		FlxG.camera.setScale(FlxG.camera.scaleX, FlxG.height/(_terrain.mapHeight * _terrain.getTileHeight()));
		trace("Width2 " + FlxG.camera.scaleY);
		trace(FlxG.cameras.list.length);
		trace(FlxG.camera.height);*/

		// then also set up the flags depending on the game mode and the level spawn information
		if (_levelData.gameMode == "Hold the Flag") {
			// our firstt and likely only game mode
			flag1 = new Flag(_levelData.flag1X, _levelData.flag1Y);
			add(flag1);
			// flag2 = new Flag(_levelData.flag2X, _levelData.flag2Y);
			// then do whatever else we need to
		} else {
			trace("LOADED A LEVEL BUT DIDN'T FIND A VALID GAME MODE ERROR");
		}

		// then load the UI
		_countdownTimer = new FlxText(1080/2, 50, 200, "Timer");
		_countdownTimer.setFormat("assets/fonts/Adventure.otf", 20, FlxColor.WHITE, CENTER);
        _countdownTimer.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);

        _p1ScoreDisplay = new FlxText(1080/3, 50, 200, "P1 Score");
		_p1ScoreDisplay.setFormat("assets/fonts/Adventure.otf", 16, FlxColor.RED, CENTER);
        _p1ScoreDisplay.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);

        _p2ScoreDisplay = new FlxText(1080/3*2, 50, 200, "P2 Score");
		_p2ScoreDisplay.setFormat("assets/fonts/Adventure.otf", 16, FlxColor.BLUE, CENTER);
        _p2ScoreDisplay.setBorderStyle(OUTLINE, FlxColor.BLACK, 1);

        add(_p1ScoreDisplay);
        add(_p2ScoreDisplay);
        add(_countdownTimer);
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            FlxG.switchState(new MenuState());
		}
		timer.text = "" + elapsed;
		super.update(elapsed);
		_terrain.collide(player1);
		_terrain.collide(player2);
		FlxG.collide(screenBoarderWalls, player1);
		FlxG.collide(screenBoarderWalls, player2);
		//trace(FlxG.camera.height);

		/*if (FlxG.keys.pressed.L) {
			FlxG.camera.x = FlxG.camera.x - 1;
		}
		if (FlxG.keys.justPressed.J) {
			for (bg in _backgroundArt) {
				bg.x = bg.x + 1;
			}
		}
		if (FlxG.keys.justPressed.K) {
			for (bg in _backgroundArt) {
				bg.y = bg.y - 1;
			}
		}
		if (FlxG.keys.justPressed.I) {
			for (bg in _backgroundArt) {
				bg.y = bg.y + 1;
			}
		}
		if (FlxG.keys.pressed.P) {
			trace(FlxG.camera.x + " : " + FlxG.camera.y);
		}*/
		_terrain.updateBuffers();
		updateBackgroundArt(elapsed);
	}

	private function updateBackgroundArt(elapsed:Float) {
		_backgroundArtFrameTimer += elapsed;
		if (_backgroundArtFrameTimer > _backgroundArtFrameTime) {
			// then increase the frame index
			_backgroundArtFrameTimer -= _backgroundArtFrameTime;
			_backgroundArt[_backgroundArtFrame].alpha = 0;
			_backgroundArtFrame++;
			_backgroundArtFrame %= _backgroundArt.length;
			_backgroundArt[_backgroundArtFrame].alpha = 1;
		}
	}
}

enum GameMode {
		// what game mode the game is in
		holdFlag; captureTheFlag; captureTheSingleFlag;
	}