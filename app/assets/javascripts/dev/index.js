$(function () {
  // home
  $('.banner li:eq(4)').after('<li class="intro"><p>笔记自然，发现植物之趣</p></li>');

  // search
  $('#search-link').click(function(){
    $('#search').toggle();
  });

  // plants' name
  $('.p-lists li, .p-slide ul li').hover(function () {
    $(this).find('.p-top').fadeTo(400, 0.8);
    $(this).find('img').fadeTo(400, 0);
  }, function () {
    $(this).find('.p-top').fadeTo(400, 0);
    $(this).find('img').fadeTo(400, 1);
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

});