$(function(){

  // 登录验证
  $('#loginform').validate({
    rules: {
      'login': {
        required: true,
        email:true
      },
      'password': {
        required: true
      }
    },
    messages: {
      'login': {
        required: '请输入邮箱',
        email: '邮箱格式不正确'
      },
      'password': {
        required: '请输入密码'
      }
    },
    errorPlacement: function(label, el){
      el.siblings('p.tips').append(label);
    },
    success: function(label){
      label.remove();
    }
  });

  // 忘记密码验证
  $('#forgot-pwd-form').validate({
    rules: {
      'login': {
        required: true,
        email:true
      }
    },
    messages: {
      'login': {
        required: '请输入邮箱',
        email: '邮箱格式不正确'
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

