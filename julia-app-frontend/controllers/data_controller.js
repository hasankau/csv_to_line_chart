var baseUrl = 'http://localhost:8000';
var control = '';

function getData(con) {
    control = con;
    $.ajax({
        url: baseUrl+"/generate/table",
        data: '',
        cache: false,
        method: 'GET',
        success: function (result) {
            var row = $('.data_wrapper');
            row.html(result);
        },
        error: function (jqXHR, exception) {
            console.log(jqXHR.responseText)
        }
    });
}

function getGraph(con) {
    control = con;
    $.ajax({
        url: baseUrl+"/generate/graph",
        data: '',
        cache: false,
        method: 'GET',
        success: function (result) {
            var row = $('.graph_wrapper');
            row.html(result);
        },
        error: function (jqXHR, exception) {
            console.log(jqXHR.responseText)
        }
    });
}

$(document).ready(function(){
    getData();
    getGraph();
});