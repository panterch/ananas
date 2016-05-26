$(document).ready(function(){

  if (0 == $('#events').length) { return; }

  var dayIndex = 0,
      index = 0,
      months = $('.month'),
      days = $('.day'),
      previousPositons = [],
      previousPositonsDays = [],
      leftMarginMonth = $('.month').position().left;
      leftMarginDay = $('.day').position().left;

  // Month scroll function;
  $(window).scroll(function() {
    var currentElement = calculateDistance(months.eq(index)),
        nextElement = calculateDistance(months.eq(index + 1)),
        previousElement = calculateDistance(months.eq(index - 1));

    if (currentElement < 80 && index === 0) {
      months.eq(index).addClass('fixed-month').css('left', leftMarginMonth + 'px');
    }

    if ($(window).scrollTop() < previousPositons[index-1]) {
      months.eq(index).removeClass('fixed-month');
      index -= 1;
      months.eq(index).addClass('fixed-month').css('left', leftMarginMonth + 'px');
    }

    if (nextElement < 110) {
      previousPositons[index] = $(window).scrollTop();
      months.eq(index).removeClass('fixed-month');
      index += 1;
      months.eq(index).addClass('fixed-month').css('left', leftMarginMonth + 'px');
    }

    if ($(window).scrollTop() <= 224) {
      months.eq(index).removeClass('fixed-month');
      days.eq(dayIndex).removeClass('fixed-day');
    }

    // Day scrolling function
    var currentDayElement = calculateDistance(days.eq(dayIndex)),
        nextDayElement = calculateDistance(days.eq(dayIndex + 1));

    if (currentDayElement < 80 && dayIndex === 0) {
      days.eq(dayIndex).addClass('fixed-day').css('left', leftMarginDay + 'px');
    }

    if ($(window).scrollTop() < previousPositonsDays[dayIndex-1]) {
      days.eq(dayIndex).removeClass('fixed-day');
      dayIndex -= 1;
      days.eq(dayIndex).addClass('fixed-day').css('left', leftMarginDay + 'px');
    }

    if (nextDayElement <= 151) {
      previousPositonsDays[dayIndex] = $(window).scrollTop();
      days.eq(dayIndex).removeClass('fixed-day');
      dayIndex += 1;
      days.eq(dayIndex).addClass('fixed-day').css('left', leftMarginDay + 'px');
    }
  });

  function calculateDistance(element) {
    var scrollTop     = $(window).scrollTop(),
        elementOffset = element.offset().top,
        distance      = (elementOffset - scrollTop);

    return distance;
  }
});
