package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class OptionsState extends MusicBeatSubstate
{
    var textMenuItems:Array<String> = ['Controls', 'Erase Save Data'];

	var selector:FlxSprite;
	var curSelected:Int = 0;

	var grpOptionsTexts:FlxTypedGroup<FlxText>;

	public function new()
	{
		super();

		grpOptionsTexts = new FlxTypedGroup<FlxText>();
		add(grpOptionsTexts);

		selector = new FlxSprite().makeGraphic(5, 5, FlxColor.RED);
		add(selector);

		for (i in 0...textMenuItems.length)
		{
			var optionText:FlxText = new FlxText(20, 20 + (i * 50), 0, textMenuItems[i], 32);
			optionText.ID = i;
			grpOptionsTexts.add(optionText);
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UP_P) { curSelected -= 1; }
		else if (controls.DOWN_P) { curSelected += 1; }
		else if (controls.BACK) { FlxG.switchState(new MainMenuState()); }
		else if (controls.ACCEPT)
		{
			switch (textMenuItems[curSelected])
			{
				case "Controls":
					// SSSSSS
                case "Erase Save Data":
                    onClear();
			}

			trace(textMenuItems[curSelected]);
		}

		if (curSelected < 0) { curSelected = textMenuItems.length - 1; }
		else if (curSelected >= textMenuItems.length) { curSelected = 0; }

		grpOptionsTexts.forEach(function(txt:FlxText)
		{
			txt.color = FlxColor.WHITE;

			if (txt.ID == curSelected)
				txt.color = FlxColor.YELLOW;
		});
	}

    function onClear():Void
    {
        var defaultWeekUnlocked:Array<Bool> = [true, true, false, false, false, false, false];

		FlxG.save.data.weekUnlocked = defaultWeekUnlocked;
        FlxG.switchState(new MainMenuState());
    }
}