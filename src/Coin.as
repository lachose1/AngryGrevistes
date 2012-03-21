package  
{
	import org.flixel.*;
	
	public class Coin extends FlxSprite
	{
		public const X_OFFSET:uint = 3;
		public const Y_OFFSET:uint = 2;
		public const TILE_SIZE:uint = 8;
		
		public function Coin(X:uint, Y:uint)
		{
			super(X * TILE_SIZE + X_OFFSET, Y * TILE_SIZE + Y_OFFSET);
			super.makeGraphic(2,4,0xffffff00);
		}
		
		static public function getCoin(coin:Coin, player:Player):void
		{
			coin.kill();
			//TODO ajouter 5$ au score
		}
	}

}