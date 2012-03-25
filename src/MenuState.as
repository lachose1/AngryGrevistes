package
{
	import org.flixel.*;
 
	public class MenuState extends FlxState
	{
		override public function create():void
		{
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Angry Grévistes");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
 
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Appuyez sur X ou C pour jouer");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
		}

		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C"))
			{
				FlxG.switchState(new PlayState());
			}
		}
 
		public function MenuState()
		{
			super();
		}
	}
}