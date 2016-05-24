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

    Materialize.updateTextFields();
}

$(document).on('ready page:change', initMaterialize);
