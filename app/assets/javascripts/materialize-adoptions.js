$(document).on('ready page:change',function() {
    $('form.simple_form .datepicker').pickadate();

    // collect splitted up date and time values and submit them in one
    // datetime field. see simple_form_materialze.rb
    $('form.simple_form').submit(function() {
        $('div.input.datetime').each(function() {
            var $wrapper = $(this);

            var $date = $wrapper.find('.date input.datepicker');
            var $time = $wrapper.find('.time input.timepicker');

            var datetime = $date.val() + ' ' + $time.val();
            console.log(datetime);
            $wrapper.find('input[type=hidden]').val(datetime);
        });
    });

    $(".dropdown-button").dropdown();

})

