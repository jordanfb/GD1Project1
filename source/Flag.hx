package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Flag extends FlxSprite {

    public function new(X:Float, Y:Float, ?SimpleGraphic:FlxGraphicAsset) {
        super(X, Y, SimpleGraphic);
        // "true" is for if it should be animated and the (x, y) are for where each animation is sliced
        loadGraphic("assets/images/flag.png", true, 200, 200);
        // "name", [frame path], at what fps, should it loop?
        animation.add("flagWave", [0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,9], 10, true);
        scale.set(.25, .25);
        animation.play("flagWave");
    }

    public function pickUp(player:Player, X:Float, Y:Float) {
        // character picks up flag at (X, Y)
        player.hasFlag = true;
        //player.toggleFlag();
    }

    public function flagSteal(player1:Player, other:Player) {
        // player who had flag gets stunned and flag goes to opponent
        player1.hasFlag = false;
        player1.stun();
        other.hasFlag = true;
        //other.toggleFlag();
    }
}