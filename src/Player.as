package  
{
	
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../res/ninja.png')] private var ninjaImage:Class;
		private var gnd:Boolean;
		
		public function Player(PLAYER_X:int) 
		{
			gnd = false;
						
			super(PLAYER_X, FlxG.height - 64);
			loadGraphic(ninjaImage, true, false, 16, 16);
			maxVelocity.x = 80;
			maxVelocity.y = 400;
			acceleration.y = 300;
			drag.x = maxVelocity.x * 4;
			
			acceleration.x = maxVelocity.x * 4;
			
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
		
		override public function update():void 
		{	
			if (velocity.y != 0)
				play("jump");
			else
				play("normal");
			
			if (FlxG.keys.justPressed("SPACE") && isTouching(FlxObject.FLOOR))
				velocity.y = -maxVelocity.y / 2;
			
			super.update();
		}
	}

}