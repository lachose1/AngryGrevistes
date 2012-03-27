package  
{
	import org.flixel.*
	
	public class Grenade extends FlxSprite
	{
		[Embed(source = '../res/grenade.png')] private var grenadeImage:Class;
		[Embed(source = '../res/smoke.png')] private var smokeImage:Class;
		
		private var player:Player;
		public var crosshair:Crosshair;
		public var smokeEmitter:FlxEmitter;
		private var smokeOn:Boolean;
		
		public const TILE_SIZE:uint = 8;
		public const WIDTH:uint = 16;
		public const HEIGHT:uint = 16;
		public const SMOKE_PARTICLES:uint = 20;
		
		public function Grenade(X:uint, Y:uint, playerRef:Player) 
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(grenadeImage, true, false, WIDTH, HEIGHT);
			
			player = playerRef;
			crosshair = new Crosshair(X, Y, playerRef);
			smokeEmitter = new FlxEmitter(X * TILE_SIZE, Y * TILE_SIZE, SMOKE_PARTICLES);
			smokeEmitter.setXSpeed(50, 100);
			smokeEmitter.setYSpeed(-10, 10);
			for (var i:uint = 0; i < SMOKE_PARTICLES; i++)
			{
				var smokeParticles:FlxParticle = new FlxParticle();
				smokeParticles.loadGraphic(smokeImage, false , false, 16, 16);
				smokeEmitter.add(smokeParticles);
			}
			smokeOn = false;
		}
		
		public function Launch():void
		{
			smokeEmitter.x = x + 20;
			if (!smokeOn)
				startSmoke();
			velocity.x = -150;
		}
		
		override public function update():void 
		{
			if (player.x > x - 350)
			{
				Launch();
				crosshair.kill();
			}
			angle -= 10
		}
		
		public function startSmoke():void
		{
			smokeEmitter.start(false, 1.5, 0.05, 0);
			smokeOn = true;
		}
	}
		
}
