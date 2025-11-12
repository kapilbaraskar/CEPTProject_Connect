(function (d, $) {
    $(d).ready(function () {
      
        $("#showSubMenuToggle").click(function (event) {
            event.preventDefault();
            $("#sub-menu").slideToggle();
        });
    });
})(document, jQuery);