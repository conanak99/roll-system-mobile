
//Ratio de resize hinh lai
var ratio = 0.5;

$(window).load(function () {
    $('.img-holder, .face-region').each(function (index) {
        var height = $(this).height();
        var width = $(this).width();
        $(this).height(height * ratio);
        $(this).width(width * ratio);
    });

    $('.face-region').each(function (index) {
        var marTop = $(this).css('margin-top').replace('px', '');
        var marLeft = $(this).css('margin-left').replace('px', ''); ;
        $(this).css('margin-top', (marTop * ratio) + 'px');
        $(this).css('margin-left', (marLeft * ratio) + 'px');
    });
});