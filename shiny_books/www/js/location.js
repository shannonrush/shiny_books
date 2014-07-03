function initialize() {
    var mapOptions = {
            center: new google.maps.LatLng(40, -105),
            zoom: 2,
            mapTypeId: google.maps.MapTypeId.HYBRID
        };
    var map = new google.maps.Map(document.getElementById("map"),
            mapOptions);
}
google.maps.event.addDomListener(window, 'load', initialize);

$(document).on('click', '#plottabs li a', function() {
    if ($(this).text()=="By Location") {
        $('#map').removeClass("noshow"); 
    } else {
        $('#map').addClass("noshow"); 
    }
});
