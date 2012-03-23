package  
{
	import org.flixel.*
	
	public class Grenade extends FlxSprite
	{
		[Embed(source = '../res/grenade.png')] private var grenadeImage:Class;
		
		private var player:Player;
		
		public const TILE_SIZE:uint = 8;
		public const WIDTH:uint = 16;
		public const HEIGHT:uint = 16;
		
		public function Grenade(X:uint, Y:uint, playerRef:Player) 
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(grenadeImage, true, false, WIDTH, HEIGHT);
			
			player = playerRef;
		}
		
		public function Launch():void
		{
			velocity.x = -150;
		}
		
		public function Aim():void
		{
			//A faire, c'est ca qui va faire appartire une mire avant de lancer la grenade
		}
		
		override public function update():void 
		{
			if (player.x > x - 350)
				Launch();
		}
	}
		
}
