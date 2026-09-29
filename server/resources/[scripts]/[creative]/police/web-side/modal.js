$(document).ready(function() {
  $('a.inline_modal').click(function() {
    $('#modal').fadeIn().css({ 'width': Number( 300 ) }).prepend('<a href="#" class="close">close</a>');
    var popMargTop = ($('#modal').height()) / 2;
    var popMargLeft = ($('#modal').width()) / 2;
    $('#modal').css({
      'margin-top' : -popMargTop,
      'margin-left' : -popMargLeft
    });
    $('body').append('<div id="fade"></div>');
    $('#fade').css({'filter' : 'alpha(opacity=50)'}).fadeIn();
  });
  $('a.close, #fade').live('click', function() { 
    $('#fade , .popup_block').fadeOut(function() {
      $('#fade, a.close').remove();
    });
  });
});