window.loaderText = '<i class="fa fa-spinner fa-spin" ></i> Please Wait...';
function btnLoaderStart(btnId, btnTxt = "") {
    var loaderText = window.loaderText;
    window.btnText = $(btnId).html();
    if (btnTxt != "") {
        loaderText = '<i class="fa fa-spinner fa-spin" ></i> ' + btnTxt;
    }
    $(btnId).html(loaderText);
    $(btnId).attr("disabled", true);
}
function btnLoaderStop(btnId) {
    $(btnId).removeAttr("disabled");
    $(btnId).html(window.btnText);
}