// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie.test {
	
	//{ =^_^= import
	import flash.display.Sprite;
	import flash.geom.Matrix;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 14.01.2011 22:40
	 */
	public class TestWorldObjectBox extends Sprite {
		
		//{ =^_^= CONSTRUCTOR
		
		function TestWorldObjectBox (blockWidth:Number, objectHeight:Number, width:uint=4, height:uint=2, color:uint=0xFF00FF) {
			var h:Number = objectHeight;
			
			var spr:Sprite = new Sprite();
			var spr0:Sprite = spr.addChild(new Sprite());
			var sp:Sprite = spr0.addChild(new Sprite());
			
			//1
			var sp0:Sprite;
			sp0 = sp.addChild(new Sprite());
			sp0.graphics.beginFill(0x0000FF);
			sp0.graphics.drawRect(0, -h, blockWidth/2*width, h);
			sp0.transform.matrix = new Matrix(1, .5, 0, 1);
			sp0.alpha = .80
			
			//2
			sp0 = sp.addChild(new Sprite());
			sp0.graphics.beginFill(0x0000FF);
			sp0.graphics.drawRect(0, -h, blockWidth/2*height, h);
			sp0.transform.matrix = new Matrix(-1, .5, 0, 1);
			sp0.alpha = .80
			//3
			sp0 = sp.addChild(new Sprite());
			sp0.graphics.beginFill(0x0000FF);
			sp0.graphics.drawRect(0, -h, blockWidth/2*width, h);
			sp0.transform.matrix = new Matrix(1, .5, 0, 1);
			sp0.alpha = .80
			sp0.x = -blockWidth/2*height;
			if (width>1 && height>1) {
				sp0.y = blockWidth/2;
			} else {
				sp0.y = blockWidth/4;
			}
			//4
			sp0 = sp.addChild(new Sprite());
			sp0.graphics.beginFill(0x0000FF);
			sp0.graphics.drawRect(0, -h, blockWidth/2*height, h);
			sp0.transform.matrix = new Matrix(-1, .5, 0, 1);
			sp0.x = blockWidth/2*width;
			sp0.y = (blockWidth/2*width)/2;
			sp0.alpha = .80
			
			
			//roof
			sp0 = sp.addChild(new Sprite());
			sp0.graphics.beginFill(color);
			sp0.graphics.drawRect(0, 0, blockWidth/2*width, blockWidth/2*height);
			sp0.transform.matrix = new Matrix(1, 0.5, -1, .5);
			sp0.alpha = .80
			sp0.y = -h;
			
			//sp.x = -blockWidth/2*width/2;
			//sp.y = -blockWidth/2*(width+height)/2;
			
			sp0 = spr.addChild(new Sprite());
			graphics.beginFill(0xFFFF00);
			graphics.drawRect(0, 0, 8, 8);
			
			//sp.x = blockWidth;
			//sp.y = -blockWidth/2;
			//
			
			spr.x = -blockWidth/2*width;
			spr.y = -blockWidth/4*width;
			
			//spr0.x = blockWidth/2*width;
			//spr0.y = blockWidth/4*width;
			
			addChild(spr);
		}
		//} =^_^= END OF CONSTRUCTOR
		
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 22.03.2011_[01#59#20]_[2] fixed bug with size 1x1
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]