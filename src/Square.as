package  
{
	import org.flixel.*;
	
	public class Square extends FlxSprite
	{
		[Embed(source = '../res/carre-rouge.png')] private var redSquareImage:Class;
		[Embed(source = '../res/carre-vert.png')] private var greenSquareImage:Class;
		
		public const TILE_SIZE:uint = 8;
		
		public var green:Boolean;
		
		public function Square(X:uint, Y:uint)
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(greenSquareImage, true, false, 17, 17);
			addAnimation("spinning", [0, 1, 2, 3, 4, 5, 6, 7], 20);
			play("spinning");
			
			green = true;
			
			velocity.x = -100;
			
			velocity.y = Math.random() * 125 + 50;
		}
		
		override public function update():void 
		{	
			super.update();
		}
		
		public function changeColor():void
		{
				green = !green;
				if (green)
				{
					loadGraphic(greenSquareImage, true, false, 17, 17);
					velocity.x = -100;
					velocity.y = -velocity.y;
				}
				else
				{
					loadGraphic(redSquareImage, true, false, 17, 17);
					velocity.x = 400;
					velocity.y = -velocity.y + 50;
				}
		}
	}

}