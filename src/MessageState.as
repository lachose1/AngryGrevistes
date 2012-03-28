package
{
	import mx.core.FlexSprite;
	import org.flixel.*;
 
	public class MessageState extends FlxState
	{
		private var message:FlxText;
		private var vote:FlxText;
		private var creditsTimer:FlxTimer;
		
		override public function create():void
		{
			message = new FlxText(0, 0, FlxG.width, "Bravo! Vous avez reussi a surmonter les multiples obstacles et vaincu Robeauchamp. Par contre, la lutte reelle n'est pas encore terminee. La victoire est proche, les Liberaux sont sur le point de reculer. C'est pourquoi les votes de reconduction de greve sont extremement importants, nous touchons a la victoire. Nous n'avons qu'une chose a vous dire :");
			message.setFormat(null, 12, 0xFFFFFFFF, "center");
			add(message);
			
			vote = new FlxText(0, 200, FlxG.width, "Reconduisez la greve!");
			vote.setFormat(null, 20, 0xFFFFFFFFF, "center");
			add(vote);
						
			FlxG.bgColor = 0xFFFF0000;
			creditsTimer = new FlxTimer()
			creditsTimer.start(10);
			FlxG.camera.fade(0xff000000, 10);
		}
 
		public function MessageState()
		{
			super();
		}
		
		override public function update():void 
		{
			super.update();
			if (creditsTimer.finished)
				FlxG.switchState(new CreditsState());
		}
	}
}