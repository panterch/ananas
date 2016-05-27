$(document).ready(function(){

  if (0 === $('#events').length) { return; }

  var dayIndex = 0,
      monthIndex = 0,
      months = $('.month'),
      days = $('.day'),
      previousPositons = [],
      previousPositonsDays = [],
      leftMarginMonth = $('.month').position().left;
      leftMarginDay = $('.day').position().left
      currentPosition = $(window).scrollTop();

  checkTime();

  $(window).resize(function() {
    leftMarginMonth = $('.month').last().position().left;
    leftMarginDay = $('.day').last().position().left;

    months.each(function(index, element) {
      $(element).css('left', leftMarginMonth + 'px');
    });

    days.each(function(index, element) {
      $(element).css('left', leftMarginDay + 'px');
    });
  });

  $('html, body').animate({
    scrollTop: $("#today").offset().top + 140
  }, 1000);

  months.each(function(index, element) {
    previousPositons[index] = $(element).offset().top;
    $(element).css('left', leftMarginMonth + 'px');
  });

  days.each(function(index, element) {
    previousPositonsDays[index] = $(element).offset().top;
    $(element).css('left', leftMarginDay + 'px');
  });

  previousPositons.forEach(function(position, index) {
    if (position >= $(window).scrollTop() && monthIndex === 0) {
      monthIndex = (index - 1);
      months.eq(monthIndex).addClass('fixed-month');
    }
  });

  previousPositonsDays.forEach(function(position, index) {
    if (position >= $(window).scrollTop() && dayIndex === 0) {
      dayIndex = (index - 1);
      days.eq(dayIndex).addClass('fixed-day');
    }
  });

  // Month scroll function;
  $(window).scroll(function() {
    var currentElement = calculateDistance(months.eq(monthIndex)),
        nextElement = calculateDistance(months.eq(monthIndex + 1)),
        previousElement = calculateDistance(months.eq(monthIndex - 1));

    if (currentElement < 80 && monthIndex === 0) {
      months.eq(monthIndex).addClass('fixed-month').css('left', leftMarginMonth + 'px');
    }

    if ($(window).scrollTop() < previousPositons[monthIndex-1]) {
      months.eq(monthIndex).removeClass('fixed-month');
      monthIndex -= 1;
      months.eq(monthIndex).addClass('fixed-month').css('left', leftMarginMonth + 'px');
    }

    if (nextElement < 110) {
      previousPositons[monthIndex] = $(window).scrollTop();
      months.eq(monthIndex).removeClass('fixed-month');
      monthIndex += 1;
      months.eq(monthIndex).addClass('fixed-month').css('left', leftMarginMonth + 'px');
    }

    if ($(window).scrollTop() <= 224) {
      months.eq(monthIndex).removeClass('fixed-month');
      days.eq(monthIndex).removeClass('fixed-day');
    }

    // Day scrolling function
    var currentDayElement = calculateDistance(days.eq(dayIndex)),
        nextDayElement = calculateDistance(days.eq(dayIndex + 1));

    if (currentDayElement < 80 && dayIndex === 0) {
      days.eq(dayIndex).addClass('fixed-day').css('left', leftMarginDay + 'px');
      checkTime();
    }

    if ($(window).scrollTop() < previousPositonsDays[dayIndex-1]) {
      days.eq(dayIndex).removeClass('fixed-day');
      dayIndex -= 1;
      days.eq(dayIndex).addClass('fixed-day').css('left', leftMarginDay + 'px');
      checkTime();
    }

    if (nextDayElement <= 151) {
      previousPositonsDays[dayIndex] = $(window).scrollTop();
      days.eq(dayIndex).removeClass('fixed-day');
      dayIndex += 1;
      days.eq(dayIndex).addClass('fixed-day').css('left', leftMarginDay + 'px');
      checkTime();
    }
  });

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
  }

  function calculateDistance(element) {
    if (!element) { return $(window).scrollTop(); }
    var scrollTop     = $(window).scrollTop(),
        elementOffset = element.offset().top,
        distance      = (elementOffset - scrollTop);

    return distance;
  }
});
