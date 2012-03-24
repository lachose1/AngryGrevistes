package  
{
	import org.flixel.*
	
	public class Crosshair extends FlxSprite
	{
		[Embed(source = '../res/crosshair.png')] private var crosshairImage:Class;
		
		private var player:Player;
		private var sinX:Number = 0;
		
		public const TILE_SIZE:uint = 8;
		public const WIDTH:uint = 15;
		public const HEIGHT:uint = 15;
		
		public function Crosshair(X:uint, Y:uint, playerRef:Player) 
		{
			super(X * TILE_SIZE - 350, Y * TILE_SIZE);
			loadGraphic(crosshairImage, false , false, WIDTH, HEIGHT);
			
			player = playerRef;
		}
		
		public function Aim():void
		{
			y = Math.sin(sinX) * 100 + 105;
			sinX += 0.05;
			x = player.x + 272
		}
		
		override public function update():void 
		{
			if (player.x > x - 500)
				Aim();
		}
	}
		
}
