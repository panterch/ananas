function modalInit() {
  var $modal = $('#modal');
  var $form = $modal.find('form');

  initMaterialize();

  $modal.find(".modal-close").on('click.close', function() {
    $modal.closeModal();
  });

  $form.find('[type=submit]').hide();

  $form.data('remote', true);
  $modal.find('.modal-submit').on('click', function() {
    $form.submit();
  });
}
