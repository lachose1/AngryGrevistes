package  
{
	import org.flixel.*;
	
	public class Square extends FlxSprite
	{
		[Embed(source = '../res/carre-rouge.png')] private var redSquareImage:Class;
		[Embed(source = '../res/carre-vert.png')] private var greenSquareImage:Class;
		
		public const TILE_SIZE:uint = 8;
		
		public var green:Boolean;
		
		public function Coin(X:uint, Y:uint)
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(greenSquareImageImage, true, false, 16, 16);
			addAnimation("spinning", [0, 1, 2, 3, 4, 5, 6, 7], 10);
			
			play("spinning");
			
			green = true;
			
			velocity.x = -150;
		}
		
		override public function update():void 
		{	
			super.update();
		}
	}

}