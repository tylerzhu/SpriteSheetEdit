/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class AlertUI extends Dialog {
		public var tfContent:TextArea;
		protected var uiXML:XML =
			<Dialog>
			  <Image url="png.comp.bg" x="0" y="0" sizeGrid="3,26,3,5" width="300" height="200"/>
			  <TextArea text="TextArea" skin="png.comp.textarea" x="14" y="38" width="274" height="144" var="tfContent" editable="false" autoSize="left" align="left" multiline="true" wordWrap="true" mouseEnabled="false" mouseChildren="false"/>
			  <Button skin="png.comp.btn_close" x="267" y="3" name="close"/>
			</Dialog>;
		public function AlertUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}