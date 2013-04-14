package 
{
	import flash.display.Sprite;

	import com.mollyjameson.SimpleChart.AreaChart;
	import com.mollyjameson.SimpleChart.ChartLegend;
	import com.mollyjameson.SimpleChart.LineChart;
	import com.mollyjameson.SimpleChart.LineSeries;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Test Harness for SimpleChart.
	 * @author Molly Jameson www.MollyJameson.com
	 */
	public class Main extends Sprite 
	{
		private var m_CurrTest:int = 0;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);

			// entry point
			DoNextTest();
			
			// Run failure tests
			//DoTestError();
		}
		
		private function onMouseClick(ev:MouseEvent):void
		{
			// go to next test function.
			DoNextTest();
		}
		
		private function DoNextTest():void
		{
			while( this.numChildren > 0 )
			{
				this.removeChildAt(0);
			}
			const NUM_TESTS:int = 6;
			switch( m_CurrTest )
			{
				default:
					DoTest0();
					break;
				case 1:
					DoTest1();
					break;
				case 2:
					DoTest2();
					break;
				case 3:
					DoTest3();
					break;
				case 4:
					DoTest4();
					break;
				case 5:
					DoTest5();
					break;
			}
			
			m_CurrTest = (m_CurrTest + 1) % NUM_TESTS;
			
			var tf:TextField = new TextField();
			tf.text = "SimpleChart test harness. Click to change tests.";
			tf.selectable = tf.mouseEnabled = false;
			tf.width = 300;
			this.addChild(tf);
		}
		
		private function DoTest0():void
		{
			// add my test data.
			
			var test_data:Array = [
			{month: "jan", revenue: 2, virality: 5, otherStuff: 2 },
			{month: "feb", revenue: 10, virality: 3 },
			{month: "mar", revenue: -4, virality: 15 },
			{month: "apr", revenue: 1, virality: 5 },
			];
			var areaChart:AreaChart = new AreaChart(test_data,"month");
			
			var lineSeries2:LineSeries = new LineSeries("revenue",null,0xCC0000);
			areaChart.AddLineSeries(lineSeries2);
			
			var lineSeries:LineSeries = new LineSeries("virality");
			areaChart.AddLineSeries(lineSeries);
			
			var legend:ChartLegend = new ChartLegend();
			legend.SetChart(areaChart);

			this.addChild(areaChart);
			areaChart.x = 100; areaChart.y = 200;
			
			this.addChild(legend);
			legend.x = areaChart.x + areaChart.width + 10;
			legend.y = areaChart.y;
			
			AddTestDescription("Example 1:\nLine charts with fills ( AreaCharts ) with legends and multiple data points.");
		}
		
		private function DoTest1():void
		{
			// add my test data.
			
			var test_data:Array = [
			{day: 1, data: 2 },
			{day: 2, data: 10 },
			{day: 3, data: -4 },
			{day: 4, data: 1 },
			];
			var lineChart:LineChart = new LineChart(test_data,"day");
			lineChart.AddLineSeries(new LineSeries( "data" ));
			
			this.addChild(lineChart);
			lineChart.x = 100; lineChart.y = 200;
			
			AddTestDescription("Example 2:\nTrivial example.");
		}
		
		private function DoTest2():void
		{
			// add my test data.
			
			var test_data:Array = [
			{level: "ice", time: 2 },
			{level: "fire", time: 3 },
			{level: "cave", time: 10 },
			{level: "water", time: 1 },
			];
			var lineChart:AreaChart = new AreaChart(null,"");
			lineChart.SetData(test_data);
			lineChart.SetHorizontalAxisCategory("level");
			// if we have no valid category  don't render test
			//lineChart.AddLineSeries(new LineSeries("time","total time per level",0xCCCCCC,0));
			lineChart.AddLineSeries(new LineSeries("time","total time per level",0));
			lineChart.SetTitle("Level Times");
			
			this.addChild(lineChart);
			lineChart.x = 100; lineChart.y = 200;
			
			var legend:ChartLegend = new ChartLegend();
			legend.SetChart(lineChart);
			this.addChild(legend);
			legend.x = lineChart.x + lineChart.width + 10;
			legend.y = lineChart.y;
			
			AddTestDescription("Example 3:\nUse String names or anything in yAxis and change label names after constructor. With Title and unique colors.");
		}
		
		private function DoTest3():void
		{
			// add my test data.
			
			var test_data:Array = [
			{month: 1, data: 0 },
			{month: 2, data: -2 },
			{month: 3, data: 5 },
			{month: 5, data: 1 },
			];
			var lineChart:LineChart = new LineChart(test_data,"month");
			lineChart.AddLineSeries(new LineSeries( "data" ));
			lineChart.SetShowBorder( false);
			lineChart.SetShowLabels( false );
			
			this.addChild(lineChart);
			lineChart.x = 100; lineChart.y = 200;
			
			AddTestDescription("Example 4:\nHide all the extra labels or borders");
		}
		
		private function DoTest4():void
		{
			// add my test data.
			var test_data:Array = [
			{ Month: "Jan", Profit: 2000, Expenses: 1500, Amount: 450, ArbitraryData: 5 },
            { Month: "Feb", Profit: 1000, Expenses: 200, Amount: 600, ArbitraryData: 5 },
            { Month: "Mar", Profit: 1500, Expenses: 500, Amount: 300, ArbitraryData: 5 },
            { Month: "Apr", Profit: 1800, Expenses: 1200, Amount: 900, ArbitraryData: 5 },
            { Month: "May", Profit: 2400, Expenses: 575, Amount: 500, ArbitraryData: 5 }
			];
			var areaChart:AreaChart = new AreaChart(test_data, "Month");
			
			areaChart.SetMinYOverride(0);
			
			var lineSeries:LineSeries = new LineSeries("Profit",null,0x0000CC);
			areaChart.AddLineSeries(lineSeries);
			
			var lineSeries2:LineSeries = new LineSeries("Expenses",null,0xCC0000);
			areaChart.AddLineSeries(lineSeries2);
			
			var lineSeries3:LineSeries = new LineSeries("Amount",null,0x00CC00);
			areaChart.AddLineSeries(lineSeries3);
			
			var legend:ChartLegend = new ChartLegend();
			legend.SetChart(areaChart);

			this.addChild(areaChart);
			areaChart.x = 100; areaChart.y = 200;
			
			this.addChild(legend);
			legend.x = areaChart.x + areaChart.width + 10;
			legend.y = areaChart.y;
			
			AddTestDescription("Example 5:\nSet a lower Y minimum to always show the origin.");
		}
		
		private function DoTest5():void
		{
			// add my test data.
			
			var test_data:Array = [
			{month: "jan", revenue: 2, virality: 5, otherStuff: 2 },
			{month: "feb", revenue: 10, virality: 15 },
			{month: "mar", revenue: -4, virality: 0 },
			{month: "apr", revenue: 1, virality: 5 },
			];
			var areaChart:AreaChart = new AreaChart(test_data,"month");
			areaChart.SetSize(200, 300);
			var lineSeries2:LineSeries = new LineSeries("revenue",null,0xCC0000);
			areaChart.AddLineSeries(lineSeries2);
			
			var lineSeries:LineSeries = new LineSeries("virality");
			areaChart.AddLineSeries(lineSeries);
			
			var legend:ChartLegend = new ChartLegend();
			legend.SetChart(areaChart);

			this.addChild(areaChart);
			areaChart.x = 100; areaChart.y = 100;
			
			this.addChild(legend);
			legend.x = areaChart.x + areaChart.width + 10;
			legend.y = areaChart.y;
			
			AddTestDescription("Example 6:\nSet arbitrary window sizes.");
		}
		
		private function DoTestError():void
		{
			// Should fail because y is not a number.
			// expected behavoir: show NaN
			/*var test_data:Array = [
			{day: "blah", data: "blah3" },
			{day: "blah2", data: "blah4" }
			];
			var lineChart:LineChart = new LineChart(test_data,"day");*/
			// Not a number fail end
			
			// empty set start
			// Expected behavoir: render nothing
			var test_data:Array = [	];
			var lineChart:LineChart = new LineChart(test_data,"day");
			//  empty set failend
			
			// invalid x category set start
			// Expected behavoir: throw error
			/*var test_data:Array = [
			{day: "blah", data: 1 },
			{day: "blah2", data: 2 }
			];
			var lineChart:LineChart = new LineChart(test_data,"asdfadfd");*/
			// nvalid x category set end
			
			lineChart.AddLineSeries(new LineSeries( "data" ));
			this.addChild(lineChart);
			lineChart.x = 100; lineChart.y = 200;
			AddTestDescription("Example of error cases.");
		}
		
		private function AddTestDescription(str:String):void
		{
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat(null, 16);
			tf.text = str;
			tf.selectable = tf.mouseEnabled = false;
			tf.autoSize = TextFieldAutoSize.LEFT;
			
			tf.y = 30;
			this.addChild(tf);
		}
		
	}
	
}