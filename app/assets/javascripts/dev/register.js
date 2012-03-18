$(function(){

  // 注册验证
  $('#loginform').validate({
    rules: {
      'user_name': {
        requird: true
      },
      'user_email': {
        required: true,
        email:true
      },
      'user_password': {
        required: true
      }
    },
    messages: {
      'user_name': {
        required: '请输入名字'
      },
      'user_email': {
        required: '请输入邮箱',
        email: '邮箱格式不正确'
      },
      'user_password': {
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


});

