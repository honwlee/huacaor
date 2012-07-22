$(function () {
  // home
  $('.banner li:eq(4)').after('<li class="intro"><p>笔记自然，发现植物之趣</p></li>');

  // search
  $('#search-link').click(function(){
    $('#search').toggle();
  });

  // choose plants' characters
  $('.choosebox a').click(function(){
    $(this).toggleClass('choose');
  });

  // show plants' name
  $('.p-lists li, .p-slide ul li').hover(function () {
    $(this).find('.p-top').fadeTo(400, 0.8);
  }, function () {
    $(this).find('.p-top').fadeTo(400, 0);
  });

  // hide notice
  $('#flash-notice').delay(3000).fadeOut('slow');

  // slide
  $('.p-slide .right-nav').live('click', function(){
    var by = $(this);
    // 先加载loading.gif图片
    // by.parent().siblings('ul').find('li').fadeTo(400, 0).html('<img src="/images/loading.gif" />');
    // 然后ajax取到下一批图片
    // 目前等待后台数据传递中
  });

  // follow
  $('a.follow').live('click', function(){
    var by = $(this);
    if (by.hasClass('ico-ui-follow')){
      by.removeClass('ico-ui-follow').addClass('ico-ui-unfollow');
    }else{
      by.removeClass('ico-ui-unfollow').addClass('ico-ui-follow');
    }
  });

  // edit photo's description
  $('.edit-description').click(function(){
    var by = $(this),
        description = $('.description'),
        text = description.text();
    if(by.text() == "[编辑]"){
      $(this).text('[取消]');
      description.after('<div id="description"><textarea class="comm-content">'+ text +'</textarea>' + 
                       '<button type="submit" id="descrption-btn">保存</button></div>');
      description.hide();
    }else{
      $('#description').remove();
      description.show();
      $(this).text('[编辑]');
    }
    
    $('#descrption-btn').click(function(){
      var by = $(this);
      description.html(by.prev().val()).show();
      by.parent().remove();
      $('.edit-description').text('[编辑]');
    });
    // 此处应为ajax，求后台数据支援
  });

  // comment
  $('#comment-btn').click(function(){
    var by = $(this),
        commBox = by.prev(),
        text = commBox.val(),
        pid = $('#comment-li').attr('rel'),
        url = '/pictures/'+ pid +'/comments';
    
    if ( text.length == 0 ){
      by.before('<b>你还没有输入内容</b>').slideUp(50);
      return false;
    }

    
    $.ajax({
      type: 'post',
      cache: false,
      url: url,
      data: {
        content: text
      },
      beforeSend: function(){
        by.attr('disabled', 'disabled').addClass('disabled');
        // $this.before('<img class="comm-load" src="' + loadingImg + '" />');
      },
      error: function(){
        by.before('<b>错误</b>').slideUp();
      },
      success: function(data){
        $(data).prependTo( by.closest('ul') ).hide().slideDown();
        commBox.val('');
      },
      complete: function(){
        by.removeAttr('disabled').removeClass('disabled');
        //$this.prev('img').remove();
      }
    });
  });



});