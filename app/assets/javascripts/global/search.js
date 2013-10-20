tags = [];
var name, current_location;
specialitySearch = function () {
	$.ajax({
		url: '/search/',
		dataType: 'script',
		data: {
			'search[name]' : name,
			'search[tags]' : tags,
			'search[location]' : current_location,
		},
		success: function (data) {
			console.log(data);
		}
	});
};

function addTag(value) {
	if (tags.indexOf(value) === -1) { tags.push(value); }
	specialitySearch();
}
function removeTag(value) {
	if (tags.indexOf(value) !== -1) {
		tags.splice(tags.indexOf(value), 1);
	}
	specialitySearch();
}
function setName(value) {
	name = value;
	specialitySearch();
}
function setLocation(value) {
	current_location = value;
	specialitySearch();
}