package com.mollyjameson.SimpleChart 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	/**
	 * 
	 * Seperate Sprite that automatically shows your <code>LineSeries</code> colors and display name.
	 * 
	 * @author Molly Jameson
	 */
	public class ChartLegend extends Sprite 
	{
		/**
		 * Sets what chart data to show. 
		 * @param	chart - null will clear everything
		 */
		public function SetChart(chart:BaseChart):void
		{
			this.graphics.clear();
			while( this.numChildren > 0 )
			{
				this.removeChildAt(0);
			}
			
			// refreshes the data
			if ( chart == null )
			{
				return;
			}
			
			const SPACER:int = 20;
			for (var i:int = 0; i < chart.GetTotalData(); ++i )
			{
				var color:uint = chart.GetDataColorAtIndex(i);
				var str_name:String = chart.GetDataNameAtIndex(i);
				
				var tf:TextField = new TextField();
				this.addChild(tf);
				tf.x = SPACER;
				tf.y = SPACER * i;
				tf.text = str_name;
				tf.mouseEnabled = tf.selectable = false;
				tf.autoSize = TextFieldAutoSize.LEFT;
				
				this.graphics.beginFill(color);
				this.graphics.drawRect(0, SPACER * i, SPACER, tf.height);
				this.graphics.endFill();
			}
		}
	}
}