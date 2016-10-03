package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	import starling.utils.SystemUtil;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author michael
	 */
	[SWF(width="320", height="480", frameRate="60", backgroundColor="#000000")]
	public class Main extends Sprite 
	{
		private var mStarling:Starling;
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(flash.events.Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// Entry point
			// New to AIR? Please read *carefully* the readme.txt files!
			
			var iOS:Boolean = SystemUtil.platform == "IOS";
			
			var viewPort:Rectangle = RectangleUtil.fit(
                new Rectangle(0, 0, 640, 960), 
                new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
                ScaleMode.SHOW_ALL);
			
			mStarling = new Starling(Game, stage, viewPort);
			mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():void {
				mStarling.start();
			});
			
		}
		
		private function deactivate(e:flash.events.Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}