package 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author michael
	 */
	public class Sky extends Sprite
	{
		public var background1:Image;
		public var background2:Image;
		public var background3:Image;
		
		public function Sky(gameAtlas:TextureAtlas) 
		{
			background1 = new Image(gameAtlas.getTexture("sky"));
			background1.alignPivot("left");
			background1.x = 0;
			
			background2 = new Image(gameAtlas.getTexture("sky"));
			background2.alignPivot("left");
			background2.x = Game.STAGE_WIDTH;
			
			this.addChild(background1);
			this.addChild(background2);
		}
		
		public function tween():void {
			TweenLite.to(background1, 2, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				background1.x = Game.STAGE_WIDTH;
				tweenFirst();
			} } );
			TweenLite.to(background2, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				background2.x = Game.STAGE_WIDTH;
				tweenSecond();
			} } );
		}
		
		private function tweenFirst():void {
			TweenLite.to(background1, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				background1.x = Game.STAGE_WIDTH;
				tweenFirst();
			} } );
		}
		
		private function tweenSecond():void {
			TweenLite.to(background2, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				background2.x = Game.STAGE_WIDTH;
				tweenSecond();
			} } );
		}
		
	}

}