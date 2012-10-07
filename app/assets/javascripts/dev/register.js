$(function(){

  // 注册验证
  $('form').validate({
    rules: {
      'user[name]': {
        requird: true
      },
      'user[email]': {
        required: true,
        email:true
      },
      'user[password]': {
        required: true
      }
    },
    messages: {
      'user[name]': {
        required: '请输入名字'
      },
      'user[email]': {
        required: '请输入邮箱',
        email: '邮箱格式不正确'
      },
      'user[password]': {
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

