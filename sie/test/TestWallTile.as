// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie.test {
	
	//{ =^_^= import
	import flash.geom.Matrix;
	import flash.display.Sprite;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 14.01.2011 22:40
	 */
	public class TestWallTile extends Sprite {
		
		//{ =^_^= CONSTRUCTOR
		
		function TestWallTile (width:Number, right:Boolean=false, color:uint=0xCCCC22) {
			var sp:Sprite = addChild(new Sprite());
			sp.graphics.beginFill(color);
			alpha = .8;
			
			if (right) {
				sp.graphics.drawRect(0, -width/2, width/2, width/2-5);
				sp.transform.matrix = new Matrix(1, 0.5, 0, 1);
			} else {
				sp.graphics.drawRect(-width/2, -width/2, width/2, width/2-5);
				sp.transform.matrix = new Matrix(1, -0.5, 0, 1);
			}	
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