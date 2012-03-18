$(function(){

  // 表单认证
  $('.edit_user').validate({
    rules: {
      'user_email': {
        required: true,
        email:true
      },
      'user_name': {
        required: true
      }
    },
    messages: {
      'user_email': {
        required: '请输入邮箱',
        email: '邮箱格式不正确'
      },
      'user_name': {
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

  // 重置密码
  $('#getpwd').validate({
    rules: {
      '_old_password': {
        required: true,
        minlength: 5
      },
      '_new_password': {
        required: true,
        minlength: 5
      },
      '_new_password_confirm': {
        required: true,
        minlength: 5,
        equalTo: '#new_password'
      }
    },
    messages: {
      '_old_password': {
        required: '请输入原密码',
        minlength: '密码必须大于5个字符'
      },
      '_new_password': {
        required: '请输入新密码',
        minlength: '密码必须大于5个字符'
      },
      '_new_password_confirm': {
        required: '请输入新密码',
        minlength: '两次输入不同'
      }
    },
    errorPlacement: function(label, el){
      el.siblings('p.tips').append(label).children(':not(label)').hide();
    },
    success: function(label){
      label.siblings().show();
      label.remove();
    }
  });

});

