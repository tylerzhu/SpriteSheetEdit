package 
{
	import flash.display.Sprite;
	import game.view.MainView;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			//初始化组件
			App.init(this);
			//加载资源			
			App.loader.loadAssets(["assets/comp.swf"], new Handler(loadComplete), new Handler(loadProgress));
		}
		
		private function loadProgress(value:Number):void {
			//加载进度
			//trace("loaded", value);
		}
		
		private function loadComplete():void {
			//实例化场景
			addChild(new MainView());
		}
	}
	
}