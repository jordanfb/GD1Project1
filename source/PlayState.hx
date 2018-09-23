package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	var stateInfo:FlxText;
	var timer:FlxText;
	var flag:Flag;
	var counter:Float = 1;

	override public function create():Void {
		stateInfo = new FlxText(10, 30, 100);
        stateInfo.text = "Play State";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
		timer = new FlxText(475, 30, 200);
		timer.text = "";
		timer.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
		timer.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);
		add(stateInfo);
		//add(timer);

		flag = new Flag(550, 300);
		add(flag);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		if(FlxG.keys.pressed.ESCAPE) {
            FlxG.switchState(new MenuState());
		}
		var test = new LevelManager();
		test.parse();
		//timer.text = "" + elapsed;
		super.update(elapsed);
	}
}