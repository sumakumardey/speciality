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
		var MyEngine = {
			compile: function(template) {
				return {
					render: function(context) {
						return template.replace(/\{\{\s*(\w+)\s*\}\}/g,
						function(match, p1) {
							return jQuery('<div/>').text(context[p1] || '').html();
						});
					}
				}
			}
		};
		$( "#search_speciality" ).typeahead([
		{
			name: 'dishes',
			remote: {
				url: '/dish_autocompleter/?search=%QUERY',
				filter: function(response){
					return response.dishes.data;
				},
				cache: false
			},
			header: '<h5 class="section-title">Dishes</h5>',
			template: '<p>{{ value }}</p>',
			engine: MyEngine,
			timeout: 1000
		},
		{
			name: 'tags',
			remote: {
				url: '/tag_autocompleter/?search=%QUERY',
				filter: function(response){
					return response.tags.data;
				},
				cache: false
			},
			header: '<h5 class="section-title">Tags</h5>',
			template: '<p>{{ value }}</p>',
			engine: MyEngine,
			timeout: 1000
		},
		{
			name: 'places',
			remote: {
				url: '/place_autocompleter/?search=%QUERY',
				filter: function(response){
					return response.places.data;
				},
				cache: false
			},
			header: '<h5 class="section-title">Places</h5>',
			template: '<p>{{ value }}</p>',
			engine: MyEngine,
			timeout: 1000
		}
		]);
		
		$('.front_component').mouseenter(function() {
			var parent = $(this).parent();
			$(this).fadeOut(100,function() { 
				parent.find('.back_component').fadeIn(100);
			});
		});
		$('.back_component').mouseleave(function() {
			var parent = $(this).parent();
			$(this).fadeOut(100,function() {
				parent.find('.front_component').fadeIn(100); 
			});
		});
  
		$('#login').popover({
			html : true,
			animation : true,
			content : 'hello'
		});
	
	});
}(jQuery));