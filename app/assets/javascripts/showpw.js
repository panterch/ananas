$(document).ready(function() {
  $('#new_user div.show-pw').bind('click', function(evt) {
    $('#new_user div.show-pw i.material-icons').toggleClass('show-pw');
    var pwfield = $('#user_password');
    switch ($(pwfield).attr('type')) {
      case ('password'):
        $(pwfield).attr('type', 'text');
        break;
      case ('text'):
        $(pwfield).attr('type', 'password');
        break;
      default:
        $(pwfield).attr('type', 'password');
        break;
    }
  });
});
