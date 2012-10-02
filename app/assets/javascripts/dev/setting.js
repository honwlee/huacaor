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

  // 添加表单项目
  $('a.add-item').live('click', function(){
    var by = $(this);
    by.parent().after('<dd><input type="text" /><a href="javascript:void(0)" class="add-item">+</a></dd>');
    by.hide();
  });

  // 获取科属
  $('ul.choose-class select').live('change',function(){
    var $this = $(this),
        target = $this.parent().next().find('select');

    $.ajax({
      cache: false,
      url: '/plant_base_info/' + $(this).val(),
      dataType: 'json',
      error: function(){
        alert('系统忙');
      },
      success: function(data){
        if(data == []){

        }else{
          target.html('<option>－－</option>');
          $.each(data, function(i){
            target.append('<option value="' + data[i].id + '">' + data[i].name.zh + '</option>');
          });
          target.parent().show();
          target.parent().nextAll().find('select').html('<option>－－</option>');
          target.parent().nextAll().hide();
        }

      }
    });
    return false;
  });


  // choose plants' characters
  $('.character a').on('click', function(){
    var tags = $('#category_tag_ids'),
        $this = $(this);
    if($this.hasClass('choose')){
      if(tags.val().length == 0){
        tags.val($this.data('id'));
      }else{
        tags.val(tags.val() + ',' + $this.data('id'));
      }
    }
  });

});

