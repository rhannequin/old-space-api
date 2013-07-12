(function ($) {
  'use strict';

  var $attributes = $('.attribute');
  $attributes.find('h4').on('click', function () {
    var $parent = $(this).parent();
    var $children = $parent.find('> .attribute');
    if($children.is(':visible')) {
      $children.hide();
    } else {
      $children.show();
    }
  });

})(jQuery);