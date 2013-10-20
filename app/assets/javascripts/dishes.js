// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function () {
	$(".write_review").on('click', function(ev) {
		ev.preventDefault();

		$('html, body').animate({
			scrollTop: $(".reviews_comment").offset().top
		}, 2000);
	});
});
function showLocationOnMap(latitude,longitude) {
	var myLatlng = new google.maps.LatLng(latitude,longitude) ;
	var mapOptions = {
		zoom: 14,
		center: myLatlng,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}
	console.log("inside intialize")
	var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
	console.log("inside intializer map-canvas")
	var marker = new google.maps.Marker({
		position: myLatlng,
		map: map,
		title: 'Hello World!'
	});
	console.log("here");
	console.log(myLatlng);
}