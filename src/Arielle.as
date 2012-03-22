package  
{
	import org.flixel.*;
	
	public class Arielle extends FlxSprite
	{
		[Embed(source = '../res/metroid.png')] private var metroidImage:Class;
		
		public const TILE_SIZE:uint = 17;
		
		public function Arielle(X:uint, Y:uint) 
		{
			super(X * 8, Y * 8);
			loadGraphic(metroidImage, true, false, 17, 17);
			addAnimation("normal", [0, 1], 5);
			
			play("normal");
		}
	}

}