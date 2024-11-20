// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie.test {
	
	//{ =^_^= import
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.display.Sprite;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 14.01.2011 22:40
	 */
	public class TestFloorTile extends Sprite {
		
		//{ =^_^= CONSTRUCTOR
		
		function TestFloorTile (width:Number, wx:uint, wy:uint, showText:Boolean=true):void {
			var sp:Sprite = new Sprite();
			addChild(sp);
			sp.graphics.beginFill(0x0000AA);
			sp.graphics.drawRect(0, 0, width/2, width/2);
			sp.graphics.beginFill(0x009900);
			sp.graphics.drawRect(2, 2, width/2-4, width/2-4);
			sp.transform.matrix = new Matrix(1, 0.5, -1, .5);
			if (!showText) {return;}
			var t:TextField = new TextField();
			addChild(t);
			t.defaultTextFormat = new TextFormat("system", 10, 0xFFFFFF, true);
			t.cacheAsBitmap = true;
			t.text = wx+'.'+wy;
			t.x = sp.x-10;
			t.y = sp.y+10;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]