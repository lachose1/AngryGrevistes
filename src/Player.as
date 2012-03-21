package  
{
	
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../res/ninja.png')] private var ninjaImage:Class;
		
		private var gnd:Boolean;
		public var score:uint;
		public var scoreDisplay:FlxText;
		
		public function Player(xPosition:int) 
		{
			gnd = false;
			score = 0;
			
			scoreDisplay = new FlxText(2, 2, 80);
			scoreDisplay.scrollFactor.x = scoreDisplay.scrollFactor.y = 0;
			scoreDisplay.shadow = 0xff000000;
			scoreDisplay.text = "SCORE: " + score;
			
			super(xPosition, FlxG.height - 24);
			loadGraphic(ninjaImage, true, false, 16, 16);
			maxVelocity.x = 150;
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
		
		public function loopback():void
		{
			this.x = 32;
		}
		
		override public function update():void 
		{
			scoreDisplay.text = "SCORE: " + score;
			
			if (velocity.y != 0)
				play("jump");
			else
				play("normal");
			
			if ((FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C")) && isTouching(FlxObject.FLOOR))
				velocity.y = -maxVelocity.y / 2;
			
			super.update();
		}
	}

}