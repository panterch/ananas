$(document).ready(function(){

  if (0 === $('#events').length) { return; }

  var dayIndex = 0,
      monthIndex = 0,
      months = $('.month'),
      days = $('.day'),
      previousPositonsMonths = [],
      previousPositonsDays = [],
      leftMarginMonth = $('.month').position().left,
      leftMarginDay = $('.day').position().left,
      firstTrigger = 190;

  // Always start from top so that you get the correct element positions
  $(window).scrollTop(0);

  $(window).resize(function() {
    leftMarginMonth = $('.month').removeClass('fixed-month').position().left;
    leftMarginDay = $('.day').removeClass('fixed-day').position().left;

    months.each(function(index, element) {
      $(element).css('left', leftMarginMonth + 'px');
    });

    days.each(function(index, element) {
      $(element).css('left', leftMarginDay + 'px');
    });

    fixMonth();
    fixDay();
  });

  if ($("#today")) {
    $('html, body').animate({
      scrollTop: $("#today").offset().top + 130
    }, 1000);
  }

  months.each(function(index, element) {
    previousPositonsMonths[index] = $(element).offset().top;
    $(element).css('left', leftMarginMonth + 'px');
  });

  days.each(function(index, element) {
    previousPositonsDays[index] = $(element).offset().top;
    $(element).css('left', leftMarginDay + 'px');
  });

  // Month scroll function;
  $(window).scroll(function() {
    var currentElement = calculateDistance(months.eq(monthIndex)),
        nextElement = calculateDistance(months.eq(monthIndex + 1));

    if ($(window).scrollTop() > firstTrigger) {
      fixMonth();
      fixDay();
    }

    if ($(window).scrollTop() < previousPositonsMonths[monthIndex-1]) {
      unFixMonth();
      monthIndex -= 1;
      // The index can be negative if you scroll upwards too fast, so wa have to fix it
      if (monthIndex < 0) {
        monthIndex = 0;
      }
      fixMonth();
    }

    if (nextElement < 110) {
      previousPositonsMonths[monthIndex] = $(window).scrollTop();
      unFixMonth();
      monthIndex += 1;
      fixMonth();
    }

    // Day scrolling function
    var currentDayElement = calculateDistance(days.eq(dayIndex)),
        nextDayElement = calculateDistance(days.eq(dayIndex + 1));

    if ($(window).scrollTop() < previousPositonsDays[dayIndex-1]) {
      unFixDay();
      dayIndex -= 1;
      // The index can be negative if you scroll upwards too fast, so wa have to fix it
      if (dayIndex < 0) {
        dayIndex = 0;
      }
      fixDay();
    }

    if (nextDayElement <= 151) {
      previousPositonsDays[dayIndex] = $(window).scrollTop();
      unFixDay();
      dayIndex += 1;
      fixDay();
    }

    // Remove the fixed class if you arrive a the top
    if ($(window).scrollTop() < firstTrigger) {
      unFixMonth();
      unFixDay();
    }
  });

  function fixMonth() {
    months.eq(monthIndex).addClass('fixed-month');
  };

  function unFixMonth () {
    months.eq(monthIndex).removeClass('fixed-month');
  };

  function fixDay() {
    days.eq(dayIndex).addClass('fixed-day');
    checkTime();
  };

  function unFixDay() {
    days.eq(dayIndex).removeClass('fixed-day');
    checkTime();
  };

  function checkTime() {
    if (days.eq(dayIndex).hasClass('today')) {
      months.eq(monthIndex).removeClass('past');
      months.eq(monthIndex).removeClass('future');
      months.eq(monthIndex).addClass('today');
    };
    if (days.eq(dayIndex).hasClass('past')) {
      months.eq(monthIndex).removeClass('today');
      months.eq(monthIndex).removeClass('future');
      months.eq(monthIndex).addClass('past');
    }
    if(days.eq(dayIndex).hasClass('future')) {
      months.eq(monthIndex).removeClass('past');
      months.eq(monthIndex).removeClass('today');
      months.eq(monthIndex).addClass('future');
    }
  };

  function calculateDistance(element) {
    if (!element.length) { return $(document).height(); }
    var scrollTop     = $(window).scrollTop(),
        elementOffset = element.offset().top,
        distance      = (elementOffset - scrollTop);

    return distance;
  };
});
