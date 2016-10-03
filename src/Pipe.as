package 
{
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author michael
	 */
	public class Pipe extends Sprite
	{
		public static const TOP:String = "top";
		public static const BOTTOM:String = "bottom";
		
		public var pipeMouth:Image;
		public var pipeStick:Image;
		
		public var position:String;
		
		public function Pipe(gameAtlas:TextureAtlas,position:String) 
		{
			this.position = position
			pipeStick = new Image(gameAtlas.getTexture("pipe"));
			pipeStick.scale9Grid = new Rectangle(1, 1, 46, 1);
			pipeStick.height = 100;
			pipeStick.alignPivot();
			this.addChild(pipeStick);
			
			if (position == TOP) {
				pipeStick.alignPivot("center", "bottom");
				pipeStick.y = 100;
				pipeMouth = new Image(gameAtlas.getTexture("pipe-down"));
				pipeMouth.alignPivot("center", "top");
				pipeMouth.y = pipeStick.height;
			}else {
				pipeMouth = new Image(gameAtlas.getTexture("pipe-up"));
				pipeMouth.alignPivot("center", "top");
				pipeStick.alignPivot("center", "top");
				pipeStick.y = pipeMouth.height;
			}
			this.addChild(pipeMouth);
		}
		
	}

}