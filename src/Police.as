package  
{
	import org.flixel.*
	
	public class Police extends FlxSprite
	{
		[Embed(source = '../res/police.png')] private var policeImage:Class;
		
		public const TILE_WIDTH:uint = 35;
		public const TILE_HEIGHT:uint = 32;
		public const Y_OFFSET:uint = 9;
		
		public function Police(X:uint, Y:uint) 
		{
			super(X * TILE_WIDTH, Y * TILE_HEIGHT + Y_OFFSET);
			loadGraphic(policeImage, true, false, TILE_WIDTH, TILE_HEIGHT);
			addAnimation("hitting", [0, 1], 5);
			
			play("hitting");
		}
		
	}

}