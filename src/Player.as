package  
{
	
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../res/ninja.png')] private var ninjaImage:Class;
		[Embed(source = '../res/jump.mp3')] private var jumpSound:Class;
		
		private var gnd:Boolean;
		private var jumped:Boolean;
		private var doubleJumped:Boolean;
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
			
			super(xPosition, FlxG.height - 40);
			loadGraphic(ninjaImage, true, false, 25, 32);
			maxVelocity.x = 150;
			maxVelocity.y = 400;
			acceleration.y = 300;
			
			acceleration.x = maxVelocity.x * 4;
			
			addAnimation("normal", [0, 1, 2], 10);
			addAnimation("jump", [3]);
			addAnimation("stopped", [0]);
			addAnimation("dead", [4, 4, 4], 5);
			
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
			{
				play("normal");
				jumped = false;
				doubleJumped = false;
			}
			
			if ((FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C")) && isTouching(FlxObject.FLOOR))
			{
				velocity.y = -maxVelocity.y / 2;
				FlxG.play(jumpSound);
				jumped = true;
			}
			else if ((FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C")) && jumped && !doubleJumped)
			{
				velocity.y = -maxVelocity.y / 2;
				FlxG.play(jumpSound);
				doubleJumped = true;
			}
			
			super.update();
		}
		
		override public function kill():void
		{
			//FlxG.play(deathSound);
			reset(32, FlxG.height - 24);
		}
	}

}