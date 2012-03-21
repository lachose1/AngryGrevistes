package  
{
	import org.flixel.*;
	
	public class Coin extends FlxSprite
	{
		[Embed(source = '../res/coin.png')] private var coinImage:Class;
		
		public const TILE_SIZE:uint = 8;
		
		public function Coin(X:uint, Y:uint)
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(coinImage, true, false, 8, 8);
			addAnimation("spinning", [0, 1, 2, 3, 4, 5, 6, 7], 10);
			
			play("spinning");
		}
	}

}