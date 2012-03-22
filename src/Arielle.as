package  
{
	import org.flixel.*;
	
	public class Arielle extends FlxSprite
	{
		[Embed(source = '../res/metroid.png')] private var metroidImage:Class;
		
		public const TILE_SIZE:uint = 17;
		
		public function Arielle() 
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(metroidImage, true, false, 17, 17);
			addAnimation("normal", [0, 1], 10);
			
			play("normal");
		}
	}

}