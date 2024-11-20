// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie.data {
	
	//{ =^_^= import
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.jinanoimateydragoncat.works.sie.ExtendedEvent;
	//} =^_^= END OF import
	
	
	/**
	 * objects list, floor texture info
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 14.01.2011 23:05
	 */
	public class WorldData {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * 
		 * @param	countX block count horisontally
		 * @param	countY block count vertically
		 */
		function WorldData (countX:uint, countY:uint, blockWidth:Number) {
			this.countX = countX;
			this.countY = countY;
			this.blockWidth = blockWidth;
			
			for (var xx:uint = 0; xx < countX; xx++ ) {
				worldBlocks[xx] = [];
				for (var yy:uint = 0; yy < countY; yy++ ) {
					worldBlocks[xx][yy] = new WorldBlock(xx, yy);
					worldBlocksList.push(worldBlocks[xx][yy]);
				}
			}
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
		//{ =^_^= Objects
		
		public function get_objectsList():Vector.<WorldObject> {
			return objectsList;
		}
		
		public function addObject(object:WorldObject):void {
			if (objectsList.indexOf(object)>-1) {return;}
			objectsList.push(object);
			dispatchEvent(new ExtendedEvent(EVENT_OBJECT_ADDED, object));
		}
		
		public function removeObject(object:WorldObject):void {
			if (objectsList.indexOf(object)>-1) {
				//trace('world data::removeObject>found, deleting');
				objectsList.splice(objectsList.indexOf(object), 1);
				dispatchEvent(new ExtendedEvent(EVENT_OBJECT_REMOVED, object));
			} else {
				//trace('world data::removeObject>not found');
			}
		}
		
		private var objectsList:Vector.<WorldObject> = new Vector.<WorldObject>();
		//} =^_^= END OF Objects
		
		
		
		/**
		 * [wx][wy]
		 * Array [[WorldBlock], ...]
		 */
		public function get_worldBlocks():Array {return worldBlocks;}
		/**
		 * Array [WorldBlock]
		 */
		public function get_worldBlocksList():Vector.<WorldBlock> {return worldBlocksList;}
		/**
		 */
		public function getWorldBlock(wx:uint, wy:uint):WorldBlock {
			if (worldBlocks[wx] && worldBlocks[wx][wy]) {
				return worldBlocks[wx][wy];
			}
			return null;
		}
		
		/**
		 * Array[xx][yy]:WorldBlock
		 */
		private var worldBlocks:Array = [];
		private var worldBlocksList:Vector.<WorldBlock> = new Vector.<WorldBlock>();
		
		
		//{ =^_^= Data
		
		public function get_countX():uint {return countX;}
		public function get_countY():uint {return countY;}
		public function get_blockWidth():Number {return blockWidth;}
		
		private var countX:uint;
		private var countY:uint;
		private var blockWidth:uint;
		//} =^_^= END OF Data
		
		
		//{ =^_^= Events
		public static const EVENT_OBJECT_ADDED:String = 'event_object_added';
		public static const EVENT_OBJECT_REMOVED:String = 'event_object_removed';
		/**
		 * data:WorldBlock
		 */
		public static const EVENT_FLOOR_TILE_ADDED:String = 'event_floor_tile_added';
		/**
		 * data:DisplayObject
		 */
		public static const EVENT_FLOOR_TILE_REMOVED:String = 'event_floor_tile_removed';
		
		//} =^_^= END OF Events
		
		
		//{ =^_^= Engineering
		
		public function get_eventDispatcher():EventDispatcher {return eventDispatcher;}
		
		private function dispatchEvent(e:Event):void {eventDispatcher.dispatchEvent(e);}
		
		private var eventDispatcher:EventDispatcher = new EventDispatcher();
		//} =^_^= END OF Engineering
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 02.02.2011_[22#54#53]_[3] - walls conception
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]