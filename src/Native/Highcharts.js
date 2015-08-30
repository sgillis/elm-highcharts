Elm.Native = Elm.Native || {};
Elm.Native.Highcharts = Elm.Native.Highcharts || {};

Elm.Native.Highcharts.make = function(elm){
    'use strict';
    elm.Native = elm.Native || {};
    elm.Native.Highcharts = elm.Native.Highcharts || {};
    if (elm.Native.Highcharts.values) return elm.Native.Highcharts.values;

    var newElement = Elm.Graphics.Element.make(elm).newElement;
    var Element = Elm.Native.Graphics.Element.make(elm);
    var List = Elm.Native.List.make(elm);

    function render(model){
        var chart = Element.createNode('div');
        chart.id = 'highchart-container';
        setTimeout(function(){
            create_highchart(model)
        }, 100);
        return chart
    }

    function update(node, oldModel, newModel){
        update_highchart(newModel);
        return node
    }

    function update_highchart(model){
        series = transform_series(model.series, elm);
        Highcharts.charts[0].series[0].setData(series[0].data);
        Highcharts.charts[0].series[1].setData(series[1].data);
    }

    function create_highchart(model){
        series = transform_series(model.series)
        $('#highchart-container').highcharts({
            chart: {
                type: 'bar',
            },
            title: {
                text: model.title
            },
            xAxis: {
                categories: List.toArray(model.categories)
            },
            yAxis: {
                title: {
                    text: model.yaxistitle
                }
            },
            series: series
        });
    }

    function transform_series(series){
        series = List.toArray(series);
        for(i=0; i<series.length; i++){
            series[i].data = List.toArray(series[i].data)
        }
        return series
    }

    function barChart(title, categories, yaxistitle, series){
        return A3(Element.newElement, 800, 600, {
            'ctor'   : 'Custom',
            'type'   : 'Highchart',
            'render' : render,
            'update' : update,
            'model'  : {
                title: title,
                categories: categories,
                yaxistitle: yaxistitle,
                series: series
            }
        });
    }

    return elm.Native.Highcharts.values = {
        barChart: F4(barChart),
    }
}
