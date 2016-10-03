package 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
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
		
		public var assetManager:AssetManager;
		public var gameAtlas:TextureAtlas;
		
		public var quadClick:Quad;
		public var bird:MovieClip;
		public var land:Land;
		public var sky:Sky;
		public var ceiling:Ceiling;
		public var topPipe:Pipe;
		public var btmPipe:Pipe;
		public var scoreBoardBackground:Image;
		public var getReadyImage:Image;
		
		public var gravity:Number = 0.5;
		public var velocity:Number = 0;
		public var jump_force:Number = 10;
		public var birdRotation:Number = 0;
		
		public var pause:Boolean;
		
		public function Game() 
		{
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
			birdRotation = 0;
			
			land = new Land(gameAtlas);
			land.alignPivot("left", "bottom");
			land.x = 0;
			land.y = STAGE_HEIGHT;
			
			sky = new Sky(gameAtlas);
			sky.alignPivot("left", "bottom");
			sky.x = 0;
			sky.y = STAGE_HEIGHT - land.height;
			
			ceiling = new Ceiling(gameAtlas);
			ceiling.alignPivot("left", "top");
			ceiling.x = 0;
			ceiling.y = 0;
			
			this.addChild(sky);
			this.addChild(ceiling);
			this.addChild(land);
			
			topPipe = new Pipe(gameAtlas, Pipe.TOP);
			topPipe.x = 160;
			topPipe.y = ceiling.height;
			this.addChild(topPipe);
			
			btmPipe = new Pipe(gameAtlas, Pipe.BOTTOM);
			btmPipe.alignPivot("center", "bottom");
			btmPipe.x = 160;
			btmPipe.y = sky.y;
			this.addChild(btmPipe);
			
			bird = new MovieClip(gameAtlas.getTextures("bird_"), 12);
			bird.alignPivot();
			bird.x = 30;
			bird.y = 200;
			this.addChild(bird);
			Starling.juggler.add(bird);
			bird.play();
			
			land.tween();
			sky.tween();
			ceiling.tween();
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		}
		
		private function onKeyPress(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.UP) {
				if (pause) return;
				velocity = -jump_force;
				birdRotation = -50;
				bird.rotation = deg2rad(birdRotation);
			}
		}
		
		private function onEnterFrame(e:Event):void 
		{
			if (pause) return;
			if ((bird.y - bird.height / 2) <= 0) {
				bird.y = bird.height / 2 + 0;
				velocity = 0;
			}
			if ((bird.y + bird.height / 2) >= (STAGE_HEIGHT - land.height)) {
				pause = true;
				bird.stop();
			}

			bird.y += velocity;
			velocity += gravity;
			if (bird.rotation != deg2rad(90)) {
				birdRotation += 2;
				bird.rotation = deg2rad(birdRotation);
			}
		}
	}
}