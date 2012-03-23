package  
{
	import org.flixel.*;
	
	public class Arielle extends FlxSprite
	{
		[Embed(source = '../res/metroid.png')] private var metroidImage:Class;
		
		public var player:Player;
		
		public const TILE_SIZE:uint = 8;
		
		public function Arielle(X:uint, Y:uint, playerRef:Player) 
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(metroidImage, true, false, 17, 17);
			addAnimation("normal", [0, 1], 5);
			
			play("normal");
			
			player = playerRef;
		}
		
		override public function update():void 
		{
			seek(player);
		}
		
		public function seek(target:Player):void
		{
			var tempForce:Vector2D = new Vector2D(0, 0); // I HIGHLY recommend you add a scratch Vector2D object to your game object class because calling "new" is EXPENSIVE
		}
	}

}