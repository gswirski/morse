$(document).ready(function() {
  syntax = $('#paste_syntax');
  
  $('#paste_name').keyup(function(e) {
    $('#syntax_based_on_filename').remove();
    if ($(this).val()) {
      syntax.prepend('<option id="syntax_based_on_filename" value="">Language based on filename</option>');
      syntax.val('');
    }
  });
});