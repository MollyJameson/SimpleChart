package com.mollyjameson.SimpleChart 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * 
	 * Base class for all chart types, should not be instantiated.
	 * 
	 * TODO: bar graphs and pie graphs
	 * 
	 * @author Molly Jameson
	 */
	public class BaseChart extends Sprite 
	{
		protected var m_Data:Array;
		protected var m_ShowBorder:Boolean;
		protected var m_ShowLabels:Boolean;
		protected var m_ShowTitle:Boolean;
		protected var m_ChartTitle:String;
		protected var m_TFTitle:TextField;
		
		public function BaseChart()
		{
			m_Data = null;
			m_ShowBorder = true;
			m_ShowLabels = true;
			m_ShowTitle = true;
			m_ChartTitle = "";
			
			m_TFTitle = new TextField();
			m_TFTitle.autoSize = TextFieldAutoSize.LEFT;
			var text_format:TextFormat = new TextFormat();
			text_format.size = 18;
			m_TFTitle.defaultTextFormat = text_format;
			this.addChild(m_TFTitle);
		}
		/**
		 *
		 * Sets the model data we want to view ( only works with number data sets.)<br>
		 * @example <code>[{"foo":5,"bar":2},{"foo":10,"bar":4}];</code>
		 * @param data an array of objects to model.
		 * 
		 */
		public function SetData(data:Array):void
		{
			m_Data = data;
			Update();
		}
		/**
		 * Show or hide the black border around the chart. True by default.
		 * @param	border_visible
		 */
		public function SetShowBorder(border_visible:Boolean):void
		{
			m_ShowBorder = border_visible;
			Update();
		}
		public function GetShowBorder():Boolean
		{
			return m_ShowBorder;
		}
		
		/**
		 * Show the labels on the x and y axis. True by default.
		 * @param	labels_visible
		 */
		public function SetShowLabels(labels_visible:Boolean):void
		{
			m_ShowLabels = labels_visible;
			Update();
		}
		public function GetShowLabels():Boolean
		{
			return m_ShowLabels;
		}
		/**
		 * Sets the title to display about the graph, empty by default.
		 * @param	chart_title
		 */
		public function SetTitle(chart_title:String):void
		{
			m_ChartTitle = chart_title;
			Update();
		}
		
		public function GetTitle():String
		{
			return m_ChartTitle;
		}
		
		/**
		 * Show or hide the Graph title even if explicitly set.
		 * @param	show_title
		 */
		public function SetShowTitle(show_title:Boolean):void
		{
			m_ShowTitle = show_title;
			Update();
		}
		
		public function GetShowTitle():Boolean
		{
			return m_ShowTitle;
		}
		
		public function GetTotalData():int
		{
			return 0;
		}
		public function GetDataColorAtIndex(i:int):uint
		{
			return 0;
		}
		public function GetDataNameAtIndex(i:int):String
		{
			return "";
		}
		
		protected function Update():void
		{
		}
	}
}