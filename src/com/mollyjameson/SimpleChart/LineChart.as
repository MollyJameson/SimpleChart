package com.mollyjameson.SimpleChart 
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * 
	 * A sprite that draws several <code>LineSeries</code> on a chart.
	 * 
	 * @author Molly Jameson
	 */
	public class LineChart extends BaseChart 
	{
		/**
		 * An array of @see com.mollyjameson.SimpleChart.LineSeries to use with SetData.
		 */
		protected var m_LineSeries:Array;
		protected var m_Width:Number;
		protected var m_Height:Number;
		
		protected var m_MinY:Number;
		protected var m_MaxY:Number;
		
		protected var m_MinYOverride:Number;
		
		protected var m_RangeX:Number;
		protected var m_RangeY:Number;
		
		protected var m_LabelList:Array;
		protected var m_HorizontalAxisCategory:String;
		
		/**
		 * Constructs the Line chart Sprite.
		 * Ex:<br>
		 * <code>
		 * 		var test_data:Array = [{day: 1, data: 2 },
		 *								{day: 2, data: 10 }];
		 *		var lineChart:LineChart = new LineChart(test_data,"day");
		 *		lineChart.AddLineSeries(new LineSeries( "data" ));		
		 *		this.addChild(lineChart);
		 * </code>
		 * @param	data - An array of objects with keys and values to show.
		 * @param	horizontalAxisKey - which key to use on the x axis that will be shown in order.
		 */
		public function LineChart(data:Array, horizontalAxisKey:String)
		{
			m_Width = 400;
			m_Height = 300;
			m_MinYOverride = Number.NaN;
			m_LineSeries = new Array();
			m_LabelList = new Array();
			m_HorizontalAxisCategory = horizontalAxisKey;
			if ( data != null && m_HorizontalAxisCategory != "" )
			{
				SetData(data);
			}
		}
		
		/**
		 * Sets the minimum y value to show. By default the chart will show form the lowest data point passed in to the highest 
		 * if this is not set.
		 * @param	min_y_override - lowest value to show.
		 */
		public function SetMinYOverride(min_y_override:Number):void
		{
			m_MinYOverride = min_y_override;
			Update();
		}
		/**
		 * resets chart to show the lowest value in the data.
		 */
		public function ClearMinYOverride():void
		{
			SetMinYOverride(Number.NaN);
		}
		public function GetMinYOverride():Number
		{
			return m_MinYOverride;
		}
		
		/**
		 * Adds a new line using the data set in SetData and Re-renderes.
		 * @param	series
		 */
		public function AddLineSeries(series:LineSeries):void
		{
			m_LineSeries.push(series);
			Update();
		}
		
		/**
		 * Clears all lines and re-renders.
		 */
		public function ClearAllLineSeries():void
		{
			m_LineSeries = new Array();
			Update();
		}
		
		/**
		 * Defaults to a 400 x 300 sprite, changes the total pixel size.
		 * 
		 * @param	total_width
		 * @param	total_height
		 */
		public function SetSize(total_width:Number, total_height:Number):void
		{
			m_Width = total_width;
			m_Height = total_height;
			Update();
		}
		
		/**
		 * Sets what field to use for the x-axis and show in all line series. By default set in constructor.
		 * @param	horizontalAxisCategory
		 */
		public function SetHorizontalAxisCategory(horizontalAxisCategory:String):void
		{
			m_HorizontalAxisCategory = horizontalAxisCategory;
			Update();
		}
		public function GetHorizontalAxisCategory():String
		{
			return m_HorizontalAxisCategory;
		}
		
		protected override function Update():void
		{
			if ( m_ShowTitle && m_ChartTitle != "" )
			{
				m_TFTitle.text = m_ChartTitle;
				m_TFTitle.y = -m_TFTitle.height;
				m_TFTitle.x = m_Width / 2 - m_TFTitle.width/2;
				m_TFTitle.visible = true;
			}
			else
			{
				m_TFTitle.visible = false;
			}
			
			if ( m_Data == null )
			{
				throw new Error("Data is set to NULL, call SetData with valid a valid array before drawing chart.");
				return;
			}
			if ( m_LineSeries.length == 0 )
			{
				// no error, just nothing to draw.
				return;
			}

			if ( m_HorizontalAxisCategory == "" )
			{
				throw new Error("Blank Horizontal AxisCategory");
				return;
			}
			
			if ( m_Data.length > 0 && m_Data[0][m_HorizontalAxisCategory] == undefined )
			{
				throw new Error("Horizontal AxisCategory " + m_HorizontalAxisCategory + " not found");
				return;
			}
			Refresh();
			Draw();
			DrawLabels();
		}
		
		protected function Refresh():void
		{
			var num_lines:int = m_LineSeries.length;
			//Find range of all our lines minY maxY
			// clear the old labels and graphics
			
			m_MinY = Number.MAX_VALUE;
			m_MaxY = Number.MIN_VALUE;
			
			var data_size:int = m_Data.length;
			// for each line, for each data point
			for (var i:int = 0; i < num_lines; ++i)
			{
				var line:LineSeries = m_LineSeries[i];
				var x_name:String = this.m_HorizontalAxisCategory;
				var y_name:String = line.GetVerticalKey();
				for (var j:int = 0; j < data_size; ++j)
				{
					var obj:Object = m_Data[j];
					if ( obj[x_name] && obj[y_name] )
					{
						var x_data:Number = obj[x_name];
						var y_data:Number = obj[y_name];
						m_MinY = Math.min( y_data, m_MinY );
						m_MaxY = Math.max( y_data, m_MaxY );
					}
				}
			}
			
			if ( !isNaN(m_MinYOverride) && m_MinYOverride < m_MinY )
			{
				m_MinY = m_MinYOverride;
			}
			m_RangeY = m_MaxY - m_MinY;
		}
		
		protected function Draw(do_clear:Boolean = true):void
		{
			var num_lines:int = m_LineSeries.length;
			
			if ( do_clear )
			{
				this.graphics.clear();
			}
			var data_size:int = m_Data.length;
			for (var i:int = 0; i < num_lines; ++i)
			{
				var line:LineSeries = m_LineSeries[i];
				var x_name:String = this.m_HorizontalAxisCategory;
				var y_name:String = line.GetVerticalKey();
				
				var x_count:int = GetValidDataCountForField(x_name, line) - 1;
				
				this.graphics.lineStyle(3, line.GetColor());
				for (var j:int = 0; j < data_size; ++j)
				{
					var obj:Object = m_Data[j];
					if ( obj[x_name] && obj[y_name] )
					{
						var x_data:Number = obj[x_name];
						var y_data:Number = obj[y_name];
						
						// convert to [0,1] and scale to our range
						var x_graphic:Number = (j / x_count) * m_Width;
						// convert to [0,1] and scale to our range and then invert so 0,0 is on bottom
						var y_graphic:Number = m_Height - ((( y_data - m_MinY ) / m_RangeY) * m_Height);
						
						if ( j == 0 )
						{
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
			}
			
			// draw our border
			if ( m_ShowBorder )
			{
				this.graphics.lineStyle(1, 0);
				this.graphics.drawRect( -3, -3, m_Width + 3, m_Height + 3);
			}
		}
		protected function DrawLabels():void
		{
			// TODO: move this error check to shared func that calls all 3 functions
			var num_lines:int = m_LineSeries.length;
			
			var num_labels:int = m_LabelList.length;
			for (var old_child_i:int = 0; old_child_i < num_labels; ++old_child_i)
			{
				this.removeChild( m_LabelList[old_child_i] );
			}
			m_LabelList = new Array();
			
			if ( !m_ShowLabels )
			{
				return;
			}
			
			const MIN_SPACING:int = 51;
			var maxNumRequiredLabelsX:int = m_Width / MIN_SPACING;
			var maxNumRequiredLabelsY:int = m_Height / MIN_SPACING;
			
			var data_size:int = m_Data.length;
			if ( data_size == 0 )
			{
				return;
			}
			// 1 label since ranges are shared on y
			// and only one category in x
			for (var i:int = 0; i < 1; ++i)
			{
				var line:LineSeries = m_LineSeries[i];
				var x_name:String = this.m_HorizontalAxisCategory;
				var y_name:String = line.GetVerticalKey();
				var x_count:int = GetValidDataCountForField(x_name, line);
				
				var reqlabelsY:int = maxNumRequiredLabelsY;
				var intervalY:Number = Math.round( (m_RangeY / reqlabelsY) ) ;
				var x_index:int = 0;
				// we only have one label
				if ( i == 0 )
				{
					for ( var j:int = 0; j < x_count; ++j)
					{
						var obj:Object = m_Data[x_index++];
						while ( obj[x_name] == null )
						{
							obj = m_Data[x_index++];
						}
						
						var tf:TextField = new TextField();
						tf.text = obj[x_name].toString();
						tf.selectable = tf.mouseEnabled = false;
						tf.autoSize = TextFieldAutoSize.LEFT;
						tf.y = m_Height + (i * tf.height);
						tf.x = ( j / (x_count-1) * m_Width ) - tf.width/2;
						this.addChild( tf );
						m_LabelList.push( tf );
					}
					var tfXCat:TextField = new TextField();
					tfXCat.text = this.m_HorizontalAxisCategory;
					tfXCat.selectable = tfXCat.mouseEnabled = false;
					tfXCat.autoSize = TextFieldAutoSize.RIGHT;
					tfXCat.y = m_Height + (i * tfXCat.height);
					tfXCat.x = -tfXCat.width - 10;
					this.addChild( tfXCat ); m_LabelList.push( tfXCat );
						
					for ( var k:int = 0; k < maxNumRequiredLabelsY+1; ++k)
					{
						var tfy:TextField = new TextField();
						tfy.autoSize = TextFieldAutoSize.RIGHT;
						var offsetY:Number = (intervalY * k);
						var displaynum:Number = m_MinY + offsetY;
						if ( k == maxNumRequiredLabelsY )
						{
							displaynum = m_MaxY;
							offsetY = m_RangeY;
						}
						if ( displaynum == Math.round(displaynum) )
						{
							tfy.text = displaynum.toString();
						}
						else
						{
							tfy.text = displaynum.toFixed(2);
						}
						tfy.selectable = tfy.mouseEnabled = false;
						//var y_graphic:Number = m_Height - ((( y_data - m_MinY ) / m_RangeY) * m_Height);
						var nudge_factor:Number = tfy.height / 2;
						if ( k == 0 )
						{
							nudge_factor = tfy.height;
						}
						tfy.y = m_Height - ((offsetY / m_RangeY)* m_Height) - nudge_factor;
						tfy.x = -tfy.width - 5;
						
						this.addChild( tfy );
						m_LabelList.push( tfy );
					}
				}
			}
		}
		
		protected function GetValidDataCountForField(field:String, series:LineSeries):int
		{
			var valid_data_size:int = 0;
			var data_size:int = m_Data.length;
			for (var j:int = 0; j < data_size; ++j)
			{
				var obj:Object = m_Data[j];
				if ( obj[field] )
				{
					valid_data_size++;
				}
			}
			return valid_data_size;
		}
		
		public override function GetTotalData():int
		{
			return m_LineSeries.length;
		}
		public override function GetDataColorAtIndex(i:int):uint
		{
			if ( i >= m_LineSeries.length )
			{
				return 0;
			}
			return m_LineSeries[i].GetColor();
		}
		public override function GetDataNameAtIndex(i:int):String
		{
			if ( i >= m_LineSeries.length )
			{
				return "";
			}
			return m_LineSeries[i]..GetDisplayName();
		}
	}
}