$(function() {
    var $window = $(window);

    // side bar
    setTimeout(function () {
        $('.sidenav').affix({
            offset: {
              top: function () { return $window.width() <= 980 ? 290 : 270; },
              bottom: 270
            }
        });
    }, 500);

    // $(".sendmail").fancybox({
    //     'transitionIn'    : 'fade',
    //     'transitionOut'   : 'fade',
    //     'speedIn'         : 600,
    //     'speedOut'        : 200,
    //     'height'          : 600,
    //     'width'           : 680,
    //     'showCloseButton' : true,
    //     'overlayShow'	 : false,
    //     'type'            : 'iframe'
    // });

    // $(".fancybox").fancybox({
    //     'speedIn'	: 600, 
    //     'speedOut'	:  200, 
    //     'centerOnScroll': true,
    //     'type'		: 'image'
    // });
});

