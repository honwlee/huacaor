$(function () {

    $('#filedata').fileupload({
        //dataType: 'json',
        singleFileUploads: true,
        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
        done: function (e, data) {
            // $.each(data.result, function (index, file) {
            //     $('<p/>').text(file.name).appendTo($('.form'));
            // });

        },

        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10),
                bar = $('#progress .bar');
            bar.css(
                'width',
                progress + '%'
            );
            bar.html('已完成' + progress + '%');
            $('a.return').show();

        }
    });
});
