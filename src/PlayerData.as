package 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author michael
	 */
	public class PlayerData 
	{
		private static var sharedObject:SharedObject = SharedObject.getLocal("Save");
		public static var highScore:int;
		
		public function PlayerData() 
		{
			
		}
		
		public static function saveVariable(variableName:String):void {
			sharedObject.data[variableName] = highScore;
			sharedObject.flush();
		}
		
		public static function initialData():void {
			getSavedVariable("highScore");
		}
		
		public static function getSavedVariable(variableName:String):void {
			if (variableName == "highScore") {
				if (sharedObject.data[variableName] == null) {
					highScore = 0;
					sharedObject.data[variableName] = highScore;
				}else {
					highScore = sharedObject.data[variableName]
				}
			}
		}
		
	}

}