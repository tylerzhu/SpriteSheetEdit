package game.view 
{
	import flash.events.MouseEvent;
	import game.ui.AlertUI;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class Alert extends AlertUI 
	{
		
		public function Alert(tip:String) 
		{
			tfContent.text = tip;
		}
	}

}