// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
function initialize() {
	var myLatlng = new google.maps.LatLng("<%=@dish.location.latitude%>","<%=@dish.location.longitude%>");
	var mapOptions = {
		zoom: 11,
		center: myLatlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}
	var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

	var marker = new google.maps.Marker({
		position: myLatlng,
		map: map,
		title: 'Hello World!'
	});
}

// google.maps.event.addDomListener(window, 'load', initialize);
$(document).ready(function () {
	$(".write_review").on('click', function(ev) {
		ev.preventDefault();

		$('html, body').animate({
			scrollTop: $(".reviews_comment").offset().top
		}, 2000);
	});
});