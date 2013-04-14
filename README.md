SimpleChart Actionscript Library
============

It's a lightweight ( < 5kb to your final swf ) pure actionscript library for chart drawing. See the [demo](http://www.mollyjameson.com/PersonalProjects/SimpleChartDemo/) above for examples.

You can just download the swc in the bin directory to get the functionality or download the source.

Basic Features
---------------

- Drawing multiple lines for the same data set on a single chart
- Fills under lines or just lines charts
- Showing and hiding labels and features
- Arbitrary resizing
- Easy to add Chart Legend

Code Example
---------------

<pre><code>
var test_data:Array = [{level: "first", time: 2 },{level: "second", time: 10 }];
var lineChart:LineChart = new LineChart(test_data,"level");
lineChart.AddLineSeries(new LineSeries( "data" ));		
this.addChild(lineChart);
</code></pre>

VERSION HISTORY
-----------------

### 0.0.1

First release. SWC, docs, and source.


FUTURE RELEASE
---------------------

If you've found a bug, suggestion or want to contribute please let me know.
Currently it only supports plain and stylized line graphs but in the future will support bar, pie and scatterplots as well.

http://www.MollyJameson.com
