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
		[Embed(source = '../res/carre-vert.png')] private var greenSquareImage:Class;
		
		private var title:FlxText;
		private var instructions:FlxText;
		
		override public function create():void
		{
			title = new FlxText(0, 0, FlxG.width, "Instructions:");
			title.setFormat(null, 12, 0xFFFFFFFF, "center");
			add(title);
			
			instructions = new FlxText(0, 20, FlxG.width, "Vous incarnez un gréviste. Vous pouvez sauter avec X ou C. Appuyez une seconde fois dans les airs pour effectuer un double saut:");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			instructions = new FlxText(0, 96, FlxG.width, "Evitez les obstacles et ennemis:");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			instructions = new FlxText(0, 136, FlxG.width, "Amassez 1625$:");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			instructions = new FlxText(0, 160, FlxG.width, "Retournez ce projectile contre l'ennemi:");
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
			
			if (FlxG.keys.justPressed("X") || FlxG.keys.justPressed("C"))
				FlxG.switchState(new PlayState());
		}
	}
}