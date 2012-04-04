package
{
	import flash.ui.Mouse;
	import mx.core.FlexSprite;
	import org.flixel.*;
 
	public class GameOverState extends FlxState
	{
		private var score:uint;
		
		override public function create():void
		{	
			FlxG.bgColor = 0xFFFF0000;
		}
 
		public function GameOverState(playerScore:uint)
		{
			score = playerScore;
			
			super();
		}
		
		override public function update():void 
		{
			Mouse.show();
			
			super.update();
		}
	}
}