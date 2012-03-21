package  
{	
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source = '../res/rock.png')] private var rockImage:Class;
		public var player:Player;
		public var level:Level;
		public var route:FlxTileblock;

		public const PLAYER_X:int = 32;

		override public function create():void 
		{
			FlxU.bound(0, 0, 0);
			
			level = new Level();
			//add(level);
			add(level.coins);
			
			route = new FlxTileblock(0, 232, 5120, 8);
			route.loadTiles(rockImage, 0, 0);
			add(route);
			
			player = new Player(PLAYER_X);
			add(player);
			add(player.scoreDisplay);

			//FlxG.camera.bounds = new FlxRect(0, 0, 2560, 240);
			FlxG.camera.follow(player);
			FlxG.camera.deadzone = new FlxRect(0, 0, PLAYER_X, 240);
		}

		override public function update():void 
		{			
			if (FlxG.camera.scroll.x > 1280)
			{
				player.loopback();
				FlxG.camera.setBounds( 0, 0, 640, 240, true );
			}
			
			super.update();

			FlxG.overlap(level.coins, player, getCoin);

			FlxG.collide(route, player);

			if (player.y > FlxG.height)
				FlxG.resetState();
				
			//Garder un collision-checking bound pas trop grand sinon ça va foirer la mémoire
			FlxG.camera.setBounds( FlxG.camera.scroll.x, FlxG.camera.scroll.y, FlxG.camera.scroll.x + 1280, 240, true );
		}

		public function getCoin(coin:Coin, player:Player):void
		{
			coin.kill();
			player.score += 5;
		}
	}

}