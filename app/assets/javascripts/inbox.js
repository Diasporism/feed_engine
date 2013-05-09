$(document).ready(function(){
  var showChar = 100;
  var ellipsestext = "...";
  var moretext = "more";
  var lesstext = "less";
  $('p.message').each(function() {
    var content = $(this).html();

    if(content.length > showChar) {

      var shortened = content.substr(0, showChar);
      var more_content = content.substr(showChar, content.length - showChar);

      var html = shortened + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + more_content + '</span>&nbsp;&nbsp;<a href="" class="toggle_content">' + lesstext + '</a></span>';
      var test = shortened + '</span>&nbsp;&nbsp;<a href="" class="toggle_content">' + moretext + '</a></span>';

      $(this).html(html);
      $('this').prev().toggle();
    }
  });

  $(".toggle_content").click(function(){
    if($(this).hasClass("less")) {
        $(this).removeClass("less");
        $(this).html(lesstext);
    } else {
        $(this).addClass("less");
        $(this).html(moretext);
    }
    $(this).parent().prev().toggle(); //elipse toggle
    $(this).prev().toggle();      //morecontent toggle
    return false;
  });
});
