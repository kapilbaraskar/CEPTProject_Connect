var oTable;
var oTable1;
var fees_status;
var mandatory_time_day_data;
var total_creadit = 0;
var mandatory_credit = 0;
var elective_credit = 0;
var asInitVals = new Array();
var saved_data;
var pre_assigned_data;
var course_prog_type_data;
var obj_mandatory_data;

$(document).ready(function () {
    //$('#btn_print').prop("disabled", true);
    //$('#btnsave').prop("disabled", true);
    //$('#btnonlinepayment').prop("disabled", true);

    //$('#btn_save').prop("disabled", true);
    $('[data-rel=tooltip]').tooltip();
    $('[data-rel=popover]').popover({ html: true });

    //$('#my_outline').modal(
    //{
    //    backdrop: 'static'
    //    //keyboard: false
    //});

    $('#rbtgpa').change(function () {
        if ((this).checked) {
            $('#rbtnongpa').prop('checked', false);
        }
        else {
            $('#rbtnongpa').prop('checked', true);
        }
    });

    $('#rbtnongpa').change(function () {
        if ((this).checked) {
            $('#rbtgpa').prop('checked', false);
        }
        else {
            $('#rbtgpa').prop('checked', true);
        }
    });

    $('#btn_print_outline').on('click', function () {
        //var mywindow = window.open('', 'print_data', 'height=400,width=600');
        ////mywindow.document.write('<link href=\"DesignCss/bootstrap.min.css\" rel=\"stylesheet\" />  <link href=\"DesignCss/ace.min.css\" rel=\"stylesheet\" /><link href=\"Style/dataTables.bootstrap.css\" rel=\"stylesheet\" type="text/css" />');
        //mywindow.document.write('');
        ////mywindow.document.write('<style type="text/css"> th, td, .table-bordered {border-radius: 0!important;} .table-bordered {border: 1px solid #ddd;border-collapse: separate;border-left: 0}table {border-spacing: 0;}body {padding-bottom: 0;background-color: #e4e6e9;min-height: 100%;font-family: 'Open Sans';font-size: 13px;color: #393939;} </style>');
        ////mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} .dxc-markers circle{display:none;}</style>');
        //mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
        ///*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
        //mywindow.document.write('</head><body>');
        //mywindow.document.write($('#my_print_outline').html());
        //mywindow.document.write('</body></html>');

        //mywindow.print();
        //mywindow.close();

        var str_html = "<html><head> <link href='https://connect.cept.ac.in/DesignCss/bootstrap.min.css' rel='stylesheet' /> ";
        str_html = str_html+"<link href='https://connect.cept.ac.in/DesignCss/bootstrap-responsive.min.css' rel='stylesheet' />" + $('style')[0].outerHTML  + "</head><body>" + $('#my_print_outline').html() + "</body></html>";

        str_html = str_html.replace(/</g, '&lt;');
        str_html = str_html.replace(/>/g, '&rt;');

        $('#hdn_outline').val(str_html);
        $('#hdn_download').click();

        return false;
    });

    $('#btn_save').on('click', function () {
        if (total_creadit == '0') {
            bootbox.alert('Please Select Course.You are not Selected Any course');
            return false;
        }

        var flag = "N";

        var mandatory_datalist = [];
        var elective_datalist = [];
        var oSettings = oTable.fnSettings();

        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }

        oSettings.oPreviousSearch.sSearch = '';
        oTable.fnDraw();

        oSettings = oTable1.fnSettings();

        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }

        oSettings.oPreviousSearch.sSearch = '';
        oTable1.fnDraw();

        $("#example tbody tr").each(function (i) {
            if ($(this).find(".madaniyu").is(':checked')) {
                var obj = {};

                obj["semester_code"] = $(this).children().eq(1).html();
                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();

                mandatory_datalist.push(obj);
            }
        });

        $("#elective1 tbody tr").each(function (i) {
            if ($(this).find(".chk_elective").is(':checked')) {
                var course_code = $(this).children().eq(2).html();
                if ($(this).find(".gpa").val() == '0') {
                    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);
                    //total_creadit = total_creadit - parseInt(aData["credits"]);
                    //elective_credit = elective_credit - parseInt(aData["credits"]);
                    //$('#lbl_elective').html(elective_credit);
                    //checkbox.checked = false;
                    flag = 'Y';
                    return false;
                }

                if ($(this).find(".priority").val() == '0') {
                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                    //total_creadit = total_creadit - parseInt(aData["credits"]);
                    //elective_credit = elective_credit - parseInt(aData["credits"]);
                    //$('#lbl_elective').html(elective_credit);
                    //checkbox.checked = false;
                    flag = 'Y';
                    return false;
                }

                var obj = {};

                obj["department"] = $(this).children().eq(6).html();

                var aPos = oTable1.fnGetPosition(this);
                var aData = oTable1.fnGetData(aPos[i]);
                var a = aData[i];

                //ob["semester_code"] = $(this).children().eq(3).html();

                obj["semester_code"] = a["semester"];

                //obj["semester_code"] = $(this).children().eq(3).html();
                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();
                obj["gpa_nongpa"] = $(this).find(".gpa").val();
                obj["priority"] = $(this).find(".priority").val();

                elective_datalist.push(obj);
            }
        });

        if (flag == "N") {
            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'S' });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Save_student_course_dtl_new",
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

    //coding for online payment
    $('#btnonlinepayment').on('click', function () {
        if (total_creadit == '0') {
            bootbox.alert('Please Select Course. You are not selected any course');
            return false;
        }

        //change for foren students changed on call by tushar bose
        //bootbox.confirm("Please make sure you have saved your courses.  Proceed?", function (result) {

        bootbox.confirm("Are you sure you want to proceed?", function (result) {
            if (result == true) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/Create_online_payment",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != "") {
                            //if (data.d == "Fail to Save Details.") {
                            //    bootbox.alert(data.d);
                            //    return false;
                            //}

                            //if (data.d == "Data Saved Successfully") {
                            //    //bind_sem_course_data();
                            //    //total_creadit = 0;
                            //}

                            var result = JSON.parse(data.d);

                            if (result["status"]) {
                                generateHMAC(result);
                            }
                            else {
                                bootbox.alert(result["message"]);
                                return false;
                            }

                            //bootbox.alert(data.d);
                            return false;
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
            }
        });

        //bootbox.confirm("Please check all the courses you have selected. \nOnce registered for course you will not be able to change the courses.", function (result) {
        //    if (result == true) {
        //        bootbox.confirm("Are you sure for register?", function (result1) {
        //        if (result1 == true) {
        //            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'R' });
        //        }
        //        });
        //    }
        //    else {
        //    }
        //});

        return false;
    });

    $('#btn_print').on('click', function () {
        //bootbox.alert('Payment is closed');
        //return false;

        if (total_creadit == '0') {
            bootbox.alert('Please Select Course. You are not selected any course');
            return false;
        }

        //bootbox.confirm("Please make sure you have saved your courses.  Proceed?", function (result) {

        bootbox.confirm("Are you sure you want to proceed?", function (result) {
            if (result == true) {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/check_save_course_for_print_pay_in_slip",
                    data: "{}",
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var result = JSON.parse(data.d);

                            if (result["status"]) {
                                window.open('Print_pay_in_slip_new.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                                return false;
                            }
                            else {
                                bootbox.alert(result["message"]);
                                return false;
                            }

                            //bootbox.alert(data.d);
                            return false;
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
            }
        });

        return false;
    });

    $('#btnsave').on('click', function () {
        if (total_creadit == '0') {
            bootbox.alert('Please Select Course. You have not selected any course');
            return false;
        }

        //if (total_creadit > 0) {
        //    //alert(total_creadit);
        //    if (fees_status != '') {
        //        if (fees_status[0]["fees_status"] == 'H') {
        //            if (total_creadit > 12) {
        //                bootbox.alert("You Can Select Max 12 Creadits because You paid Half Fees.Your current total credit selection is " + total_creadit);
        //                return false;
        //            }
        //        }
        //        else if (fees_status[0]["fees_status"] == 'F') {
        //            if (total_creadit > 24) {
        //                bootbox.alert("You Can Select Max 24 Creadits.Your current total credit selection is " + total_creadit);
        //                return false;
        //            }
        //        }
        //    }
        //}

        var flag = "N";
        var mandatory_datalist = [];
        var elective_datalist = [];

        var oSettings = oTable.fnSettings();
        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }
        oSettings.oPreviousSearch.sSearch = '';
        oTable.fnDraw();

        oSettings = oTable1.fnSettings();
        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }
        oSettings.oPreviousSearch.sSearch = '';
        oTable1.fnDraw();

        $("#example tbody tr").each(function (i) {
            if ($(this).find(".madaniyu").is(':checked')) {
                var obj = {};

                obj["semester_code"] = $(this).children().eq(1).html();
                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();

                mandatory_datalist.push(obj);
            }
        });

        $("#elective1 tbody tr").each(function (i) {
            if ($(this).find(".chk_elective").is(':checked')) {
                var course_code = $(this).children().eq(2).html();

                if ($(this).find(".gpa").val() == '0') {
                    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);
                    flag = 'Y';
                    return false;
                }

                if ($(this).find(".priority").val() == '0') {
                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                    flag = 'Y';
                    return false;
                }

                var obj = {};

                obj["department"] = $(this).children().eq(6).html();

                var aPos = oTable1.fnGetPosition(this);
                var aData = oTable1.fnGetData(aPos[i]);
                var a = aData[i];

                //ob["semester_code"] = $(this).children().eq(3).html();

                obj["semester_code"] = a["semester"];
                //obj["semester_code"] = $(this).children().eq(3).html();

                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();
                obj["gpa_nongpa"] = $(this).find(".gpa").val();
                obj["priority"] = $(this).find(".priority").val();

                elective_datalist.push(obj);
            }
        });

        if (flag == "N") {
            bootbox.confirm("Please check all the courses you have selected. \nOnce registered for course you will not be able to change the courses.", function (result) {
                if (result == true) {
                    bootbox.confirm("Are you sure for register?", function (result1) {
                        if (result1 == true) {
                            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'R' });

                            $.ajax({
                                type: "POST",
                                url: "../WebService.asmx/Save_student_course_dtl_new",
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

    $('#btn_save_credit').on('click', function () {
        var selected_credits = "";

        if ($('#txtcredit_choice').val().trim() != "") {
            selected_credits = $('#txtcredit_choice').val();
        }
        else {
            bootbox.alert('please enter your total credits you would like to apply');
            return false;
        }

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/save_user_choice_of_credits",
            data: "{selected_credits:'" + selected_credits + "'}",
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    var result = JSON.parse(data.d);

                    if (result["status"]) {
                        bootbox.alert(result["message"]);

                        chek_fees_status();
                    }
                    else {
                        bootbox.alert(result["message"]);
                    }

                    return false;
                }
            },
            error: function (msg) { alert(msg.d); }
        });

        return false;
    });

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

    //    $("#elective1 tbody tr").each(function (j) {

    //         
    //        if ($(this).find(".priority").val() != '0') {

    //            if ((parseInt(val) - parseInt(1)) == $(this).find(".priority").val()) {
    //                flag = 'Y';
    //                return false;
    //            }
    //            else {
    //                flag = 'N';

    //            }

    //        }
    //    });

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

$(document).on("click", ".madaniyu", function (event) {
    var checkbox = this;
    var datalist = [];
    var datalist1 = [];
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var course_code = aData["course_code"];
    var sem_code = aData["semester"];
    var creadits = aData["credits"];
    var prog_course_id = aData["prog_course_id"];
    var aData_mandatory;

    //    if (fees_status != '') {

    //        if (fees_status[0]["fees_status"] == 'H') {

    //            if (this.checked) {

    //                total_creadit = total_creadit + parseInt(aData["credits"]);

    //                if (total_creadit > fees_status[0]["fees_credits"]) {

    //                    bootbox.alert("You Select Max 12 Creadits");
    //                    $(this).prop("checked", false);

    //                    total_creadit = total_creadit - parseInt(aData["credits"]);

    //                    return false;
    //                }
    //                // alert(total_creadit);
    //            }
    //            else {
    //                total_creadit = total_creadit - parseInt(aData["credits"]);

    //                // alert(total_creadit);
    //            }
    //        }
    //        else if (fees_status[0]["fees_status"] == 'F') {
    //            if (this.checked) {
    //                total_creadit = total_creadit + parseInt(aData["credits"]);

    //                if (total_creadit > fees_status[0]["fees_credits"]) {
    //                    bootbox.alert("You Select Max 24 Creadits");
    //                    $(this).prop("checked", false);

    //                    total_creadit = total_creadit - parseInt(aData["credits"]);
    //                    return false;
    //                }
    //                //            alert(total_creadit);
    //            }
    //            else {
    //                total_creadit = total_creadit - parseInt(aData["credits"]);
    //                //            alert(total_creadit);
    //            }
    //        }
    //    }

    if (this.checked) {

        total_creadit = total_creadit + parseInt(aData["credits"]);

        mandatory_credit = mandatory_credit + parseInt(aData["credits"]);

        ///new prog_course_id
        if (course_prog_type_data != "") {
            if (prog_course_id != '') {
                $('#lbl_count_' + prog_course_id).html(parseInt($('#lbl_count_' + prog_course_id).html()) + parseInt(aData["credits"]));
            }
        }

        $('#lbl_mandatory').html(mandatory_credit);
        if (total_creadit > 34) {

            bootbox.alert("You Select Max 34 Creadits for save your courses.");
            $(this).prop("checked", false);

            total_creadit = total_creadit - parseInt(aData["credits"]);

            mandatory_credit = mandatory_credit - parseInt(aData["credits"]);

            $('#lbl_mandatory').html(mandatory_credit);

            ///new prog_course_id
            if (course_prog_type_data != "") {
                if (prog_course_id != '') {
                    $('#lbl_count_' + prog_course_id).html(parseInt($('#lbl_count_' + prog_course_id).html()) - parseInt(aData["credits"]));
                }
            }

            return false;
        }
        // alert(total_creadit);
        // alert(total_creadit);
    }
    else {
        total_creadit = total_creadit - parseInt(aData["credits"]);

        mandatory_credit = mandatory_credit - parseInt(aData["credits"]);

        ///new prog_course_id
        if (course_prog_type_data != "") {
            if (prog_course_id != '') {
                $('#lbl_count_' + prog_course_id).html(parseInt($('#lbl_count_' + prog_course_id).html()) - parseInt(aData["credits"]));
            }
        }

        $('#lbl_mandatory').html(mandatory_credit);
        // alert(total_creadit);
    }


    if (this.checked) {
        var nNodes = oTable.fnGetNodes();
        var nNodes1 = oTable1.fnGetNodes();

        for (var i = 0; i < nNodes.length; i++) {
            if ($(nNodes[i].cells[0].firstChild.firstChild).prop('checked')) {
                //var aPos = oTable1.fnGetPosition(this);
                //   
                var ob = {};
                aData_mandatory = oTable.fnGetData(i);
                //var a = aData[i];

                ob["semester_code"] = aData_mandatory.semester;
                ob["course_code"] = aData_mandatory.course_code;
                datalist.push(ob);

                for (var j = 0; j < nNodes1.length; j++) {
                    //  
                    if ($(nNodes1[j].cells[0].firstChild.firstChild).prop('checked')) {
                        //var aPos = oTable1.fnGetPosition(this);
                        //     
                        var ob1 = {};
                        var aData1 = oTable1.fnGetData(j);
                        //var a = aData[i];

                        ob1["semester_code"] = aData1.semester;
                        ob1["course_code"] = aData1.course_code;
                        datalist1.push(ob1);


                    }

                }
                //return false;
            }
        }



        //$("#example tbody tr").each(function (i) {
        //    if ($(this).find(".madaniyu").is(':checked')) {
        //        var ob = {};
        //        ob["semester_code"] = $(this).children().eq(1).html();
        //        ob["course_code"] = $(this).children().eq(2).html();
        //        datalist.push(ob);
        //        $("#elective1 tbody tr").each(function (j) {
        //            if ($(this).find(".chk_elective").is(':checked')) {
        //                var ob1 = {};
        //                var aPos = oTable1.fnGetPosition(this);
        //                var aData = oTable1.fnGetData(aPos[i]);
        //                var a = aData[i];
        //                //ob["semester_code"] = $(this).children().eq(3).html();
        //                ob1["semester_code"] = a["semester"];
        //                //ob1["semester_code"] = $(this).children().eq(3).html();
        //                ob1["course_code"] = $(this).children().eq(2).html();
        //                datalist1.push(ob1);
        //                //alert($(this).children().eq(3).html());
        //            }
        //        });
        //        //}
        //    }
        //});

        var data = JSON.stringify({ mandatory_time: JSON.stringify(datalist), elective_time: JSON.stringify(datalist1), course_code: course_code, sem_code: sem_code, flag: 'M' });
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/Check_time_validation",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    bootbox.alert(data.d);

                    checkbox.checked = false;
                    total_creadit = total_creadit - parseInt(aData["credits"]);

                    mandatory_credit = mandatory_credit - parseInt(aData["credits"]);

                    ///new prog_course_id
                    if (course_prog_type_data != "") {
                        if (prog_course_id != '') {
                            $('#lbl_count_' + prog_course_id).html(parseInt($('#lbl_count_' + prog_course_id).html()) - parseInt(aData["credits"]));
                        }
                    }

                    $('#lbl_mandatory').html(mandatory_credit);
                }
            },
            error: function (msg) { alert(msg.d); }
        });
    }
    
    //  alert(total_creadit);
});

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

    //if (fees_status != '') {
    //    if (fees_status[0]["fees_status"] == 'H') {
    //        if (this.checked) {
    //            //alert(aData["course_code"]);
    //            total_creadit = total_creadit + parseInt(aData["credits"]);
    //            if (total_creadit > fees_status[0]["fees_credits"]) {
    //                bootbox.alert("You Select Max 12 Creadits");
    //                $(this).prop("checked", false);
    //                total_creadit = total_creadit - parseInt(aData["credits"]);
    //                return false;
    //            }
    //            //  alert(total_creadit);
    //        }
    //        else {
    //            total_creadit = total_creadit - parseInt(aData["credits"]);
    //            //alert(total_creadit);
    //        }
    //    }
    //    else if (fees_status[0]["fees_status"] == 'F') {
    //        if (this.checked) {
    //            total_creadit = total_creadit + parseInt(aData["credits"]);
    //            if (total_creadit > fees_status[0]["fees_credits"]) {
    //                bootbox.alert("You Select Max 24 Creadits");
    //                $(this).prop("checked", false);
    //                total_creadit = total_creadit - parseInt(aData["credits"]);
    //                return false;
    //            }
    //        }
    //        else {
    //            total_creadit = total_creadit - parseInt(aData["credits"]);
    //        }
    //    }
    //}


    if (this.checked) {
        total_creadit = total_creadit + parseInt(aData["credits"]);

        elective_credit = elective_credit + parseInt(aData["credits"]);
        $('#lbl_elective').html(elective_credit);

        if (total_creadit > 34) {
            bootbox.alert("You Select Max 34 Creadits for save your courses.");
            $(this).prop("checked", false);

            total_creadit = total_creadit - parseInt(aData["credits"]);
            elective_credit = elective_credit - parseInt(aData["credits"]);

            $('#lbl_elective').html(elective_credit);
            return false;
        }
    }
    else {
        $("#elective1 tbody tr").each(function (i) {
            if (course_code == $(this).children().eq(2).html()) {
                $(this).find(".priority").val('0');
                generateSelectedAreas();
            }
        });

        total_creadit = total_creadit - parseInt(aData["credits"]);
        elective_credit = elective_credit - parseInt(aData["credits"]);
        $('#lbl_elective').html(elective_credit);
    }

    if (this.checked) {
        var nNodes = oTable1.fnGetNodes();
        var nNodes1 = oTable.fnGetNodes();

        for (var i = 0; i < nNodes.length; i++) {
            if ($(nNodes[i].cells[0].firstChild.firstChild).prop('checked')) {
                //var aPos = oTable1.fnGetPosition(this);

                var ob = {};
                var aData = oTable1.fnGetData(i);
                //var a = aData[i];

                ob["semester_code"] = aData.semester;
                ob["course_code"] = aData.course_code;
                datalist1.push(ob);

                for (var j = 0; j < nNodes1.length; j++) {
                    if ($(nNodes1[j].cells[0].firstChild.firstChild).prop('checked')) {
                        //var aPos = oTable1.fnGetPosition(this);

                        var ob1 = {};
                        var aData1 = oTable.fnGetData(j);
                        //var a = aData[i];

                        ob1["semester_code"] = aData1.semester;
                        ob1["course_code"] = aData1.course_code;
                        datalist.push(ob1);
                    }
                }
            }
            //return false;
        }

        //if (flag == 'Y') {
        //  return false;
        //}

        var data = JSON.stringify({ mandatory_time: JSON.stringify(datalist), elective_time: JSON.stringify(datalist1), course_code: course_code, sem_code: sem_code, flag: 'E' });
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/Check_time_validation",
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
                                    if (course_code == $(this).children().eq(2).html()) {
                                        if ($(this).find(".priority").val() == '0') {
                                            bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                                            total_creadit = total_creadit - parseInt(aData["credits"]);
                                            elective_credit = elective_credit - parseInt(aData["credits"]);

                                            $('#lbl_elective').html(elective_credit);
                                            checkbox.checked = false;

                                            //return false;
                                        }

                                        if ($(this).find(".gpa").val() == '0') {
                                            bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);

                                            if ($(this).find(".priority").val() != '0') {
                                                total_creadit = total_creadit - parseInt(aData["credits"]);
                                                elective_credit = elective_credit - parseInt(aData["credits"]);

                                                $('#lbl_elective').html(elective_credit);
                                                /////////////////////// ADDED BY kamlesh on 28/11/2014
                                                $(this).find(".priority").val('0');

                                                generateSelectedAreas();
                                                ////////////////////////////////
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
                            $("#elective1 tbody tr").each(function (i) {


                                if ($(this).find(".chk_elective").is(':checked')) {

                                    if (course_code == $(this).children().eq(2).html()) {

                                        $(this).find(".priority").val('0');

                                        generateSelectedAreas();
                                    }
                                }
                            });

                            /////////////////////////////////////////

                            checkbox.checked = false;
                            total_creadit = total_creadit - parseInt(aData["credits"]);
                            elective_credit = elective_credit - parseInt(aData["credits"]);

                            generateSelectedAreas();

                            $('#lbl_elective').html(elective_credit);
                            bootbox.alert(data.d);
                        }
                    }
                }
                else {
                    $("#elective1 tbody tr").each(function (i) {
                        if ($(this).find(".chk_elective").is(':checked')) {
                            if (course_code == $(this).children().eq(2).html()) {
                                if ($(this).find(".gpa").val() == '0') {
                                    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);

                                    total_creadit = total_creadit - parseInt(aData["credits"]);
                                    elective_credit = elective_credit - parseInt(aData["credits"]);

                                    $('#lbl_elective').html(elective_credit);
                                    checkbox.checked = false;

                                    /////////////////////// ADDED BY kamlesh on 28/11/2014
                                    $(this).find(".priority").val('0');

                                    generateSelectedAreas();
                                    ////////////////////////////////
                                    return false;
                                    // return false;
                                }

                                if ($(this).find(".priority").val() == '0') {
                                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                                    total_creadit = total_creadit - parseInt(aData["credits"]);
                                    elective_credit = elective_credit - parseInt(aData["credits"]);

                                    $('#lbl_elective').html(elective_credit);

                                    checkbox.checked = false;

                                    return false;
                                }
                            }
                        }
                    });
                }

                return false;
            },
            error: function (msg) { alert(msg.d); }
        });
    }
});
$(document).on("click", ".course_outlin_link", function (event) {

    $('#my_outline').modal('hide');

    $('#txtcourse_outline').html('');
    $('#txt_week1').html('');
    $('#txt_week2').html('');
    $('#txt_week3').html('');
    $('#txt_week4').html('');
    $('#txt_week5').html('');
    $('#txt_week6').html('');
    $('#txt_week7').html('');
    $('#txt_week8').html('');
    $('#txt_week9').html('');
    $('#txt_week10').html('');
    $('#txt_week11').html('');
    $('#txt_week12').html('');
    $('#txt_week13').html('');
    $('#txt_week14').html('');
    $('#txt_week15').html('');
    $('#txt_week16').html('');

    $('#txtcourse_structure').html('');
    $('#txt_course_code').html('');

    $('#txt_reference').html('');
    $('#txt_eval_method').html('');
    $('#head_data').html('');

    $('#lear_outcome').html("");
    $('#lear_outcome1').html("");
    $('#lear_outcome2').html("");
    $('#lear_outcome3').html("");
    $('#lear_outcome4').html("");
    $('#lear_outcome5').html("");

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);

    var flag = 'N';

    var course_code = aData["course_code"];


    $('#txtcourse_outline').html(aData["course_outline"]);

    $('#txt_week1').html(aData["week1"]);
    $('#txt_week2').html(aData["week2"]);
    $('#txt_week3').html(aData["week3"]);
    $('#txt_week4').html(aData["week4"]);
    $('#txt_week5').html(aData["week5"]);
    $('#txt_week6').html(aData["week6"]);
    $('#txt_week7').html(aData["week7"]);
    $('#txt_week8').html(aData["week8"]);
    $('#txt_week9').html(aData["week9"]);
    $('#txt_week10').html(aData["week10"]);
    $('#txt_week11').html(aData["week11"]);
    $('#txt_week12').html(aData["week12"]);
    $('#txt_week13').html(aData["week13"]);
    $('#txt_week14').html(aData["week14"]);
    $('#txt_week15').html(aData["week15"]);
    $('#txt_week16').html(aData["week16"]);

    $('#txtcourse_structure').html(aData["course_structure"]);
    $('#txt_course_code').html(course_code);

    $('#txt_reference').html(aData["remark"]);
    $('#txt_eval_method').html(aData["eval_method1"]);

    $('#img1').css("display", "none");
    $('#img2').css("display", "none");
    $('#img3').css("display", "none");
    $('#img4').css("display", "none");
    $('#img5').css("display", "none");
    $('#img6').css("display", "none");
    $('#img7').css("display", "none");
    $('#mainimg').css("display", "none");
    $('#img567').css("display", "none");

    $('#lear_outcome').html("After completing the " + aData["Course_type_name"] + ",the student will be able to :");
    if (aData["eval_method5"] != "" && aData["eval_method5"] != null) {
        var learing_outcome = JSON.parse(aData.eval_method5);
        if (learing_outcome["course_outcome1"] != "" && learing_outcome["course_outcome1"] != null)
            $('#lear_outcome1').html("- " + learing_outcome["course_outcome1"]);
        if (learing_outcome["course_outcome2"] != "" && learing_outcome["course_outcome2"] != null)
            $('#lear_outcome2').html("- " + learing_outcome["course_outcome2"]);
        if (learing_outcome["course_outcome3"] != "" && learing_outcome["course_outcome3"] != null)
            $('#lear_outcome3').html("- " + learing_outcome["course_outcome3"]);
        if (learing_outcome["course_outcome4"] != "" && learing_outcome["course_outcome4"] != null)
            $('#lear_outcome4').html("- " + learing_outcome["course_outcome4"]);
        if (learing_outcome["course_outcome5"] != "" && learing_outcome["course_outcome5"] != null)
            $('#lear_outcome5').html("- " + learing_outcome["course_outcome5"]);
    }
    if (aData["eval_method4"] != "" && aData["eval_method4"] != null) {

        var CourseImg = JSON.parse(aData["eval_method4"]);
        if (CourseImg.length > 2)
            $('#img567').removeAttr('style');

        if (CourseImg.length > 0) {
            $('#mainimg').removeAttr('style');
            for (var i = 1; i <= CourseImg.length; i++) {

                $('#img' + i).attr("src", "https://connect.cept.ac.in/CEPT/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
                //$('#img' + i).attr("src", "http://27.109.12.252:81/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
                $('#div_caption' + i).html(CourseImg[i - 1]["img_caption"]);
                //$('#div_caption1').html(CourseImg[0]["img_caption"]);
                //$('#div_caption2').html(CourseImg[1]["img_caption"]);
                //$('#img' + i).css("display", "block");
                $('#img' + i).removeAttr('style');
            }
        }
    }
    // head set

    if (aData["semester_type"] == "M") {

        $('#head_data').append("Monsoon");
    } else {

        $('#head_data').append("Spring");
    }
    if (aData["year_semester"] != "") {
        $('#head_data').append(", " + aData["year_semester"]);
    }
    switch (aData["dept_code"]) {
        case "1":
            $('#head_data').append(",  Faculty of Architecture");
            break;
        case "2":
            $('#head_data').append(",  Faculty of Design");
            break;
        case "3":
            $('#head_data').append(",  Faculty of Management");
            break;
        case "4":
            $('#head_data').append(",  Faculty of Planning");
            break;
        case "5":
            $('#head_data').append(",  Faculty of Technology");
            break;
        case "6":
            $('#head_data').append(",  Faculty of Centre of Excellence in Urban Transport");
            break;
        case "7":
            $('#head_data').append(",  Faculty of Summer Winter");
            break;
        case "8":
            $('#head_data').append(",  Faculty of Ahmedabad University");
            break;

        default:
    }
    $('#head_data').append(",  Cept University");
    $('#course_name').html(aData["course_name"]);
    $('#tutors').html(aData["instructor"]);
    //var inst = aData["instructor"].split(',');


    $('#my_outline').modal('show');


    if (aData.course_structure != '') {
        $('#div_weekly_plan').css('display', 'none');
        $('#div_course_structure').css('display', 'block');
    }
    else if (aData.week1 != '' || aData.week2 != '' || aData.week3 != '' || aData.week4 != '' || aData.week5 != '' || aData.week6 != '' || aData.week7 != '' || aData.week8 != '' || aData.week9 != '' || aData.week10 != '' || aData.week11 != '' || aData.week12 != '' || aData.week13 != '' || aData.week14 != '' || aData.week15 != '' || aData.week16 != '') {
        $('#div_weekly_plan').css('display', 'block');
        $('#div_course_structure').css('display', 'none');
    }
    else {
        $('#div_weekly_plan').css('display', 'none');
        $('#div_course_structure').css('display', 'none');
    }

    return false;

});

$(document).on("click", ".course_outlin_link_elective", function (event) {

    $('#my_outline').modal('hide');

    $('#txtcourse_outline').html('');
    $('#txt_week1').html('');
    $('#txt_week2').html('');
    $('#txt_week3').html('');
    $('#txt_week4').html('');
    $('#txt_week5').html('');
    $('#txt_week6').html('');
    $('#txt_week7').html('');
    $('#txt_week8').html('');
    $('#txt_week9').html('');
    $('#txt_week10').html('');
    $('#txt_week11').html('');
    $('#txt_week12').html('');
    $('#txt_week13').html('');
    $('#txt_week14').html('');
    $('#txt_week15').html('');
    $('#txt_week16').html('');

    $('#txtcourse_structure').html('');
    $('#txt_course_code').html('');

    $('#txt_reference').html('');
    $('#txt_eval_method').html('');
    $('#head_data').html('');

    $('#lear_outcome').html("");
    $('#lear_outcome1').html("");
    $('#lear_outcome2').html("");
    $('#lear_outcome3').html("");
    $('#lear_outcome4').html("");
    $('#lear_outcome5').html("");

    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);

    var flag = 'N';

    var course_code = aData["course_code"];


    $('#txtcourse_outline').html(aData["course_outline"]);

    $('#txt_week1').html(aData["week1"]);
    $('#txt_week2').html(aData["week2"]);
    $('#txt_week3').html(aData["week3"]);
    $('#txt_week4').html(aData["week4"]);
    $('#txt_week5').html(aData["week5"]);
    $('#txt_week6').html(aData["week6"]);
    $('#txt_week7').html(aData["week7"]);
    $('#txt_week8').html(aData["week8"]);
    $('#txt_week9').html(aData["week9"]);
    $('#txt_week10').html(aData["week10"]);
    $('#txt_week11').html(aData["week11"]);
    $('#txt_week12').html(aData["week12"]);
    $('#txt_week13').html(aData["week13"]);
    $('#txt_week14').html(aData["week14"]);
    $('#txt_week15').html(aData["week15"]);
    $('#txt_week16').html(aData["week16"]);

    $('#txtcourse_structure').html(aData["course_structure"]);
    $('#txt_course_code').html(course_code);

    $('#txt_reference').html(aData["remark"]);
    $('#txt_eval_method').html(aData["eval_method1"]);

    $('#img1').css("display", "none");
    $('#img2').css("display", "none");
    $('#img3').css("display", "none");
    $('#img4').css("display", "none");
    $('#img5').css("display", "none");
    $('#img6').css("display", "none");
    $('#img7').css("display", "none");
    $('#mainimg').css("display", "none");
    $('#img567').css("display", "none");

    $('#lear_outcome').html("After completing the " + aData["Course_type_name"] + ",the student will be able to :");
    if (aData["eval_method5"] != "" && aData["eval_method5"] != null) {
        var learing_outcome = JSON.parse(aData.eval_method5);

        if (learing_outcome["course_outcome1"] != "" && learing_outcome["course_outcome1"] != null)
            $('#lear_outcome1').html("- " + learing_outcome["course_outcome1"]);
        if (learing_outcome["course_outcome2"] != "" && learing_outcome["course_outcome2"] != null)
            $('#lear_outcome2').html("- " + learing_outcome["course_outcome2"]);
        if (learing_outcome["course_outcome3"] != "" && learing_outcome["course_outcome3"] != null)
            $('#lear_outcome3').html("- " + learing_outcome["course_outcome3"]);
        if (learing_outcome["course_outcome4"] != "" && learing_outcome["course_outcome4"] != null)
            $('#lear_outcome4').html("- " + learing_outcome["course_outcome4"]);
        if (learing_outcome["course_outcome5"] != "" && learing_outcome["course_outcome5"] != null)
            $('#lear_outcome5').html("- " + learing_outcome["course_outcome5"]);
    }
    if (aData["eval_method4"] != "" && aData["eval_method4"] != null) {

        var CourseImg = JSON.parse(aData["eval_method4"]);
        if (CourseImg.length > 2)
            $('#img567').removeAttr('style');

        if (CourseImg.length > 0) {
            $('#mainimg').removeAttr('style');
            for (var i = 1; i <= CourseImg.length; i++) {

                $('#img' + i).attr("src", "https://connect.cept.ac.in/CEPT/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
                //$('#img' + i).attr("src", "http://27.109.12.252:81/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
                $('#div_caption' + i).html(CourseImg[i - 1]["img_caption"]);

                //$('#div_caption2').html(CourseImg[1]["img_caption"]);
                //$('#img' + i).css("display", "block");
                $('#img' + i).removeAttr('style');
            }
        }
    }
    //set Header

    if (aData["semester_type"] == "M") {

        $('#head_data').append("Monsoon Semester");
    } else if (aData["semester_type"] == "S") {

        $('#head_data').append("Spring Semester");
    }

    if (aData["year_semester"] != "") {
        $('#head_data').append(", " + aData["year_semester"]);
    }

    $('#head_data').append(", Faculty of " + aData["department"] + ",  Cept University");
    $('#course_name').html(aData["course_name"]);
    $('#tutors').html(aData["instructor"]);

    $('#my_outline').modal('show');


    if (aData.course_structure != '') {
        $('#div_weekly_plan').css('display', 'none');
        $('#div_course_structure').css('display', 'block');
    }
    else if (aData.week1 != '' || aData.week2 != '' || aData.week3 != '' || aData.week4 != '' || aData.week5 != '' || aData.week6 != '' || aData.week7 != '' || aData.week8 != '' || aData.week9 != '' || aData.week10 != '' || aData.week11 != '' || aData.week12 != '' || aData.week13 != '' || aData.week14 != '' || aData.week15 != '' || aData.week16 != '') {
        $('#div_weekly_plan').css('display', 'block');
        $('#div_course_structure').css('display', 'none');
    }
    else {
        $('#div_weekly_plan').css('display', 'none');
        $('#div_course_structure').css('display', 'none');
    }
    return false;

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
        url: "../WebService.asmx/Get_saved_student_course_data",
        data: {},
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                saved_data = JSON.parse(data.d);

                if (saved_data != "") {
                    for (var i = 0; i < saved_data.length; i++) {
                        total_creadit = total_creadit + parseInt(saved_data[i]["credits"]);
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
    $('#tbl_prog_type tr').html('');
    mandatory_credit = 0;
    elective_credit = 0;

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_mandatory_course_data_for_student",
        data: {},
        async: false,
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                if (data.d == "fees not found") {
                    bootbox.alert("Please Submmit Fees Of Current Semester")
                    return;
                }

                //get_saved_data();

                if (data.d == 'There are no mandatory courses available') {
                    bootbox.alert('There are no mandatory courses available for your department');
                    return false;
                }

                $.ajax({
                    async: false,
                    type: "POST",
                    url: "../WebService.asmx/Get_saved_student_course_data_with_preassigned",
                    data: {},
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != null) {
                            if (data.d[2] != null) {
                                course_prog_type_data = JSON.parse(data.d[2]);

                                if (course_prog_type_data != "") {
                                    for (var i = 0; i < course_prog_type_data.length; i++) {
                                        var row_data = "";

                                        if (course_prog_type_data[i]["color"] != '') {
                                            row_data = "<td style='color: " + course_prog_type_data[i]["color"] + "' id='lbl_" + course_prog_type_data[i]["prog_course_id"] + "'>" + course_prog_type_data[i]["prog_short_name"] + " :</td><td id='lbl_count_" + course_prog_type_data[i]["prog_course_id"] + "'>0</td>";
                                        }
                                        else {
                                            row_data = "<td style='color: Red' id='lbl_" + course_prog_type_data[i]["prog_course_id"] + "'>" + course_prog_type_data[i]["prog_short_name"] + " :</td><td id='lbl_count_" + course_prog_type_data[i]["prog_course_id"] + "'>0</td>";
                                        }

                                        $('#tbl_prog_type tr').append(row_data);
                                    }
                                }
                                else {
                                    course_prog_type_data = "";
                                }
                            }

                            if (data.d[0] != null) {
                                saved_data = JSON.parse(data.d[0]);

                                if (saved_data != "") {
                                    for (var i = 0; i < saved_data.length; i++) {
                                        total_creadit = total_creadit + parseInt(saved_data[i]["credits"]);

                                        if (saved_data[i]["course_type"] == "M") {
                                            mandatory_credit = mandatory_credit + parseInt(saved_data[i]["credits"]);

                                            if (course_prog_type_data != "") {
                                                if (saved_data[i]["prog_course_id"] != '') {
                                                    $('#lbl_count_' + saved_data[i]["prog_course_id"]).html(parseInt($('#lbl_count_' + saved_data[i]["prog_course_id"]).html()) + parseInt(saved_data[i]["credits"]));
                                                }
                                            }
                                        }
                                        else {
                                            elective_credit = elective_credit + parseInt(saved_data[i]["credits"]);
                                        }
                                    }

                                    $('#lbl_mandatory').html(mandatory_credit);
                                    $('#lbl_elective').html(elective_credit);
                                }
                            }
                            else {
                                saved_data = "";
                            }

                            if (data.d[1] != null) {
                                pre_assigned_data = JSON.parse(data.d[1]);

                                if (pre_assigned_data != "") {
                                    for (var i = 0; i < pre_assigned_data.length; i++) {
                                        var flag = 'N';

                                        if (saved_data != "") {
                                            for (var j = 0; j < saved_data.length; j++) {
                                                if (saved_data[j]["course_code"] == pre_assigned_data[i]["course_code"]) {
                                                    flag = 'Y';
                                                }
                                            }
                                        }

                                        if (flag == 'N') {
                                            total_creadit = total_creadit + parseInt(pre_assigned_data[i]["credits"]);

                                            if (pre_assigned_data[i]["course_type"] == "M") {
                                                mandatory_credit = mandatory_credit + parseInt(pre_assigned_data[i]["credits"]);
                                            }
                                            else {
                                                elective_credit = elective_credit + parseInt(pre_assigned_data[i]["credits"]);
                                            }
                                        }
                                    }

                                    $('#lbl_mandatory').html(mandatory_credit);
                                    $('#lbl_elective').html(elective_credit);
                                }
                            }
                            else {
                                pre_assigned_data = "";
                            }
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });

                obj_mandatory_data = JSON.parse(data.d);
                DisplayData(data.d);
            }
            else {
                alert('There is no data found');
            }
        },
        error: function (data) {
            alert(data.d);
        }
    });

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_elective_course_data_for_student",
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
                    url: "../WebService.asmx/Get_saved_student_course_data",
                    data: {},
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {
                        if (data.d != "") {
                            saved_data = JSON.parse(data.d);
                        }
                        else {
                            saved_data = "";
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });

                var obj_elective_data = JSON.parse(data.d);

                if (obj_mandatory_data != undefined && obj_mandatory_data.length > 0) {
                    for (var i = 0; i < obj_elective_data.length; i++) {
                        var temp_obj = $.grep(obj_mandatory_data, function (data) { return data.course_code == obj_elective_data[i]['course_code'] });

                        if (temp_obj.length > 0) {
                            obj_elective_data.splice(i, 1);
                            i--;
                        }
                    }
                }

                if (obj_elective_data.length > 0) {
                    DisplayData1(obj_elective_data);
                    //get_saved_data();
                }
            }
            else {
                alert('There is no data found');
            }
        },
        error: function (data) {
            alert(data.d);
        }
    });
}

function DisplayData(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> <tfoot id="abc"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 5px; display: none" name="search_engine" value=""class="search_init" /></th><th><input type="text" style="width: 35px" name="search_engine" value="" class="search_init" /></th><th><center><input type="text" style="width: 54px;" name="search_Faculty" value="" class="search_init" /></center></th><th><input type="text" style="width: 86px" name="search_semester" value="" class="search_init" /></th><th><input type="text" style="width: 25px" name="search_code" value="" class="search_init" /></th><th><center><input type="text" style="width: 95px" name="search_name" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 47px" name="search_credits" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 50px" name="search_pre" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 100px" name="search_instructor" value="" class="search_init" /></center></th><th></th></tr></tfoot> </tbody> </table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //"sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        "oTableTools": {
            "aButtons": [
            ]
        },
        "aaData": JSON.parse(data),
        "aoColumns": [
            {
                "sTitle": "Select",
                "mData": null,
                "bSortable": false,
                "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="madaniyu" ></center>'
            },
            { "sTitle": "Sem.", "mData": "semester", "bSortable": false },
            { "sTitle": "Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Name", "mData": "course_name", "bSortable": false },
            { "sTitle": "Credits", "mData": "credits", "bSortable": false },
            { "sTitle": "faculty", "mData": "instructor", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            { "sTitle": "Days", "mData": "days", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            {
                "sTitle": "Course Outline",
                "bSortable": false,
                "mData": null,



                "mRender": function () {


                    //                //alert(course_code);
                    return '<center><a style="cursor:pointer" class="course_outlin_link" >View</a></center>';



                }
            }
        ],
        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            /* imagine aData[0] is an object, not a string {text: 'X1', title: 'Title X1'} */
            $('td:eq(3)', nRow).attr('title', aData.course_desc).tooltip();
            $('td:eq(3)', nRow).css({ cursor: "pointer" });
            return nRow;
        }
    });

    //.columnFilter({ sPlaceHolder: "head:before",
    //  aoColumns: [{ type: "text" },
    //	    { type: "date-range" },
    //      { type: "date-range" }
    //	]
    //});

    get_fees_status();

    $("#example tbody tr").each(function (i) {
        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];

        if (a.color != '') {
            $(this).children('td').css("background-color", a.color);
        }

        if (saved_data != "") {
            for (var j = 0; j < saved_data.length; j++) {
                if (saved_data[j]["doc_no"] == a["doc_no"]) {
                    $(this).find(".madaniyu").prop('checked', true);
                }
            }
        }
        else {
            if (a.prog_level_code != "PA2") {
                if (a.student_current_sem == "1") {
                    if (a.semester == a.student_current_sem) {
                        $(this).find(".madaniyu").prop('checked', true);
                        mandatory_credit = mandatory_credit + parseInt(a.credits);
                    }
                }
            }
            //listItems += "<option  value='" + exporess[i]["Document_number"] + "'>" + exporess[i]["expression"] + "</option>";
        }
    });

    if (saved_data == "") {
        $('#lbl_mandatory').html(mandatory_credit);
        total_creadit = mandatory_credit;
    }

    $("#example tbody tr").each(function (i) {
        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];

        if (pre_assigned_data != "") {
            for (var j = 0; j < pre_assigned_data.length; j++) {
                if (pre_assigned_data[j]["course_code"] == a["course_code"]) {
                    $(this).find(".madaniyu").prop('checked', true);
                    $(this).find(".madaniyu").attr("disabled", "disabled");
                    $(this).children('td').css("background-color", "red");
                }
            }
        }
        else {
        }
    });

    $("#abc input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("#abc input").index(this));
    });

    /*
    * Support functions to provide a little bit of 'user friendlyness' to the textboxes in
    * the footer
    */
    
    $("#abc input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("#abc input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("#abc input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("#abc input").index(this)];
        }
    });

    $('#btnsave').css("display", "block");
    $('#btn_save').css("display", "block");
    $('#btn_print').css("display", "block");
    $('#btnonlinepayment').css("display", "block");
}

function get_fees_status() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_fees_status",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                fees_status = JSON.parse(data.d);
            }
            else {
                fees_status = '';
            }
        },
        error: function (data) {
            alert(data.d);
        }
    });

    return false;
}

function get_mandatory_time_day_data() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_mandatory_time_day_data",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                mandatory_time_day_data = JSON.parse(data.d);
            }
            else {
                alert('There is no data found');
            }
        },
        error: function (data) {
            alert(data.d);
        }
    });

    return false;
}

function DisplayData1(data) {
    if (oTable1 != null) {
        oTable1.fnDestroy();
        $("#datalist_elective").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="elective1"><thead></thead><tbody> </tbody><tfoot id="abc1"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th><input type="text" style="width: 10px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th><input type="text" style="width: 30px" name="search_code" value="" class="search_init" /></th><th><input type="text" style="width: 79px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 10px" name="search_credits" value="" class="search_init" /></th><th><input type="text" style="width: 70px;" name="search_pre" value="" class="search_init" /></th><th><input type="text" style="width: 50px;" name="search_Faculty" value="" class="search_init" /></th><th><input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" /></th><th> <input type="text" style="width: 48px" name="search_time" value="" class="search_init"></th><th><input type="text" style="width: 48px" name="search_days" value="" class="search_init" /></th><th><input type="text" style="width: 72px" name="search_Area" value="" class="search_init" /></th><th><input type="text" style="width: 1px; display: none" name="search_Area" value="Area"class="search_init" /></th><th> <input type="text" style="width: 1px; display: none" name="" value="Area" class="search_init" /> </th> </tr></tfoot></table>');
    }

    oTable1 = $("#elective1").dataTable({
        "bPaginate": false,
        "bStateSave": false,
        //"fnStateLoad": function (oSettings) {
        //  return false;
        //},
        //"sDom": 't',
        "bAutoWidth": false,
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"bJQueryUI": true,
        //"sScrollY": '400px',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oTableTools": {
            "aButtons": [
            ]
        },
        "aaData": data,
        "aoColumns": [
            {
                "sTitle": "Select",
                "mData": null,
                "bSortable": false,

                "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_elective" ></center>'
            },
            {
                "sTitle": "Priority",
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
                    listItems += "<option value='6'>6</option>";
                    listItems += "<option value='7'>7</option>";
                    listItems += "<option value='8'>8</option>";
                    listItems += "<option value='9'>9</option>";
                    listItems += "<option value='10'>10</option>";
                    listItems += '</select>';

                    return listItems;
                }
            },
            { "sTitle": "Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Name", "mData": "course_name", "bWidth": "5px", "bSortable": false },
            { "sTitle": "Credits", "mData": "credits", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Faculty", "mData": "department", "bSortable": false },
            { "sTitle": "faculty", "mData": "instructor", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            { "sTitle": "Days", "mData": "days", "bSortable": false },
            { "sTitle": "Area", "mData": "area", "bSortable": false },
            {
                "sTitle": "GPA/Non GPA",
                "bSortable": false,
                "mData": null,
                fnRender: function (oObj) {
                    var listItems = '<select class="gpa">';
                    listItems += "<option value='0'>Select</option>";
                    listItems += "<option value='G'>GPA</option>";
                    listItems += "<option value='N'>Non GPA</option>";
                    listItems += '</select>';
                    return listItems;
                }
            },
            { "sTitle": "Sem", "mData": "semester", "bSortable": false, "bVisible": false, "aTargets": [0] },
            {
                "sTitle": "Selected Priority",
                "bSortable": false,
                "mData": null,
                fnRender: function (oObj) {
                    var listItems = '<div style= "font-size: 10px;">Total Registration = ' + oObj.aData.total_reg_student + '</div><div class="progress progress-mini progress-striped active pos-rel" style="width:100px; height: 15px;" >';
                    if (oObj.aData.total_reg_student != 0) {
                        listItems += '<div style="background-color: #2a91d8; background-size: 40px 40px; -webkit-animation: progress-bar-stripes 4s linear infinite;background-image: -webkit-linear-gradient(44deg,rgba(255,255,255,.15) 25%,transparent 25%,transparent 50%,rgba(255,255,255,.15) 50%,rgba(255,255,255,.15) 75%,transparent 75%,transparent); width:' + parseInt((parseInt(oObj.aData.total_priority) * 100) / parseInt(oObj.aData.total_reg_student)) + '%;" class="progress bar-danger prog-image-anim" ></div>';
                    }
                    else {
                        listItems += '<div style="background-color: #2a91d8; background-size: 40px 40px; -webkit-animation: progress-bar-stripes 4s linear infinite;background-image: -webkit-linear-gradient(44deg,rgba(255,255,255,.15) 25%,transparent 25%,transparent 50%,rgba(255,255,255,.15) 50%,rgba(255,255,255,.15) 75%,transparent 75%,transparent); width:0%;" class="progress bar-danger prog-image-anim" ></div>';
                    }
                    listItems += '</div><div style="font-size: 10px; margin-top:-20px">Registration as Priority 1 = ' + oObj.aData.total_priority + '</div>';
                    return listItems;
                }
            },
            {
                "sTitle": "Course Outline",
                "bSortable": false,
                "mData": null,
                "mRender": function () {
                    return '<center><a style="cursor:pointer" class="course_outlin_link_elective" >View</a></center>';
                }
            }
        ],
        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            /* imagine aData[0] is an object, not a string {text: 'X1', title: 'Title X1'} */
            $('td:eq(3)', nRow).attr('title', aData.course_desc).tooltip();
            $('td:eq(3)', nRow).css({ cursor: "pointer" });
            return nRow;
        }

    });

    //.columnFilter({
    //    aoColumns: [null
    //    //{ sSelector: "#renderingEngineFilter" }
    //                                				]
    //});
    //new FixedHeader(oTable1);

    $("#elective1 tbody tr").each(function (i) {
        var aPos = oTable1.fnGetPosition(this);
        var aData = oTable1.fnGetData(aPos[i]);
        var a = aData[i];

        if (saved_data != "") {
            for (var j = 0; j < saved_data.length; j++) {
                if (saved_data[j]["doc_no"] == a["doc_no"]) {
                    $(this).find(".chk_elective").prop('checked', true);

                    if (saved_data[j]["gpa_nongpa"] != '') {
                        $(this).find(".gpa").val(saved_data[j]["gpa_nongpa"]);
                        $(this).find(".priority").val(saved_data[j]["priority"]);
                    }
                }
            }
        }
        else {
            // listItems += "<option  value='" + exporess[i]["Document_number"] + "'>" + exporess[i]["expression"] + "</option>";
        }
    });

    //.columnFilter({
    //  aoColumns: [null,
    //      { sSelector: "#renderingEngineFilter" }
    //  ]
    //}
    //);

    generateSelectedAreas();

    //$('#elective1 th').bind('mouseup', function (event) {
    //    var index = $(this).parent().children().index($(this));
    //    var colWidth = $(this).css('width');
    //    var input = $('#elective1 tfoot tr input:eq(' + index + ')');
    //    alert('kamlesh');
    //    input.css("width", colWidth);
    //});

    //$('#elective1 thead tr').find(':input').each(function (index) {
    //    var colWidth = $('#elective1 tbody tr th:eq(' + index + ')').css('width');
    //    var colWidth1 = $(this).css('width');
    //    var input = $('#elective1 tfoot tr input:eq(' + index + ')');
    //    alert(input + '-' + colWidth1);
    //    $(this).css("width", "42");
    //});

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
}

function get_prerequisite(data) {
    var str_return = '';
    var obj_prerequisite;
    if (data != "") {
        try {
            obj_prerequisite = JSON.parse(data);
        } catch (e) {
            return data;
        }

        if (obj_prerequisite["chkbox"] != "") {
            var split_chk_data = obj_prerequisite["chkbox"].split('~');

            for (var i = 0; i < split_chk_data.length; i++) {
                if (split_chk_data[i] != 'chk_pre10') {
                    if (str_return != '') str_return = str_return + ', ';

                    switch (split_chk_data[i]) {
                        case 'chk_pre1':
                            str_return = str_return + 'None'; break;
                        case 'chk_pre2':
                            str_return = str_return + 'Completed 3rd year FA'; break;
                        case 'chk_pre3':
                            str_return = str_return + 'Completed 3rd year FD'; break;
                        case 'chk_pre4':
                            str_return = str_return + 'Completed 3rd year FP'; break;
                        case 'chk_pre5':
                            str_return = str_return + 'Completed 3rd year FT'; break;
                        case 'chk_pre6':
                            str_return = str_return + 'Completed UG Architecture'; break;
                        case 'chk_pre7':
                            str_return = str_return + 'Completed UG Planning'; break;
                        case 'chk_pre8':
                            str_return = str_return + 'Completed UG Design'; break;
                        case 'chk_pre9':
                            str_return = str_return + 'Completed UG Technology/ Engineering'; break;
                    }
                }
            }
        }

        if (obj_prerequisite["other"] != "") {
            if (str_return != '') str_return = str_return + ', ';
            str_return = str_return + obj_prerequisite["other"];
        }
    }

    return str_return;
}

function chek_fees_status() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_fees_status_new",
        data: {},
        contentType: "application/json",
        datatype: "json",
        async: false,
        success: function (data) {
            if (data.d != null) {
                if (data.d[0] != null) {
                    fees_status = JSON.parse(data.d[0]);

                    if (fees_status[0]["fees_status"] != "") {
                        if (fees_status[0]["fees_status"] == "H") {
                            $('#txtcredit_choice').prop("disabled", true);
                            $('#btn_save_credit').prop("disabled", true);
                        }
                        else if (fees_status[0]["fees_status"] == "F") {
                        }
                        else {
                            $('#btnsave').prop("disabled", true);
                            $('#btn_save').prop("disabled", true);
                            $('#txtcredit_choice').prop("disabled", true);
                            $('#btn_save_credit').prop("disabled", true);
                        }
                    }
                    else {
                        $('#btnsave').prop("disabled", true);
                        $('#btn_save').prop("disabled", true);
                        $('#txtcredit_choice').prop("disabled", true);
                        $('#btn_save_credit').prop("disabled", true);
                    }
                }
                else {

                    $('#btnsave').prop("disabled", true);
                    $('#btn_save').prop("disabled", true);
                    $('#txtcredit_choice').prop("disabled", true);
                    $('#btn_save_credit').prop("disabled", true);
                }

                if (data.d[1] != null) {
                    var choice_credits = data.d[1];

                    if (choice_credits != '') {
                        $('#txtcredit_choice').val(choice_credits);

                        // if (choice_credits < 16) {
                        if (choice_credits < 13) {
                            $('#txtcredit_choice').prop("disabled", true);
                            $('#btn_save_credit').prop("disabled", true);
                        }
                    }
                }
            }
            else {
                $('#btnsave').prop("disabled", true);
                $('#btn_save').prop("disabled", true);
                $('#txtcredit_choice').prop("disabled", true);
                $('#btn_save_credit').prop("disabled", true);
            }
        },
        error: function (data) {
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
    document.aspnetForm.action = merchantURLPart;
    document.aspnetForm.method = 'POST';
    document.aspnetForm.submit();
}

function IsNumeric(e) {
    var keyCode = e.which ? e.which : e.keyCode;

    if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        return true;
    }

    if (keyCode >= 48 && keyCode <= 57) {
        //if (parseInt($(document.activeElement).val()) > 10) {
        //    return false;
        //}
        //else if (parseInt($(document.activeElement).val()) == 10) {
        //    if (keyCode != 48) {
        //        return false;
        //    }
        //}

        return true;
    }
    else {
        return false;
    }
}