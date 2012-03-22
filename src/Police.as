package  
{
	import org.flixel.*
	
	public class Police extends FlxSprite
	{
		[Embed(source = '../res/police.png')] private var policeImage:Class;
		
		public const TILE_SIZE:uint = 8;
		public const WIDTH:uint = 35;
		public const HEIGHT:uint = 32;
		public const Y_OFFSET:uint = 1;
		
		public function Police(X:uint, Y:uint) 
		{
			super(X * TILE_SIZE, Y * TILE_SIZE + Y_OFFSET);
			loadGraphic(policeImage, true, false, WIDTH, HEIGHT);
			addAnimation("hitting", [0, 1], 5);
			
			play("hitting");
		}
		
	}

}