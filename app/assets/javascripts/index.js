$(function () {
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