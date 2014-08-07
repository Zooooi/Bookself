package jsProject.view
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import jsProject.mdel.Files;
	import jsProject.mdel.NameDefine;
	import jsProject.mdel.XmlContent;

	public class PageSubGroupLayer extends Sprite
	{
		
		private var nodeSubGroupRoot:XMLList
		private var nodeSubGroupNode:XML
		private var currentSprite:SubGroupBase
		private var nPage:uint
		
		public function PageSubGroupLayer(_pageNum:uint) 
		{
			nPage = _pageNum
			nodeSubGroupRoot = XmlContent.getCurrentSubGroupNode(nPage)
			
			for (var i:int = 0; i < nodeSubGroupRoot.children().length(); i++) 
			{
				nodeSubGroupNode = nodeSubGroupRoot.children()[i]
				switch(nodeSubGroupNode.@id.toString())
				{
					//PlayList
					default:
					case NameDefine.KEY_SUBGROUP_PLAYLIST:
						currentSprite = new SubGroup_PlayList
						break;
					
					//Show/Hide
					case NameDefine.KEY_SUBGROUP_SHOWHIDE:
						
						switch(nodeSubGroupNode.@mode.toString())
						{
							case "":
							case undefined :
							case NameDefine.KEY_SUBGROUP_PLAYLIST_NORMAL:
								currentSprite = new SubGroup_ShowHideNormal
								break;
							case NameDefine.KEY_SUBGROUP_PLAYLIST_SLIDER:
								currentSprite = new SubGroup_ShowHideSlider
								break;	
						}
						break;
					
					
					
				}
				currentSprite.setXML(nodeSubGroupNode)
				addChild(currentSprite)
			}
		}
		
		protected function onAddEvent(event:Event):void
		{
			
		}
	}
}