package game.view 
{
	import game.ui.AboutUI;
	import morn.core.components.Label;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class About extends AboutUI 
	{
		
		public function About() 
		{
			App.loader.loadTXT("about.txt", new Handler(loadComplete));
		}
		
		private function loadComplete(str:String):void 
		{
			var lab:Label = getChildByName("tfContent") as Label;
			lab.text = str;
		}
		
		
		
	}

}