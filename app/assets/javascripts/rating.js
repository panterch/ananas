function initStarRating() {
  $('.new_rating').find('.js-star-rating').each(function() {
    var input_wrapper = $(this).parent('.input-field');

    var html = '';
    for(var i = 1; i <= 5; i++) {
      html += '<i class="material-icons js-rating-star" data-value="' + i + '">star_border</i>';
    }

    input_wrapper.append($(html));

    input_wrapper.find('.js-rating-star')
      .mouseover(function() {
        var value = $(this).data('value');
        input_wrapper.find('.js-rating-star').removeClass('active').each(function() {
          if ($(this).data('value') <= value) {
            $(this).html('star');
          }
          else {
            $(this).html('star_border');
          }
        });
      })
      .click(function() {
        input_wrapper.find('.js-rating-star').removeClass('active');
        $(this).addClass('active');
      });

      input_wrapper.mouseout(function() {
        if (input_wrapper.find('.js-rating-star.active').length === 0) {
          input_wrapper.find('.js-rating-star').html('star_border');
        }
      });
  });
}

$(document).on('page:change', initStarRating);
