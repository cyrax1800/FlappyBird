package 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Linear;
	import flash.text.Font;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import starling.utils.deg2rad;
	/**
	 * ...
	 * @author michael
	 */
	public class Game extends Sprite
	{
		public static const STAGE_WIDTH:int = 320;
		public static const STAGE_HEIGHT:int = 480;
		public static const PIPE_SPACE:int = 100;
		public static const GAME_AREA:int = 352;
		
		public var assetManager:AssetManager;
		public var gameAtlas:TextureAtlas;
		
		private static var mInstance:Game;
		
		public var quadClick:Quad;
		public var background:Quad;
		public var bird:MovieClip;
		public var land:Land;
		public var sky:Sky;
		public var ceiling:Ceiling;
		public var topPipe:Pipe;
		public var btmPipe:Pipe;
		public var score:int;
		public var scoreText:TextField;
		public var scoreBoard:ScoreBoard;
		public var getReadyImage:Image;
		
		public var gravity:Number = 0.5;
		public var velocity:Number = 0;
		public var jump_force:Number = 6;
		public var birdRotation:Number = 0;
		
		public var pause:Boolean;
		public var gameOver:Boolean;
		public var passed:Boolean;
		
		[Embed(source = "../bin/flappyFont.TTF", embedAsCFF = "false", fontFamily = "flappyfont")]
        public static const font:Class;
		
		public function Game() 
		{
			Font.registerFont(font);
			PlayerData.initialData();
			assetManager = new AssetManager();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			assetManager.enqueue("game_atlas.png", "game_atlas.xml");
			assetManager.loadQueue(function(ratio:int):void {
				if (ratio == 1) {
					startGame();
				}
			});
		}
		
		private function startGame():void {
			gameAtlas = assetManager.getTextureAtlas("game_atlas");
			
			pause = true;
			gameOver = false;
			score = 0;
			birdRotation = 0;
			
			background = new Quad(Game.STAGE_WIDTH, Game.STAGE_HEIGHT, 0x4ec0ca);
			background.touchable = false;
			this.addChild(background);
			
			land = new Land(gameAtlas);
			land.alignPivot("left", "bottom");
			land.x = 0;
			land.y = STAGE_HEIGHT;
			land.touchable = false;
			
			sky = new Sky(gameAtlas);
			sky.alignPivot("left", "bottom");
			sky.x = 0;
			sky.y = STAGE_HEIGHT - land.height;
			sky.touchable = false;
			
			ceiling = new Ceiling(gameAtlas);
			ceiling.alignPivot("left", "top");
			ceiling.x = 0;
			ceiling.y = 0;
			ceiling.touchable = false;
			
			this.addChild(sky);
			this.addChild(ceiling);
			this.addChild(land);
			
			topPipe = new Pipe(gameAtlas, Pipe.TOP);
			topPipe.x = Game.STAGE_WIDTH + topPipe.width;
			topPipe.y = ceiling.height;
			topPipe.touchable = false;
			this.addChild(topPipe);
			
			btmPipe = new Pipe(gameAtlas, Pipe.BOTTOM);
			btmPipe.alignPivot("center", "bottom");
			btmPipe.x = Game.STAGE_WIDTH + btmPipe.width;
			btmPipe.y = sky.y;
			btmPipe.touchable = false;
			this.addChild(btmPipe);
			
			bird = new MovieClip(gameAtlas.getTextures("bird_"), 12);
			bird.alignPivot();
			bird.x = 30;
			bird.y = 200;
			bird.touchable = false;
			this.addChild(bird);
			Starling.juggler.add(bird);
			bird.play();
			
			scoreText = new TextField(Game.STAGE_WIDTH, 50, String(score), new TextFormat("flappyfont", 30, 0xffffff));
			scoreText.alignPivot();
			scoreText.x = Game.STAGE_WIDTH / 2;
			scoreText.y = 70;
			scoreText.touchable = false;
			this.addChild(scoreText);
			
			getReadyImage = new Image(assetManager.getTexture("splash"));
			getReadyImage.alignPivot();
			getReadyImage.x = Game.STAGE_WIDTH / 2;
			getReadyImage.y = Game.STAGE_HEIGHT / 2;
			getReadyImage.touchable = false;
			this.addChild(getReadyImage);
			
			quadClick = new Quad(Game.STAGE_WIDTH, Game.STAGE_HEIGHT);
			quadClick.alpha = 0;
			quadClick.addEventListener(TouchEvent.TOUCH, onQuadTouch);
			this.addChild(quadClick);
			
			scoreBoard = new ScoreBoard(gameAtlas);
			scoreBoard.alignPivot();
			scoreBoard.x = Game.STAGE_WIDTH / 2;
			scoreBoard.y = Game.STAGE_HEIGHT / 2 - 50;
			this.addChild(scoreBoard);
			
			sky.move();
			
			mInstance = this;
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
		
		public function startAgain():void {
			pause = true;
			gameOver = false;
			passed = false;
			score = 0;
			scoreText.text = String(score);
			bird.x = 30;
			bird.y = 200;
			birdRotation = 0;
			bird.rotation = deg2rad(birdRotation);
			velocity = 0;
			bird.play();
			sky.move();
			btmPipe.x = Game.STAGE_WIDTH + btmPipe.width;
			topPipe.x = Game.STAGE_WIDTH + topPipe.width;
			getReadyImage.alpha = 1;
			scoreBoard.visible = false;
		}
		
		public function tweenGameOverQuad():void {
			if (gameOver || pause) return;
			TweenLite.to(quadClick, .1, {ease:Linear.easeNone, alpha:.7, onComplete:function():void{
				TweenLite.to(quadClick, .3, {ease:Linear.easeNone, alpha:0 } );
			} } );
			scoreBoard.show(score);
		}
		
		private function onQuadTouch(e:TouchEvent):void 
		{
			if (gameOver) return;
			var touch:Touch = e.getTouch((e.currentTarget as Quad));
			if (e.getTouch(e.currentTarget as Quad, TouchPhase.BEGAN)) {
				if (pause) {
					newPipePosition();
					pause = false;
					TweenLite.to(getReadyImage, 0.5, { ease:Linear.easeNone, alpha:0 } );
					velocity = -jump_force;
				}
				velocity = -jump_force;
				birdRotation = -50;
				bird.rotation = deg2rad(birdRotation);
			}
		}
		
		public function newPipePosition():void {
			passed = false;
			var randomTopPipeHeight:Number = RandomRange(50, GAME_AREA - PIPE_SPACE - 50);
			topPipe.setPipe(randomTopPipeHeight);
			btmPipe.setPipe(GAME_AREA -randomTopPipeHeight - PIPE_SPACE);
			btmPipe.y = sky.y;
			topPipe.y = ceiling.height;
			btmPipe.alignPivot("center", "bottom");
			tweenPipe();
		}
		
		public static function RandomRange(Low : int, High : int):int {
			return Math.floor(Math.random()*(1 + High - Low )) + Low;
		}
		
		public function tweenPipe():void {
			TweenLite.killTweensOf(topPipe);
			TweenLite.killTweensOf(btmPipe);
			topPipe.x = Game.STAGE_WIDTH;
			btmPipe.x = Game.STAGE_WIDTH;
			TweenLite.to(btmPipe, 3, { ease:Linear.easeNone, x: -btmPipe.width / 2 } );
			TweenLite.to(topPipe, 3, { ease:Linear.easeNone, x: -topPipe.width / 2, onComplete:newPipePosition } );
		}
		
		public function checkCollision():Boolean {
			if (bird.bounds.intersects(topPipe.bounds) || bird.bounds.intersects(btmPipe.bounds)) {
				return true;
			}
			return false;
		}
		
		public function updateScore(amount:int):void {
			passed = true;
			score += amount;
			scoreText.text = String(score);
		}
		
		private function onKeyPress(e:KeyboardEvent):void 
		{
			if (gameOver) return;
			if (e.keyCode == Keyboard.UP) {
				if (pause) return;
				velocity = -jump_force;
				birdRotation = -50;
				bird.rotation = deg2rad(birdRotation);
			}
		}
		
		private function onEnterFrame(e:Event,passedTime:Number):void 
		{
			if (pause) return;
			if ((bird.y - bird.height / 2) <= 0) {
				bird.y = bird.height / 2 + 0;
				velocity = 0;
			}
			if ((bird.y + bird.height / 2) >= (STAGE_HEIGHT - land.height)) {
				tweenGameOverQuad();
				gameOver = true;
				pause = true;
				TweenLite.killTweensOf(topPipe);
				TweenLite.killTweensOf(btmPipe);
				sky.stop();
				bird.stop();
			}

			bird.y += velocity;
			velocity += gravity;
			if (bird.rotation != deg2rad(90)) {
				birdRotation += 2;
				bird.rotation = deg2rad(birdRotation);
			}
			
			if ((bird.x >= btmPipe.x) && !passed) updateScore(1);
			
			if (checkCollision()) {
				tweenGameOverQuad();
				TweenLite.killTweensOf(topPipe);
				TweenLite.killTweensOf(btmPipe);
				gameOver = true;
			}
			
			land.move(passedTime);
			ceiling.move(passedTime);
		}
		
		public static function getInstance():Game {
			return mInstance;
		}
	}
}