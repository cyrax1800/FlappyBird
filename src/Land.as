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
	public class Land extends Sprite
	{
		
		public var bottomBackground1:Image;
		public var bottomBackground2:Image;
		
		public function Land(gameAtlas:TextureAtlas) 
		{
			bottomBackground1 = new Image(gameAtlas.getTexture("land"));
			bottomBackground1.alignPivot("left");
			bottomBackground1.x = 0;
			
			bottomBackground2 = new Image(gameAtlas.getTexture("land"));
			bottomBackground2.alignPivot("left");
			bottomBackground2.x = Game.STAGE_WIDTH;
			
			this.addChild(bottomBackground1);
			this.addChild(bottomBackground2);
		}
		
		public function tween():void {
			TweenLite.to(bottomBackground1, 2, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				bottomBackground1.x = Game.STAGE_WIDTH;
				tweenLand1();
			} } );
			TweenLite.to(bottomBackground2, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				bottomBackground2.x = Game.STAGE_WIDTH;
				tweenLand2();
			} } );
		}
		
		private function tweenLand1():void {
			TweenLite.to(bottomBackground1, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				bottomBackground1.x = Game.STAGE_WIDTH;
				tweenLand1();
			} } );
		}
		
		private function tweenLand2():void {
			TweenLite.to(bottomBackground2, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				bottomBackground2.x = Game.STAGE_WIDTH;
				tweenLand2();
			} } );
		}
	}
}