package  
{
	import org.flixel.*
	
	public class Crosshair extends FlxSprite
	{
		[Embed(source = '../res/crosshair.png')] private var crosshairImage:Class;
		
		private var player:Player;
		private var sinX:Number = 0;
		private var grenadeY:int;
		private var aimTimer:FlxTimer;
		
		public const TILE_SIZE:uint = 8;
		public const WIDTH:uint = 15;
		public const HEIGHT:uint = 15;
		
		public function Crosshair(X:uint, Y:uint, playerRef:Player) 
		{
			super(X * TILE_SIZE - 350, Y * TILE_SIZE);
			loadGraphic(crosshairImage, false , false, WIDTH, HEIGHT);
			
			player = playerRef;
			grenadeY = Y * TILE_SIZE;
			aimTimer = new FlxTimer();
		}
		
		public function Aim():void
		{
			var answer:Number = Math.sin(2*sinX) * 100 + 120;
			if (answer < grenadeY || !aimTimer.finished)
			{
				sinX += 0.05;
				y = answer;
			}
			else
			{
				y = grenadeY;
			}
			x = player.x + 275;
		}
		
		override public function update():void 
		{
			if (player.x > x - 500)
			{
				Aim();
				aimTimer.start(1);
			}
		}
	}
		
}
