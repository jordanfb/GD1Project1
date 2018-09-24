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
        super(X, Y, SimpleGraphic); // add in flag image when complete
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