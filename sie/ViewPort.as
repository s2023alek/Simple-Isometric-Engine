// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie {
	
	//{ =^_^= import
	import api.com.odnoklassniki.sdk.events.Events;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix
	import flash.geom.Point;
	import org.jinanoimateydragoncat.works.sie.data.IWorldObject;
	import org.jinanoimateydragoncat.works.sie.data.WorldBlock;
	import org.jinanoimateydragoncat.works.sie.data.WorldData;
	import org.jinanoimateydragoncat.works.sie.data.WorldObject;
	//} =^_^= END OF import
	
	
	/**
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 14.01.2011 18:08
	 */
	public class ViewPort extends Sprite {
		
		//{ =^_^= CONSTRUCTOR
		
		/**
		 * 
		 * @param	blockWidth (px)
		 */
		function ViewPort (worldData:WorldData, blockWidth:Number) 
		{
			if (!worldData) {throw new ArgumentError("!worldData")}
			
			setWorldData(worldData);
			countX = worldData.get_countX();
			countY = worldData.get_countY();
			if (countX < 2 || countY < 2) {throw new ArgumentError("countX < 2 || countY < 2");}
			
			this.blockWidth = blockWidth;
			
			createLayers();
			createBlocks();
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
		//{ =^_^= Phys
		
		//{ 	=^_^= Floor & walls
		
		public function drawBackground(color:uint=0x00CC44, alpha:Number=.5):void {
			var sp:Sprite = addChild(new Sprite()) as Sprite;
			sp.graphics.beginFill(color, alpha);
			sp.graphics.drawRect(0, 0, blockWidth/2*countY, blockWidth/2*countX);
			sp.transform.matrix = new Matrix(1, 0.5, -1, .5);
			sortLayers();
		}
		
		/**
		 * cell highlight
		 * @param	color
		 * @param	alpha 0=remove highlighting
		 */
		public function highlightCell(x:uint, y:uint, color:uint=0x00EF40, alpha:Number=.5):void {
			highlightingCell(x, y, color, alpha);
		}
		/**
		 * @deprecated use highlightCell
		 */
		private function highlightingCell(x:uint, y:uint, color:uint=0x00EF40, alpha:Number=.5):void {
			if (alpha==0) {
				if (bgCellHighlighting[x] && bgCellHighlighting[x][y]) {
					removeChild(bgCellHighlighting[x][y]);
					bgCellHighlighting[x][y] = null;
				}
				return;
			}
			var sp:Sprite;
			if (bgCellHighlighting[x] && bgCellHighlighting[x][y]) {
				sp = bgCellHighlighting[x][y];
			} else {
				sp= addChild(new Sprite()) as Sprite;
				if (!bgCellHighlighting[x] ) {bgCellHighlighting[x] = [];}
				bgCellHighlighting[x][y] = sp;
				sortLayers();
			}
			sp.graphics.clear();
			sp.graphics.beginFill(color, alpha);
			sp.graphics.drawRect(0, 0, blockWidth/2, blockWidth/2);
			sp.transform.matrix = new Matrix(1, 0.5, -1, .5);
			sp.x = getScreenX(x, y);sp.y = getScreenY(x, y);
		}
		private var bgCellHighlighting:Array = [];
		
		
		private var floor:Array = [];// DisplayObject
		
		private var interfaceLayer:Sprite;
		private var objectsLayer:Sprite;
		private var floorLayer:Sprite;
		
		private var bg:Sprite = new Sprite();
		//} 	=^_^= END OF Floor & walls
		
		//{ 	=^_^= Objects
		
		/**
		 * e {data:WorldObject}
		 */
		private function el_objectAdded(e:ExtendedEvent):void {
			var w:WorldObject = e.data as WorldObject;
			w.get_sprite().visible  = true;
			orderObjectsOnScreen();
		}
		
		/**
		 * e {data:WorldObject}
		 */
		private function  el_objectRemoved(e:ExtendedEvent):void {
			if (WorldObject(e.data).get_sprite()) {
				WorldObject(e.data).get_sprite().visible = false;
				if (WorldObject(e.data).get_sprite().parent) {
					WorldObject(e.data).get_sprite().parent.removeChild(WorldObject(e.data).get_sprite());
				}
			}
			if (WorldObject(e.data).get_interfaceSpriteRef()) {
				WorldObject(e.data).get_interfaceSpriteRef().visible = false;
				if (WorldObject(e.data).get_interfaceSpriteRef().parent) {
					WorldObject(e.data).get_interfaceSpriteRef().parent.removeChild(WorldObject(e.data).get_interfaceSpriteRef());
				}
			}
		}
		//} 	=^_^= END OF Objects
		
		public function redraw():void {
			orderObjectsOnScreen();
		}
		
		/**
		 * z sort
		 */
		private function orderObjectsOnScreen():void {
			var wb:WorldBlock;
			var max:uint = Math.max(countX, countY);
			var ax:uint = (countX+countY)-1;
			var wx:uint;
			var wy:uint;
			var startY:uint;
			var spArrFloors:Array=[];
			var spArr:Array=[];
			var interfacesArr:Array=[];
			var do_:DisplayObject;
			//clear
			for each(wb in worldData.get_worldBlocksList()) {
				wb.clearObjectsList();
			}
			//assign
			for each(var wo:WorldObject in worldData.get_objectsList()) {
				wx = wo.get_wx();
				//if (wx == countX) {wx = countX- 1;}
				wy = wo.get_wy();
				//if (wy == countY) {wy = countY- 1;}
				
				wb = worldData.getWorldBlock(wx, wy);
				if (!wb) {
					continue;
				}
				wb.addObject(wo);
				if (wo.locationChangedSinceLastRedraw) {
					wo.get_sprite().x = getScreenX_w(wo);
					wo.get_sprite().y = getScreenY_w(wo);
					wo.locationChangedSinceLastRedraw = false;
				}
			}
			
			for (var i:uint = 0; i < ax; i++ ) {//lines
				wx = Math.min(i, countX-1);
				wy = 0;
				if (i>countX-1) {
					startY = (i-countX+1);
				} else {
					startY = 0;
				}
				for (var ii:uint = startY; ii < Math.min(i+1, countY); ii++ ) {//blocks
					wb = worldData.getWorldBlock(wx, ii);
					if (!wb) {continue;}
					//add objects to list
					if (wb.hasFloor()) {
						spArrFloors.push.apply(spArrFloors, wb.getFloorObjectsList());
					}
					if (wb.hasObjects()) {
						spArr.push.apply(spArr, wb.getObjectsList());
						//interfaces 
						for each(wo in wb.getWorldObjectsList()) {
							do_ = wo.get_interfaceSpriteRef();
							if (do_) {
								do_.x = wo.get_sprite().x;
								do_.y = wo.get_sprite().y;
								interfaceLayer.addChild(do_);
								//interfacesArr.push(do_);
							}
						}
						//
					}
					if (wx>0) {wx-= 1;}
				}
			}
			// add floors
			for each(do_ in spArrFloors) {
				floorLayer.addChild(do_);
			}
			// add objects
			for each(do_ in spArr) {
				objectsLayer.addChild(do_);
			}
			//add interfaces
			//for each(do_ in interfacesArr) {
				//interfaceLayer.addChild(do_);
			//}
			
		}
		
		//} =^_^= END OF Phys
		
		
		//{ =^_^= Data
		
		public function get_blockWidth():Number {return blockWidth;}
		private var blockWidth:Number;
		
		private function createLayers():void {
			floorLayer = addChild(new Sprite()) as Sprite;
			objectsLayer = addChild(new Sprite()) as Sprite;
			interfaceLayer = addChild(new Sprite()) as Sprite;
		}
		
		private function sortLayers():void {
			addChild(floorLayer);
			addChild(objectsLayer);
			addChild(interfaceLayer);
		}
		
		
		private function createBlocks():void {
			for (var xx:uint = 0; xx < countX; xx++ ) {
				floor[xx] = [];
				for (var yy:uint = 0; yy < countY; yy++) {
					blocks.push(new WorldBlock(xx, yy));
				}
			}
		}
		
		private function setWorldData(wd:WorldData):void {
			worldData = wd;
			wd.get_eventDispatcher().addEventListener(WorldData.EVENT_OBJECT_ADDED, el_objectAdded);
			wd.get_eventDispatcher().addEventListener(WorldData.EVENT_OBJECT_REMOVED, el_objectRemoved);
		}
		
		private var countX:uint;
		private var countY:uint;
		
		private var worldData:WorldData;
		private var blocks:Vector.<WorldBlock> = new Vector.<WorldBlock>();
		
		//} =^_^= END OF Data
		
		
		//{ =^_^= Working with coordinates
		
		public function getScreenX(wx:Number, wy:Number):Number {
			return (wy-wx)*blockWidth/2;
		}
		public function getScreenX_w(wb:IWorldObject):Number {
			return getScreenX(wb.get_wx(), wb.get_wy());
		}
		public function getScreenStageGlobalPosition(wb:IWorldObject):Point {
			var p:Point = new Point(
				getScreenX(wb.get_wx(), wb.get_wy())
				,getScreenY(wb.get_wx(), wb.get_wy())
			);
			return localToGlobal(p);
			
		}
		
		public function getScreenY(wx:Number, wy:Number):Number {
			return (wy+wx)*blockWidth/4;
		}
		public function getScreenY_w(wb:IWorldObject):Number {
			return getScreenY(wb.get_wx(), wb.get_wy());
		}
		public function getWorldX(screenX:Number, screenY:Number):Number {
			return (screenY-screenX/2)/blockWidth*2;	
		}
		public function getWorldY(screenX:Number, screenY:Number):Number {
			return (screenY+screenX/2)/blockWidth*2;				
		}
		//} =^_^= END OF Working with coordinates
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > +15.01.2011_[00#06#04]_[6] + floor and data blocks
 * > + 02.02.2011_[22#54#53]_[3] - walls concept
 * > + 17.03.2011_[21#01#39]_[4] - interfaces support
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]