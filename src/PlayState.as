package  
{	
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source = '../res/rock.png')] private var rockImage:Class;
		[Embed(source = '../res/coin.mp3')] private var coinSound:Class;
		public var player:Player;
		public var route:FlxTileblock;
		public var coins:FlxGroup;
		public var cops:FlxGroup;
		public var mesrq:FlxGroup;
		public var grenades:FlxGroup;

		public const PLAYER_X:int = 32;
		public const MIN_X_COIN:int = 42;
		public const COINS_PATTERNS:int = 5;
		public const COIN_SPAWN_WIDTH:int = 20;
		public const MIN_X_POLICE:int = 42;
		public const MAX_Y_POLICE:int = 25;
		public const COP_SPAWN_WIDTH:int = 50;
		public const COP_PATTERNS:int = 2;
		public const MIN_X_ARIELLE:int = 55;
		public const MAX_X_ARIELLE:int = 155;

		override public function create():void 
		{
			FlxU.bound(0, 0, 0);
			FlxG.bgColor = 0xffaaaaaa;
			
			coins = new FlxGroup();
			add(coins);
			
			cops = new FlxGroup();
			add(cops);
			
			mesrq = new FlxGroup();
			add(mesrq);
			
			grenades = new FlxGroup();
			add(grenades);
			
			route = new FlxTileblock(0, 232, 1280 + 320, 8);
			route.loadTiles(rockImage, 0, 0);
			add(route);
			
			player = new Player(PLAYER_X);
			add(player);
			add(player.scoreDisplay);
			
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
				cops.clear();
				mesrq.clear();
				grenades.clear();
			}
			
			if (FlxG.camera.scroll.x == 0)
			{
				createWorld();
			}
			
			super.update();

			FlxG.overlap(coins, player, getCoin);
			
			FlxG.overlap(cops, player, handlePoliceCollision);

			FlxG.collide(route, player);
				
			//Garder un collision-checking bound pas trop grand sinon ça va foirer la mémoire
			FlxG.camera.setBounds( FlxG.camera.scroll.x, FlxG.camera.scroll.y, FlxG.camera.scroll.x + 640, 240, true );
		}

		public function getCoin(coin:Coin, player:Player):void
		{
			coin.kill();
			player.scoreVal += 5;
			FlxG.play(coinSound);
		}
		
		public function handlePoliceCollision(police:Police, player:Player):void
		{
				player.kill();
				FlxG.camera.setBounds( 0, 0, 320, 240, true );
				coins.clear();
				cops.clear();
				mesrq.clear();
				grenades.clear();
				createWorld();
		}
		
		public function createWorld():void
		{	
			for ( var i:uint = 0; i < COINS_PATTERNS; ++i)
				createCoins(Math.floor(Math.random() * 2), i);
			for (i = 0; i < COP_PATTERNS; ++i)
				createPolice(Math.floor(Math.random() * 2), i);
			if (Math.random() > 0.5)
				createArielle();
			createGrenades();
		}
		
		public function createCoins(patternType:uint, patternNumber:uint):void
		{	
			var random:Number = Math.floor(Math.random() * COIN_SPAWN_WIDTH + MIN_X_COIN + patternNumber * COIN_SPAWN_WIDTH);
			
			switch(patternType) 
			{
				case 0: //Ligne de 8 sous
					if (((random - MIN_X_COIN) % COIN_SPAWN_WIDTH) > (COIN_SPAWN_WIDTH - 8))
						random -= 8;
					for (var i:uint = 0; i < 8; ++i)
					{
						coins.add(new Coin(random + i, 20));
					}
					break;
				case 1: //X de 9 sous
					if (((random - MIN_X_COIN) % COIN_SPAWN_WIDTH) > (COIN_SPAWN_WIDTH - 5))
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
		
		public function createPolice(patternType:uint, patternNumber:uint):void
		{
			var random:Number = Math.floor(Math.random() * COP_SPAWN_WIDTH + MIN_X_POLICE + patternNumber * COP_SPAWN_WIDTH);
			
			switch(patternType) 
			{
				case 0: //1 verticalement
					cops.add(new Police(random, MAX_Y_POLICE));
					break;
				case 1: //2 verticalement
					cops.add(new Police(random, MAX_Y_POLICE));
					cops.add(new Police(random, MAX_Y_POLICE - 4));
					break;
				default:
					break;
			}
		}
		
		public function createArielle():void
		{
			var random:Number = Math.floor(Math.random() * (MAX_X_ARIELLE - MIN_X_ARIELLE) + MIN_X_ARIELLE);
				mesrq.add(new Arielle(random, 20, player));
		}
		
		public function createGrenades():void
		{
			var random:Number = Math.floor(Math.random() * (MAX_X_ARIELLE - MIN_X_ARIELLE) + MIN_X_ARIELLE);
				grenades.add(new Grenade(100, 20, player));
		}
	}

}