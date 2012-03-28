package
{
	import mx.core.FlexSprite;
	import org.flixel.*;
 
	public class CreditsState extends FlxState
	{
		[Embed(source = '../res/bts.png')] private var btsImage:Class;
		
		private var logo:FlxSprite;
		private var prog:FlxText;
		private var hugo:FlxText;
		private var antoine:FlxText;
		private var graph:FlxText;
		private var jeanNicolas:FlxText;
		private var musique:FlxText;
		private var sebastien:FlxText;
		private var copyright:FlxText;
		
		override public function create():void
		{
			logo = new FlxSprite();
			logo.loadGraphic(btsImage);
			logo.x = FlxG.width / 2 - logo.width / 2;
			add(logo);
			
			prog = new FlxText(0, logo.height + 8, FlxG.width, "Programmation et Design");
			prog.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(prog);
			
			hugo = new FlxText(0, logo.height + 24, FlxG.width, "Hugo Laliberté");
			hugo.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(hugo);
			
			antoine = new FlxText(0, logo.height + 32, FlxG.width, "Antoine Busque");
			antoine.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(antoine);
			
			graph = new FlxText(0, logo.height + 54, FlxG.width, "Graphismes");
			graph.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(graph);
			
			jeanNicolas = new FlxText(0, logo.height + 72, FlxG.width, "Jean-Nicolas Bourdon");
			jeanNicolas.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(jeanNicolas);
			
			musique = new FlxText(0, logo.height + 96, FlxG.width, "Musique");
			musique.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(musique);
			
			sebastien = new FlxText(0, logo.height + 112, FlxG.width, "Sébastien Monette-Roy");
			sebastien.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(sebastien);
			
			copyright = new FlxText(0, FlxG.height - 16, FlxG.width, "Copyright 2012 Big Tree Studios");
			copyright.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(copyright);
			
			FlxG.bgColor = 0xFF000000;
		}
 
		public function CreditsState()
		{
			super();
		}
	}
}