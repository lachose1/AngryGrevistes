package  
{
	import org.flixel.*;
	
	public class Coin extends FlxSprite
	{
		[Embed(source = '../res/coin.png')] private var coinImage:Class;
		
		public const X_OFFSET:uint = 3;
		public const Y_OFFSET:uint = 2;
		public const TILE_SIZE:uint = 8;
		
		public function Coin(X:uint, Y:uint)
		{
			super(X * TILE_SIZE + X_OFFSET, Y * TILE_SIZE + Y_OFFSET);
			loadGraphic(coinImage, true, false, 8, 8);
			addAnimation("spinning", [0, 1, 2, 3, 4, 5, 6, 7], 10);
			
			play("spinning");
		}
	}

}