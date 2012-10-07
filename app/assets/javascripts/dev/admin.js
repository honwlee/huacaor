$(function(){

  // hide notice
  $('#flash-notice').delay(3000).fadeOut('slow');

  // 表单认证
  $('form').validate({
    errorPlacement: function(label, el){
      el.siblings('p.tips').append(label);
    },
    success: function(label){
      label.remove();
    }
  });


});

