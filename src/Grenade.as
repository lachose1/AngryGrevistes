package  
{
	import org.flixel.*
	
	public class Grenade extends FlxSprite
	{
		[Embed(source = '../res/grenade.png')] private var grenadeImage:Class;
		
		public const TILE_SIZE:uint = 8;
		public const WIDTH:uint = 16;
		public const HEIGHT:uint = 16;
		
		public function Grenade(X:uint, Y:uint) 
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(grenadeImage, true, false, WIDTH, HEIGHT);
			
			velocity.x = -150;
		}
		
	}

}