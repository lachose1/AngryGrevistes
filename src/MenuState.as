package
{
	import org.flixel.*;
 
	public class MenuState extends FlxState
	{
		[Embed(source = '../res/speech-heart.mp3')] private var menuMusic:Class;
		[Embed(source = '../res/logo.png')] private var logoImage:Class;
		[Embed(source = '../res/backgroundnature.png')] private var backgroundImage:Class;
		
		private var logo:FlxSprite;
		private var background:FlxSprite;
		private var backgroundLoop:FlxSprite;
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, backgroundImage);
			add(background);
			
			backgroundLoop = new FlxSprite(1280, 0, backgroundImage);
			add(backgroundLoop);
			
			var title:FlxText;
			title = new FlxText(0, 16, FlxG.width, "Angry Grévistes");
			title.setFormat (null, 16, 0xFFFFFFFF, "center");
			add(title);
			
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 32, FlxG.width, "Appuyez sur X ou C pour jouer");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			FlxG.playMusic(menuMusic, 1);
			FlxG.bgColor = 0xffff0000;
			
			logo = new FlxSprite(0, 0);
			logo.loadGraphic(logoImage, false, false);
			add(logo);
			FlxG.camera.follow(logo);
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