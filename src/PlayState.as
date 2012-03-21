package  
{	
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		public var player:Player;
		public var level:Level;
		
		public const PLAYER_X:int = 32;
		
		override public function create():void 
		{
			level = new Level();
			add(level);
			add(level.coins);
			
			player = new Player(PLAYER_X);
			add(player);
						
			FlxG.camera.bounds = new FlxRect(0, 0, 640, 240);
			FlxG.camera.follow(player);
			FlxG.camera.deadzone = new FlxRect(0, 0, PLAYER_X, 240);
		}
		
		override public function update():void 
		{		
			super.update();
			
			FlxG.collide(level, player);
			
			if (player.y > FlxG.height)
				FlxG.resetState();
		}
	}

}