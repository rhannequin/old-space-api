(function ($) {
  'use strict';

  var $attributes = $('.attribute');
  var $buttons = $attributes.find('button');
  var $h4 = $attributes.find('h4');
  var clickHandler = function() {
    var $mainParent = $(this).parents('.attribute');
    var $children = $mainParent.find('> .attribute');
    var $buttonIcon = $mainParent.find('button').find('i');
    if($children.is(':visible')) {
      $children.hide();
      $buttonIcon.removeClass('icon-chevron-down').addClass('icon-chevron-right');
    } else {
      $children.show();
      $buttonIcon.removeClass('icon-chevron-right').addClass('icon-chevron-down');
    }
  };
  $h4.on('click', clickHandler);
  $buttons.on('click', clickHandler);

})(jQuery);