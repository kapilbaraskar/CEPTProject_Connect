// 462 line
var oTable;
var oTable1;
var fees_status;
var mandatory_time_day_data;
var total_creadit = 0;
var mandatory_credit = 0;
var elective_credit = 0;
var asInitVals = new Array();
var saved_data;
var credit_choice = '';
var FileName = '';

$(document).ready(function () {

    //    $('#btn_print').prop("disabled", true);
    //    $('#btnonlinepayment').prop("disabled", true);
    //   $('#btnsave').prop("disabled", true);
    $('[data-rel=tooltip]').tooltip();
    $('[data-rel=popover]').popover({ html: true });

    $(".fancybox").fancybox({ arrows: false });

    $("#elective1").on('click', function () {

    });

    $('#btn_save').on('click', function () {



        if (total_creadit == '0') {
            bootbox.alert('Please Select Course. You have not Selected Any course');
            return false;
        }


        var flag = "N";

        var mandatory_datalist = [];
        var elective_datalist = [];
        var oSettings = oTable1.fnSettings();

        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }
        oSettings.oPreviousSearch.sSearch = '';
        oTable1.fnDraw();


        $("#elective1 tbody tr").each(function (i) {


            if ($(this).find(".chk_elective").is(':checked')) {

                var course_code = $(this).children().eq(2).html();

                //kamlesh nada
                //                if ($(this).find(".gpa").val() == '0') {
                //                    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);
                //                    //                    total_creadit = total_creadit - parseInt(aData["credits"]);
                //                    //                    elective_credit = elective_credit - parseInt(aData["credits"]);

                //                    //                    $('#lbl_elective').html(elective_credit);
                //                    //                    checkbox.checked = false;
                //                    flag = 'Y';
                //                    return false;
                //                }

                if ($(this).find(".priority").val() == '0') {
                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                    //                    total_creadit = total_creadit - parseInt(aData["credits"]);
                    //                    elective_credit = elective_credit - parseInt(aData["credits"]);

                    //                    $('#lbl_elective').html(elective_credit);
                    //                    checkbox.checked = false;
                    flag = 'Y';

                    //$('#div_student_passport_dtl').css('display', 'none');

                    return false;
                }

                var obj = {};

                //  obj["department"] = $(this).children().eq(7).html();

                var aPos = oTable1.fnGetPosition(this);
                //                var aData = oTable1.fnGetData(aPos[i]);
                //                var a = aData[i];

                var a = oTable1.fnGetData(aPos);

                //                ob["semester_code"] = $(this).children().eq(3).html();


                obj["semester_code"] = a["semester"];
                obj["department"] = a["department"];

                // obj["semester_code"] = $(this).children().eq(3).html();
                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();
                obj["fees"] = $(this).children().eq(5).html();
                obj["priority"] = $(this).find(".priority").val();

                elective_datalist.push(obj);
            }
        });

        if (flag == "N") {

            var is_travel_course_selected = false;
            $("#elective1 tbody tr").each(function (i) {
                if ($(this).find(".chk_elective").is(':checked')) {
                    if (oTable1.fnGetData(this).is_international_travel_course == 'I') {
                        is_travel_course_selected = true;
                    }
                }
            });

            var obj_passport_detail = {};
            var passport_detail = '';

            if (is_travel_course_selected) {
                obj_passport_detail = { 'name_as_per_passport': $('#txt_passport_name').val(), 'passport_number': $('#txt_passport_number').val(), 'passport_scan_copy': FileName };
                passport_detail = JSON.stringify(obj_passport_detail);
            }

            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'S', passport_detail: passport_detail });

            $.ajax({
                type: "POST",
                url: "../WebService_WS.asmx/Save_student_course_dtl",
                data: data,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {

                    if (data.d != "") {

                        if (data.d == "Fail to Save Details.") {
                            bootbox.alert(data.d);
                            return false;
                        }

                        if (data.d == "Data Saved Successfully") {

                            bind_sem_course_data();
                            total_creadit = 0;
                        }

                        bootbox.alert(data.d);

                    }


                },
                error: function (msg) { alert(msg.d); }
            });
        }


        return false;

    });



    //    $('#btn_print').on('click', function () {

    //         

    //        if ('<%= Session["country"] %>' == '2') {
    //            window.open('Print_pay_in_slip_other.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
    //        }
    //        else {
    //            window.open('Print_pay_in_slip.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
    //        }
    //        return false;

    //    });

    // coding for online payment
    $('#btnonlinepayment').on('click', function () {


//        if (credit_choice == '') {
//            bootbox.alert("You can not use Online Payment.<br /> You have not saved your choice of credits.");

//            return false;

//        }

//        if (credit_choice[0]['credit_choice'] == '0') {
//            bootbox.alert("You can not use Online Payment.<br />You have saved 0 choice of credits.");
//            return false;
//        }

        bootbox.confirm("Please make sure you have saved your courses.  Proceed?", function (result) {

            if (result == true) {

                $.ajax({
                    type: "POST",
                    url: "../WebService_WS.asmx/Create_online_payment",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {



                        if (data.d != "") {

                            //                    if (data.d == "Fail to Save Details.") {
                            //                        bootbox.alert(data.d);
                            //                        return false;
                            //                    }

                            //                    if (data.d == "Data Saved Successfully") {

                            //                        //  bind_sem_course_data();
                            //                        // total_creadit = 0;
                            //                    }

                            var result = JSON.parse(data.d);

                            if (result["status"]) {

                                generateHMAC(result);
                            }
                            else {

                                bootbox.alert(result["message"]);
                                return false;
                            }


                            //   bootbox.alert(data.d);
                            return false;
                        }


                    },
                    error: function (msg) { alert(msg.d); }
                });
            }
        });

        //        bootbox.confirm("Please check all the courses you have selected. \nOnce registered for course you will not be able to change the courses.", function (result) {

        //            if (result == true) {

        //                bootbox.confirm("Are you sure for register?", function (result1) {

        //                    if (result1 == true) {

        //  var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'R' });


        //   }

        // });

        //            }
        //            else {


        //            }

        // });


        return false;

    });

    $('#btn_save_credit').on('click', function () {

        var credit_choice = $('#txtcredit_choice').val();

        if (credit_choice == "") {

            bootbox.alert("please Enter your choice of credit.");
            $('#txtcredit_choice').focus();
            return false;
        }

        if (credit_choice == 0) {

            bootbox.alert("You can not save 0 credit of choice.");
            $('#txtcredit_choice').focus();
            return false;
        }

        if (credit_choice > 8) {

            bootbox.alert("You Can Save Maximum 8 choice of credit");
            $('#txtcredit_choice').focus();
            return false;
        }



        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/save_credit_choice",
            data: "{credit_choice : '" + credit_choice + "'}",
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {

                    if (data.d == "completed") {
                        bootbox.alert("You can not change your choice of credit.Allocation completed for this semester");
                        return false;
                    }

                    if (data.d == "Data Saved Successfully") {
                        bootbox.alert(data.d);

                        get_credit_choice();
                        bind_sem_course_data();
                        total_creadit = 0;
                        elective_credit = 0;



                        $('#lbl_elective').html(elective_credit);

                        return false;
                    }

                    bootbox.alert(data.d);

                }


            },
            error: function (msg) { alert(msg.d); }
        });


        return false;
    });


    $('#btnsave').on('click', function () {



        if (total_creadit == '0') {
            bootbox.alert('Please Select Course. You have not selected any course');
            return false;
        }

        var is_travel_course_selected = false;
        $("#elective1 tbody tr").each(function (i) {
            if ($(this).find(".chk_elective").is(':checked')) {
                if (oTable1.fnGetData(this).is_international_travel_course == 'I') {
                    is_travel_course_selected = true;
                }
            }
        });

//        if (is_travel_course_selected) {
//            if ($('#txt_passport_name').val() == '') {
//                bootbox.alert('Please Enter Name as per your Passport');
//                return false;
//            }

//            if ($('#txt_passport_number').val() == '') {
//                bootbox.alert('Please Enter Passport Number');
//                return false;
//            }

//            if (FileName == '') {
//                bootbox.alert('Please Upload scan copy of first and last page of your Passport');
//                return false;
//            }
//        }


        //        if (total_creadit > 0) {


        //            // alert(total_creadit);
        //            if (fees_status != '') {



        //                if (fees_status[0]["fees_status"] == 'H') {

        //                    if (total_creadit > 12) {

        //                        bootbox.alert("You Can Select Max 12 Creadits because You paid Half Fees.Your current total credit selection is " + total_creadit);
        //                        return false;

        //                    }



        //                }
        //                else if (fees_status[0]["fees_status"] == 'F') {

        //                    if (total_creadit > 24) {

        //                        bootbox.alert("You Can Select Max 24 Creadits.Your current total credit selection is " + total_creadit);
        //                        return false;

        //                    }



        //                }
        //            }

        //        }




        var flag = "N";
        var mandatory_datalist = [];
        var elective_datalist = [];

        var oSettings = oTable1.fnSettings();


        oSettings = oTable1.fnSettings();
        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }
        oSettings.oPreviousSearch.sSearch = '';
        oTable1.fnDraw();


        $("#elective1 tbody tr").each(function (i) {



            if ($(this).find(".chk_elective").is(':checked')) {

                var course_code = $(this).children().eq(2).html();
                //kamlesh nada
                //                if ($(this).find(".gpa").val() == '0') {
                //                    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);

                //                    flag = 'Y';
                //                    return false;
                //                }

                if ($(this).find(".priority").val() == '0') {
                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);

                    flag = 'Y';

                    //$('#div_student_passport_dtl').css('display', 'none');

                    return false;
                }



                var obj = {};

                //  obj["department"] = $(this).children().eq(7).html();


                var aPos = oTable1.fnGetPosition(this);
                //                var aData = oTable1.fnGetData(aPos[i]);
                //                var a = aData[i];

                var a = oTable1.fnGetData(aPos);

                //                ob["semester_code"] = $(this).children().eq(3).html();


                obj["semester_code"] = a["semester"];
                obj["department"] = a["department"];

                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();
                obj["fees"] = $(this).children().eq(5).html();
                obj["priority"] = $(this).find(".priority").val();

                elective_datalist.push(obj);
            }
        });



        if (flag == "N") {

            bootbox.confirm("Please check all the courses you have selected. \nOnce registered for course you will not be able to change the courses.", function (result) {

                if (result == true) {

                    bootbox.confirm("Are you sure for register?", function (result1) {

                        if (result1 == true) {

                            var is_travel_course_selected = false;
                            $("#elective1 tbody tr").each(function (i) {
                                if ($(this).find(".chk_elective").is(':checked')) {
                                    if (oTable1.fnGetData(this).is_international_travel_course == 'I') {
                                        is_travel_course_selected = true;
                                    }
                                }
                            });

                            var obj_passport_detail = {};
                            var passport_detail = '';

                            if (is_travel_course_selected) {
                                obj_passport_detail = { 'name_as_per_passport': $('#txt_passport_name').val(), 'passport_number': $('#txt_passport_number').val(), 'passport_scan_copy': FileName };
                                passport_detail = JSON.stringify(obj_passport_detail);
                            }

                            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'R', passport_detail: passport_detail });

                            $.ajax({
                                type: "POST",
                                url: "../WebService_WS.asmx/Save_student_course_dtl",
                                data: data,
                                contentType: "application/json; charset=utf-8",
                                datatype: "json",
                                success: function (data) {

                                    if (data.d != "") {

                                        if (data.d == "Fail to Save Details.") {
                                            bootbox.alert(data.d);
                                            return false;
                                        }

                                        if (data.d == "Data Saved Successfully") {

                                            bind_sem_course_data();
                                            total_creadit = 0;

                                        }

                                        bootbox.alert(data.d);

                                    }


                                },
                                error: function (msg) { alert(msg.d); }
                            });
                        }

                    });

                }
                else {


                }

            });




        }


        return false;
    });




    get_credit_choice();

    bind_sem_course_data();

    chek_fees_status();



});


$(document).on("change", ".priority", function (event) {


    var val = $(this).val();



    var control = $(this);
    var flag = 'Y';
    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);
    var course_code = aData["course_code"];
    var counter = 0;
    var check_flag = 'N';
    //  var Faculty = aData["department"];



    //$("#elective1 tbody tr").each(function (j) {
    //        var $selects = $('.priority');
    //        $('.priority').change(function () {
    //             
    //            alert('loop');
    //            $('option:hidden', $selects).each(function () {
    //                 
    //                var self = this,
    //		            toShow = true;
    //                $selects.not($(this).parent()).each(function () {
    //                    if (self.value == this.value) toShow = false;
    //                })
    //                if (toShow) $(this).show();
    //            });
    //            if (this.value != 0) //to keep default option available
    //                $selects.not(this).children('option[value=' + this.value + ']').hide();
    //        });
    var selectedValues = [];
    var nNodes = oTable1.fnGetNodes();
    for (var i = 0; i < nNodes.length; i++) {
        if ($(nNodes[i]).find('.priority').val() != '0') {
            counter = counter + 1;
            if (course_code != $(nNodes[i]).children().eq(2).html()) {
                if (val == $(nNodes[i]).find(".priority").val()) {
                    bootbox.alert('You already Select this Priority for Course  Code : ' + $(nNodes[i]).children().eq(2).html());

                    control.val("0");

                    return false;
                }
            }
        }
    }

    //        if ($(this).find(".priority").val() != '0') {

    //            counter = counter + 1;

    //            if (course_code != $(this).children().eq(2).html()) {
    //                if (val == $(this).find(".priority").val()) {
    //                    bootbox.alert('You already Select this Priority for Course  Code : ' + $(this).children().eq(2).html());

    //                    control.val("0");

    //                    return false;
    //                }



    //            }




    //   alert($(this).children().eq(3).html());
    //}
    //});



    for (var i = 0; i < nNodes.length; i++) {
        if ($(nNodes[i]).find('.priority').val() != '0') {
            if ((parseInt(val) - parseInt(1)) == $(nNodes[i]).find(".priority").val()) {
                flag = 'Y';
                generateSelectedAreas();
                return false;
            }
            else {
                flag = 'N';
            }
        }
    }



    if (counter == 1) {



        if (val > 1) {

            bootbox.alert("Please Select Priority in Sequence");
            control.val("0");
        }
    }

    else {

        if (flag == 'N') {

            if (val == 0) {

            }
            else {
                bootbox.alert("Please Select Priority in Sequence");
                control.val("0");
            }

        }
    }

    generateSelectedAreas();

});

function generateSelectedAreas() {

    var selectedValues = [];

    var nNodes = oTable1.fnGetNodes();
    for (var i = 0; i < nNodes.length; i++) {
        $(nNodes[i]).find('.priority option').each(function () {
            $(this).css('display', 'block');
        });
    }
    for (var i = 0; i < nNodes.length; i++) {
        $(nNodes[i]).find('.priority option:selected').each(function () {
            var select = $(this).parent();
            optValue = $(this).val();
            if ($(this).val() != '0') {

                //$(this).not(select).children().css('display', 'none');
                $('.priority').not(select).children().filter(function (e) {
                    if ($(this).val() == optValue)
                        return e
                }).css('display', 'none');
            }
        });
    }
}



$(document).on("click", ".chk_elective", function (event) {

    //var nNodes = oTable1.fnGetNodes();
    //oTable1.fnFilter('');
    //    var oSettings = oTable1.fnSettings();
    //    for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
    //        oSettings.aoPreSearchCols[iCol].sSearch = '';
    //    }
    //    oSettings.oPreviousSearch.sSearch = '';
    //    oTable1.fnDraw();
    var checkbox = this;
    var datalist = [];
    var datalist1 = [];
    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);

    var flag = 'N';

    var course_code = aData["course_code"];
    var sem_code = aData["semester"];
    var creadits = aData["credits"];



    if (credit_choice == '') {
        bootbox.alert("You can not Select Courses.\n You have not saved your choice of credits.");
        $(this).prop("checked", false);

        //        total_creadit = total_creadit - parseInt(aData["credits"]);
        //        elective_credit = elective_credit - parseInt(aData["credits"]);

        //        $('#lbl_elective').html(elective_credit);
        return false;

    }

    if (this.checked) {

        total_creadit = total_creadit + parseInt(aData["credits"]);

        elective_credit = elective_credit + parseInt(aData["credits"]);
        $('#lbl_elective').html(elective_credit);
        if (total_creadit > 25) {

            bootbox.alert("You can Select Maximum 25 Credits for save your courses.");
            $(this).prop("checked", false);

            total_creadit = total_creadit - parseInt(aData["credits"]);
            elective_credit = elective_credit - parseInt(aData["credits"]);

            $('#lbl_elective').html(elective_credit);
            return false;

        }

        // alert(total_creadit);

    }
    else {

        total_creadit = total_creadit - parseInt(aData["credits"]);
        elective_credit = elective_credit - parseInt(aData["credits"]);
        $('#lbl_elective').html(elective_credit);

        var is_travel_course_selected = false;
        $("#elective1 tbody tr").each(function (i) {
            if ($(this).find(".chk_elective").is(':checked')) {
                if (oTable1.fnGetData(this).is_international_travel_course == 'I') {
                    is_travel_course_selected = true;
                }
            }
        });

        if (is_travel_course_selected) $('#div_student_passport_dtl').css('display', 'block');
        else $('#div_student_passport_dtl').css('display', 'none');

        // alert(total_creadit);
    }


    if (this.checked) {

        var nNodes = oTable1.fnGetNodes();
        //        var nNodes1 = oTable.fnGetNodes();

        for (var i = 0; i < nNodes.length; i++) {
            if ($(nNodes[i].cells[0].firstChild.firstChild).prop('checked')) {
                //var aPos = oTable1.fnGetPosition(this);

                var ob = {};
                var aData1 = oTable1.fnGetData(i);
                //var a = aData[i];

                ob["semester_code"] = aData1.semester;
                ob["course_code"] = aData1.course_code;
                datalist1.push(ob);


            }
            //return false;
        }


        //        if (flag == 'Y') {
        //            return false;
        //        }

        var data = JSON.stringify({ mandatory_time: "", elective_time: JSON.stringify(datalist1), course_code: course_code, sem_code: sem_code, flag: 'E' });
        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/Check_time_validation",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {




                    if (data.d == "Error") {

                    }
                    else {



                        var split_data = data.d.split(":");

                        if (split_data[0] == "ok") {




                            $("#elective1 tbody tr").each(function (i) {


                                if ($(this).find(".chk_elective").is(':checked')) {



                                    //commet by kamlesh///


                                    if (course_code == $(this).children().eq(2).html()) {

                                        if ($(this).find(".priority").val() == '0') {
                                            bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                                            total_creadit = total_creadit - parseInt(aData["credits"]);
                                            elective_credit = elective_credit - parseInt(aData["credits"]);

                                            $('#lbl_elective').html(elective_credit);
                                            checkbox.checked = false;

                                            //$('#div_student_passport_dtl').css('display', 'none');

                                            //return false;
                                        }

                                        if ($(this).find(".gpa").val() == '0') {
                                            bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);

                                            if ($(this).find(".priority").val() != '0') {
                                                total_creadit = total_creadit - parseInt(aData["credits"]);
                                                elective_credit = elective_credit - parseInt(aData["credits"]);

                                                $('#lbl_elective').html(elective_credit);
                                                checkbox.checked = false;
                                            }

                                            // return false;
                                        }

                                    }
                                }
                            });

                            bootbox.alert(split_data[1]);



                        }
                        else {
                            checkbox.checked = false;
                            total_creadit = total_creadit - parseInt(aData["credits"]);
                            elective_credit = elective_credit - parseInt(aData["credits"]);

                            $('#lbl_elective').html(elective_credit);
                            bootbox.alert(data.d);
                        }


                    }




                }
                else {

                    $("#elective1 tbody tr").each(function (i) {


                        if ($(this).find(".chk_elective").is(':checked')) {



                            //commet by kamlesh///

                            if (course_code == $(this).children().eq(2).html()) {



                                if ($(this).find(".priority").val() == '0') {
                                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                                    total_creadit = total_creadit - parseInt(aData["credits"]);
                                    elective_credit = elective_credit - parseInt(aData["credits"]);

                                    $('#lbl_elective').html(elective_credit);
                                    checkbox.checked = false;

                                    //$('#div_student_passport_dtl').css('display', 'none');

                                    return false;
                                }

                            }
                        }
                    });

                }

                var is_travel_course_selected = false;
                $("#elective1 tbody tr").each(function (i) {
                    if ($(this).find(".chk_elective").is(':checked')) {
                        if (oTable1.fnGetData(this).is_international_travel_course == 'I') {
                            is_travel_course_selected = true;
                        }
                    }
                });

                if (is_travel_course_selected) $('#div_student_passport_dtl').css('display', 'block');
                else $('#div_student_passport_dtl').css('display', 'none');

                return false;

            },
            error: function (msg) { alert(msg.d); }
        });
    }


});



$('#callbacks').multiSelect({

});

$('.ms-selectable .ms-list').on('mouseenter', '.ms-elem-selectable', function () {
    $('li', that.$container).removeClass('ms-hover');
    $(this).addClass('ms-hover');
    alert('hi');
}).on('mouseleave', function () {
    $('li', that.$container).removeClass('ms-hover');
});


function get_saved_data() {

    $.ajax({
        async: false,
        type: "POST",
        url: "../WebService_WS.asmx/Get_saved_student_course_data",
        data: {},
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                saved_data = JSON.parse(data.d);

                //  alert(saved_data);

                if (saved_data != "") {
                    for (var i = 0; i < saved_data.length; i++) {
                        total_creadit = total_creadit + parseInt(saved_data[i]["credits"]);
                        //                        alert(total_creadit);
                    }

                }


            }
            else {

                saved_data = "";
            }


        },
        error: function (msg) { alert(msg.d); }
    });


}


function bind_sem_course_data() {
    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_elective_course_data_for_student",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                if (data.d == "fees not found") {
                    return false;
                }
                if (data.d == "no data") {
                    bootbox.alert("There are no elective courses available for your department");
                    return false;
                }
                $.ajax({
                    async: false,
                    type: "POST",
                    url: "../WebService_WS.asmx/Get_saved_student_course_data",
                    data: {},
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data1) {
                        if (data1.d != "") {
                            elective_credit = 0;
                            saved_data = JSON.parse(data1.d);

                            if (saved_data != "") {
                                for (var i = 0; i < saved_data.length; i++) {
                                    total_creadit = total_creadit + parseInt(saved_data[i]["credits"]);
                                    elective_credit = elective_credit + parseInt(saved_data[i]["credits"]);
                                }
                                $('#lbl_elective').html(elective_credit);
                            }
                        }
                        else {
                            saved_data = "";
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });

                DisplayData1(data.d);
            }
            else {
                alert('There is no data found');
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
}





function get_fees_status() {

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_fees_status",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            //   alert('kamlesh');
            if (data.d != "") {

                fees_status = JSON.parse(data.d);





            }
            else {
                fees_status = '';
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });

    return false;


}
function get_mandatory_time_day_data() {


    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_mandatory_time_day_data",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                mandatory_time_day_data = JSON.parse(data.d);

                //alert(mandatory_time_day_data);

            }
            else {
                alert('There is no data found');
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });

    return false;


}


function DisplayData1(data) {


    if (oTable1 != null) {
        oTable1.fnDestroy();

        //        $("#datalist_elective").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="elective1"><thead></thead><tbody> </tbody><tfoot id="abc1"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th>Deselect <input type="checkbox" name="priority" id="chkpriority"onchange="chkpriorityDeselect()"/></th><th><input type="text" style="width: 30px" name="search_code" value="" class="search_init" /></th><th><input type="text" style="width: 79px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 10px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 20px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 50px;" name="search_Faculty" value="" class="search_init" /></th><th><input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" /></th><th><input type="text" style="width: 70px" name="search_time" value="" class="search_init" /></th><th><input type="text" style="width: 142px" name="search_time" value="" class="search_init" /></th><th><input type="text" style="width: 44px" name="search_Area" value="" class="search_init" /></th><th><input type="text" style="width: 1px; display: none" name="search_Area" value="Area" class="search_init" /></th><th><input type="text" style="width: 1px; display: none" name="search_Area" value="Area" class="search_init" /></th></tfoot></table>');
        //        $("#datalist_elective").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="elective1"><thead></thead><tbody> </tbody><tfoot id="abc1"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th>Deselect <input type="checkbox" name="priority" id="chkpriority"onchange="chkpriorityDeselect()"/></th><th><input type="text" style="width: 30px" name="search_code" value="" class="search_init" /></th><th><input type="text" style="width: 79px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 79px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 10px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 20px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 50px;" name="search_Faculty" value="" class="search_init" /></th><th><input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" /></th><th><input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" /></th><th><input type="text" style="width: 70px" name="search_time" value="" class="search_init" /></th><th><input type="text" style="width: 142px" name="search_time" value="" class="search_init" /></th><th><input type="text" style="width: 30px" name="search_Area" value="" class="search_init" /></th><th></th><th><input type="text" style="width: 1px; display: none" name="search_Area" value="Area" class="search_init" /></th></tfoot></table>');

        $("#datalist_elective").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="elective1"><thead></thead><tbody> </tbody><tfoot id="abc1"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th>Deselect <input type="checkbox" name="priority" id="chkpriority"onchange="chkpriorityDeselect()"/></th><th><input type="text" style="width: 30px" name="search_code" value="" class="search_init" /></th><th><input type="text" style="width: 79px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 11px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 10px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 20px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" /></th><th><input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" /></th><th><input type="text" style="width: 70px" name="search_time" value="" class="search_init" /></th><th><input type="text" style="width: 94px" name="search_time" value="" class="search_init" /></th><th><input type="text" style="width: 25px" name="search_Area" value="" class="search_init" /></th><th></th><th><input type="text" style="width: 1px; display: none" name="search_Area" value="Area" class="search_init" /></th></tfoot></table>');

    }
    oTable1 = $("#elective1").dataTable({

        "bPaginate": false,
        "bStateSave": false,

        //        "fnStateLoad": function (oSettings) {
        //            return false;
        //        },
        //        "sDom": 't',
        "bAutoWidth": false,
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "bJQueryUI": true,
        // "sScrollY": '400px',
        //        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oTableTools": {
            "aButtons": [

						]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [
                    { "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_elective" ></center>' },
                    { "sTitle": "Priority",
                        "bSortable": false,
                        "mData": null,

                        fnRender: function (oObj) {

                            var listItems = '<select class="priority">';
                            listItems += "<option value='0'>Select</option>";
                            listItems += "<option value='1'>1</option>";
                            listItems += "<option value='2'>2</option>";
                            listItems += "<option value='3'>3</option>";
                            listItems += "<option value='4'>4</option>";
                            listItems += "<option value='5'>5</option>";
                            //                    listItems += "<option value='6'>6</option>";
                            //                    listItems += "<option value='7'>7</option>";
                            //                    listItems += "<option value='8'>8</option>";
                            //                    listItems += "<option value='9'>9</option>";
                            //                    listItems += "<option value='10'>10</option>";
                            listItems += '</select>';



                            return listItems;



                        }
                    },

                    { "sTitle": "Code", "mData": "course_code", "bSortable": false },
//                    { "sTitle": "Name", "mData": null, "bWidth": "5px", "bSortable": false, fnRender: function (oObj) {
//                        //                        return oObj.aData.course_name.toUpperCase();
//                        return oObj.aData.course_name;
//                    }
//                    },
                    { "sTitle": "Name", "mData": "course_name", "bWidth": "5px", "bSortable": false },
                    { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                    { "sTitle": "Fees for student", "mData": "fees", "bSortable": false },
                    { "sTitle": "Fees for Prof.", "mData": "prof_fees", "bSortable": false },
        //                    { "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
        ////   {"sTitle": "Faculty", "mData": "department", "bSortable": false },
//                    {"sTitle": "Prerequisite for student", "mData": null, "bSortable": false, fnRender: function (oObj) {
//                        //                        return oObj.aData.prerequisite.toUpperCase();
//                        return oObj.aData.prerequisite;
//                    }
//                    },
                    {"sTitle": "Prerequisite for student", "mData": "prerequisite", "bSortable": false },
//                    { "sTitle": "Prerequisite for professional", "mData": null, "bSortable": false, fnRender: function (oObj) {
//                        //                        return oObj.aData.prerequisite_for_prof.toUpperCase();
//                        return oObj.aData.prerequisite_for_prof;
//                    }
                   // },
                    { "sTitle": "Prerequisite for professional", "mData": "prerequisite_for_prof", "bSortable": false },


                    { "sTitle": "Instructor/s", "mData": "instructor", "bSortable": false },

                    { "sTitle": "Dates", "mData": "date", "sWidth": "1%", "bSortable": false },
                    { "sTitle": "Seats", "mData": "available_seats", "sWidth": "1%", "bSortable": false },
        //                       { "sTitle": "Time (Indicative)", "mData": "time", "bSortable": false },
        //                         { "sTitle": "Days", "mData": "days", "bSortable": false },
        //                    { "sTitle": "Area", "mData": "area", "bSortable": false },

        //                                 { "sTitle": "GPA/Non GPA",
        //                                     "bSortable": false,
        //                                     "mData": null,

        //                                     fnRender: function (oObj) {

        //                                         var listItems = '<select class="gpa">';
        //                                         listItems += "<option value='0'>Select</option>";
        //                                         listItems += "<option value='G'>GPA</option>";
        //                                         listItems += "<option value='N'>Non GPA</option>";
        //                                         listItems += '</select>';



        //                                         return listItems;



        //                                     }
        //                                 },
                    {"sTitle": "View Details",
                    "mData": null,
                    "bSortable": false,
                    fnRender: function (oObj) {

                        if (oObj.aData.image_name == '') {
                            return '<a class="fancybox" rel="group" href="../course_image/noimage.jpg"><img src="../course_image/noimage.jpg" height="60px" width="75px" alt="No Image"></img></a>';
                        }
                        else {
                            //         return '<a class="fancybox" rel="group" href="../course_image/' + oObj.aData.image_name + '"><img src="../course_image/' + oObj.aData.image_name + '" height="60px" width="75px" alt="No Image"></img></a>';
                            return '<a class="fancybox" target="_blank" rel="group" href="../course_image/' + oObj.aData.image_name + '"><img src="../course_image/' + oObj.aData.course_code + '.jpg" height="60px" width="60px" alt="No Image"></img></a>';
                            //         return '<a class="fancybox" rel="group" href="../course_image/' + oObj.aData.image_name + '"><img src="../course_image/pdf.jpg" height="60px" width="75px" alt="No Image"></img></a>';
                        }
                    }
                },
                    { "sTitle": "Sem", "mData": "semester", "bSortable": false, "bVisible": false, "aTargets": [0] }



           ],
        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            /* imagine aData[0] is an object, not a string {text: 'X1', title: 'Title X1'} */
            $('td:eq(3)', nRow).attr('title', aData.course_desc).tooltip();
            $('td:eq(3)', nRow).css({ cursor: "pointer" });
            return nRow;
        }

    });

    $("#elective1").freezeHeader({ 'height': '420px' });

    //    .columnFilter({
    //        aoColumns: [null
    //        //        { sSelector: "#renderingEngineFilter" }

    //                                    				]
    //    });

    //    new FixedHeader(oTable1);


    $("#elective1 tbody tr").each(function (i) {



        var aPos = oTable1.fnGetPosition(this);
        var aData = oTable1.fnGetData(aPos[i]);
        var a = aData[i];

        if (saved_data != "") {

            for (var j = 0; j < saved_data.length; j++) {



                if (saved_data[j]["doc_no"] == a["doc_no"]) {


                    $(this).find(".chk_elective").prop('checked', true);

                    //                    if (saved_data[j]["gpa_nongpa"] != '') {
                    //                        $(this).find(".gpa").val(saved_data[j]["gpa_nongpa"]);
                    $(this).find(".priority").val(saved_data[j]["priority"]);
                    //   }

                }



            }
        }
        else {
            // listItems += "<option  value='" + exporess[i]["Document_number"] + "'>" + exporess[i]["expression"] + "</option>";
        }

    });





    //    .columnFilter({

    //        aoColumns: [null,
    //        { sSelector: "#renderingEngineFilter" }

    //        				]
    //    }
    //    );

    generateSelectedAreas();

    //    $('#elective1 th').bind('mouseup', function (event) {
    //        var index = $(this).parent().children().index($(this));
    //        var colWidth = $(this).css('width');
    //        var input = $('#elective1 tfoot tr input:eq(' + index + ')');
    //        alert('kamlesh');
    //        input.css("width", colWidth);
    //    });

    //    $('#elective1 thead tr').find(':input').each(function (index) {
    //        var colWidth = $('#elective1 tbody tr th:eq(' + index + ')').css('width');
    //        var colWidth1 = $(this).css('width');
    //        var input = $('#elective1 tfoot tr input:eq(' + index + ')');
    //        alert(input + '-' + colWidth1);
    //        $(this).css("width", "42");
    //    });

    $("#abc1 input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable1.fnFilter(this.value, $("#abc1 input").index(this));
    });



    /*
    * Support functions to provide a little bit of 'user friendlyness' to the textboxes in
    * the footer
    */
    $("#abc1 input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("#abc1 input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("#abc1 input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("#abc1 input").index(this)];
        }
    });

    $('#btnsave').css("display", "block");
    $('#btn_save').css("display", "block");

    $('#btnonlinepayment').css("display", "block");

    $('#btn_print').css("display", "block");


    var is_travel_course_selected = false;
    $("#elective1 tbody tr").each(function (i) {
        if ($(this).find(".chk_elective").is(':checked')) {
            if (oTable1.fnGetData(this).is_international_travel_course == 'I') {
                is_travel_course_selected = true;
            }
        }
    });

    if (is_travel_course_selected) $('#div_student_passport_dtl').css('display', 'block');
    else $('#div_student_passport_dtl').css('display', 'none');

    debugger;

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_student_passport_detailnew",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                var student_passport_detail = JSON.parse(data.d);

                $('#txt_passport_name').val(student_passport_detail[0]['name_as_per_passport'].toString());
                $('#txt_passport_number').val(student_passport_detail[0]['passport_number'].toString());
                $('#spn_image').html(student_passport_detail[0]['passport_scan_copy'].toString());
                FileName = student_passport_detail[0]['passport_scan_copy'].toString();
            }
        },
        error: function (data) {
            alert(data.d);
        }
    });
}

function chek_fees_status() {

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_fees_status",
        data: {},
        contentType: "application/json",
        datatype: "json",
        async: false,
        success: function (data) {


            //   alert('kamlesh');
            if (data.d != "") {

                fees_status = JSON.parse(data.d);

                if (fees_status[0]["fees_status"] != "") {



                    if (fees_status[0]["fees_status"] == "Y") {


                    }

                    else {
                        $('#btnsave').prop("disabled", true);
                    }
                }
                else {
                    $('#btnsave').prop("disabled", true);
                }



            }
            else {
                $('#btnsave').prop("disabled", true);
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });

}

function get_credit_choice() {

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/get_ws_credit_choice",
        data: {},
        contentType: "application/json",
        datatype: "json",
        async: false,
        success: function (data) {


            if (data.d != "") {

                credit_choice = JSON.parse(data.d);


                if (credit_choice != '') {
                    $('#txtcredit_choice').val(credit_choice[0]["credit_choice"]);
                }


            }
            else {

                $('#txtcredit_choice').val(5);

            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });

}


var merchantURLPart = "";
var vanityURLPart = "";
var reqObj = null;

function generateHMAC(param1) {


    document.getElementById("orderAmount").value = param1["amount"];
    document.getElementById("merchantTxnId").value = param1["transaction_id"];
    document.getElementById("currency").value = param1["currency"];
    document.getElementById("returnUrl").value = param1["return_url"];

    //  alert(param1["return_url"]);

    if (window.XMLHttpRequest) {
        reqObj = new XMLHttpRequest();
    } else {
        reqObj = new ActiveXObject("Microsoft.XMLHTTP");
    }

    merchantURLPart = param1["merchant_id"];

    if (merchantURLPart.lastIndexOf("/") != -1) {
        vanityURLPart = merchantURLPart.substring(merchantURLPart.lastIndexOf("/") + 1)
    }
    var orderAmount = document.getElementById("orderAmount").value;
    var merchantTxnId = document.getElementById("merchantTxnId").value;
    var currency = document.getElementById("currency").value;


    var param = "merchantId=" + vanityURLPart + "&orderAmount=" + orderAmount
				+ "&merchantTxnId=" + merchantTxnId + "&currency=" + currency;
    reqObj.onreadystatechange = process;

    reqObj.open("POST", param1["hmac_url"] + "?" + param, false);
    reqObj.send(null);
}
function process() {
    if (reqObj.readyState == 4) {
        document.getElementById("secSignature").value = reqObj.responseText;
        submitForm();
    }
}

function submitForm() {

    //    document.aspnetForm.action = merchantURLPart;
    //    document.aspnetForm.method = 'POST';
    //    document.aspnetForm.submit();

    document.aspnetForm.action = merchantURLPart;
    document.aspnetForm.method = 'POST';
    document.aspnetForm.submit();
}

function print_payslip(country_id) {



    // alert(country_id);
    bootbox.confirm("Please make sure you have saved your courses.  Proceed?", function (result) {

        if (result == true) {
            if (country_id == "2") {
                window.open('Print_pay_in_slip_other.aspx', 'PrintMe', 'height=600px,width=610,scrollbars=1');
                return false;
            }
            else {
                window.open('Print_pay_in_slip_new.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                return false;
            }

            return false;
        }

        // return false;
    });
}

