var baseUrl = window.location.origin;

function addView(control, id) {
    $.ajax({
        url: baseUrl+"/view/"+control+"/"+id,
        data: '',
        cache: false,
        method: 'GET',
        success: function (result) {
        },
        error: function (jqXHR, exception) {
            console.log(jqXHR.responseText)
        }
    });
}