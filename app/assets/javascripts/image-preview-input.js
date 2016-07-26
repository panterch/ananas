// dynamic code for app/inputs/image_preview_input.rb
//
// previews images immediatelly after upload
function initImagePreviewInput() {

    function readURL() {
        if (this.files && this.files[0]) {
            var name = this.name;
            var reader = new FileReader();

            reader.onload = function (e) {
                $('img[name="' + name + '"]')
                    .attr('src', e.target.result);
            };
            reader.readAsDataURL(this.files[0]);
        }
    }

    var elements = $('input.image_preview[type=file]');
    elements.each(function() {
        var $inputFile = $(this);
        var $labelFile = $inputFile.siblings('label[for='+$inputFile.attr('id')+']');
        var $wrapper = $inputFile.parents('div.image_preview');
        var $inputSubmit = $wrapper.find('input[type=submit]');
        console.log($labelFile);
        // register preview
        $inputFile.change(readURL);
        // there is a submit button rendered next to the
        // file upload which can be hidden till the upload
        // happended
        $inputSubmit.addClass('hide');
        $inputFile.change(function() {
            $labelFile.addClass('hide');
            $inputFile.addClass('hide');
            $inputSubmit.parent().removeClass('hide');
        });
    });

}

$(document).on('ready page:change', initImagePreviewInput);

