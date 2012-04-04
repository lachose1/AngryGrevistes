package
{
	import org.flixel.*;
 
	public class InstructionsState extends FlxState
	{
		[Embed(source = '../res/arielle.png')] private var metroidImage:Class;
		[Embed(source = '../res/coin.png')] private var coinImage:Class;
		[Embed(source = '../res/grenade.png')] private var grenadeImage:Class;
		[Embed(source = '../res/gabriel.png')] private var ninjaImage:Class;
		[Embed(source = '../res/police.png')] private var policeImage:Class;
		
		private var title:FlxText;
		private var instructions:FlxText;
		private var gabriel:FlxSprite;
		private var arielle:FlxSprite;
		private var police:FlxSprite;
		private var grenade:FlxSprite;
		private var coin:FlxSprite;
		
		override public function create():void
		{
			gabriel = new FlxSprite(148, 60);
			gabriel.loadGraphic(ninjaImage, true, false, 25, 32, false);
			gabriel.addAnimation("normal", [0, 1, 2], 10);
			gabriel.play("normal");
			add(gabriel);
			
			arielle = new FlxSprite(90, 120);
			arielle.loadGraphic(metroidImage, true, false, 17, 17, false);
			arielle.addAnimation("normal", [0, 1], 5);
			arielle.play("normal");
			arielle.angle = 180;
			add(arielle);
			
			police = new FlxSprite(145, 110);
			police.loadGraphic(policeImage, true, false, 35, 32, false);
			police.addAnimation("hitting", [0, 1], 5);
			police.play("hitting");
			add(police);
			
			grenade = new FlxSprite(210, 120);
			grenade.loadGraphic(grenadeImage, true, false, 16, 16, false);
			add(grenade);
			
			coin = new FlxSprite(155, 163);
			coin.loadGraphic(coinImage, true, false, 8, 8, false);
			coin.addAnimation("spinning", [0, 1, 2, 3, 4, 5, 6, 7], 10);
			coin.play("spinning");
			add(coin);
			
			title = new FlxText(0, 0, FlxG.width, "Instructions:");
			title.setFormat(null, 12, 0xFFFFFFFF, "center");
			add(title);
			
			instructions = new FlxText(0, 20, FlxG.width, "Vous incarnez GND. Vous pouvez sauter avec X ou C. Appuyez une seconde fois dans les airs pour effectuer un double saut:");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			instructions = new FlxText(0, 96, FlxG.width, "Evitez les obstacles et ennemis:");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			instructions = new FlxText(0, 146, FlxG.width, "Récuperez les pièces pour augmenter vos économies:");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			instructions = new FlxText(0, 174, FlxG.width, "Vous devez simplement ammasser le plus d'argent avant de perdre vos trois vies, car l'argent est le seul langage que le gouvernement Charest comprend.");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			instructions = new FlxText(0, FlxG.height - 16, FlxG.width, "Appuyez sur X ou C pour jouer");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			FlxG.bgColor = 0xFFFF0000;
		}
 
		public function InstructionsState()
		{
			super();
		}
		
		override public function update():void 
		{
			super.update();
			grenade.angle -= 10;
			if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C"))
				FlxG.switchState(new PlayState());
		}
	}
}