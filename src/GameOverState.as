package
{
	import flash.ui.Mouse;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import org.flixel.*;
 
	public class GameOverState extends FlxState
	{
		[Embed(source = '../res/fblogo.png')] private var fbImage:Class;
		[Embed(source = '../res/twitterlogo.png')] private var twitterImage:Class;
		private var score:uint;
		private var fbUrl:URLRequest;
		private var fbButton:FlxButton;
		private var tweetUrl:URLRequest;
		private var tweetButton:FlxButton;
		private var gameOver:FlxText;
		private var scoreText:FlxText;
		private var message:FlxText;
		private var share:FlxText;
		private var instructions:FlxText;
		
		override public function create():void
		{	
			FlxG.bgColor = 0xFFFF0000;
			
			scoreText = new FlxText(0, 16, FlxG.width, score + "$");
			scoreText.setFormat(null, 40, 0xFFFFFFFF, "center");
			add(scoreText);
			
			message = new FlxText(0, 100, FlxG.width, "C'est le montant que vous avez récolté pour tenter de convaincre le gouvernement Charest.");
			message.setFormat(null, 12, 0xFFFFFFFF, "center");
			add(message);
			
			share = new FlxText(0, 150, FlxG.width, "Partagez et voyez s'il va vous entendre!");
			share.setFormat(null, 12, 0xFFFFFFFF, "center");
			add(share);
			
			instructions = new FlxText(0, FlxG.height - 16, FlxG.width, "Appuyez sur X ou C pour rejouer");
			instructions.setFormat(null, 8, 0xFFFFFFFF, "center");
			add(instructions);
			
			var url:String = encodeURIComponent("http://www.bigtreestudios.org/games/angrygrevisteshard.html");
			var title:String = encodeURIComponent("J'ai amassé " + score + "$ à Angry Grévistes pour contrer la hausse! Es-tu capable de faire mieux?");
			var image:String = encodeURIComponent("http://bigtreestudios.org/images/logo-promotionnel.png");
			fbUrl = new URLRequest("https://www.facebook.com/sharer/sharer.php?s=100&p[title]=" + title + "&p[url]=" + url + "&p[images][0]=" + image);
			
			var twitterAcc:String = encodeURIComponent("BigTreeStudios");
			var hashtag:String = encodeURIComponent(" #AngryGrévistes");
			tweetUrl = new URLRequest("http://twitter.com/intent/tweet?text=" + title + hashtag + "&via=" + twitterAcc);
			
			fbButton = new FlxButton(90, 180, null, fbShare);
			fbButton.loadGraphic(fbImage);
			add(fbButton);
			
			tweetButton = new FlxButton(230 - 32, 180, null, tweetShare);
			tweetButton.loadGraphic(twitterImage);
			add(tweetButton);
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
		
		public function tweetShare():void
		{
			navigateToURL(tweetUrl, "_blank");
		}
	}
}