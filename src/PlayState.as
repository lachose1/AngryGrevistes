package  
{	
	import mx.core.FlexSprite;
	import org.flixel.*;

	public class PlayState extends FlxState
	{
		[Embed(source = '../res/rocaille.png')] private var rockImage:Class;
		[Embed(source = '../res/coin.mp3')] private var coinSound:Class;
		[Embed(source = '../res/grenade.mp3')] private var grenadeSound:Class;
		[Embed(source = '../res/backgroundnature.png')] private var backgroundImage:Class;
		[Embed(source = '../res/securitypipetwo.mp3')] private var gameMusic:Class;
		[Embed(source = '../res/laugh.mp3')] private var laughSound:Class;
		public var player:Player;
		public var route:FlxTileblock;
		public var coins:FlxGroup;
		public var cops:FlxGroup;
		public var mesrq:FlxGroup;
		public var grenades:FlxGroup;
		public var background:FlxSprite;
		public var backgroundLoop:FlxSprite;
		public var bossMode:Boolean;
		public var boss:Robeauchamp;

		public const MIN_X_COIN:int = 42;
		public const MAX_Y_COIN:int = 25;
		public const COINS_PATTERNS:int = 5;
		public const COIN_SPAWN_WIDTH:int = 20;
		public const COIN_SPAWN_HEIGHT:int = 15;
		public const MIN_X_POLICE:int = 42;
		public const MAX_Y_POLICE:int = 25;
		public const COP_SPAWN_WIDTH:int = 50;
		public const COP_PATTERNS:int = 2;
		public const MIN_X_ARIELLE:int = 55;
		public const MAX_X_ARIELLE:int = 155;
		public const ARIELLE_SPAWN_HEIGHT:int = 15;
		public const MAX_Y_ARIELLE:int = 25;
		public const GRENADES_SPAWN_HEIGHT:int = 15;
		public const MAX_Y_GRENADES:int = 25;
		public const MIN_X_GRENADES:int = 75;
		public const MAX_X_GRENADES:int = 155;

		override public function create():void 
		{
			background = new FlxSprite(0, 10, backgroundImage);
			add(background);
			
			backgroundLoop = new FlxSprite(1280, 10, backgroundImage);
			add(backgroundLoop);
			
			FlxU.bound(0, 0, 0);
			FlxG.bgColor = 0xffc1e8ef;
			
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
			
			player = new Player(this);
			add(player);
			add(player.scoreDisplay);
						
			FlxG.camera.follow(player);
			FlxG.camera.deadzone = new FlxRect(0, 0, Player.X_POS, 240);
			FlxG.playMusic(gameMusic, 0.8);
			
			bossMode = false;
		}

		override public function update():void 
		{	
			if (!bossMode)
			{
				if (FlxG.camera.scroll.x > 1280 + 20)
				{
					player.loopback();
					FlxG.camera.setBounds( 0, 0, 320, 240, true );
					clearAll();
				}
				
				if (FlxG.camera.scroll.x == 0)
				{
					createWorld();
				}
				
				super.update();
				
				if (!player.dead)
				{
					FlxG.overlap(coins, player, getCoin);
					FlxG.overlap(cops, player, handlePoliceCollision);
					FlxG.overlap(grenades, player, handleGrenadeCollision);
					FlxG.overlap(mesrq, player, handleArielleCollision);
				}

				FlxG.collide(route, player);
				FlxG.collide(route, mesrq);
					
				//Garder un collision-checking bound pas trop grand sinon ça va foirer la mémoire
				FlxG.camera.setBounds( FlxG.camera.scroll.x, FlxG.camera.scroll.y, FlxG.camera.scroll.x + 640, 240, true );
				if (player.scoreVal >= 1620)
				{
					player.scoreVal = 1620;
					startBossMode();
				}
			}
			else
			{
				//Definir le boss mode icite calice
				if (FlxG.camera.scroll.x > 1280 + 20)
				{
					player.loopback();
					boss.loopback();
					FlxG.camera.setBounds( 0, 0, 320, 240, true );
				}
				
				super.update();
				
				if (!player.dead)
				{
					//Pendant qui est pas mort
				}

				FlxG.collide(route, player);
					
				//Garder un collision-checking bound pas trop grand sinon ça va foirer la mémoire
				FlxG.camera.setBounds( FlxG.camera.scroll.x, FlxG.camera.scroll.y, FlxG.camera.scroll.x + 640, 240, true );				
			}
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
		}
		
		public function handleArielleCollision(arielle:Arielle, player:Player):void
		{
			arielle.moiSoundPlayer.stop();
			player.kill();
		}
		
		public function handleGrenadeCollision(grenade:Grenade, player:Player):void
		{
			FlxG.play(grenadeSound);
			FlxG.camera.flash(0xffffffff, 1);
			player.kill();
			grenade.smokeEmitter.kill();
			grenade.kill();
		}
		
		public function createWorld():void
		{	
			for ( var i:uint = 0; i < COINS_PATTERNS; ++i)
				createCoins(Math.floor(Math.random() * 3), i);
			for (i = 0; i < COP_PATTERNS; ++i)
				createPolice(Math.floor(Math.random() * 2), i);
			if (Math.random() > 0.5)
				createArielle();
			if (Math.random() > 0.5)
				createGrenades();
		}
		
		public function createCoins(patternType:uint, patternNumber:uint):void
		{	
			var randomX:Number = Math.floor(Math.random() * COIN_SPAWN_WIDTH + MIN_X_COIN + patternNumber * COIN_SPAWN_WIDTH);
			var randomY:Number = Math.floor(-Math.random() * COIN_SPAWN_HEIGHT + MAX_Y_COIN);
			
			switch(patternType) 
			{
				case 0: //Ligne de 8 sous
					if (((randomX - MIN_X_COIN) % COIN_SPAWN_WIDTH) > (COIN_SPAWN_WIDTH - 8))
						randomX -= 8;
					for (var i:uint = 0; i < 8; ++i)
					{
						coins.add(new Coin(randomX + i, randomY));
					}
					break;
				case 1: //X de 9 sous
					if (((randomX - MIN_X_COIN) % COIN_SPAWN_WIDTH) > (COIN_SPAWN_WIDTH - 5))
						randomX -= 5;					
					coins.add(new Coin(randomX, randomY - 2));
					coins.add(new Coin(randomX, randomY + 2));
					coins.add(new Coin(randomX + 1, randomY - 1));
					coins.add(new Coin(randomX + 1, randomY + 1));
					coins.add(new Coin(randomX + 2, randomY));
					coins.add(new Coin(randomX + 3, randomY - 1));
					coins.add(new Coin(randomX + 3, randomY + 1));
					coins.add(new Coin(randomX + 4, randomY - 2));
					coins.add(new Coin(randomX + 4, randomY + 2));
					break;
				case 2: //"Cercle" de 8 sous
					if (((randomX - MIN_X_COIN) % COIN_SPAWN_WIDTH) > (COIN_SPAWN_WIDTH - 4))
						randomX -= 4;
					coins.add(new Coin(randomX, randomY - 1));
					coins.add(new Coin(randomX, randomY - 2));
					coins.add(new Coin(randomX + 1, randomY));
					coins.add(new Coin(randomX + 1, randomY - 3));
					coins.add(new Coin(randomX + 2, randomY));
					coins.add(new Coin(randomX + 2, randomY - 3));
					coins.add(new Coin(randomX + 3, randomY - 1));
					coins.add(new Coin(randomX + 3, randomY - 2));
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
			var randomX:Number = Math.floor(Math.random() * (MAX_X_ARIELLE - MIN_X_ARIELLE) + MIN_X_ARIELLE);
			var randomY:Number = Math.floor(-Math.random() * ARIELLE_SPAWN_HEIGHT + MAX_Y_ARIELLE);
			
			mesrq.add(new Arielle(randomX, randomY, player));
		}
		
		public function createGrenades():void
		{
			var randomX:Number = Math.floor(Math.random() * (MAX_X_GRENADES - MIN_X_GRENADES) + MIN_X_GRENADES);
			var randomY:Number = Math.floor(-Math.random() * GRENADES_SPAWN_HEIGHT + MAX_Y_GRENADES);
			
			grenades.add(new Grenade(randomX, randomY, player));
			add(grenades.members[0].crosshair);
			add(grenades.members[0].smokeEmitter);
		}
		
		public function clearAll():void
		{
			coins.clear();
			cops.clear();
			if (mesrq.countLiving() > 0)
				mesrq.members[0].kill();
			mesrq.clear();
			if (grenades.countLiving() > 0)
			{
				grenades.members[0].crosshair.kill();
				grenades.members[0].smokeEmitter.kill();
			}
			grenades.clear();
		}
		
		public function startBossMode():void
		{
			boss = new Robeauchamp(player);
			add(boss);
			FlxG.play(laughSound);
			FlxG.camera.flash(0xffffffff, 3);
			clearAll();
			bossMode = true;
		}
	}

}