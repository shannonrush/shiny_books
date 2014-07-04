function initialize() {
    var mapOptions = {
            center: new google.maps.LatLng(40, -105),
            zoom: 2,
            mapTypeId: google.maps.MapTypeId.HYBRID
        };
    map = new google.maps.Map(document.getElementById("map"),
            mapOptions);
    initMarkers();
   // testMarker();
}
google.maps.event.addDomListener(window, 'load', initialize);

$(document).on('click', '#plottabs li a', function() {
    if ($(this).text()=="By Location") {
        $('#map').css("visibility", "visible"); 
        colorLabels();
    } else {
        $('#map').css("visibility", "hidden"); 
    }
});

$(document).on('click', '#locgenres input[type="checkbox"]', function() {
    (this.checked) ? addMarkers(this.value) : removeMarkers(this.value);
});

function initMarkers() {
    markers = {}
    for (var i = 0; i < genres.length; i++) {
        markers[genres[i]] = markersForGenre(genres[i], mapcolors[i])
    }
}

function markersForGenre(genre, color) {
    genre_markers = [];
    locs = locations[genre];
    if (typeof locs != "undefined") {
        var lats = locs.lat;
        var lons = locs.lon;
        var counts = locs.counts;
        for (var i = 0; i < lats.length; i++) {
            var ll = new google.maps.LatLng(lats[i],lons[i]);
            var marker = new google.maps.Marker({
                position: ll,
                icon: {
                    path: google.maps.SymbolPath.CIRCLE,
                    scale: 2,
                    fillColor:color,
                    fillOpacity:0.5,
                    strokeWeight:1
                }
            })
            genre_markers.push(marker);
        }
    }
    return genre_markers;
}

function addMarkers(genre) {
    for (var i = 0; i < markers[genre].length; i++) {
        markers[genre][i].setMap(map);
    }
}

function removeMarkers(genre) {
    for (var i = 0; i < markers[genre].length; i++) {
        markers[genre][i].setMap(null);
    }
}

function testMarker() {
    var markers = {};
    var genre_markers = [];
    var loc = locations["adventure"];
    var myLatlng = new google.maps.LatLng(loc.lat[0],loc.lon[0]);
    var marker = new google.maps.Marker({
        position: myLatlng,
        icon: {
            path: google.maps.SymbolPath.CIRCLE,
            scale: 2,
            fillColor:"red",
            fillOpacity:0.5,
            strokeWeight:1
        }
    });
    genre_markers.push(marker);
    markers["adventure"] = genre_markers;
    markers["adventure"][0].setMap(map);
}


function colorLabels() {
    $('#locgenres label.checkbox span').each(function(i) {
      this.style.color=mapcolors[i]; 
    });
}


