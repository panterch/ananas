// Linkify containers having attribute data-href-container
function addLinkifyContainersBehaviour() {
  var elements = $('*[data-href-container]');
  elements.each(function() {
    var element = $(this);
    var container = element.closest(element.data('href-container'));
    container.css('cursor', "pointer");
    container.addClass('linkified_container')
    var href = element.attr('href');
    element.addClass('linkified_element')

    container.delegate('*', 'click', {href: href}, function(event) {
      // Don't override original link behaviour
      if (event.target.nodeName == 'A' || $(event.target).parents('a').length > 0) {
        return;
      };

      document.location.href = href;
    });
  });
};

$(document).on('ready page:change', addLinkifyContainersBehaviour);
