package com.mollyjameson.SimpleChart 
{
	
	/**
	 * Sprite that shows Fills under the lines rather than only lines like <code>LineChart</code>
	 * 
	 * @author Molly Jameson
	 */
	public class AreaChart extends LineChart 
	{
		public function AreaChart(data:Array,horizontalAxisKey:String)
		{
			super(data,horizontalAxisKey);
		}
		protected override function Draw(do_clear:Boolean = true):void
		{
			var num_lines:int = m_LineSeries.length;
			if ( m_Data == null || num_lines == 0 )
			{
				return;
			}
			this.graphics.clear();
			
			var data_size:int = m_Data.length;
			for (var i:int = 0; i < num_lines; ++i)
			{
				var line:LineSeries = m_LineSeries[i];
				var x_name:String = this.m_HorizontalAxisCategory;
				var y_name:String = line.GetVerticalKey();
			
				var x_count:int = GetValidDataCountForField(x_name, line) - 1;
				
				this.graphics.lineStyle(3, line.GetColor(),1);
				this.graphics.beginFill(line.GetColor(), 0.5);
				var x_graphic:Number = 0;
				var y_graphic:Number = 0;
				var first_data:Boolean = true;
				var first_valid_y:Number = 0;
				for (var j:int = 0; j < data_size; ++j)
				{
					var obj:Object = m_Data[j];
					if ( obj[x_name] && obj[y_name] )
					{
						var x_data:Number = obj[x_name];
						var y_data:Number = obj[y_name];
						
						// convert to [0,1] and scale to our range
						x_graphic = (j / x_count) * m_Width;
						// convert to [0,1] and scale to our range and then invert so 0,0 is on bottom
						y_graphic = m_Height - ((( y_data - m_MinY ) / m_RangeY) * m_Height);
						
						if ( first_data == true )
						{
							first_data = false;
							first_valid_y = y_graphic;
							if ( data_size > 1 )
							{
								this.graphics.moveTo(x_graphic, y_graphic);
							}
							else
							{
								this.graphics.drawCircle(x_graphic, y_graphic, 2);
							}
						}
						else
						{
							this.graphics.lineTo(x_graphic, y_graphic);
						}
					}
				}
				// finish up drawing what we fill in but don't show the stroke.
				// this draw is to make sure that flash has a convex shape and shouldn't be seen by the user.
				this.graphics.lineStyle(3, line.GetColor(),0.5);
				this.graphics.lineTo( x_graphic, m_Height);
				this.graphics.lineTo( 0, m_Height );
				this.graphics.lineTo( 0, first_valid_y );
				this.graphics.endFill();
			}
			super.Draw(false);
		}
	}
}