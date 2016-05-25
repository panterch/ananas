function initMaterialize() {
    $('form .datepicker').pickadate();

    // collect splitted up date and time values and submit them in one
    // datetime field
    $('form').submit(function() {
        $('div.row.datetime').each(function() {
            var $wrapper = $(this);

            var $date = $wrapper.find('.date input.datepicker');
            var $time = $wrapper.find('.time input.timepicker');

            var datetime = $date.val() + ' ' + $time.val();
            $wrapper.find('input[type=hidden]').val(datetime);
        });
    });

    // remove rails error messages once in an errorous field typed
    $('.input-field.has_error input').one('keypress', function() {
        $(this).siblings('p.error-block').css('visibility', 'hidden');
    });

    $(".dropdown-button").dropdown();
    $('label.select').addClass('active');
    $('select').material_select();
    $('.parallax').parallax();

    Materialize.updateTextFields();

    if (!!$('.alert').length) {
      $('.alert').each(function (index, element) {
        var message = '';
        if ($(element).hasClass('alert-info')) {
          message += '<i class="material-icons alert-info">lightbulb_outline</i>';
        } else if ($(element).hasClass('alert-danger')) {
          message += '<i class="material-icons alert-danger">warning</i>';
        }
        message += $(element).text();
        element.remove();
        Materialize.toast(message, 3000);
      });
    }

    // when collapbisle contains links, they should be used for navigation
    // and not trigger an (un)collapse
    $('ul.collapsible a').click(function(event) {
        event.stopPropagation();
    });
}

$(document).on('ready page:change', initMaterialize);
