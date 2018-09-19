package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Flag extends FlxSprite {

    // "?X:Float=0" means that it is optional to pass this and if its not passed then it defaults to 0s
    public function new(X:Float, Y:Float, ?SimpleGraphic:FlxGraphicAsset) {
        super(X, Y, SimpleGraphic);
    }

    /*public function pickUp(character:Player, X:Float, Y:Float) {
        // character picks up flag at (X, Y)
    }

    public function captured(character:Player) {
        // end game, the player who captured the flag first won
    }*/
}