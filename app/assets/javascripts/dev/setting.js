$(function(){

  $('form').validate({
    errorPlacement: function(label, el){
      el.siblings('p.tips').append(label);
    },
    success: function(label){
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
    var tags = $('#tag_ids'),
        $this = $(this),
        tag = $this.data('id');
    if(tags.val().length ==0){
      var target = [];
    }else{
      var target = tags.val().split(',');
    }
    var _exist = $.inArray(tag, target);
    if($this.hasClass('choose')){
      if(_exist >= 0){
        target.splice(_exist, 1);
      }
      $this.removeClass('choose');
    }else{
      if(_exist < 0){
        target.push(tag);
      }
      $this.addClass('choose');
    }
    tags.val(target.join(','));
  });

});

