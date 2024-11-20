// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie.data {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.1.0
	 * @created 14.01.2011 21:15
	 */
	public class WorldObject implements IWorldObject {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * 
		 * @param	wx world x
		 * @param	wy world y
		 */
		function WorldObject (wx:Number, wy:Number, sprite:DisplayObject = null, isFloor:Boolean = false, name:String = 'null', isWall:Boolean = false, isWallAttachable:Boolean = false) {
			this.isWall = isWall;
			this.isWallAttachable = isWallAttachable;
			this.wx = wx;
			this.wy = wy;
			this.name = name;
			this.sprite = new Sprite();
			DisplayObjectContainer(this.sprite).addChild(sprite);
			this.isFloor = isFloor;
			
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
		//{ =^_^= Data
		
		public function set_isVisible(a:Boolean) :void {
			isVisible = a;
			if (sprite) {sprite.visible = a;}
			if (interfaceSpriteRef) {interfaceSpriteRef.visible = a;}
		}
		
		public function get_isVisible():Boolean {
			return isVisible;
		}
		
		private var isVisible:Boolean = true;
		
		
		/**
		 * 
		 */
		public function get_wx():Number {return wx;}
		/**
		 * world
		 */
		public function get_wy():Number {return wy;}
		
		/**
		 * world
		 */
		public function set_wx(a:Number):void {if (a != wx) {locationChangedSinceLastRedraw = true;wx = a;}}
		/**
		 * world
		 */
		public function set_wy(a:Number):void {if (a!=wy) {locationChangedSinceLastRedraw = true;wy = a;}}
		
		public function get_name():String{return name;}
		/**
		 * sort as floor
		 */
		public function get_isFloor():Boolean {return isFloor;}
		/**
		 * sort as wall
		 */
		public function get_isWall():Boolean {return isWall;}
		/**
		 * sort as wall attachable
		 */
		public function get_isWallAttachable():Boolean {return isWallAttachable;}
		public function set_isWallAttachable (a:Boolean):void {isWallAttachable = a;}
		
		/**
		 * world x
		 */
		private var wx:Number;
		/**
		 * world y
		 */
		private var wy:Number;
		
		private var name:String;
		private var isFloor:Boolean;
		private var isWall:Boolean;
		private var isWallAttachable:Boolean;
		public var locationChangedSinceLastRedraw:Boolean;
			
		//} =^_^= END OF Data
		
		//{ =*^_^*= attached interface
		
		/**
		 * sprite will be rendered at topmost layer
		 */
		public function set_interfaceSpriteRef (a:DisplayObject):void
		{
			//reomove old
			if (interfaceSpriteRef && interfaceSpriteRef != a && interfaceSpriteRef.parent)
			{
				interfaceSpriteRef.parent.removeChild(interfaceSpriteRef);
			}
			
			interfaceSpriteRef = a;
		}
		/**
		 * sprite will be rendered at topmost layer
		 */
		public function get_interfaceSpriteRef():DisplayObjectContainer {return interfaceSpriteRef as DisplayObjectContainer;}
		private var interfaceSpriteRef:DisplayObject;
		//} =*^_^*= END OF attached interface
		
		
		public function get_sprite():DisplayObject {return sprite;}
		public function set_sprite(a:DisplayObject):void {sprite = a;}
		private var sprite:DisplayObject;
		
		//{ =^_^= Misc
		public function toString():String {
			return 'name='+name+' isFloor='+isFloor+' [wx='+wx+ '/wy='+wy+']';
		}
		//} =^_^= END OF Misc
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 05.02.2011_[23#05#41]_[6] + isFloor
 * > 15.02.2011_[11#39#30]_[2] + isWall, isWallAttachable
 * > 13.08.2011_00#59#14 + romove old (line 111)
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]