Elm.Native = Elm.Native || {};
Elm.Native.Highcharts = Elm.Native.Highcharts || {};

Elm.Native.Highcharts.make = function(elm){
  'use strict';
  elm.Native = elm.Native || {};
  elm.Native.Highcharts = elm.Native.Highcharts || {};
  if (elm.Native.Highcharts.values) return elm.Native.Highcharts.values;

  var VirtualDom = Elm.Native.VirtualDom.make(elm);
  var List = Elm.Native.List.make(elm);

  var objectComparison = function(series1, series2){
    return JSON.stringify(series1) == JSON.stringify(series2);
  };

  var decode = function(chart){
    return {
      chartOptions: decodeChartOptions(chart.chartOptions),
      tooltip: chart.tooltip,
      plotOptions: decodePlotOptions(chart.plotOptions),
      series: decodeSeries(chart.series)
    };
  };

  var decodeChartOptions = function(chartOptions){
    return chartOptions;
  };

  var decodePlotOptions = function(plotOptions){
    var options = List.toArray(plotOptions);
    var decoded = {};
    for(var i=0; i<options.length; i++){
      if(options[i].ctor == "PieOptions"){
        decoded['pie'] = options[i]._0;
      }
    }
    return decoded;
  };

  var decodeSeries = function(series){
    var ss = List.toArray(series);
    var decoded = [];
    for(var i=0; i<ss.length; i++){
      if(ss[i].ctor == "Pie"){
        decoded.push(decodePieOptions(ss[i]._0));
      }
    }
    return decoded;
  };

  var decodePieOptions = function(pieOptions){
    return {
      type: 'pie',
      innerSize: pieOptions.innerSize + '%',
      data: List.toArray(pieOptions.data)
    };
  };

  var Hook = function(chart){
    this.chart = decode(chart);
    this.highchart = undefined;
  };

  Hook.prototype.initialize = function(node, propertyName, previousValue){
    this.highchart = new Highcharts.Chart(node, {
      chart: this.chart.chartOptions,
      tooltip: { pointFormat: this.chart.tooltip },
      plotOptions: this.chart.plotOptions,
      series: this.chart.series
    });
  };

  Hook.prototype.loadData = function(previousValue){
    var newSeries = this.chart.series;
    var oldSeries = previousValue.chart.series;
    if(!objectComparison(newSeries, oldSeries)){
      // Extend to support multiple series and changing of length
      // of series array
      this.highchart.series[0].setData(
        newSeries[0].data, true, true);
    }
  };

  Hook.prototype.update = function(node, propertyName, previousValue){
    this.highchart = previousValue.highchart;
    this.loadData(previousValue);
  };

  Hook.prototype.hook = function(node, propertyName, previousValue) {
    if(previousValue === undefined || previousValue.highchart === undefined){
      this.initialize(node, propertyName, previousValue);
    } else {
      this.update(node, propertyName, previousValue);
    }
  };

  function highchart(chart){
    var propertyList = List.fromArray(
      [ { key: "highchart-hook", value: new Hook(chart) } ]
    );
    var node =
          A3(VirtualDom.node, "highchart", propertyList, List.fromArray([]));
    return node;
  }

  return elm.Native.Highcharts.values = {
    highchart: highchart
  };
};
