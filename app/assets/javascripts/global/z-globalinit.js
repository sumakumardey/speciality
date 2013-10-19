var searchTag,
	searchRestaurant;
(function ($) {
	searchTag = function (name) {
		$.ajax({
			url: '/tags/search',
			data: { 'tag[name]' : name },
			success: function (data) {
				console.log(data);
			}
		});
	};
	searchRestaurant = function (name) {
		$.ajax({
			url: '/restaurants/search',
			data: { 'restaurant[name]' : name },
			success: function (data) {
				console.log(data);
			}
		});
	};
	$(document).ready(function () {
		$('.tags_autocomplete').select2({
			placeholder: "Enter tags",
			tags: true,
			tokenSeparators: [",", " "],
			createSearchChoice: function(term, data) {
				if ($(data).filter(function() {
					return this.text.localeCompare(term) === 0;
				}).length === 0) {
					return {
						id: term,
						text: term
					};
				}
			},
			multiple: true,
			ajax: {
					url: '/tags/search.json',
					dataType: "json",
					quietMillis: 1000,
					data: function (term) { 
						return {
							'tag[name]': term
						};
					},
					results: function (data) {
						return { results: data };
					}
			}
		});
		
	});
}(jQuery));