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
	public class Ceiling extends Sprite
	{
		public var topBackground1:Image;
		public var topBackground2:Image;
		
		public function Ceiling(gameAtlas:TextureAtlas) 
		{
			topBackground1 = new Image(gameAtlas.getTexture("ceiling"));
			topBackground1.alignPivot("left");
			topBackground1.x = 0;
			
			topBackground2 = new Image(gameAtlas.getTexture("ceiling"));
			topBackground2.alignPivot("left");
			topBackground2.x = Game.STAGE_WIDTH;
			
			this.addChild(topBackground1);
			this.addChild(topBackground2);
		}
		
		public function tween():void {
			TweenLite.to(topBackground1, 2, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				topBackground1.x = Game.STAGE_WIDTH;
				tweenFirst();
			} } );
			TweenLite.to(topBackground2, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				topBackground2.x = Game.STAGE_WIDTH;
				tweenSecond();
			} } );
		}
		
		private function tweenFirst():void {
			TweenLite.to(topBackground1, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				topBackground1.x = Game.STAGE_WIDTH;
				tweenFirst();
			} } );
		}
		
		private function tweenSecond():void {
			TweenLite.to(topBackground2, 4, { ease:Linear.easeNone, x: -Game.STAGE_WIDTH, onComplete:function():void{
				topBackground2.x = Game.STAGE_WIDTH;
				tweenSecond();
			} } );
		}
		
	}

}