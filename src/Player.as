package  
{
	
	import org.flixel.*;
	
	public class Player extends FlxSprite
	{
		[Embed(source = '../res/gabriel.png')] private var ninjaImage:Class;
		[Embed(source = '../res/jump.mp3')] private var jumpSound:Class;
		[Embed(source = '../res/death.mp3')] private var deathSound:Class;
		
		static public const X_POS:int = 32;
		static public const X_ACCEL:int = 800;
		private var jumped:Boolean;
		private var doubleJumped:Boolean;
		private var jumpTimer:FlxTimer;
		public var scoreVal:uint;
		public var scoreDisplay:FlxText;
		private var deathTimer:FlxTimer;
		public var dead:Boolean;
		private var playState:PlayState;
		
		public function Player(stateObj:PlayState) 
		{
			playState = stateObj;
			
			scoreVal = 0;
			
			scoreDisplay = new FlxText(2, 2, 120);
			scoreDisplay.scrollFactor.x = scoreDisplay.scrollFactor.y = 0;
			scoreDisplay.shadow = 0xff000000;
			scoreDisplay.text = "ECONOMIES: " + scoreVal + "$";
			
			super(X_POS, FlxG.height - 40);
			loadGraphic(ninjaImage, true, false, 25, 32);
			maxVelocity.x = 200;
			maxVelocity.y = 400;
			acceleration.y = 400;
			
			velocity.x = maxVelocity.x;
			
			addAnimation("normal", [0, 1, 2], 10);
			addAnimation("jump", [3]);
			addAnimation("stopped", [0]);
			addAnimation("dead", [4, 4, 4], 5);
			
			play("normal");
			
			width = 12;
			height = 32;
			
			deathTimer = new FlxTimer();
			jumpTimer = new FlxTimer();
		}
		
		public function loopback():void
		{
			x = X_POS;
		}
		
		override public function update():void 
		{
			scoreDisplay.text = "ECONOMIES: " + scoreVal + "$";
			if (dead)
			{
				if (deathTimer.finished)
				{
					dead = false;
					loopback();
					velocity.x = maxVelocity.x;
					
					FlxG.camera.setBounds( 0, 0, 320, 240, true );
					playState.clearAll();
					if(!playState.bossMode)
						playState.createWorld();
					else
						playState.boss.loopback();
				}
			}
			else
			{
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
					jumpTimer.start(0.2);
				}
				else if ((FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C")) && jumped && !doubleJumped)
				{
					velocity.y = -maxVelocity.y / 2;
					FlxG.play(jumpSound);
					doubleJumped = true;
					jumpTimer.start(0.2);
				}
				
				if ((FlxG.keys.pressed("X") || FlxG.keys.pressed("C")) && !jumpTimer.finished)
					velocity.y = -maxVelocity.y / 2;
					
				if ((FlxG.keys.pressed("Q")))//CHEAT MODE POUR TOUT SUITE ARRIVER AU BOSS
					scoreVal = 1620;
			}
			
			super.update();
		}
		
		override public function kill():void
		{
			if (!dead)
			{
				dead = true;
				FlxG.play(deathSound);
				play("dead");
				acceleration.x = 0;
				velocity.x = velocity.y = 0;
				deathTimer.start(1);
				if (playState.bossMode)
				{
					FlxG.play(playState.laughSound);
				}
			}
		}
	}

}