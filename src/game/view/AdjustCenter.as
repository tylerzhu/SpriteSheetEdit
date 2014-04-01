package game.view
{
	import com.as3game.spritesheet.SpriteFrame;
	import com.as3game.spritesheet.SpriteSheet;
	import com.as3game.spritesheet.SpriteSheetButton;
	import com.as3game.spritesheet.vos.DataFormat;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FileListEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.utils.Dictionary;
	import morn.core.components.Box;
	import morn.core.components.CheckBox;
	import morn.core.components.Component;
	import morn.core.components.Label;
	import morn.core.components.List;
	import morn.core.components.ProgressBar;
	import morn.core.handlers.Handler;
	
	/**
	 * ...
	 * @author Tylerzhu
	 */
	public class AdjustCenter extends Sprite
	{
		private var mainview:MainView;
		private var progressBar:ProgressBar;
		private var selectFiles:Array = [];
		private var loadedFiles:Array = [];
		private var previewContainer:Sprite;
		
		public function AdjustCenter(mv:MainView)
		{
			mainview = mv;
			mainview.btnChooseFileCompress.clickHandler = new Handler(onChooseFiles);
			mainview.btnSavePosition.clickHandler = new Handler(onSavePosition);
			
			mainview.clsList.array = [];
			mainview.clsList.renderHandler = new Handler(clsListHander);
			mainview.clsList.mouseHandler = new Handler(previewByClsName);
			
			mainview.fileList.renderHandler = new Handler(fileListHandler);
			mainview.fileList.mouseHandler = new Handler(onCheckListMouse)
			mainview.fileList.array = [];
			
			previewContainer = new Sprite();
			previewContainer.x = mainview.container.x;
			previewContainer.y = mainview.container.y;
			(mainview.viewStack.items[mainview.viewStack.selectedIndex] as DisplayObjectContainer).addChild(previewContainer);
		}
		
		private function onCheckListMouse(e:MouseEvent, index:int):void
		{
		
		}
		
		private function fileListHandler(item:Component, index:int):void
		{
			if (index < mainview.fileList.length)
			{
				var chkBox:CheckBox = item.getChildAt(0) as CheckBox;
				var data:Object = mainview.fileList.array[index];
				chkBox.selected = true;
				//chkBox.label = data.name + "(png & xml)";
				chkBox.label = data.name;
			}
		}
		
		//包存中心点位置调整
		private function onSavePosition():void
		{
			if (previewContainer.numChildren == 0)
			{
				new Alert("请选择需要调整的元件").show();
				return;
			}
			var xml:XML = mainview.clsList.selectedItem.xml;
			var file:File = new File();
			file.save(xml, mainview.clsList.selectedItem.fileName + ".xml");
		}
		
		//选择需要压缩的文件（PNG与XML一一对应）
		private function onChooseFiles():void
		{
			var filters:Array = [];
			filters.push(new FileFilter("png和xml", "*.png;*.xml"));
			
			var fils:File = new File();
			fils.addEventListener(FileListEvent.SELECT_MULTIPLE, onSelectedSaveFile);
			fils.browseForOpenMultiple("请选择目录", filters);
		}
		
		//保存选择的文件列表
		private function onSelectedSaveFile(e:FileListEvent):void
		{
			//对文件进行分析，组合png、xml文件
			var dic:Dictionary = new Dictionary(true);
			for each (var item:File in e.files)
			{
				if (item.isDirectory)
				{
					continue;
				}
				var name:String = item.name.split("." + item.extension)[0];
				if (dic[name] == null || dic[name] == undefined)
				{
					dic[name] = {name: name, png: "", xml: ""};
				}
				
				if (item.extension == "png")
				{
					dic[name].png = item;
				}
				else if (item.extension == "xml")
				{
					dic[name].xml = item;
				}
			}
			
			//过滤掉非法的数据，不完整的png、xml
			var files:Array = [];
			for each (var obj:Object in dic)
			{
				if (obj.xml == "" || obj.png == "")
				{ //过滤掉不完整的数据
					continue;
				}
				files.push(obj);
			}
			
			//加载文件
			selectFiles = files;
			loadedFiles = [];
			var len:int = files.length;
			for (var i:int = 0; i < len; i++)
			{
				var pngfile:File = files[i].png as File; //加载png
				pngfile.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				pngfile.addEventListener(Event.COMPLETE, onLoadFile);
				pngfile.load();
				
				var xmlfile:File = files[i].xml as File; //加载xml
				xmlfile.addEventListener(ProgressEvent.PROGRESS, onProgressHandler);
				xmlfile.addEventListener(Event.COMPLETE, onLoadFile);
				xmlfile.load();
			}
			
			mainview.fileList.array = files;
		}
		
		private function onProgressHandler(e:ProgressEvent):void
		{
			if (progressBar == null)
			{
				progressBar = new ProgressBar();
				mainview.addChild(progressBar);
			}
			progressBar.value = e.bytesLoaded / e.bytesTotal;
			progressBar.label = "当前进度" + int(e.bytesLoaded / e.bytesTotal * 100) + "%";
		
		}
		
		private function onLoadFile(e:Event):void
		{
			mainview.removeChild(progressBar);
			progressBar = null;
			loadedFiles.push(e.currentTarget);
			if (loadedFiles.length == 2 * selectFiles.length)
			{ //所有文件都加载完成
				//初始化预览列表
				var clsList:List = mainview.clsList;
				mainview.clsList.array = [];
				for (var i:int = 0; i < selectFiles.length; i++)
				{
					var files:Object = selectFiles[i];
					var obj:Object = {name: files.name};
					obj.type = 1;
					obj.png = (files.png as File).data;
					obj.xml = (files.xml as File).data;
					parsePNG(obj);
				}
			}
		
		}
		
		private function parsePNG(obj:Object):void
		{
			var clsList:List = mainview.clsList;
			var _loader:Loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void
				{
					var png:Bitmap = (_loader.content as Bitmap);
					var xml:XML = new XML(obj.xml);
					
					var button:SpriteSheetButton = new SpriteSheetButton(png.bitmapData, xml);
					var len:int = button.sheets.frames.length;
					for (var i:int = 0; i < len; i++)
					{
						var sp:SpriteFrame = button.sheets.frames[i];
						var cls:String = sp.id.substr(0, sp.id.length - 4);
						var isExisted:Boolean = false;
						for each (var item:Object in clsList.array)
						{
							if (item.clsName == cls)
							{
								isExisted = true;
								break;
							}
						}
						
						if (!isExisted)
						{
							clsList.array.push({"clsName": cls, "bitmapData": png.bitmapData, "xml": xml, "fileName": obj.name});
							clsList.refresh();
						}
					}
				});
			_loader.loadBytes(obj.png);
		}
		
		private function clsListHander(cell:Box, index:int):void
		{
			if (index < mainview.clsList.length)
			{
				var label:Label = cell.getChildByName("labClsName") as Label;
				label.text = cell.dataSource.clsName;
			}
		}
		
		private function previewByClsName(e:MouseEvent, index:int):void
		{
			if (e.type == MouseEvent.CLICK)
			{
				var data:Object = mainview.clsList.array[index];
				if (mainview.rgFileType.selectedIndex == 0)
				{
					previewMovieclip(data.bitmapData, data.xml, data.clsName);
				}
				else
				{
					previewButton(data.bitmapData, data.xml, data.clsName);
				}
			}
		}
		
		private function previewMovieclip(bitmapData:BitmapData, xmlData:XML, actionName:String):void
		{
			var sp:SpriteSheet = new SpriteSheet(bitmapData, xmlData, DataFormat.FORMAT_XML);
			sp.setAction(actionName);
			sp.play();
			while (previewContainer.numChildren > 0)
			{
				previewContainer.removeChildAt(0);
			}
			previewContainer.addChild(sp);
			
			sp.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
		}
		
		private function previewButton(bitmapData:BitmapData, xmlData:XML, buttonName:String):void
		{
			var spButton:SpriteSheetButton = new SpriteSheetButton(bitmapData, xmlData, DataFormat.FORMAT_XML, buttonName);
			while (previewContainer.numChildren > 0)
			{
				previewContainer.removeChildAt(0);
			}
			previewContainer.addChild(spButton);
			spButton.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
		}
		
		private function onStartDrag(e:MouseEvent):void
		{
			var sp:Sprite = (e.currentTarget as Sprite);
			sp.removeEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
			sp.addEventListener(MouseEvent.MOUSE_UP, onStropDrag);
			sp.startDrag();
		}
		
		private function onStropDrag(e:MouseEvent):void
		{
			var sp:Object = (e.currentTarget as Object);
			sp.removeEventListener(MouseEvent.MOUSE_UP, onStropDrag);
			sp.stopDrag();
			//记录调整之后的位置
			var xml:XML = mainview.clsList.selectedItem.xml;
			for (var i:int = 0; i < xml.SubTexture.length(); i++)
			{
				var name:String = xml.SubTexture[i].@name;
				if (name.substr(0, name.length - 4) == mainview.clsList.selectedItem.clsName)
				{
					xml.SubTexture[i].@centerX = sp.x + sp.centor.x;
					xml.SubTexture[i].@centerY = sp.y + sp.centor.y;
				}
			}
			sp.addEventListener(MouseEvent.MOUSE_DOWN, onStartDrag);
		}
		
		private function onClickTest(e:MouseEvent):void
		{
			new Alert("点击测试: " + e.currentTarget.name).show();
		}
	}

}