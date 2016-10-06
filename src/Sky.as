package 
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author michael
	 */
	public class Sky extends Sprite
	{
		private var texture:Texture;
		public var background1:Image;
		public var background2:Image;
		public var tileGrid:Rectangle;
		
		public function Sky(gameAtlas:TextureAtlas) 
		{
			texture = gameAtlas.getTexture("sky")
			background1 = new Image(texture);
			background1.width = Game.STAGE_WIDTH;
			tileGrid = new Rectangle(0, 0,  Game.STAGE_WIDTH, texture.height);
			background1.tileGrid = tileGrid;
			
			this.addChild(background1);
		}
		
		public function move():void {
			background1.tileGrid.x = 0;
			background1.tileGrid = background1.tileGrid;
			TweenMax.to(background1.tileGrid, 5, {ease:Linear.easeNone, repeat:-1 ,x: -Game.STAGE_WIDTH, onUpdate:function():void{
				background1.tileGrid = background1.tileGrid;
			} } );
		}
		
		public function stop():void {
			TweenMax.killTweensOf(background1.tileGrid);
		}
		
	}
}