$(function() {
    colorLabels();
    createMap();
});

$(document).on('click', 'input[type="checkbox"][name="locgenres"]', function() {
    $('#map').empty(); 
    createMap();
})

$(document).on('click', '#plottabs li a', function() {
    if ($(this).text()=="By Location") {
        colorLabels();
        $('#map').removeClass("hidden"); 
    } else {
        $('#map').addClass("hidden"); 
    }
});

function createMap() {
	var width = 870,
    height = 600;

	projection = d3.geo.mercator()
    		.scale(191.25)
			.translate([width / 2, height / 2])
			.precision(.1);

	var path = d3.geo.path()
			.projection(projection);

	var graticule = d3.geo.graticule();

	svg = d3.select("#map").append("svg")
			.attr("width", width)
			.attr("height", height);

	svg.append("path")
			.datum(graticule)
			.attr("class", "graticule")
				.attr("d", path);

	d3.json("json/world-50m.json", function(world) {
		  svg.insert("path", ".graticule")
			  .datum(topojson.feature(world, world.objects.land))
			  .attr("class", "land")
			  .attr("d", path);

	  svg.insert("path", ".graticule")
			  .datum(topojson.mesh(world, world.objects.countries, function(a, b) { return a !== b; }))
			  .attr("class", "boundary")
			  .attr("d", path);
	});
    populateMap();
}

function populateMap() {
    if (typeof points === "undefined") {
        window.setTimeout(populateMap, 2000);
    } else {
        renderPoints();
    }
}

function renderPoints() {
    rendered = false;
    clearWhenReady();
    var lats = points.lat;
    var lons = points.lon;
    var colors = points.colors;
    for (i = 0; i < lats.length; i++) { 
        var coords = projection([lons[i], lats[i]]);
        svg.append('circle')
		    .attr('cx', coords[0])
		    .attr('cy', coords[1])										
            .attr('r', 2)
			.style('fill', colors[i]);
    }
    rendered = true;
}

function clearWhenReady() {
    if (!rendered) {
        window.setTimeout(clearWhenReady, 2000);  
    } else {
        $('#location_ui').empty();
        points = undefined;
    }
}

function colorLabels() {
    var mapcolors =  ["#A6CEE3", "#3384BA", "#86C096", "#6BBC55", "#849D58", "#F47878", "#E52C25", "#FCB86B", "#FE8A14", "#DBA08E", "#9875B6", "#A18499", "#EDDA7F", "#AE6233", "#8FC9BB", "#E5F5B7", "#D6D3CB", "#DB9EA7", "#D29092", "#97B1BE", "#FAB562", "#BBD968", "#E9D1C4", "#E7D4DD", "#CCB1CC", "#C09FBF", "#D3EBB8", "#FFED6F"];

    
    $('#locgenres label.checkbox span').each(function(i) {
      this.style.color=mapcolors[i]; 
    });
}



