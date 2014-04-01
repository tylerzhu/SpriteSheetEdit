/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class AboutUI extends Dialog {
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="3,26,3,5" width="480" height="315"/>
			  <Button skin="png.comp.btn_close" x="450" y="3" name="close"/>
			  <Button label="确定" skin="png.comp.button" x="196" y="272" name="close" labelFont="Microsoft YaHei" labelSize="14"/>
			  <TextArea text="TextArea" skin="png.comp.textarea" x="27" y="58" width="425" height="191" name="tfContent"/>
			</Dialog>;
		public function AboutUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}