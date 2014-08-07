package jsProject.mdel
{

	public class XmlContent
	{
	
		//controls/component.xml------------------------------------------------------------------------------------------------------
		[Bindable]public static var XML_COMPONENT:XML;
		//controls/resource.xml------------------------------------------------------------------------------------------------------
		[Bindable]public static var XML_RESOURCE:XML;
		//document/user.xml------------------------------------------------------------------------------------------------------
		[Bindable]public static var XML_USER:XML;
		
		//================================================================================================================
		//语言
		public static const Edit_Language:XML=
			<content fileID={NameDefine.FILE_ID_LANGUAGE} website="">
				<language icon="" exe=""/>
				<language icon="" exe=""/>
			</content>;
		//书组
		public static const Edit_BookSelf:XML=
			<content fileID={NameDefine.FILE_ID_BOOKSELF} groupId=""  website="" menuY="">
				<books/>
				<layoutContent>
					<auto vGap="10" hGap="10"/>
					<landscape vGap="10" line="4|3|0" hGap="10|10|10"/>
					<protrait vGap="10" line="3|2|2" hGap="10|10|10"/>
				</layoutContent>
			</content>;
		
		public static const Edit_BookSelf_Download:XML=
			<root fileID={NameDefine.FILE_ID_DOWNLOAD_BOOKSELF}>
				<books/>
			</root>;
		//书组.book
		public static const Edit_IntroBooks:XML=
			<book fileID={NameDefine.FILE_ID_BOOK} bookId="" website=""
				isbn="" folder="" file="">
				<icon src=""/>
				<icon src=""/>
			</book>;
		//书组.layout
		public static const Edit_IntroLayout:XML=
			<layoutContent>
				<auto vGap="10" hGap="10"/>
				<landscape vGap="10" line="4|3|0" hGap="10|10|10"/>
				<protrait vGap="10" line="3|2|2" hGap="10|10|10"/>
			</layoutContent>
		
		//================================================================================================================
				
		//页面------------------------------------------------------------------------------------------
		public static const Edit_Pages:XML =  
			<content pageMode="1" bindingX="10" bindingY="10" id={NameDefine.FILE_ID_BOOK} mode="">
				<!--mode:1-單頁開始2-雙頁開始-->
				<menu/>
				<pages/>
			</content>;
		//单页节点
		public static const Edit_Pages_Page:XML = 
			<{NameDefine.KEY_PAGENODE} src="" pageID="">
				<text/>
				<controls/>
				<functions/>
				{Edit_Search_root}
			</{NameDefine.KEY_PAGENODE}>;
		
		public static const Edit_Search_root:XML = <search color="16776960" alpha="0.1"/>
		public static const Edit_Search_Node:XML = 
			<{NameDefine.KEY_SEARCH} x="" y="" width="" height="">
				<text/>
			</{NameDefine.KEY_SEARCH}>;
		
		
		
		//================================================================================================================
			
		//页面组件---------------------------------------------------------------------------------------
		public static const Edit_Component:XML = 
			<components fileID={NameDefine.FILE_ID_COMPONENT}></components>;
				
		public static const Edit_Component_Item:XML = 
			<{NameDefine.KEY_COMPONENTS_KEY} 
				width="0" 
				height="0" 
				action="" 
				prompt="" 
				id="" 
				componentID="" 
				openfile=""
				folder="">
				<files/><files/><files/><files/>
			</{NameDefine.KEY_COMPONENTS_KEY}>

		
		//resource资源图标---------------------------------------------------------------------------------------
		public static const Edit_Resource:XML = 
			<components fileID={NameDefine.FILE_ID_RESOURCE}></components>;
		
		public static const Edit_Resource_Icon:XML = 
			<icon file="" width="0" height="0"	action="" resourceID=""></icon>

		//功能组件---------------------------------------------------------------------------------------
		public static const Edit_Function_ROOT:XML = 
			<{NameDefine.KEY_FUNCTION_ROOT}></{NameDefine.KEY_FUNCTION_ROOT}>
		public static const Edit_Function_NODE:XML = 
			<{NameDefine.KEY_FUNCTION_NODE} id="">
			</{NameDefine.KEY_FUNCTION_NODE}>;

		//功能组件---------------------------------------------------------------------------------------
		public static const Edit_USER:XML = 
			<content fileID={NameDefine.FILE_ID_USER}>
							<{NameDefine.KEY_USER_BOOKMARK}/>
							<{NameDefine.KEY_USER_NOTE}/>
							<{NameDefine.KEY_USER_RESOURCE}/>
						</content>;
		//draw
		public static const Edit_drawXML:XML=<drawing/>;
		public static const Edit_drawNode:XML=<draw shape="" fillColor="" fillAlpha="" stroke="" strokeAlpha="" blendMode=""/>;
		public static const Edit_drawShape:XML=<shape x="" y="" width="" height=""/>;
		public static const Edit_drawPoint:XML=<point x="" y=""/>;
		
		
		
		
		
		
		public static function updataComponent(_componentID:String,xml:XML):XML
		{
			var _xmlListComponent:XMLList = XML_COMPONENT.children().(@componentID==_componentID)
			var _xml:XML = xml.copy()
			_xml.@folder = _xmlListComponent.@folder
			_xml.@action = _xmlListComponent.@action
			for (var j:int = 0; j < _xml.children().length(); j++) 
			{
				_xml.children()[j]= _xmlListComponent.files.children()[j]
			}
			return _xml
		}
		
		public static function updataButtonsXML(_componentID:String,xml:XML):XML
		{
			var _xml:XML = new XML(XML_COMPONENT.children().(@componentID==_componentID))
			_xml.@x = xml.@x
			_xml.@y = xml.@y
			_xml.@width = xml.@width
			_xml.@height = xml.@height
			return _xml
		}
		
		//pages/data.xml--------------------------------------------------------------------------------------------------------------
		[Bindable] public static var XML_PAGE:XML
		public static var currentPageNode:XMLList
		public static function getPagesNodes():XMLList
		{
			return XML_PAGE[NameDefine.KEY_PAGES]
		}
		public static function getCurrentPageNode(_page:uint):XMLList
		{
			currentPageNode = XMLList(getPagesNodes().children()[_page])
			return currentPageNode
		}
		public static function getCurrentCtrlNode(_page:uint):XMLList
		{
			return getPagesNodes().children()[_page].controls
		}
		public static function getCurrentSubGroupNode(_page:uint):XMLList
		{
			return getPagesNodes().children()[_page][NameDefine.KEY_FUNCTION_ROOT]
			
		}
	}
}