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
			tokenSeparators: [","],
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
			minimumInputLength: 1,
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
			},
			initSelection: function(element, callback) {
				var data = [];
				var val = $(element).data('value');
				
				$(element).val("");
				
				if(val){
					$(val.split(",")).each(function () {
						data.push({id: this, text: this});
					});
				}

				callback(data);
			}
		});

		$('.restaurant_autocomplete').select2({
			placeholder: "Enter tags",
			minimumInputLength: 1,
			multiple: false,
			ajax: {
					url: '/restaurants/search.json',
					dataType: "json",
					quietMillis: 1000,
					data: function (term) { 
						return {
							'restaurant[name]': term
						};
					},
					results: function (data, page, query) {
						if (!data.length) {
							data = [{ id :query.term, text: query.term}];
						}
						return { results: data };
					}
			},
			initSelection: function(element, callback) {
				var id = $(element).val(),
					text = $(element).data('text');

				callback({ id: id, text: text});
			}
		});
	});
}(jQuery));