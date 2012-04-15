$(function(){
  var uploadAvatar = {
    'form' : $('#upform'),
    'iframe' : window.frames['doIframe'],
    'uploading' : $('.uploading'),
    'lastResponse' : '',
    'chechkInterval' : 500,
    'checkTimeout' : undefined,
    'origin' : {},
    'pageSize' : {}
  };
  uploadAvatar.startCheck = function(){
    try{
      var response = $.trim(uploadAvatar.iframe.document.body.innerHTML);
      if(response && uploadAvatar.lastResponse !== response){
        var responseMatches = response.match(/{response}({.+?}){\/response}/);
        uploadAvatar.lastResponse = response;
        if(responseMatches){
          try{
            response = $.parseJSON(responseMatches[1]);
            uploadAvatar.endCheck();
            if(response.status){
              uploadAvatar.success(response.id, response.origin, response.page_size);
            }else{
              uploadAvatar.form[0].reset();
              alert(response.message);
              return false;
            }
          }catch(e){
            uploadAvatar.endCheck();
            alert('抱歉，出错了，请重新上传图片');
            return false;
          }
        }else{
          uploadAvatar.checkTimeout = setTimeout(uploadAvatar.startCheck, uploadAvatar.checkInterval);
        }
      }else{
        uploadAvatar.checkTimeout = setTimeout(uploadAvatar.startCheck, uploadAvatar.checkInterval);
      }
    }catch(e){
      uploadAvatar.checkTimeout = setTimeout(uploadAvatar.startCheck, uploadAvatar.checkInterval);
    }
  };
  uploadAvatar.endCheck = function(){
    $('.change-avatar').hide();
    uploadAvatar.form.hide();
    uploadAvatar.uploading.hide();
    uploadAvatar.form[0].reset();
    uploadAvatar.iframe.document.body.innerHTML = '';
    clearTimeout(uploadAvatar.checkTimeout);
  };
  uploadAvatar.success = function(id, origin, pageSize){
    uploadAvatar.endCheck();
    try{
      jcrop.destroy();
    }catch(e){
      // do nothing
    }
    $('#avatar_id').val(id);
    uploadAvatar.origin.src = origin.src;
    uploadAvatar.origin.width = parseInt(origin.width);
    uploadAvatar.origin.height = parseInt(origin.height);
    uploadAvatar.pageSize.src = pageSize.src;
    uploadAvatar.pageSize.width = pageSize.width;
    uploadAvatar.pageSize.height = pageSize.height;
    uploadAvatar.ratio = origin.width / pageSize.width;
    $('#crop').append(
      $('<img>', {
        width: uploadAvatar.pageSize.width,
        height: uploadAvatar.pageSize.height,
        src: uploadAvatar.origin.src
      })
    );
    $('#preview').find('img').each(function(index, img){
      $(img).attr('src', uploadAvatar.origin.src);
    });
    jcrop = $.Jcrop('#crop > img', {
      'setSelect' : [0, 0, 120, 120],
      'onChange' : previewAvatars,
      'onSelect' : previewAvatars,
      'aspectRatio' : 1,
      'minSize' : [120 /uploadAvatar.ratio, 120 / uploadAvatar.ratio]
    });
    $('#up-avatar').show();
  };
  uploadAvatar.form.find('input[type=file]').val('').change(function(){
    var fileName = $(this).val();
    if(!fileName){
      return false;
    }
    if(/\.(gif|jpg|jpeg|png)$/i.test($(this).val()) === false){
      uploadAvatar.form[0].reset();
      alert('请选择JPG、GIF、PNG格式的图片');
      return false;
    }else{
      uploadAvatar.form.submit();
      uploadAvatar.uploading.show();
      uploadAvatar.startCheck();
    }
  });

  $('input[type=file]').hover(function(){
    $('.change-avatar').css('border-bottom', '1px solid #76B130');
  }, function(){
    $('.change-avatar').removeAttr('style');
  });

  function previewAvatars(coords){
    if(parseInt(coords.w)){
      var originX = coords.x * uploadAvatar.ratio;
      var originY = coords.y * uploadAvatar.ratio;
      var normalAvatarRatio = 180 / uploadAvatar.ratio / coords.w;
      $('#preview').find('.normal > img').css({
        width : Math.round(uploadAvatar.origin.width * normalAvatarRatio) + 'px',
        height : Math.round(uploadAvatar.origin.height * normalAvatarRatio) + 'px',
        marginLeft : '-' + Math.round(originX * normalAvatarRatio) + 'px',
        marginTop : '-' + Math.round(originY * normalAvatarRatio) + 'px'
      });
    }
    $('#crop_x').val(Math.round(originX));
    $('#crop_y').val(Math.round(originY));
    $('#crop_w').val(Math.round(coords.w * uploadAvatar.ratio));
    $('#crop_h').val(Math.round(coords.h * uploadAvatar.ratio));
  }
});