package  
{
	import org.flixel.*;
	
	public class Arielle extends FlxSprite
	{
		public const TILE_SIZE:uint = 8;
		public const FRICTION:Number = 0.95;
		public const THRUST:int = 400;
		public const MAX_THRUST:int = 400;
		
		[Embed(source = '../res/arielle.png')] private var metroidImage:Class;
		[Embed(source = '../res/arielle.mp3')] private var moiSound:Class;
		private var player:Player;
		
		public function Arielle(X:uint, Y:uint, playerRef:Player) 
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(metroidImage, true, false, 17, 17);
			addAnimation("normal", [0, 1], 5);
			
			play("normal");
			
			player = playerRef;

			maxAngular = 300;
		}
		
		override public function update():void 
		{
			if(!player.dead)
				seek(player);
		}
		
		public function seek(target:Player):void
		{
			var dx:Number = (player.x + (player.width>>1)) - (x + (width>>1));
			var dy:Number = (player.y + (player.height>>1)) - (y + (height>>1));
			var targetAngle:Number = (Math.atan2(dy, dx) * 57.295) - angle;
			var delta:Number = maxAngular * FlxG.elapsed;
			
			if (targetAngle < -180)
				targetAngle += 360;
			if (targetAngle > 180)
				targetAngle -= 360;
			if (targetAngle > delta)
				targetAngle = delta;
			else if (targetAngle < -delta)
				targetAngle = -delta;
	
			angle += targetAngle;
			
			var angleRad:Number = angle * 0.01745;
			var cosa:Number = Math.cos(angleRad);
			var sina:Number = Math.sin(angleRad);
			
			velocity.x += (cosa * THRUST) * FlxG.elapsed;
			velocity.y += (sina * THRUST) * FlxG.elapsed;
			
			if (velocity.x > MAX_THRUST)
				velocity.x = MAX_THRUST;
			else if (velocity.x < -MAX_THRUST)
				velocity.x = -MAX_THRUST;
			if (velocity.y > MAX_THRUST)
				velocity.y = MAX_THRUST;
			else if (velocity.y < -MAX_THRUST)
				velocity.y = -MAX_THRUST;
				
			velocity.x *= FRICTION;
			velocity.y *= FRICTION;
		}
	}

}