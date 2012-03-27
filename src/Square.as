package  
{
	import org.flixel.*;
	
	public class Square extends FlxSprite
	{
		[Embed(source = '../res/carre-rouge.png')] private var redSquareImage:Class;
		[Embed(source = '../res/carre-vert.png')] private var greenSquareImage:Class;
		
		public const TILE_SIZE:uint = 8;
		
		public var green:Boolean;
		private var changedColor:Boolean;
		
		public function Square(X:uint, Y:uint)
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(greenSquareImage, true, false, 17, 17);
			addAnimation("spinning", [0, 1, 2, 3, 4, 5, 6, 7], 20);
			play("spinning");
			
			green = true;
			changedColor = false;
			
			velocity.x = -100;
		}
		
		override public function update():void 
		{	
			super.update();
		}
		
		public function changeColor():void
		{
			if (!changedColor)
			{
				green = !green;
			
				if (green)
				{
					loadGraphic(greenSquareImage, true, false, 17, 17);
					velocity.x = -100;
				}
				else
				{
					loadGraphic(redSquareImage, true, false, 17, 17);
					velocity.x = 300;
				}
				
				changedColor = true;
			}
		}
	}

}