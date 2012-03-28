package  
{
	import org.flixel.*
	
	public class Robeauchamp extends FlxSprite
	{
		[Embed(source = '../res/robeauchamppixel.png')] private var robeauchampImage:Class;
		[Embed(source = '../res/beauchamphitbox.png')] private var beauchampHitboxImage:Class;
		[Embed(source = '../res/createpolice.mp3')] private var createPoliceSound:Class;
		[Embed(source = '../res/shoot.mp3')] private var shootSound:Class;
		[Embed(source = '../res/dammage.mp3')] private var dammageSound:Class;
		[Embed(source = '../res/destroy.mp3')] private var destroySound:Class;
		
		[Embed(source = '../res/accessibiliteauxetudes.mp3')] private var replique1Sound:Class;
		[Embed(source = '../res/positionequilibree.mp3')] private var replique2Sound:Class;
		[Embed(source = '../res/gardiennedemocratie.mp3')] private var replique3Sound:Class;
		[Embed(source = '../res/lunettescassees.mp3')] private var replique4Sound:Class;
		[Embed(source = '../res/toutehonnetete.mp3')] private var replique5Sound:Class;
		[Embed(source = '../res/decisionprise.mp3')] private var replique6Sound:Class;
		
		private var player:Player;
		private var attackTimer:FlxTimer;
		private var animTimer:FlxTimer;
		private var damageTimer:FlxTimer;
		public var cops:FlxGroup;
		public var squares:FlxGroup;
		private var soundBank:Array;
		private var soundTimer:FlxTimer;
		public var hitCounter:int;
		public var bounceCounter:int;
		public var hitboxBeauchamp:FlxSprite;
		public var dead:Boolean;
		
		static public const X_POS:int = 140;
		public const MIN_X_POLICE:int = 42;
		public const MAX_X_POLICE:int = 142;
		public const MAX_Y_POLICE:int = 25;
		public const MIN_X_SQUARE:int = 42;
		public const MAX_X_SQUARE:int = 142;
		public const ATTACK_DELAY:int = 2;
		public const ANIM_DELAY:int = 1;
		public const SOUND_DELAY:int = 5;
		public const DAMAGE_DELAY:int = 0.2;
		
		public function Robeauchamp(playerRef:Player) 
		{
			dead = false;
			player = playerRef;
			super(player.x + X_POS, 50);
			loadGraphic(robeauchampImage, true, false, 240, 180);
			maxVelocity.x = 200;
			acceleration.x = 800;
			
			hitboxBeauchamp = new FlxSprite(x + 100, y);
			hitboxBeauchamp.loadGraphic(beauchampHitboxImage, false, false, 100, 180);
			
			addAnimation("normal", [0, 1, 2], 3);
			addAnimation("shooting", [3, 4, 5], 3);
			addAnimation("dead", [6, 6, 6], 5);
			addAnimation("damage", [7, 7, 7], 3);
			
			play("normal");
			x = player.x + X_POS;
			
			soundBank = new Array(replique1Sound, replique2Sound, replique3Sound, replique4Sound, replique5Sound, replique6Sound);
			soundTimer = new FlxTimer();
			soundTimer.start(SOUND_DELAY);
			
			cops = new FlxGroup();
			squares = new FlxGroup();
			
			attackTimer = new FlxTimer();
			attackTimer.start(ATTACK_DELAY);
			
			animTimer = new FlxTimer();
			
			damageTimer = new FlxTimer();
			
			hitCounter = 0;
			bounceCounter = 0;
		}
		
		public function loopback():void
		{
			x = X_POS + 9;
			cops.clear();
			squares.clear();
		}
		
		override public function update():void 
		{
			if (!dead)
			{
				if (attackTimer.finished)
				{
					attack();
					attackTimer.start(ATTACK_DELAY);
				}
				
				if (animTimer.finished && !dead)
					play("normal");
									
				if (soundTimer.finished)
				{
					sayReplique();
					soundTimer.start(SOUND_DELAY);
				}
					
				super.update();
				hitboxBeauchamp.x = x + 100;
			}
			else
				play("dead");
		}
		
		private function attack():void
		{
			var attackType:int = Math.floor(Math.random() * 2);
			
			switch(attackType)
			{
				case 0: //Creer polices
					createPolice();
					break;
				case 1: //Lancer carres
					launchSquares();
					break;
				default:
					break;
			}
		}
		
		private function createPolice():void
		{
			var patternType:int = Math.floor(Math.random() * 2);
			var posX:int = Math.floor((x + width / 2) / 8);
			
			if (posX >= MIN_X_POLICE && posX <= MAX_X_POLICE)
			{
				FlxG.play(createPoliceSound);
				switch(patternType)
				{
					case 0: //1 verticalement
						cops.add(new Police(posX, MAX_Y_POLICE));
						break;
					case 1: //2 verticalement
						cops.add(new Police(posX, MAX_Y_POLICE));
						cops.add(new Police(posX, MAX_Y_POLICE - 4));
						break;
					default:
						break;
				}
			}
		}
		
		private function launchSquares():void
		{	
			var posX:int = Math.floor((x + width / 2) / 8);
			
			if (posX >= MIN_X_SQUARE && posX <= MAX_X_SQUARE)
			{
				bounceCounter = 0;
				squares.add(new Square(posX, 9));
				FlxG.play(shootSound);
				play("shooting");
				animTimer.start(ANIM_DELAY);
			}
		}
		
		public function sayReplique():void
		{
			if (Math.random() > 0.5)
			{
				FlxG.play(soundBank[Math.floor(Math.random() * 6)]);
			}
		}
		
		public function takeDamage():void
		{
			FlxG.play(dammageSound);
			play("damage");
			damageTimer.start(DAMAGE_DELAY);
		}
		
		public function winBoss():void
		{
			dead = true;
			FlxG.camera.flash(0xffffffff, 5);
			FlxG.play(destroySound);
			play("dead");
			maxVelocity.x = 0;
			acceleration.x = 0;
		}
	}
		
}
