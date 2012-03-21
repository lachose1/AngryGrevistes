package  
{
	import org.flixel.*;
	[SWF(width = "640", height = "480", backgroundColor = "#000000")];
	[Frame(factoryClass = "Preloader")];
	
	public class AngryGrevistes extends FlxGame
	{
		
		public function AngryGrevistes() 
		{
			super(640, 240, PlayState, 2);
		}
		
	}

}