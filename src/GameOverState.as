package
{
	import flash.ui.Mouse;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import org.flixel.*;
 
	public class GameOverState extends FlxState
	{
		[Embed(source = '../res/fblogo.png')] private var fbImage:Class;
		private var score:uint;
		private var fbUrl:URLRequest;
		private var fbButton:FlxButton;
		
		override public function create():void
		{	
			FlxG.bgColor = 0xFFFF0000;
			var url:String = encodeURIComponent("http://www.bigtreestudios.org/games/angrygrevisteshard.html");
			var title:String = encodeURIComponent("J'ai amassé " + score + "$ à Angry Grévistes pour contrer la hausse! Es-tu capable de faire mieux?");
			var image:String = encodeURIComponent("http://bigtreestudios.org/images/logo-promotionnel.png");
			fbUrl = new URLRequest("https://www.facebook.com/sharer/sharer.php?s=100&p[title]=" + title + "&p[url]=" + url + "&p[images][0]=" + image);
			
			fbButton = new FlxButton(10, 200, "fb", fbShare);
			fbButton.loadGraphic(fbImage);
			add(fbButton);
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
		
		public function fbShare():void
		{
			navigateToURL(fbUrl, "_blank");
		}
	}
}