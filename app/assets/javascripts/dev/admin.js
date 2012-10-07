$(function(){

  // hide notice
  $('#flash-notice').delay(3000).fadeOut('slow');

  // 表单认证
  $('.edit_tag, #new_tag').validate({
    rules: {
      'tag[name]': {
        required: true
      },
      'tag[css_name]': {
        required: true
      }
    },
    messages: {
      'tag[name]': {
        required: '请输入名称'
      },
      'tag[css_name]': {
        required: '请输入样式标识'
      }
    },
    errorPlacement: function(label, el){
      el.siblings('p.tips').append(label);
    },
    success: function(label){
      label.remove();
    }
  });

  // 表单认证
  $('.edit_user').validate({
    rules: {
      'user[user_email]': {
        required: true,
        email:true
      },
      'user[user_name]': {
        required: true
      }
    },
    messages: {
      'user[user_email]': {
        required: '请输入邮箱',
        email: '邮箱格式不正确'
      },
      'user[user_name]': {
        required: '请输入名字'
      }
    },
    errorPlacement: function(label, el){
      el.siblings('p.tips').append(label);
    },
    success: function(label){
      label.remove();
    }
  });

});

