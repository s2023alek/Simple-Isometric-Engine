// Project SimpleIsometricEngine
package org.jinanoimateydragoncat.works.sie {
	
	//{ =^_^= import
	import flash.events.Event;
	//} =^_^= END OF import
	
	
	/**
	 * 
	 * @author Jinanoimatey Dragoncat
	 * @version 0.0.0
	 * @created 14.01.2011 23:19
	 */
	public class ExtendedEvent extends Event {
		
		//{ =^_^= CONSTRUCTOR
		
		function ExtendedEvent (type:String, data:Object) {
			super(type);
			data_ = data;
		}
		//} =^_^= END OF CONSTRUCTOR
		
		public function get data():Object {return data_;}
		
		private var data_:Object;
		
	}
}

//{ =^_^= History
/* > (timestamp) [ ("+" (added) ) || ("-" (removed) ) || ("*" (modified) )] (text)
 * > 
 */
//} =^_^= END OF History

// template last modified:03.05.2010_[22#42#27]_[1]