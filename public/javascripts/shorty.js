/* DO NOT MODIFY. This file was compiled Thu, 05 May 2011 10:14:26 GMT from
 * /Users/shooley/Desktop/Organ/Programming/Ruby/javascriptstuff/app/coffeescripts/shorty.coffee
 */

(function() {
  $(document).ready(function() {
    var preview;
    preview = $("#preview-url");
    return $('#url_url').keyup(function() {
      var current_value;
      current_value = $.trim(this.value);
      if (current_value === '') {
        return preview.hide().attr('src', '');
      } else {
        return preview.show().attr('src', current_value);
      }
    });
  });
}).call(this);
