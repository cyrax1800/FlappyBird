package 
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Linear;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author michael
	 */
	public class Land extends Sprite
	{
		public var bottomBackground1:Image;
		
		public function Land(gameAtlas:TextureAtlas) 
		{
			var texture:Texture = gameAtlas.getTexture("land")
			bottomBackground1 = new Image(texture);
			bottomBackground1.width = Game.STAGE_WIDTH;
			bottomBackground1.tileGrid = new Rectangle(0, 0, texture.width, texture.height);
			
			this.addChild(bottomBackground1);
		}
		
		public function move(passedTime:Number):void {
			var distance:Number = 130 * passedTime;;
			bottomBackground1.tileGrid.x -= distance; 
			bottomBackground1.tileGrid = bottomBackground1.tileGrid; 	
		}
	}
}