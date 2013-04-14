package com.mollyjameson.SimpleChart 
{
	
	/**
	 * Class created to show what data to render from the original array object sent into <code>SetData</code>
	 * Ex:<br>
	 * <code>
	 * 		var test_data:Array = [{day: 1, data: 2 },
	 *								{day: 2, data: 10 }];
	 *		var lineChart:LineChart = new LineChart(test_data,"day");
	 *		lineChart.AddLineSeries(new LineSeries( "data" ));		
	 *		this.addChild(lineChart);
	 * </code>
	 * @author Molly Jameson
	 */
	public class LineSeries
	{
		protected var m_KeyVertical:String;
		protected var m_Color:uint;
		protected var m_DisplayName:String;
		/**
		 * 
		 * @param	keyVertical - name of property to use on vertical y axis.
		 * @param	displayName - name to display on the legend. If null uses dataHorizontal
		 * @param	color - line color
		 */
		public function LineSeries( keyVertical:String, displayName:String = null,color:uint = 0x0F6FDF)
		{
			m_KeyVertical = keyVertical;
			m_Color = color;
			
			if ( displayName != null)
			{
				m_DisplayName = displayName;
			}
			else
			{
				m_DisplayName = keyVertical;
			}
		}
		
		public function GetDisplayName():String
		{
			return m_DisplayName;
		}
		
		public function GetVerticalKey():String
		{
			return m_KeyVertical;
		}
		
		public function GetColor():uint
		{
			return m_Color;
		}
	}
}