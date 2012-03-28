package  
{
	import org.flixel.*;
	[SWF(width = "640", height = "480", backgroundColor = "#000000")];
	[Frame(factoryClass = "Preloader")];
	
	public class AngryGrevistes extends FlxGame
	{
		
		public function AngryGrevistes() 
		{
			super(320, 240, MessageState, 2);
		}
		
	}

}