package;

import Song.SwagSong;
import flixel.ui.FlxBar;
import flixel.math.FlxMath;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedGroup<FlxSprite>
{
    private var healthBarBG:FlxSprite;
    private var healthBar:FlxBar;
    private var iconP1:FlxSprite;
    private var iconP2:FlxSprite;
    private var scoreTxt:FlxText;

    /**
     * Creates the HUD
     * @param song The Song
     */
    public function new(song:SwagSong)
    {
        super();

        healthBarBG = new FlxSprite(0, FlxG.height * 0.9).makeGraphic(601, 19, FlxColor.BLACK);
		healthBarBG.screenCenter(X);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this,
            "", 0, 2);
		healthBar.createFilledBar(FlxColor.RED, FlxColor.LIME);

		iconP1 = new HealthIcon(song.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2);

		iconP2 = new HealthIcon(song.player2, false);
		iconP2.y = healthBar.y - (iconP2.height / 2);

		scoreTxt = new FlxText(healthBarBG.x + healthBarBG.width - 190, healthBarBG.y + 30, 0, "", 20);
		scoreTxt.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

        add(healthBarBG);
        add(healthBar);
        add(iconP1);
        add(iconP2);
		add(scoreTxt);
        forEach(function(sprite) sprite.scrollFactor.set(0, 0));
    }

    public function updateHUD(health:Float, score:Int)
    {
        iconP1.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50)));
		iconP2.setGraphicSize(Std.int(FlxMath.lerp(150, iconP2.width, 0.50)));

		iconP1.updateHitbox();
		iconP2.updateHitbox();

		var iconOffset:Int = 26;

        healthBar.value = health;

		iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

		if (health > 2)
			health = 2;

		if (healthBar.percent < 20)
			iconP1.animation.curAnim.curFrame = 1;
		else
			iconP1.animation.curAnim.curFrame = 0;

		if (healthBar.percent > 80)
			iconP2.animation.curAnim.curFrame = 1;
		else
			iconP2.animation.curAnim.curFrame = 0;

        scoreTxt.text = "Score:" + score;
    }

    public function updateBeat()
    {
        iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));

		iconP1.updateHitbox();
		iconP2.updateHitbox();
    }
}