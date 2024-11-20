// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie.test {
	
	//{ =^_^= import
	import flash.display.Sprite;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 14.01.2011 22:40
	 */
	public class TestWorldObject extends Sprite {
		
		//{ =^_^= CONSTRUCTOR
		
		function TestWorldObject (width:Number=50, height:Number=100, color:uint=0xFF00FF) {
			var sp:Sprite = addChild(new Sprite());
			
			sp.graphics.beginFill(color);
			sp.graphics.drawRect(-width/2, -height, width, height);
			sp.graphics.endFill();
			
			sp.graphics.beginFill(0x000000);
			sp.graphics.drawRect(-width/2+10, -height+10, width-20, height-20);
			sp.graphics.endFill();
			
			sp.graphics.beginFill(0xFFFFFF);
			sp.graphics.drawRect(-5, -5, 10, 10);
			sp.graphics.endFill();
			
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