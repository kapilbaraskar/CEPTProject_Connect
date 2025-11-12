function bindyeardata_for_cross_reg() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_year_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                for (var i = 0; i < year_data.length; i++) {
                    $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindsemdata() {
    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
    $('#drpsemester').chosen();
}

function bindinstallment(){
    $('#drp_installment').append($("<option></option>").val("1").html("Full / Half Fees / Installment 1"));
    $('#drp_installment').append($("<option></option>").val("2").html("2"));
    $('#drp_installment').append($("<option></option>").val("3").html("3"));
    $('#drp_installment').append($("<option></option>").val("4").html("4"));
    $('#drp_installment').chosen();
}