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
		public const MIN_X_COIN:int = 30;
		public const MAX_X_COIN:int = 130;
		public const COINS_PATTERNS:int = 5;
		public const SPAWN_WIDTH:int = 20;

		override public function create():void 
		{
			FlxU.bound(0, 0, 0);
			FlxG.bgColor = 0xffaaaaaa;
			
			coins = new FlxGroup();
			//createCoins();
			add(coins);
			
			//level = new Level();
			//add(level);
			//add(level.coins);
			
			route = new FlxTileblock(0, 232, 1280 + 320, 8);
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
				FlxG.camera.setBounds( 0, 0, 320, 240, true );
				coins.clear();
			}
			
			if (FlxG.camera.scroll.x == 0)
			{
				createWorld();
			}
			
			super.update();

			FlxG.overlap(coins, player, getCoin);

			FlxG.collide(route, player);

			if (player.y > FlxG.height)
				FlxG.resetState();
				
			//Garder un collision-checking bound pas trop grand sinon ça va foirer la mémoire
			FlxG.camera.setBounds( FlxG.camera.scroll.x, FlxG.camera.scroll.y, FlxG.camera.scroll.x + 640, 240, true );
		}

		public function getCoin(coin:Coin, player:Player):void
		{
			coin.kill();
			player.score += 5;
		}
		
		public function createWorld():void
		{	
			for ( var i:uint = 0; i < COINS_PATTERNS; ++i)
				createCoins(Math.floor(Math.random()*2), i);
		}
		
		public function createCoins(displayType:int, patternNumber:int):void
		{	
			var random:Number = Math.floor(Math.random() * SPAWN_WIDTH + MIN_X_COIN + patternNumber * SPAWN_WIDTH);
			
			switch(displayType) 
			{
				case 0: //Ligne de 8 sous
					if (((random - MIN_X_COIN) % SPAWN_WIDTH) > (SPAWN_WIDTH - 8))
						random -= 8;
					for (var i:uint = 0; i < 8; ++i)
					{
						coins.add(new Coin(random + i, 20));
					}
					break;
				case 1: //X de 9 sous
					if (((random - MIN_X_COIN) % SPAWN_WIDTH) > (SPAWN_WIDTH - 5))
						random -= 5;					
					coins.add(new Coin(random, 18));
					coins.add(new Coin(random, 22));
					coins.add(new Coin(random + 1, 19));
					coins.add(new Coin(random + 1, 21));
					coins.add(new Coin(random + 2, 20));
					coins.add(new Coin(random + 3, 19));
					coins.add(new Coin(random + 3, 21));
					coins.add(new Coin(random + 4, 18));
					coins.add(new Coin(random + 4, 22));
					break;
				default:
					break;
			}
		}
	}

}