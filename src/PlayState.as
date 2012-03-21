package  
{	
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source = '../res/rock.png')] private var rockImage:Class;
		public var player:Player;
		public var route:FlxTileblock;
		public var coins:FlxGroup;

		public const PLAYER_X:int = 32;

		override public function create():void 
		{
			FlxU.bound(0, 0, 0);
			FlxG.bgColor = 0xffaaaaaa;
			
			coins = new FlxGroup();
			createCoins();
			add(coins);
			
			//level = new Level();
			//add(level);
			//add(level.coins);
			
			route = new FlxTileblock(0, 232, 1280+640, 8);
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
			if (FlxG.camera.scroll.x > 1280-32)
			{
				player.loopback();
				FlxG.camera.setBounds( 0, 0, 640, 240, true );
			}
			
			super.update();

			FlxG.overlap(coins, player, getCoin);

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
		
		public function createCoins():void
		{	
			coins.add(new Coin(13+64,16));
			coins.add(new Coin(14+64,16));
			coins.add(new Coin(11+64,23));
			coins.add(new Coin(12+64,23));
			coins.add(new Coin(13+64,23));
			coins.add(new Coin(14+64,23));
			coins.add(new Coin(15+64,23));
			coins.add(new Coin(22+64,26));
			coins.add(new Coin(23+64,26));
			coins.add(new Coin(27+64,20));
			coins.add(new Coin(28+64,20));
		}
	}

}