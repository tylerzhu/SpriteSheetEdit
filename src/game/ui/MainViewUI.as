/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class MainViewUI extends View {
		public var viewStack:ViewStack;
		public var fileList:List;
		public var btnChooseFileCompress:Button;
		public var container:Image;
		public var rgFileType:RadioGroup;
		public var clsList:List;
		public var btnSavePosition:Button;
		public var tab:Tab;
		public var btnAbout:Button;
		protected var uiXML:XML =
			<View>
			  <ViewStack x="19" y="47" var="viewStack" selectedIndex="false">
			    <Container name="item0">
			      <Image url="png.comp.bg2" y="155" sizeGrid="3,3,3,3" width="359" height="304" x="371"/>
			      <Image url="png.comp.bg2" y="30" sizeGrid="3,3,3,3" width="730" height="81" x="1"/>
			      <Container x="401" y="157">
			        <Image url="png.comp.blank" y="150" width="300" height="1"/>
			        <Image url="png.comp.blank" x="149" width="1" height="300"/>
			      </Container>
			      <List x="5" y="38" repeatX="6" repeatY="3" spaceX="1" spaceY="5" var="fileList">
			        <Box name="render" y="0">
			          <CheckBox label="label" skin="png.comp.checkbox" width="120"/>
			        </Box>
			        <VScrollBar skin="png.comp.vscroll" x="698" y="0" name="scrollBar" width="17" height="58"/>
			      </List>
			      <Label text="请选择需要调整的PNG和XML：" font="Microsoft YaHei" size="14"/>
			      <Button label="选择" skin="png.comp.button" x="216" var="btnChooseFileCompress" labelFont="Microsoft YaHei" labelSize="14"/>
			      <Image url="png.comp.blank" y="302" width="10" height="10" var="container" x="545"/>
			      <Image url="png.comp.bg2" y="155" sizeGrid="3,3,3,3" width="350" height="304" x="1"/>
			      <RadioGroup x="183" y="131" var="rgFileType" selectedIndex="0">
			        <RadioButton label="动画" skin="png.comp.radio" name="item0" labelFont="Microsoft YaHei" labelSize="14" selected="true"/>
			        <RadioButton label="按钮" skin="png.comp.radio" x="62" name="item1" labelFont="Microsoft YaHei" labelSize="14" y="0"/>
			      </RadioGroup>
			      <List x="21" y="167" repeatX="2" repeatY="11" spaceX="10" spaceY="5" var="clsList">
			        <Box name="render">
			          <Clip url="png.comp.clip_selectBox" width="137" height="21" clipY="2" name="selectBox" x="0" y="0"/>
			          <Label text="label" x="1" y="1" width="135" height="18" name="labClsName"/>
			        </Box>
			        <VScrollBar skin="png.comp.vscroll" x="303" y="1" width="17" height="279" name="scrollBar"/>
			      </List>
			      <Label text="预览Movieclip或Button：" font="Microsoft YaHei" size="14" x="2" y="129"/>
			      <Label text="拖拽元件到中心可以调整中心点位置：" font="Microsoft YaHei" size="14" x="374" y="129"/>
			      <Button label="保存位置调整" skin="png.comp.button" x="623" y="129" var="btnSavePosition" width="90" height="23"/>
			    </Container>
			  </ViewStack>
			  <Tab labels="编辑" skin="png.comp.tab" x="19" y="13" var="tab"/>
			  <ViewStack x="13" y="72"/>
			  <Button label="关于" skin="png.comp.btn_tab" x="89" y="13" var="btnAbout"/>
			</View>;
		public function MainViewUI(){}
		override protected function createChildren():void {
			createView(uiXML);
		}
	}
}