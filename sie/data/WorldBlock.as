// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie.data {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	//} =^_^= END OF import
	
	
	/**
	 * working with objects(block level z sort)
	 * @author Jinanoimatey Dragoncat
	 * @version 1.0.0
	 * @created 14.01.2011 17:41
	 */
	public class WorldBlock implements IWorldObject {
		
		//{ =^_^= CONSTRUCTOR
		
		function WorldBlock (wx:Number, wy:Number) {
			this.wx = wx;
			this.wy = wy;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
		//{ =^_^= Data
		
		public function hasFloor():Boolean {return hasFloor_;}
		
		public function get_wx():Number {return wx;}
		public function get_wy():Number {return wy;}
		
		
		
		/**
		 * has floor
		 */
		private var hasFloor_:Boolean;	
		
		/**
		 * world x
		 */
		private var wx:Number;
		/**
		 * world y
		 */
		private var wy:Number;
		
		//} =^_^= END OF data
		
		
		//{ =^_^= Physics
		
		//{ =^_^= =^_^= Objects list
		
		public function addObject(a:WorldObject):void {
			if (a.get_isFloor()) {
				if (objectsListFloor.indexOf(a)>-1) {return;}
				objectsListFloor.push(a);
				hasFloor_ = true;
			} else if (a.get_isWall()) {
				if (objectsListWall.indexOf(a)>-1) {return;}
				objectsListWall.push(a);
				hasWorldObjects = true;
			} else if (a.get_isWallAttachable()) {
				if (objectsListWallAttachable.indexOf(a)>-1) {return;}
				objectsListWallAttachable.push(a);
				hasWorldObjects = true;
			} else {
				if (objectsList.indexOf(a)>-1) {return;}
				objectsList.push(a);
				hasWorldObjects = true;
			}
		}
		public function removeObject(a:WorldObject):void {
			if (a.get_isFloor()) {
				if (objectsListFloor.indexOf(a)<0) {return;}
				objectsListFloor.splice(objectsListFloor.indexOf(a), 1);
				if (objectsListFloor.length<1) {hasFloor_ = false;}
			} else if (a.get_isWall()) {
				if (objectsListWall.indexOf(a)<0) {return;}
				objectsListWall.splice(objectsListWall.indexOf(a), 1);
			} else if (a.get_isWallAttachable()) {
				if (objectsListWallAttachable.indexOf(a)<0) {return;}
				objectsListWallAttachable.splice(objectsListWallAttachable.indexOf(a), 1);
			} else {
				if (objectsList.indexOf(a)<0) {return;}
				objectsList.splice(objectsList.indexOf(a), 1);
			}
			if (objectsList.length<1 && objectsListWallAttachable.length<1 && objectsListWall.length<1) {hasWorldObjects = false;}
		}
		public function clearObjectsList():void {
			objectsList = [];
			objectsListWall = [];
			objectsListWallAttachable = [];
			hasWorldObjects = false;
		}
		public function hasObjects():Boolean {
			return hasWorldObjects;
		}
		/**
		 * @return z sorted objects list
		 */
		public function getObjectsList():Array {
			spList = [];
			var i:WorldObject;
			
			if (objectsList.length) {
				for each(i in objectsList) {
					spList.push(i.get_sprite());
				}
			
				spList.sortOn('x', Array.NUMERIC);
				spList.sortOn('y', Array.NUMERIC);
			}
			
			if (objectsListWallAttachable.length) {
				for each(i in objectsListWallAttachable) {
					spList.unshift(i.get_sprite());
				}
			}
			
			if (objectsListWall.length) {
				for each(i in objectsListWall) {
					spList.unshift(i.get_sprite());
				}
			}
			
			return spList;
		}
		/**
		 * @return [WorldObject]
		 */
		public function getWorldObjectsList():Array {
			spList = [];
			var i:WorldObject;
			
			if (objectsList.length) {
				for each(i in objectsList) {
					spList.push(i);
				}
			
			}
			
			if (objectsListWallAttachable.length) {
				for each(i in objectsListWallAttachable) {
					spList.unshift(i);
				}
			}
			
			if (objectsListWall.length) {
				for each(i in objectsListWall) {
					spList.unshift(i);
				}
			}
			
			return spList;
		}
		
		public function getFloorObjectsList():Array {
			spListFloor = [];
			
			for each(var i:WorldObject in objectsListFloor) {
				spListFloor.push(i.get_sprite());
			}
			
			return spListFloor;
		}
		
		/**
		 * performance
		 */
		private var hasWorldObjects:Boolean;
		/**
		 * WorldObject
		 */
		private var objectsList:Array = [];
		private var objectsListFloor:Array = [];
		private var objectsListWall:Array = [];
		private var objectsListWallAttachable:Array = [];
		private var spList:Array = [];
		private var spListFloor:Array = [];
		
		//} =^_^= =^_^= END OF Objects list
		
		
		//} =^_^= END OF Physics
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 02.02.2011_[22#54#53]_[3] - walls conception
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]