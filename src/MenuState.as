package
{
	import org.flixel.*;
 
	public class MenuState extends FlxState
	{
		[Embed(source = '../res/speech-heart.mp3')] private var menuMusic:Class;
		[Embed(source = '../res/logo.png')] private var logoImage:Class;
		[Embed(source = '../res/backgroundnature.png')] private var backgroundImage:Class;
		
		private var logo:FlxSprite;
		private var instructions:FlxText;
		private var background:FlxSprite;
		private var backgroundLoop:FlxSprite;
		private const VELOCITY:Number = 100;
		private const ACCELERATION:Number = 800;
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, backgroundImage);
			add(background);
			
			backgroundLoop = new FlxSprite(1280, 0, backgroundImage);
			add(backgroundLoop);

			logo = new FlxSprite(0, 0);
			logo.loadGraphic(logoImage, false, false);
			add(logo);
			
			logo.maxVelocity.x = VELOCITY;
			logo.acceleration.x = ACCELERATION;
			
			instructions = new FlxText(0, FlxG.height - 48, FlxG.width, "Appuyez sur X ou C pour jouer");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			instructions.maxVelocity.x = VELOCITY;
			instructions.acceleration.x = ACCELERATION;
			
			FlxG.playMusic(menuMusic, 1);
			FlxG.bgColor = 0xffff0000;
			
			FlxG.camera.follow(logo);
		}

		override public function update():void
		{
			if (FlxG.camera.scroll.x > 1280)
			{
				logo.x = 0;
				instructions.x = 0;
				FlxG.camera.setBounds( 0, 0, 320, 240, true );
			}
				
			super.update();
			
			if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C"))
				FlxG.switchState(new InstructionsState());
				
			FlxG.camera.setBounds( FlxG.camera.scroll.x, FlxG.camera.scroll.y, FlxG.camera.scroll.x + 640, 240, true );	
		}
 
		public function MenuState()
		{
			super();
		}
	}
}