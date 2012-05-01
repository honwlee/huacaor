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
                       '<button type="submit" id="save-descrption">保存</button></div>');
      description.hide();
    }else{
      $(this).text('[编辑]');
      $('#description').remove();
      description.show();
    }
    
    $('#save-descrption').click(function(){
      var by = $(this);
      description.html(by.prev().val()).show();
      by.parent().remove();
      $(this).text('[编辑]');
    });
    // 此处应为ajax，求后台数据支援
  });

});