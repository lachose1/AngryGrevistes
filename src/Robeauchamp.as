package  
{
	import org.flixel.*
	
	public class Robeauchamp extends FlxSprite
	{
		[Embed(source = '../res/robeauchamppixel.png')] private var robeauchampImage:Class;
		
		private var player:Player;
				
		static public const X_POS:int = 140;
		
		public function Robeauchamp(playerRef:Player) 
		{
			player = playerRef;
			super(player.x + X_POS, 50);
			loadGraphic(robeauchampImage, true, false, 240, 180);
			maxVelocity.x = 200;
			acceleration.x = 800;
			
			addAnimation("normal", [0, 1, 2], 3);
			addAnimation("shooting", [3, 4, 5], 3);
			addAnimation("dead", [6, 6, 6], 5);
			
			play("normal");
			x = player.x + X_POS;
		}
		
		public function loopback():void
		{
			x = X_POS + 9;
		}
	}
		
}
