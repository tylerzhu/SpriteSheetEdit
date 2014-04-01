package game.view
{
	import game.ui.MainViewUI;
	import game.view.About;
	import game.view.AdjustCenter;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class MainView extends MainViewUI
	{
		private var tabCompress:AdjustCenter;
		
		public function MainView()
		{
			tab.selectHandler = viewStack.setIndexHandler;
			//调整中心点
			tabCompress = new AdjustCenter(this);
			//关于按钮
			btnAbout.clickHandler = new Handler(about);
		}
		
		private function about():void
		{
			var dlg:About = new About();
			dlg.show();
		}
	}

}