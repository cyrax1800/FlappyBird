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
	public class Ceiling extends Sprite
	{
		public var topBackground1:Image;
		public var topBackground2:Image;
		
		public function Ceiling(gameAtlas:TextureAtlas) 
		{
			var texture:Texture = gameAtlas.getTexture("ceiling")
			topBackground1 = new Image(texture);
			topBackground1.width = Game.STAGE_WIDTH;
			topBackground1.tileGrid = new Rectangle(0, 0, texture.width, texture.height);
			
			this.addChild(topBackground1);
		}
		
		public function move(passedTime:Number):void {
			var distance:Number = 130 * passedTime;;
			topBackground1.tileGrid.x -= distance; 
			topBackground1.tileGrid = topBackground1.tileGrid; 	
		}
		
	}

}