package  
{
	
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../res/ninja.png')] private var ninjaImage:Class;
		[Embed(source = '../res/jump.mp3')] private var jumpSound:Class;
		[Embed(source = '../res/death.mp3')] private var deathSound:Class;
		
		private var gnd:Boolean;
		private var jumped:Boolean;
		private var doubleJumped:Boolean;
		public var scoreVal:uint;
		public var scoreDisplay:FlxText;
		
		public function Player(xPosition:int) 
		{
			gnd = false;
			scoreVal = 0;
			
			scoreDisplay = new FlxText(2, 2, 120);
			scoreDisplay.scrollFactor.x = scoreDisplay.scrollFactor.y = 0;
			scoreDisplay.shadow = 0xff000000;
			scoreDisplay.text = "ECONOMIES: " + scoreVal + "$";
			
			super(xPosition, FlxG.height - 40);
			loadGraphic(ninjaImage, true, false, 25, 32);
			maxVelocity.x = 200;
			maxVelocity.y = 400;
			acceleration.y = 300;
			
			acceleration.x = maxVelocity.x * 4;
			
			addAnimation("normal", [0, 1, 2], 10);
			addAnimation("jump", [3]);
			addAnimation("stopped", [0]);
			addAnimation("dead", [4, 4, 4], 5);
			
			play("normal");
			
			width = 12;
			height = 32;
		}
		
		public function isGND():Boolean
		{
			return gnd;
		}
		
		public function loopback():void
		{
			x = 32;
		}
		
		override public function update():void 
		{
			scoreDisplay.text = "ECONOMIES: " + scoreVal + "$";
			
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
			FlxG.play(deathSound);
			loopback();
		}
	}

}