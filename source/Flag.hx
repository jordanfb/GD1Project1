package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

class Flag extends FlxSprite {

    private var startingPos:FlxPoint;
    private var canBePickedUp:Bool;

    public function new(X:Float, Y:Float, ?SimpleGraphic:FlxGraphicAsset) {
        super(X, Y, SimpleGraphic);
        startingPos = new FlxPoint(X, Y);
        // "true" is for if it should be animated and the (x, y) are for where each animation is sliced
        loadGraphic("assets/images/flag.png", true, 200, 200);
        // "name", [frame path], at what fps, should it loop?
        animation.add("flagWave", [0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,9], 10, true);
        scale.set(.25, .25);
        updateHitbox();
        animation.play("flagWave");
        canBePickedUp = true;
    }

    public function isBeingHeld() : Bool {
        // we assume that whenever it's not being held then it can be picked up.
        return !canBePickedUp;
    }

    public function pickUp(player:Player, X:Float, Y:Float) {
        // character picks up flag at (X, Y)
        player.hasFlag = true;
        beenPickedUp();
    }

    public function drop(player:Player, X:Float, Y:Float) {
        setPosition(X, Y);
        beenDropped();
    }

    public function resetFlag() {
        // go back to the starting pos
        setPosition(startingPos.x, startingPos.y);
    }

    public function beenDropped() {
        alpha = 1;
        canBePickedUp = true;
    }

    public function beenPickedUp() {
        alpha = 0;
        canBePickedUp = false;
    }

    public function flagSteal(player1:Player, other:Player) {
        // player who had flag gets stunned and flag goes to other
        player1.hasFlag = false;
        player1.stun();
        other.hasFlag = true;
    }
}