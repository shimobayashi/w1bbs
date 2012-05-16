$(function() {
  $('#new_message')
    .live('ajax:success', function(event, data, status, xhr) {
      var form = $(this);
      form.find('.validation-error').empty();
      form.find('#message_body').val('');
      var dl = form.parent().find('dl');
      dl.append(xhr.responseText);
    })
    .live('ajax:error', function(event, xhr, status, error) {
      var form = $(this);
      var errors, errorText;

      try {
        errors = $.parseJSON(xhr.responseText);
      } catch (e) {
        errors = {message: "Something wrong!"};
      }

      errorText = $('<ul/>');
      for (error in errors) {
        errorText.append($('<li/>').text(error + ':' + errors[error]));
      }

      form.find('.validation-error').html(errorText);
    });
});
