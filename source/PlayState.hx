package;

import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState {
	var stateInfo:FlxText;
	var timer:FlxText;
	var flag1:Flag;
	var flag2:Flag;

	var player:Player;
	override public function create():Void {
		/*stateInfo = new FlxText(10, 30, 100);
        stateInfo.text = "Play State";
        stateInfo.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
        stateInfo.setBorderStyle(OUTLINE, FlxColor.BLUE, 1);
		timer = new FlxText(475, 30, 200);
		timer.text = "";
		timer.setFormat("assets/font.ttf", 20, FlxColor.WHITE, CENTER);
		timer.setBorderStyle(OUTLINE, FlxColor.WHITE, 1);
		add(stateInfo);
		//add(timer);

		flag1 = new Flag(550, 300);
		flag2 = new Flag(550, 650);
		add(flag1);
		add(flag2);
		*/
		player = new Player("WASDQER", 16, 16);
		add(player);
		super.create();
	}

	override public function update(elapsed:Float):Void {
		//if(FlxG.keys.pressed.ESCAPE) {
            //create pause UI possibly
          //  FlxG.switchState(new MenuState());
		//}
		//timer.text = "" + elapsed;
		super.update(elapsed);
	}
}