function initStarRating() {
  $('.new_rating').find('.js-star-rating').each(function() {
    var input = $(this);
    var input_wrapper = input.parent('.input-field');

    var html = '';
    for(var i = 1; i <= 5; i++) {
      html += '<i class="material-icons rating-star js-rating-star" data-value="' + i + '">star_border</i>';
    }

    input_wrapper.append($(html));

    var stars = input_wrapper.find('.js-rating-star');

    var markStars = function(currentStar) {
      var value = currentStar.data('value');

      stars.each(function() {
        var star = $(this);
        if (star.data('value') <= value) {
          star.html('star');
        }
        else {
          star.html('star_border');
        }
      });
    };

    input_wrapper
      .on('mouseover', '.js-rating-star', function() {
        markStars($(this));
      })
      .on('click', '.js-rating-star', function() {
        var star = $(this);
        stars.removeClass('active');
        star.addClass('active');
        markStars(star);
        // disable the hover effect, as it makes
        // keeping the currently selected star
        // difficult
        input_wrapper.off('mouseover');

        input.val(star.data('value'));
      });

      // clear the selection when no star has been clicked
      input_wrapper.mouseout(function() {
        if (stars.filter('.active').length === 0) {
          stars.html('star_border');
        }
      });
  });
}

$(document).on('page:change', initStarRating);
