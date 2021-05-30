package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();

		switch (char)
		{
			case null:
				{
					loadGraphic(Paths.image('icons/icon-face'), true, 150, 150);
					antialiasing = true;
				}
			case 'bf-pixel' | 'senpai' | 'senpai-angry' | 'spirit':
				{
					loadGraphic(Paths.image('icons/icon-$char'), true, 150, 150);
					antialiasing = false;
				}
			case 'monster-christmas':
				{
					loadGraphic(Paths.image('icons/icon-monster'), true, 150, 150);
					antialiasing = true;
				}
			case 'parents-christmas':
				{
					loadGraphic(Paths.image('icons/icon-parents'), true, 150, 150);
					antialiasing = true;
				}
			case 'mom-car':
				{
					loadGraphic(Paths.image('icons/icon-mom'), true, 150, 150);
					antialiasing = true;
				}
			case 'bf-car' | 'bf-christmas':
				{
					loadGraphic(Paths.image('icons/icon-bf'), true, 150, 150);
					antialiasing = true;
				}
			default:
				{
					loadGraphic(Paths.image('icons/icon-$char'), true, 150, 150);
					antialiasing = true;
				}
		}

		animation.add(char, [0, 1], 0, false, isPlayer);
		animation.play(char);

		scrollFactor.set();
	}

	public function changeIcon(isLossing:Bool) {
		if (isLossing) {
			animation.curAnim.curFrame = 1;
		}
		else {
			animation.curAnim.curFrame = 0;
		}
	}

	override function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
