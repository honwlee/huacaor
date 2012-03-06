$(function () {
  //home
  $('.banner li:eq(4)').after('<li class="intro"><p>笔记自然，发现植物之趣</p></li>');

  //search
  $('#search-link').click(function(){
    $('#search').toggle();
  });

  //plants' name
  $('.p-lists li').hover(function () {
    $(this).find('.p-top').fadeTo(400, 0.8);
    $(this).find('img').fadeTo(400, 0);
  }, function () {
    $(this).find('.p-top').fadeTo(400, 0);
    $(this).find('img').fadeTo(400, 1);
  });


});