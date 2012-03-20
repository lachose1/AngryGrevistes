package  
{
	
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../res/ninja.png')] private var ninjaImage:Class;
		private var gnd:Boolean;
		
		public function Player() 
		{
			gnd = false;
			
			super(FlxG.width / 2 - 5);
			loadGraphic(ninjaImage, true, false, 16, 16);
			maxVelocity.x = 80;
			maxVelocity.y = 200;
			acceleration.y = 200;
			drag.x = maxVelocity.x * 4;
			
			addAnimation("normal", [0, 1, 2, 3], 10);
			addAnimation("jump", [2]);
			addAnimation("attack", [4,5,6],10);
			addAnimation("stopped", [0]);
			addAnimation("hurt", [2,7],10);
			addAnimation("dead", [7, 7, 7], 5);
			
			play("normal");
		}
		
		public function isGND():Boolean
		{
			return gnd;
		}
	}

}