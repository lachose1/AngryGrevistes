package  
{
	import org.flixel.*;
	
	public class Square extends FlxSprite
	{
		[Embed(source = '../res/carre-rouge.png')] private var redSquareImage:Class;
		[Embed(source = '../res/carre-vert.png')] private var greenSquareImage:Class;
		[Embed(source = '../res/nut.png')] private var nutsImage:Class;
		[Embed(source = '../res/screw.png')] private var screwImage:Class;
		
		public const TILE_SIZE:uint = 8;
		
		public var green:Boolean;
		public var nutsEmitter:FlxEmitter;
		
		public const NUTS_PARTICLES:int = 11;
		
		public function Square(X:uint, Y:uint)
		{
			super(X * TILE_SIZE, Y * TILE_SIZE);
			loadGraphic(greenSquareImage, true, false, 17, 17);
			addAnimation("spinning", [0, 1, 2, 3, 4, 5, 6, 7], 20);
			play("spinning");
			
			green = true;
			
			velocity.x = -100;
			
			velocity.y = Math.random() * 125 + 50;
			
			nutsEmitter = new FlxEmitter(X * TILE_SIZE, Y * TILE_SIZE, NUTS_PARTICLES);
			nutsEmitter.setXSpeed(160, 240);
			nutsEmitter.setYSpeed(200, 300);
			for (var i:uint = 0; i < NUTS_PARTICLES; i++)
			{
				var nutsParticles:FlxParticle = new FlxParticle();
				if(i & 0x01 == 1)
					nutsParticles.loadGraphic(nutsImage, false , false, 16, 16);
				else
					nutsParticles.loadGraphic(screwImage, false, false, 16, 16);
				nutsEmitter.add(nutsParticles);
			}			
		}
		
		override public function update():void 
		{	
			super.update();
			nutsEmitter.x = x;
			nutsEmitter.y = y;
		}
		
		public function changeColor():void
		{
				green = !green;
				if (green)
				{
					loadGraphic(greenSquareImage, true, false, 17, 17);
					velocity.x = -100;
					velocity.y = -velocity.y;
				}
				else
				{
					loadGraphic(redSquareImage, true, false, 17, 17);
					velocity.x = 400;
					velocity.y = -velocity.y + 50;
				}
		}
		
		public function startNuts():void
		{
			nutsEmitter.start(true, 1, 0.1, 0);
		}
	}

}