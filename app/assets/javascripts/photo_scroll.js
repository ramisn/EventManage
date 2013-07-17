$(document).ready(function(){
  $('.photos').each(function () {
    var photo_carousel = $(this);
    photo_carousel.on('init', function()
    {
      var slide_photo_block = $(photo_carousel).find('.photo-carousel-cointainer > *');
      var slide_item_count = slide_photo_block.children().length;
      var slide_item_width = slide_photo_block.children().first().outerWidth(true);
      var slide_photo_block_left = slide_photo_block.css('left') === "auto" ? 0 : parseInt(slide_photo_block.css('left'), 10);
      $(slide_photo_block).css('width', slide_item_count * slide_item_width);
      slide_photo_block.css('left', slide_photo_block_left);

      if (slide_photo_block_left + slide_photo_block.width() <= slide_item_width) {
        photo_carousel.find('.scroll-left').hide();
        photo_carousel.find('.scroll-right').hide();
      } else {
        photo_carousel.find('.scroll-left').hide();
        photo_carousel.find('.scroll-right').show();
      }

      photo_carousel.find('.scroll-left').on('click', function () {
        if (!$(slide_photo_block).is(":animated")) {
          var new_left = parseInt(slide_photo_block.css('left'), 10) + slide_item_width;
          if (new_left <= 0) {
            $(slide_photo_block).animate({'left': new_left+'px'}, 300);
            photo_carousel.find('.scroll-right').show();
            if (new_left === 0) {
              $(this).hide();
            }
          }
        }
      });

      photo_carousel.find('.scroll-right').on('click', function () {
        if (!$(slide_photo_block).is(":animated")) {
          var slide_photo_block_left = parseInt(slide_photo_block.css('left'), 10);
          var new_left = slide_photo_block_left - slide_item_width;
          if ((new_left * -1) < (slide_photo_block.width())) {
            $(slide_photo_block).animate({'left': new_left+'px'}, 300);
            photo_carousel.find('.scroll-left').show();
            if (new_left + slide_photo_block.width() <= slide_item_width) {
              $(this).hide();
            }
          }
        }
      });

    });

    photo_carousel.trigger('init');
    
  });
});
