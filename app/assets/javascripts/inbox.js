$(document).ready(function(){
  var showChar = 200;
  var ellipsestext = "...";
  var moretext = "more";
  var lesstext = "less";
  $('.message').each(function() {
    var content = $(this).text();

    if(content.length > showChar) {

      var shortened = content.substr(0, showChar);
      var more_content = content.substr(showChar, content.length - showChar);

      var html = shortened + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + more_content + '</span>&nbsp;&nbsp;</span><a href="" class="toggle_content">' + moretext + '</a>';

      $(this).html(html);
      $('.morecontent').hide();
    }
  });

  $(".toggle_content").click(function() {
    if($(this).hasClass("less")) {
      $(this).removeClass("less");
      $(this).html(moretext);
    } else {
      $(this).addClass("less");
      $(this).html(lesstext);
    }
    $(this).prev().prev().slideToggle();            //elipse toggle
    $(this).prev().slideToggle('slow');        //morecontent toggle
    return false;
  });
});
