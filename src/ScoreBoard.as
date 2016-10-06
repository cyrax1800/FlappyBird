package 
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author michael
	 */
	public class ScoreBoard extends Sprite
	{
		private var textureAtlas:TextureAtlas;
		private var background:Image;
		private var medal:Image;
		private var scoreText:TextField;
		private var highScoreText:TextField;
		private var replay:Button;
		
		public function ScoreBoard(gameAtlas:TextureAtlas) 
		{
			this.textureAtlas = gameAtlas;
			
			background = new Image(gameAtlas.getTexture("scoreboard"));
			this.addChild(background);
			
			medal = new Image(gameAtlas.getTexture("medal_bronze"));
			medal.alignPivot();
			medal.x = 55;
			medal.y = 125;
			this.addChild(medal);
			
			scoreText = new TextField(50, 30, "100", new TextFormat("flappyfont", 20, 0xffffff, "right"));
			scoreText.x = 160;
			scoreText.y = 90;
			this.addChild(scoreText);
			
			highScoreText = new TextField(50, 30, "200", new TextFormat("flappyfont", 20, 0xffffff, "right"));
			highScoreText.x = 160;
			highScoreText.y = 130;
			this.addChild(highScoreText);
			
			replay = new Button(gameAtlas.getTexture("replay"));
			replay.alignPivot();
			replay.x = background.width / 2;
			replay.y = background.height + replay.height;
			replay.addEventListener(Event.TRIGGERED, onBtnTrigger);
			this.addChild(replay);
			
			this.visible = false;
		}
		
		private function onBtnTrigger(e:Event):void 
		{
			Game.getInstance().startAgain();
		}
		
		public function show(value:int):void {
			scoreText.text = String(value);
			if (PlayerData.highScore < value) {
				PlayerData.highScore = value;
				PlayerData.saveVariable("highScore");
			}
			highScoreText.text = String(PlayerData.highScore);
			if (value < 5) {
				medal.texture = textureAtlas.getTexture("medal_bronze");
			}else if (value > 5 && value < 10) {
				medal.texture = textureAtlas.getTexture("medal_platinum");
			}else {
				medal.texture = textureAtlas.getTexture("medal_gold");
			}
			medal.readjustSize();
			this.visible = true;
		}
		
	}

}