var searchTag,
	searchRestaurant,
	NO_RESULT_TEXT,
	NO_RESULT_TEXT_ARRAY = [],
	SEARCH_TYPE_MAPPING,
	searchPage = false;
NO_RESULT_TEXT = {
	tag: "No tags found",
	place: "No place found",
	dish: "No dishes found"
}
SEARCH_TYPE_MAPPING = {
	tags: 'tags',
	places: 'location',
	dishes: 'name'
}
for (var text in NO_RESULT_TEXT) {
	NO_RESULT_TEXT_ARRAY.push(NO_RESULT_TEXT[text]);
}
(function ($) {
	$('body').ready(function(){
	$('#current_city').popover(
		{
			placement : "bottom",
			trigger : 'hover',
			content : "We are currently taking over restaurant reviews here in SFO. Feel free to add any local dishes and join the community"
		});

	$('.back_component').css('cursor','pointer');
	$('.back_component').click(function()
		{
			
			var link = $($(this).find('a')[0]);
			window.location.href = link.attr('href');
		});
	});

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
			placeholder: "Enter tags for your dish",
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
			placeholder: "What was the name of the restaurant?",
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
					return response.dishes.data.length ? response.dishes.data : [NO_RESULT_TEXT.dish] ;
				},
				cache: false
			},
			header: '<div class="section-title" ><h5 style="text-align : center;color:#838383;">ITEMS</h5></div>',
			template: '<p>{{ value }}</p>',
			engine: MyEngine,
			timeout: 1000
		},
		{
			name: 'tags',
			remote: {
				url: '/tag_autocompleter/?search=%QUERY',
				filter: function(response){
					return response.tags.data.length ? response.tags.data : [NO_RESULT_TEXT.tag] ;
				},
				cache: false
			},
			header: '<div class="section-title" ><h5 style="text-align : center;color:#838383;">TAGS</h5></div>',
			template: '<p>{{ value }}</p>',
			engine: MyEngine,
			timeout: 1000
		},
		{
			name: 'places',
			remote: {
				url: '/place_autocompleter/?search=%QUERY',
				filter: function (response) {
					return response.places.data.length ? response.places.data : [NO_RESULT_TEXT.place] ;
				},
				cache: false
			},
			header: '<div class="section-title"><h5 style="text-align : center;color:#838383;">PLACES</h5></div>',
			template: '<p>{{ value }}</p>',
			engine: MyEngine,
			timeout: 1000
		}
		]).bind('typeahead:selected', function (obj, datum, dataset) {
			if ( $.inArray(datum.value, NO_RESULT_TEXT_ARRAY) > -1) {
				$(obj.currentTarget).val('');
				return false;
			}
			if (searchPage) {
				if (SEARCH_TYPE_MAPPING[dataset] === 'tags') {
					addTag(datum.value);
				} else if (SEARCH_TYPE_MAPPING[dataset] === 'name') {
					setName(datum.value);
				} else if (SEARCH_TYPE_MAPPING[dataset] === 'location') {
					setLocation(datum.value);
				}
			} else {
				window.location = '/search?search%5B' + SEARCH_TYPE_MAPPING[dataset] + '%5D=' + datum.value;
			}
		});

		$('.front_component').live('mouseenter', function () {
			var parent = $(this).parent();
			$(this).fadeOut(100, function () { 
				parent.find('.back_component').fadeIn(100);
			});
		});
		$('.back_component').live('mouseleave', function () {
			var parent = $(this).parent();
			$(this).fadeOut(100, function () {
				parent.find('.front_component').fadeIn(100); 
			});
		});

	});
}(jQuery));