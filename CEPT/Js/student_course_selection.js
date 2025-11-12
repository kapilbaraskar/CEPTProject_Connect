var oTable;
var oTable1;
var oTable3;
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
var cur_tab = 1;
var total_tab = 5;
var enroll_year = '';
var str_credit_choice = '';
var thesis_typology = [{ 'type_code': '2' }, { 'type_code': '15' }, { 'type_code': '25' }];
var portfolio_status = false;

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

    get_chk_agree_consent_form();

    function get_chk_agree_consent_form() {

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/get_chk_agree_consent_form_dtl",
            data: "{}",
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    var result = JSON.parse(data.d);
                    if (result[0]["agree_affidavit"] == "Y" && result[0]["agree_reg_process"] == "Y" && result[0]["agree_consent_form"] == "Y") {//result[0]["semester_type"] == 'S' && result[0]["year_semester"] == '2020' && 
                        $("#chk_agree_consent_form").prop('checked', true);
                    }
                    else {
                        $("#chk_agree_consent_form").prop('checked', false);
                    }
                }
                else {
                    //bootbox.alert("Your Gender is not updated");
                }
            },
            Error: function (data) {
                alert(data.d);
            }
        });

    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/get_thesis_detl",
        async: false,
        // data: "{}",
        data: "{sem_code:'',year_code:'',prog_code:'',dept_code:'',user_type:'',user_id:''}",
        dataType: "json",
        success: function (data) {
            if (data.d != "" && data.d != "[]") {
                var thesis_drp_data = JSON.parse(data.d);
                if (thesis_drp_data.length > 0) {
                    if (thesis_drp_data[0]["form_type"] == "25")
                        $("#type").html('<b>Thesis Title</b>');
                    else
                        $("#type").html('<b>DRP Title</b>');
                    $("#title").html(thesis_drp_data[0]["topic"]);
                    $("#guide_name").html(thesis_drp_data[0]["instructor_name"]);
                }
                $('#div_thisis_drp_guide').css('display', '');
            }
            else {
                //bootbox.alert('Thesis/DRP Details not Found');
                $('#div_thisis_drp_guide').css('display', 'none');
            }
        },
        error: function (result) {
            alert(result);
        }
    });

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
        str_html = str_html + "<link href='https://connect.cept.ac.in/DesignCss/bootstrap-responsive.min.css' rel='stylesheet' />" + $('style')[0].outerHTML + "</head><body>" + $('#my_print_outline').html() + "</body></html>";

        str_html = str_html.replace(/</g, '&lt;');
        str_html = str_html.replace(/>/g, '&rt;');

        $('#hdn_outline').val(str_html);
        $('#hdn_download').click();

        return false;
    });

    $('.btn_save_next').on('click', function () {

        $('#li_step' + (cur_tab + 1)).find('.cls_tab_a').click();
    });

    $('.btn_save').on('click', function () {
        // changes 28072021
        if (parseInt($('#txt_mandatory_credits').val()) == 0)
        {
            if (parseInt($('#txt_elective_credits').val()) == 0)
            {
                bootbox.alert('Please Enter Elective Creadit.');
                return false;
            }
        }
        else
        {
            if (total_creadit == '0' && fees_status[0]['fees_status'] != 'H') {
                bootbox.alert('Please Select Course. You have not selected any course');
                return false;
            }
        }

        //if (total_creadit == '0' && fees_status[0]['fees_status'] != 'H') {
        //    bootbox.alert('Please Select Course. You have not selected any course');
        //    return false;
        //}
        if (mandatory_credit > 0 && parseInt($('#txt_mandatory_credits').val()).toString() != "NaN" && mandatory_credit != parseInt($('#txt_mandatory_credits').val())) {
            bootbox.alert('Your Total Mandatory Course Selection does not match with your Mandatory Credit selection. Please Enter Mandatory Credit choice same as Mandatory Course Selection.');
            $('#txt_mandatory_credits').focus();
            $('#li_step1').find('.cls_tab_a').click();
            return false;
        }

        var flag = "N";

        var mandatory_datalist = [];
        var elective_datalist = [];

        if (oTable != undefined) {

            var oSettings = oTable.fnSettings();

            for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                oSettings.aoPreSearchCols[iCol].sSearch = '';
            }

            oSettings.oPreviousSearch.sSearch = '';
            oTable.fnDraw();
        }

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
                obj["gpa_nongpa"] = $(this).children().eq(8).html();
                mandatory_datalist.push(obj);
            }
        });


        $("#elective1 tbody tr").each(function (i) {
            if ($(this).find(".chk_elective").is(':checked')) {
                var course_code = $(this).children().eq(2).html();

                if (cur_tab == 4) {
                    if ($(this).find(".gpa").val() == '0') {
                        bootbox.alert('Please Select GPA/NGPA For Course : ' + course_code);
                        //total_creadit = total_creadit - parseInt(aData["credits"]);
                        //elective_credit = elective_credit - parseInt(aData["credits"]);
                        //$('#lbl_elective').html(elective_credit);
                        //checkbox.checked = false;
                        flag = 'Y';
                        return false;
                    }

                    if ($(this).find(".priority").val() == '0') {
                        bootbox.alert('Please Select Priority No. For Course : ' + course_code);
                        //total_creadit = total_creadit - parseInt(aData["credits"]);
                        //elective_credit = elective_credit - parseInt(aData["credits"]);
                        //$('#lbl_elective').html(elective_credit);
                        //checkbox.checked = false;
                        flag = 'Y';
                        return false;
                    }
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
            var status_flag = (cur_tab == 4) ? 'SS' : 'S';
            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: status_flag, thesis_guide: '' });

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
                            total_creadit = 0;
                            bind_sem_course_data();
                            $('#li_step' + (cur_tab + 1)).find('.cls_tab_a').click();
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
                            //    //total_creadit = 0;
                            //    //bind_sem_course_data();
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

        //if (total_creadit == '0') {
        if (total_creadit == '0' && fees_status[0]['fees_status'] != 'H') {
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
        var thesis_guide = '';
        var is_thesis = false;

        if (oTable != undefined) {
            var oSettings = oTable.fnSettings();
            for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                oSettings.aoPreSearchCols[iCol].sSearch = '';
            }
            oSettings.oPreviousSearch.sSearch = '';
            oTable.fnDraw();
        }

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
                obj["gpa_nongpa"] = $(this).children().eq(8).html();
                mandatory_datalist.push(obj);

                var row_data = oTable.fnGetData(this);
                if ($.grep(thesis_typology, function (data) { return data['type_code'] == row_data['course_typology']; }).length > 0) {
                    is_thesis = true;
                }
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

        if (is_thesis) {
            $('#tbl_add_guide tbody tr').each(function () {
                if ($(this).find('.drp_instructor').val() != '') {
                    if ($(this).find('.drp_instructor').val() == 'other') {
                        if ($(this).find('.cls_other_guide').val().trim() != '') {
                            thesis_guide += $(this).find('.cls_other_guide').val().trim() + ', ';
                        }
                    }
                    else {
                        thesis_guide += $(this).find('.drp_instructor')[0].selectedOptions[0].innerHTML.trim() + ', ';
                    }
                }
            });

            if (thesis_guide == '') {
                //uncomment to on this feature
                //bootbox.alert('Please Select your Guide.');
                //return false;
            }
            else {
                thesis_guide = thesis_guide.substr(0, thesis_guide.length - 2).trim();
            }
        }

        if (flag == "N") {
            bootbox.confirm("Please check all the courses you have selected. \nOnce registered you will not be able to change the courses.", function (result) {
                if (result == true) {
                    bootbox.confirm("Are you sure to proceed with registration?", function (result1) {
                        if (result1 == true) {
                            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'R', thesis_guide: thesis_guide });

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
                                            total_creadit = 0;
                                            //bind_sem_course_data();
                                        }

                                        bootbox.alert(data.d, function () {
                                            location.reload();
                                        });
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

    $('#btn_save_credit').on('click', function ()
    {
        var selected_credit_choice = { 'mandatory_credits': 0, 'elective_credits': 0, 'sws_credits': 0, 'selected_credits': '' };
        var selected_credits = "";

        if ($('#txt_mandatory_credits').val().trim() != "" && !(parseInt($('#txt_mandatory_credits').val()).toString() == 'NaN')) {
            selected_credit_choice.mandatory_credits = parseInt($('#txt_mandatory_credits').val());
        }
        else {
            bootbox.alert('please enter your mandatory credits choice you would like to apply');
            return false;
        }

        if ($('#txt_elective_credits').val().trim() != "" && !(parseInt($('#txt_elective_credits').val()).toString() == 'NaN')) {
            selected_credit_choice.elective_credits = parseInt($('#txt_elective_credits').val());
        }
        else {
            bootbox.alert('please enter your elective credits choice you would like to apply');
            return false;
        }

        if ($('#txt_sws_credits').val().trim() != "" && !(parseInt($('#txt_sws_credits').val()).toString() == 'NaN')) {
            selected_credit_choice.sws_credits = parseInt($('#txt_sws_credits').val());
        }
        else {
            bootbox.alert('please enter your sws credits choice you would like to apply');
            return false;
        }

        if (fees_status != undefined && fees_status != '' && fees_status != null && fees_status[0]['fees_status'] == 'H') {
            var temp_total_credit = selected_credit_choice.mandatory_credits + selected_credit_choice.elective_credits + selected_credit_choice.sws_credits;

            if (temp_total_credit != parseInt(str_credit_choice)) {
                bootbox.alert('Total entered credits must be same as Total credits you have applied for');
                return false;
            }
        }

        //Temporary
        var temp_total_creditt = selected_credit_choice.mandatory_credits + selected_credit_choice.elective_credits + selected_credit_choice.sws_credits;

        if (temp_total_creditt > 20) {
            bootbox.alert('Total entered credits can not be more than 20');
            return false;
        }

        $('#txtcredit_choice').val(selected_credit_choice.mandatory_credits + selected_credit_choice.elective_credits + selected_credit_choice.sws_credits);
        $('#spn_credit_choice').html(selected_credit_choice.mandatory_credits + selected_credit_choice.elective_credits + selected_credit_choice.sws_credits);

        if ($('#txtcredit_choice').val().trim() != "") {
            selected_credits = $('#txtcredit_choice').val();
            selected_credit_choice.selected_credits = $('#txtcredit_choice').val();
        }
        else {
            bootbox.alert('please enter your total credits you would like to apply');
            return false;
        }

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/save_user_choice_of_credits",
            //data: "{selected_credits:'" + selected_credits + "'}",
            data: "{selected_credit_choice:'" + JSON.stringify(selected_credit_choice) + "'}",
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    var result = JSON.parse(data.d);

                    if (result["status"]) {
                        bootbox.alert(result["message"]);
                        // changes 28072021
                        if (selected_credit_choice.mandatory_credits <= 0)
                        {
                            $('.remove0').remove();
                        }
                        chek_fees_status();

                        $('#li_step' + (cur_tab + 1)).find('.cls_tab_a').click();
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

    $('#txt_mandatory_credits,#txt_elective_credits,#txt_sws_credits').on('change', function () {
        if (fees_status != undefined && fees_status != '' && fees_status != null && fees_status[0]['fees_status'] != 'H') {
            if (parseInt($('#txt_mandatory_credits').val()).toString() != 'NaN' &&
                parseInt($('#txt_elective_credits').val()).toString() != 'NaN' && parseInt($('#txt_sws_credits').val()).toString() != 'NaN') {
                $('#spn_credit_choice').html(parseInt($('#txt_mandatory_credits').val()) + parseInt($('#txt_elective_credits').val()) + parseInt($('#txt_sws_credits').val()));
            }
            else {
                $('#spn_credit_choice').html('');
            }
        }
    });

    $('.btn_prev').on('click', function () {
        $('#li_step' + (cur_tab - 1)).find('.cls_tab_a').click();
    });

    $('.cls_tab_a').on('click', function () {
        var id = $(this).closest('li')[0].id;
        id = parseInt(id.substr(id.length - 1));
        //$('#tr_step' + cur_tab).css('display', 'none');
        $('.cls_tr_btn').css('display', 'none');
        $('#tr_step' + id).css('display', '');
        cur_tab = id;
    });

    portfolio_status = false;

    check_portfolio_status();

    if (portfolio_status) {
        bind_sem_course_data();
    }

    chek_fees_status();

    bindinstructor();



    $('#view_mand_course').on('click', function () {

        $('#example thead tr th:first-child,#example thead tr th:last-child').css('display', 'none');
        $('#example tbody tr td:first-child,#example tbody tr td:last-child').css('display', 'none');

        var str_head = '<link href="../DesignCss/bootstrap.min.css" rel="stylesheet"><link href="../DesignCss/bootstrap-responsive.min.css" rel="stylesheet"><link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"><link href="../DesignCss/fullcalendar.css" rel="stylesheet" type="text/css"><link href="../DesignCss/chosen.css" rel="stylesheet" type="text/css"><link href="../DesignCss/css.css" rel="stylesheet"><link href="../DesignCss/ace.min.css" rel="stylesheet"><link href="../DesignCss/ace-responsive.min.css" rel="stylesheet"><link href="../DesignCss/ace-skins.min.css" rel="stylesheet"><link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css"><link href="../Style/dataTables.bootstrap.css" rel="stylesheet" type="text/css"><link href="../media/css/TableTools.css" rel="stylesheet" type="text/css"><link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css"><link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css"><link href="../DesignCss/bootstrap-switch.css" rel="stylesheet" type="text/css"><link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css"><script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script><script src="../DesignJS/jquery.min.js" type="text/javascript"></script>';
        //$('link').each(function (i) { if (this.innerHTML == '') str_head += this.outerHTML; });
        //$('script').each(function (i) { if (this.innerHTML == '') str_head += this.outerHTML; });

        var mywindow = window.open('', 'Print_data', 'height=400,width=600');
        mywindow.document.write('<html><head>' + str_head + '</head><body>');
        mywindow.document.write($('#tbl_prog_type').closest('div')[0].outerHTML);
        mywindow.document.write('<table class="table table-striped table-bordered table-hover dataTable" style="font-size:13px;"><thead>' + $('#example thead').html() + '</thead><tbody>' + $('#example tbody').html() + '</tbody></table>');
        mywindow.document.write('</body></html>');

        $('#example thead tr th:first-child,#example thead tr th:last-child').css('display', '');
        $('#example tbody tr td:first-child,#example tbody tr td:last-child').css('display', '');
    });

    $('#view_elec_course').on('click', function () {
        $('#elective1 thead tr th:first-child,#elective1 thead tr th:last-child').css('display', 'none');
        $('#elective1 tbody tr td:first-child,#elective1 tbody tr td:last-child').css('display', 'none');

        var str_head = '<link href="../DesignCss/bootstrap.min.css" rel="stylesheet"><link href="../DesignCss/bootstrap-responsive.min.css" rel="stylesheet"><link href="../font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"><link href="../DesignCss/fullcalendar.css" rel="stylesheet" type="text/css"><link href="../DesignCss/chosen.css" rel="stylesheet" type="text/css"><link href="../DesignCss/css.css" rel="stylesheet"><link href="../DesignCss/ace.min.css" rel="stylesheet"><link href="../DesignCss/ace-responsive.min.css" rel="stylesheet"><link href="../DesignCss/ace-skins.min.css" rel="stylesheet"><link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css"><link href="../Style/dataTables.bootstrap.css" rel="stylesheet" type="text/css"><link href="../media/css/TableTools.css" rel="stylesheet" type="text/css"><link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css"><link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css"><link href="../DesignCss/bootstrap-switch.css" rel="stylesheet" type="text/css"><link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css"><script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script><script src="../DesignJS/jquery.min.js" type="text/javascript"></script>';

        var mywindow = window.open('', 'Print_data', 'height=400,width=600');
        mywindow.document.write('<html><head>' + str_head + '</head><body>');
        mywindow.document.write('<table class="table table-striped table-bordered table-hover dataTable" style="font-size:13px;"><thead>' + $('#elective1 thead').html() + '</thead><tbody>' + $('#elective1 tbody').html() + '</tbody></table>');
        mywindow.document.write('</body></html>');

        $('#elective1 thead tr th:first-child,#elective1 thead tr th:last-child').css('display', '');
        $('#elective1 tbody tr td:first-child,#elective1 tbody tr td:last-child').css('display', '');
    });
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
                    bootbox.alert('You have already selected this Priority for Course : ' + $(nNodes[i]).children().eq(2).html());
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

    //$("#elective1 tbody tr").each(function (j) {
    //    if ($(this).find(".priority").val() != '0') {
    //        if ((parseInt(val) - parseInt(1)) == $(this).find(".priority").val()) {
    //            flag = 'Y';
    //            return false;
    //        }
    //        else {
    //            flag = 'N';
    //        }
    //    }
    //});

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

var str_instructor = '';
$(document).on("click", "#btn_add_guide", function (event) {
    if ($('#tbl_add_guide tbody tr').length < 2) {
        var str_html = '<tr><td style="padding-bottom: 10px;">Select Guide&nbsp;&nbsp;:&nbsp;&nbsp;</td>' +
            '<td><select class="drp_instructor"><option value="">-- Select Guide --</option>' + str_instructor + '</select></td>' +
            '<td class="cls_other_txt" style="padding-left: 20px;padding-bottom: 10px;display: none;">Enter Guide Name&nbsp;&nbsp;:&nbsp;&nbsp;</td>' +
            '<td class="cls_other_txt" style="display: none;"><input type="text" class="cls_other_guide" /></td></tr>';
        $('#tbl_add_guide tbody').append(str_html);
    }
});

$(document).on("change", ".drp_instructor", function (event) {
    if (this.value == 'other') {
        $(this).closest('tr').find('.cls_other_txt').css('display', '');
    }
    else {
        $(this).closest('tr').find('.cls_other_txt').css('display', 'none');
    }
});

function bindinstructor() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_faculty_data",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var instructor_data = JSON.parse(data.d);

                for (var i = 0; i < instructor_data.length; i++) {
                    str_instructor = str_instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                }

                if (instructor_data != '') {
                    str_instructor = str_instructor + "<option value='other'>Other Guide</option>";
                }
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

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

            bootbox.alert("You can select maximum 34 credits for your course selection.");
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
            bootbox.alert("You can select maximum 34 credits for your course selection.");
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
                            //$("#elective1 tbody tr").each(function (i) {
                            //if ($(this).find(".chk_elective").is(':checked')) {
                            //if (course_code == $(this).children().eq(2).html()) {
                            //if ($(this).find(".priority").val() == '0') {
                            //    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                            //    total_creadit = total_creadit - parseInt(aData["credits"]);
                            //    elective_credit = elective_credit - parseInt(aData["credits"]);
                            //    $('#lbl_elective').html(elective_credit);
                            //    checkbox.checked = false;
                            //    //return false;
                            //}

                            //if ($(this).find(".gpa").val() == '0') {
                            //    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);
                            //    if ($(this).find(".priority").val() != '0') {
                            //        total_creadit = total_creadit - parseInt(aData["credits"]);
                            //        elective_credit = elective_credit - parseInt(aData["credits"]);
                            //        $('#lbl_elective').html(elective_credit);
                            //        /////////////////////// ADDED BY kamlesh on 28/11/2014
                            //        $(this).find(".priority").val('0');
                            //        generateSelectedAreas();
                            //        ////////////////////////////////
                            //        checkbox.checked = false;
                            //    }
                            //    // return false;
                            //}
                            //}
                            //}
                            //});

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
                    //$("#elective1 tbody tr").each(function (i) {
                    //if ($(this).find(".chk_elective").is(':checked')) {
                    //if (course_code == $(this).children().eq(2).html()) {
                    //if ($(this).find(".gpa").val() == '0') {
                    //    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);
                    //    total_creadit = total_creadit - parseInt(aData["credits"]);
                    //    elective_credit = elective_credit - parseInt(aData["credits"]);
                    //    $('#lbl_elective').html(elective_credit);
                    //    checkbox.checked = false;
                    //    /////////////////////// ADDED BY kamlesh on 28/11/2014
                    //    $(this).find(".priority").val('0');
                    //    generateSelectedAreas();
                    //    ////////////////////////////////
                    //    return false;
                    //    // return false;
                    //}

                    //if ($(this).find(".priority").val() == '0') {
                    //    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                    //    total_creadit = total_creadit - parseInt(aData["credits"]);
                    //    elective_credit = elective_credit - parseInt(aData["credits"]);
                    //    $('#lbl_elective').html(elective_credit);
                    //    checkbox.checked = false;
                    //    return false;
                    //}
                    //}
                    //}
                    //});
                }

                return false;
            },
            error: function (msg) { alert(msg.d); }
        });
    }
});

$(document).on("click", ".course_outlin_link", function (event) {
    //$('#my_outline').modal('hide');

    //$('#txtcourse_outline').html('');
    //$('#txt_week1').html('');
    //$('#txt_week2').html('');
    //$('#txt_week3').html('');
    //$('#txt_week4').html('');
    //$('#txt_week5').html('');
    //$('#txt_week6').html('');
    //$('#txt_week7').html('');
    //$('#txt_week8').html('');
    //$('#txt_week9').html('');
    //$('#txt_week10').html('');
    //$('#txt_week11').html('');
    //$('#txt_week12').html('');
    //$('#txt_week13').html('');
    //$('#txt_week14').html('');
    //$('#txt_week15').html('');
    //$('#txt_week16').html('');

    //$('#txtcourse_structure').html('');
    //$('#txt_course_code').html('');

    //$('#txt_reference').html('');
    //$('#txt_eval_method').html('');
    //$('#head_data').html('');

    //$('#lear_outcome').html("");
    //$('#lear_outcome1').html("");
    //$('#lear_outcome2').html("");
    //$('#lear_outcome3').html("");
    //$('#lear_outcome4').html("");
    //$('#lear_outcome5').html("");

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);

    //var flag = 'N';

    var course_code = aData["course_code"];
    var semester_type = aData["semester_type"];
    var year_semester = aData["year_semester"];
    window.open(location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + semester_type + '&year_code=' + year_semester + '&new_tab=N', "_newtab");
    //window.open(location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=M&year_code=2019&new_tab=N', "_newtab");
    //$('#ifrm_outline').html('<iframe src="' + location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=M&year_code=2019&new_tab=Y" width="1" height="1"></iframe>');
    //$('#txtcourse_outline').html(aData["course_outline"]);

    //$('#txt_week1').html(aData["week1"]);
    //$('#txt_week2').html(aData["week2"]);
    //$('#txt_week3').html(aData["week3"]);
    //$('#txt_week4').html(aData["week4"]);
    //$('#txt_week5').html(aData["week5"]);
    //$('#txt_week6').html(aData["week6"]);
    //$('#txt_week7').html(aData["week7"]);
    //$('#txt_week8').html(aData["week8"]);
    //$('#txt_week9').html(aData["week9"]);
    //$('#txt_week10').html(aData["week10"]);
    //$('#txt_week11').html(aData["week11"]);
    //$('#txt_week12').html(aData["week12"]);
    //$('#txt_week13').html(aData["week13"]);
    //$('#txt_week14').html(aData["week14"]);
    //$('#txt_week15').html(aData["week15"]);
    //$('#txt_week16').html(aData["week16"]);

    //$('#txtcourse_structure').html(aData["course_structure"]);
    //$('#txt_course_code').html(course_code);

    //$('#txt_reference').html(aData["remark"]);
    //$('#txt_eval_method').html(aData["eval_method1"]);

    //$('#img1').css("display", "none");
    //$('#img2').css("display", "none");
    //$('#img3').css("display", "none");
    //$('#img4').css("display", "none");
    //$('#img5').css("display", "none");
    //$('#img6').css("display", "none");
    //$('#img7').css("display", "none");
    //$('#mainimg').css("display", "none");
    //$('#img567').css("display", "none");

    //$('#lear_outcome').html("After completing the " + aData["Course_type_name"] + ",the student will be able to :");
    //if (aData["eval_method5"] != "" && aData["eval_method5"] != null) {
    //    var learing_outcome = JSON.parse(aData.eval_method5);
    //    if (learing_outcome["course_outcome1"] != "" && learing_outcome["course_outcome1"] != null)
    //        $('#lear_outcome1').html("- " + learing_outcome["course_outcome1"]);
    //    if (learing_outcome["course_outcome2"] != "" && learing_outcome["course_outcome2"] != null)
    //        $('#lear_outcome2').html("- " + learing_outcome["course_outcome2"]);
    //    if (learing_outcome["course_outcome3"] != "" && learing_outcome["course_outcome3"] != null)
    //        $('#lear_outcome3').html("- " + learing_outcome["course_outcome3"]);
    //    if (learing_outcome["course_outcome4"] != "" && learing_outcome["course_outcome4"] != null)
    //        $('#lear_outcome4').html("- " + learing_outcome["course_outcome4"]);
    //    if (learing_outcome["course_outcome5"] != "" && learing_outcome["course_outcome5"] != null)
    //        $('#lear_outcome5').html("- " + learing_outcome["course_outcome5"]);
    //}
    //if (aData["eval_method4"] != "" && aData["eval_method4"] != null) {
    //    var CourseImg = JSON.parse(aData["eval_method4"]);
    //    if (CourseImg.length > 2)
    //        $('#img567').removeAttr('style');

    //    if (CourseImg.length > 0) {
    //        $('#mainimg').removeAttr('style');
    //        for (var i = 1; i <= CourseImg.length; i++) {
    //            $('#img' + i).attr("src", "https://connect.cept.ac.in/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
    //            //$('#img' + i).attr("src", "http://27.109.12.252:81/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
    //            $('#div_caption' + i).html(CourseImg[i - 1]["img_caption"]);
    //            //$('#div_caption1').html(CourseImg[0]["img_caption"]);
    //            //$('#div_caption2').html(CourseImg[1]["img_caption"]);
    //            //$('#img' + i).css("display", "block");
    //            $('#img' + i).removeAttr('style');
    //        }
    //    }
    //}
    //// head set

    //if (aData["semester_type"] == "M") {

    //    $('#head_data').append("Monsoon");
    //} else {

    //    $('#head_data').append("Spring");
    //}
    //if (aData["year_semester"] != "") {
    //    $('#head_data').append(", " + aData["year_semester"]);
    //}
    //switch (aData["dept_code"]) {
    //    case "1":
    //        $('#head_data').append(",  Faculty of Architecture");
    //        break;
    //    case "2":
    //        $('#head_data').append(",  Faculty of Design");
    //        break;
    //    case "3":
    //        $('#head_data').append(",  Faculty of Management");
    //        break;
    //    case "4":
    //        $('#head_data').append(",  Faculty of Planning");
    //        break;
    //    case "5":
    //        $('#head_data').append(",  Faculty of Technology");
    //        break;
    //    case "6":
    //        $('#head_data').append(",  Faculty of Centre of Excellence in Urban Transport");
    //        break;
    //    case "7":
    //        $('#head_data').append(",  Faculty of Summer Winter");
    //        break;
    //    case "8":
    //        $('#head_data').append(",  Faculty of Ahmedabad University");
    //        break;

    //    default:
    //}
    //$('#head_data').append(",  Cept University");
    //$('#course_name').html(aData["course_name"]);
    //$('#tutors').html(aData["instructor"]);
    ////var inst = aData["instructor"].split(',');


    //$('#my_outline').modal('show');


    //if (aData.course_structure != '') {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'block');
    //}
    //else if (aData.week1 != '' || aData.week2 != '' || aData.week3 != '' || aData.week4 != '' || aData.week5 != '' || aData.week6 != '' || aData.week7 != '' || aData.week8 != '' || aData.week9 != '' || aData.week10 != '' || aData.week11 != '' || aData.week12 != '' || aData.week13 != '' || aData.week14 != '' || aData.week15 != '' || aData.week16 != '') {
    //    $('#div_weekly_plan').css('display', 'block');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //else {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'none');
    //}

    //return false;

});

$(document).on("click", ".course_outlin_link_elective", function (event) {
    //$('#my_outline').modal('hide');

    //$('#txtcourse_outline').html('');
    //$('#txt_week1').html('');
    //$('#txt_week2').html('');
    //$('#txt_week3').html('');
    //$('#txt_week4').html('');
    //$('#txt_week5').html('');
    //$('#txt_week6').html('');
    //$('#txt_week7').html('');
    //$('#txt_week8').html('');
    //$('#txt_week9').html('');
    //$('#txt_week10').html('');
    //$('#txt_week11').html('');
    //$('#txt_week12').html('');
    //$('#txt_week13').html('');
    //$('#txt_week14').html('');
    //$('#txt_week15').html('');
    //$('#txt_week16').html('');

    //$('#txtcourse_structure').html('');
    //$('#txt_course_code').html('');

    //$('#txt_reference').html('');
    //$('#txt_eval_method').html('');
    //$('#head_data').html('');

    //$('#lear_outcome').html("");
    //$('#lear_outcome1').html("");
    //$('#lear_outcome2').html("");
    //$('#lear_outcome3').html("");
    //$('#lear_outcome4').html("");
    //$('#lear_outcome5').html("");

    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);

    //var flag = 'N';

    var course_code = aData["course_code"];
    var semester_type = aData["semester_type"];
    var year_semester = aData["year_semester"];
    window.open(location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + semester_type + '&year_code=' + year_semester + '&new_tab=N', "_newtab");
    //window.open(location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=M&year_code=2019&new_tab=N', "_newtab");


    //$('#txtcourse_outline').html(aData["course_outline"]);

    //$('#txt_week1').html(aData["week1"]);
    //$('#txt_week2').html(aData["week2"]);
    //$('#txt_week3').html(aData["week3"]);
    //$('#txt_week4').html(aData["week4"]);
    //$('#txt_week5').html(aData["week5"]);
    //$('#txt_week6').html(aData["week6"]);
    //$('#txt_week7').html(aData["week7"]);
    //$('#txt_week8').html(aData["week8"]);
    //$('#txt_week9').html(aData["week9"]);
    //$('#txt_week10').html(aData["week10"]);
    //$('#txt_week11').html(aData["week11"]);
    //$('#txt_week12').html(aData["week12"]);
    //$('#txt_week13').html(aData["week13"]);
    //$('#txt_week14').html(aData["week14"]);
    //$('#txt_week15').html(aData["week15"]);
    //$('#txt_week16').html(aData["week16"]);

    //$('#txtcourse_structure').html(aData["course_structure"]);
    //$('#txt_course_code').html(course_code);

    //$('#txt_reference').html(aData["remark"]);
    //$('#txt_eval_method').html(aData["eval_method1"]);

    //$('#img1').css("display", "none");
    //$('#img2').css("display", "none");
    //$('#img3').css("display", "none");
    //$('#img4').css("display", "none");
    //$('#img5').css("display", "none");
    //$('#img6').css("display", "none");
    //$('#img7').css("display", "none");
    //$('#mainimg').css("display", "none");
    //$('#img567').css("display", "none");

    //$('#lear_outcome').html("After completing the " + aData["Course_type_name"] + ",the student will be able to :");
    //if (aData["eval_method5"] != "" && aData["eval_method5"] != null) {
    //    var learing_outcome = JSON.parse(aData.eval_method5);

    //    if (learing_outcome["course_outcome1"] != "" && learing_outcome["course_outcome1"] != null)
    //        $('#lear_outcome1').html("- " + learing_outcome["course_outcome1"]);
    //    if (learing_outcome["course_outcome2"] != "" && learing_outcome["course_outcome2"] != null)
    //        $('#lear_outcome2').html("- " + learing_outcome["course_outcome2"]);
    //    if (learing_outcome["course_outcome3"] != "" && learing_outcome["course_outcome3"] != null)
    //        $('#lear_outcome3').html("- " + learing_outcome["course_outcome3"]);
    //    if (learing_outcome["course_outcome4"] != "" && learing_outcome["course_outcome4"] != null)
    //        $('#lear_outcome4').html("- " + learing_outcome["course_outcome4"]);
    //    if (learing_outcome["course_outcome5"] != "" && learing_outcome["course_outcome5"] != null)
    //        $('#lear_outcome5').html("- " + learing_outcome["course_outcome5"]);
    //}
    //if (aData["eval_method4"] != "" && aData["eval_method4"] != null) {
    //    var CourseImg = JSON.parse(aData["eval_method4"]);
    //    if (CourseImg.length > 2)
    //        $('#img567').removeAttr('style');

    //    if (CourseImg.length > 0) {
    //        $('#mainimg').removeAttr('style');
    //        for (var i = 1; i <= CourseImg.length; i++) {
    //            $('#img' + i).attr("src", "https://connect.cept.ac.in/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
    //            //$('#img' + i).attr("src", "http://27.109.12.252:81/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
    //            $('#div_caption' + i).html(CourseImg[i - 1]["img_caption"]);

    //            //$('#div_caption2').html(CourseImg[1]["img_caption"]);
    //            //$('#img' + i).css("display", "block");
    //            $('#img' + i).removeAttr('style');
    //        }
    //    }
    //}
    ////set Header

    //if (aData["semester_type"] == "M") {

    //    $('#head_data').append("Monsoon Semester");
    //} else if (aData["semester_type"] == "S") {

    //    $('#head_data').append("Spring Semester");
    //}

    //if (aData["year_semester"] != "") {
    //    $('#head_data').append(", " + aData["year_semester"]);
    //}

    //$('#head_data').append(", Faculty of " + aData["department"] + ",  Cept University");
    //$('#course_name').html(aData["course_name"]);
    //$('#tutors').html(aData["instructor"]);

    //$('#my_outline').modal('show');


    //if (aData.course_structure != '') {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'block');
    //}
    //else if (aData.week1 != '' || aData.week2 != '' || aData.week3 != '' || aData.week4 != '' || aData.week5 != '' || aData.week6 != '' || aData.week7 != '' || aData.week8 != '' || aData.week9 != '' || aData.week10 != '' || aData.week11 != '' || aData.week12 != '' || aData.week13 != '' || aData.week14 != '' || aData.week15 != '' || aData.week16 != '') {
    //    $('#div_weekly_plan').css('display', 'block');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //else {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //return false;

});

$(document).on("click", ".course_outlin_link_elective_preference", function (event) {
    //$('#my_outline').modal('hide');

    //$('#txtcourse_outline').html('');
    //$('#txt_week1').html('');
    //$('#txt_week2').html('');
    //$('#txt_week3').html('');
    //$('#txt_week4').html('');
    //$('#txt_week5').html('');
    //$('#txt_week6').html('');
    //$('#txt_week7').html('');
    //$('#txt_week8').html('');
    //$('#txt_week9').html('');
    //$('#txt_week10').html('');
    //$('#txt_week11').html('');
    //$('#txt_week12').html('');
    //$('#txt_week13').html('');
    //$('#txt_week14').html('');
    //$('#txt_week15').html('');
    //$('#txt_week16').html('');

    //$('#txtcourse_structure').html('');
    //$('#txt_course_code').html('');

    //$('#txt_reference').html('');
    //$('#txt_eval_method').html('');
    //$('#head_data').html('');

    //$('#lear_outcome').html("");
    //$('#lear_outcome1').html("");
    //$('#lear_outcome2').html("");
    //$('#lear_outcome3').html("");
    //$('#lear_outcome4').html("");
    //$('#lear_outcome5').html("");

    var row = $(this).closest("tr").get(0);
    var aData = oTable3.fnGetData(row);

    //var flag = 'N';

    var course_code = aData["course_code"];
    var semester_type = aData["semester_type"];
    var year_semester = aData["year_semester"];
    window.open(location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + semester_type + '&year_code=' + year_semester + '&new_tab=N', "_newtab");
    //window.open(location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=M&year_code=2019&new_tab=N', "_newtab");


    //$('#txtcourse_outline').html(aData["course_outline"]);

    //$('#txt_week1').html(aData["week1"]);
    //$('#txt_week2').html(aData["week2"]);
    //$('#txt_week3').html(aData["week3"]);
    //$('#txt_week4').html(aData["week4"]);
    //$('#txt_week5').html(aData["week5"]);
    //$('#txt_week6').html(aData["week6"]);
    //$('#txt_week7').html(aData["week7"]);
    //$('#txt_week8').html(aData["week8"]);
    //$('#txt_week9').html(aData["week9"]);
    //$('#txt_week10').html(aData["week10"]);
    //$('#txt_week11').html(aData["week11"]);
    //$('#txt_week12').html(aData["week12"]);
    //$('#txt_week13').html(aData["week13"]);
    //$('#txt_week14').html(aData["week14"]);
    //$('#txt_week15').html(aData["week15"]);
    //$('#txt_week16').html(aData["week16"]);

    //$('#txtcourse_structure').html(aData["course_structure"]);
    //$('#txt_course_code').html(course_code);

    //$('#txt_reference').html(aData["remark"]);
    //$('#txt_eval_method').html(aData["eval_method1"]);

    //$('#img1').css("display", "none");
    //$('#img2').css("display", "none");
    //$('#img3').css("display", "none");
    //$('#img4').css("display", "none");
    //$('#img5').css("display", "none");
    //$('#img6').css("display", "none");
    //$('#img7').css("display", "none");
    //$('#mainimg').css("display", "none");
    //$('#img567').css("display", "none");

    //$('#lear_outcome').html("After completing the " + aData["Course_type_name"] + ",the student will be able to :");
    //if (aData["eval_method5"] != "" && aData["eval_method5"] != null) {
    //    var learing_outcome = JSON.parse(aData.eval_method5);

    //    if (learing_outcome["course_outcome1"] != "" && learing_outcome["course_outcome1"] != null)
    //        $('#lear_outcome1').html("- " + learing_outcome["course_outcome1"]);
    //    if (learing_outcome["course_outcome2"] != "" && learing_outcome["course_outcome2"] != null)
    //        $('#lear_outcome2').html("- " + learing_outcome["course_outcome2"]);
    //    if (learing_outcome["course_outcome3"] != "" && learing_outcome["course_outcome3"] != null)
    //        $('#lear_outcome3').html("- " + learing_outcome["course_outcome3"]);
    //    if (learing_outcome["course_outcome4"] != "" && learing_outcome["course_outcome4"] != null)
    //        $('#lear_outcome4').html("- " + learing_outcome["course_outcome4"]);
    //    if (learing_outcome["course_outcome5"] != "" && learing_outcome["course_outcome5"] != null)
    //        $('#lear_outcome5').html("- " + learing_outcome["course_outcome5"]);
    //}
    //if (aData["eval_method4"] != "" && aData["eval_method4"] != null) {
    //    var CourseImg = JSON.parse(aData["eval_method4"]);
    //    if (CourseImg.length > 2)
    //        $('#img567').removeAttr('style');

    //    if (CourseImg.length > 0) {
    //        $('#mainimg').removeAttr('style');
    //        for (var i = 1; i <= CourseImg.length; i++) {
    //            $('#img' + i).attr("src", "https://connect.cept.ac.in/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
    //            //$('#img' + i).attr("src", "http://27.109.12.252:81/CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
    //            $('#div_caption' + i).html(CourseImg[i - 1]["img_caption"]);

    //            //$('#div_caption2').html(CourseImg[1]["img_caption"]);
    //            //$('#img' + i).css("display", "block");
    //            $('#img' + i).removeAttr('style');
    //        }
    //    }
    //}
    ////set Header

    //if (aData["semester_type"] == "M") {

    //    $('#head_data').append("Monsoon Semester");
    //} else if (aData["semester_type"] == "S") {

    //    $('#head_data').append("Spring Semester");
    //}

    //if (aData["year_semester"] != "") {
    //    $('#head_data').append(", " + aData["year_semester"]);
    //}

    //$('#head_data').append(", Faculty of " + aData["department"] + ",  Cept University");
    //$('#course_name').html(aData["course_name"]);
    //$('#tutors').html(aData["instructor"]);

    //$('#my_outline').modal('show');


    //if (aData.course_structure != '') {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'block');
    //}
    //else if (aData.week1 != '' || aData.week2 != '' || aData.week3 != '' || aData.week4 != '' || aData.week5 != '' || aData.week6 != '' || aData.week7 != '' || aData.week8 != '' || aData.week9 != '' || aData.week10 != '' || aData.week11 != '' || aData.week12 != '' || aData.week13 != '' || aData.week14 != '' || aData.week15 != '' || aData.week16 != '') {
    //    $('#div_weekly_plan').css('display', 'block');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //else {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //return false;

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
                debugger;
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
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> <tfoot id="abc"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 5px; display: none" name="search_engine" value=""class="search_init" /></th><th><input type="text" style="width: 35px" name="search_engine" value="" class="search_init" /></th><th><center><input type="text" style="width: 54px;" name="search_Faculty" value="" class="search_init" /></center></th><th><input type="text" style="width: 86px" name="search_semester" value="" class="search_init" /></th><th><input type="text" style="width: 25px" name="search_code" value="" class="search_init" /></th><th><center><input type="text" style="width: 95px" name="search_name" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 47px" name="search_credits" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 50px" name="search_pre" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 100px" name="search_instructor" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 100px" name="search_prerequisite" value="" class="search_init" /></center></th><th></th></tr></tfoot> </tbody> </table>');
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
                //"sTitle": "Select",
                //"mData": null,
                //"bSortable": false,
                //"mRender": function (data) {
                //    var dataa = JSON.parse(data);
                //    for (var i = 0; i < dataa.length; i++) {
                //        if (dataa[i]["sub_category_id"] != '1') {
                //            return '<center><input type="checkbox"  name="check1" value="1" class="madaniyu" ></center>';
                //        }
                //    }

                //},

                "sTitle": "Select", "mDataProp": "sub_category_id", "bSortable": false, "mRender": function (data, type, full) {
                    return sub_category_id(data);
                    
                },

                //"sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="madaniyu" ></center>'
            },
            { "sTitle": "Sem.", "mData": "semester", "bSortable": false },
            { "sTitle": "Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Name", "mData": "course_name", "bSortable": false },
            { "sTitle": "Credits", "mData": "credits", "bSortable": false },
            { "sTitle": "faculty", "mData": "instructor", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            { "sTitle": "Days", "mData": "days", "bSortable": false },

            { "sTitle": "GPA/Non GPA", "mData": "gpa_ngpa", "bSortable": false }, ///Returned By Ananth 25/04/2019

            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
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
                //if (saved_data[j]["doc_no"] == a["doc_no"]) {
                if (saved_data[j]["doc_no"] == a["doc_no"] && saved_data[j]["course_code"] == a["course_code"] && saved_data[j]["semester_code"] == a["semester"])
                {
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
        $("#datalist_elective").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="elective1"><thead></thead><tbody> </tbody><tfoot id="abc1"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th><input type="text" style="width: 10px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th><input type="text" style="width: 30px" name="search_code" value="" class="search_init" /></th><th><input type="text" style="width: 79px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 10px" name="search_credits" value="" class="search_init" /></th><th><input type="text" style="width: 70px;" name="search_pre" value="" class="search_init" /></th><th><input type="text" style="width: 50px;" name="search_Faculty" value="" class="search_init" /></th><th><input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" /></th><th> <input type="text" style="width: 48px" name="search_time" value="" class="search_init"></th><th><input type="text" style="width: 48px" name="search_days" value="" class="search_init" /></th><th><input type="text" style="width: 72px" name="search_Area" value="" class="search_init" /></th><th><input type="text" style="width: 1px; display: none" name="search_Area" value="Area"class="search_init" /></th><th> <input type="text" style="width: 1px; display: none" name="" value="Area" class="search_init" /> </th><th></th><th></th> </tr></tfoot></table>');
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
            { "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_elective" ></center>' },
            {
                "sTitle": "Priority", "bSortable": false, "mData": null, fnRender: function (oObj) {
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

            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "GPA/Non GPA", "mData": "gpa_ngpa", "bSortable": false },

            {
                "sTitle": "GPA/Non GPA", "bSortable": false, "mData": null, fnRender: function (oObj) {
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
                "sTitle": "Selected Priority", "bSortable": false, "mData": null, fnRender: function (oObj) {
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
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
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

    $('#elective1 thead tr th:nth-child(2),#elective1 tfoot tr th:nth-child(2),#elective1 tbody tr td:nth-child(2)').css('display', 'none');
    $('#elective1 thead tr th:nth-child(12),#elective1 tfoot tr th:nth-child(12),#elective1 tbody tr td:nth-child(12)').css('display', 'none');
    $('#elective1 thead tr th:nth-child(13),#elective1 tfoot tr th:nth-child(13),#elective1 tbody tr td:nth-child(13)').css('display', 'none');

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

    setCoursePreference();

    $('#div_add_guide').css('display', 'none');
    setConfirmCourses();
}

function setCoursePreference() {
    var selected_elective = $('#elective1 .chk_elective:checked');
    var obj_prio_pref = [];

    for (var i = 0; i < selected_elective.length; i++) {
        var cur_tr = $(selected_elective[i]).closest('tr')[0];
        obj_prio_pref.push(oTable1.fnGetData(cur_tr));
    }

    if (obj_prio_pref.length > 0) {
        if (oTable3 != null) {
            oTable3.fnDestroy();
            $("#datalist_elective_preference").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="elective_preference"><thead></thead><tbody> </tbody></table>');
        }

        oTable3 = $("#elective_preference").dataTable({
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
            "aaData": obj_prio_pref,
            "aoColumns": [
                //{ "sTitle": "Select", "mData": null, "bSortable": false,
                //    "sDefaultContent": '<center><input type="checkbox" name="check1" value="1" class="chk_elective_preference" checked ></center>'
                //    //"sDefaultContent": '<center><input type="checkbox" name="check1" value="1" class="chk_elective" checked ></center>'
                //},
                {
                    "sTitle": "Priority",
                    "bSortable": false,
                    "mData": null,
                    fnRender: function (oObj) {
                        var listItems = '<select class="preference_priority">';
                        //var listItems = '<select class="priority">';
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

                //{ "sTitle": "Area", "mData": "area", "bSortable": false },
                { "sTitle": "GPA/Non GPA", "mData": "gpa_ngpa", "bSortable": false },

                {
                    "sTitle": "GPA/Non GPA", "bSortable": false, "mData": null, "sClass": "cls_gpa_ngpa", fnRender: function (oObj) {
                        var listItems = '<select class="preference_gpa">';
                        //var listItems = '<select class="gpa">';
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
                        return '<center><a style="cursor:pointer" class="course_outlin_link_elective_preference" >View</a></center>';
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

        $('#elective_preference thead tr th:nth-child(6),#elective_preference tfoot tr th:nth-child(6),#elective_preference tbody tr td:nth-child(6)').css('display', 'none');
        $('#elective_preference thead tr th:nth-child(8),#elective_preference tfoot tr th:nth-child(8),#elective_preference tbody tr td:nth-child(8)').css('display', 'none');

        $("#elective_preference tbody tr").each(function (i) {
            var aPos = oTable3.fnGetPosition(this);
            var aData = oTable3.fnGetData(aPos[i]);
            var a = aData[i];

            $(this).find(".preference_gpa").val(a['gpa_ngpa']);

            if (saved_data != "") {
                for (var j = 0; j < saved_data.length; j++) {
                    if (saved_data[j]["doc_no"] == a["doc_no"]) {
                        if (saved_data[j]["gpa_nongpa"] != '') {
                            //$(this).find(".preference_gpa").val(saved_data[j]["gpa_nongpa"]);
                            $(this).find(".preference_priority").val(saved_data[j]["priority"]);
                        }
                    }
                }
            }
        });

        $('.cls_gpa_ngpa').css('display', 'none');
    }
}

$(document).on("change", ".preference_priority", function (event) {
    var val = $(this).val();

    var control = $(this);
    var flag = 'Y';
    var row = $(this).closest("tr").get(0);
    var aData = oTable3.fnGetData(row);
    var course_code = aData["course_code"];
    var counter = 0;
    var check_flag = 'N';

    var selectedValues = [];
    var nNodes = oTable3.fnGetNodes();
    for (var i = 0; i < nNodes.length; i++) {
        if ($(nNodes[i]).find('.preference_priority').val() != '0') {
            counter = counter + 1;
            if (course_code != $(nNodes[i]).children().eq(1).html()) {
                if (val == $(nNodes[i]).find(".preference_priority").val()) {
                    bootbox.alert('You have already selected this Priority for Course : ' + $(nNodes[i]).children().eq(1).html());
                    control.val("0");
                    return false;
                }
            }
        }
    }

    for (var i = 0; i < nNodes.length; i++) {
        if ($(nNodes[i]).find('.preference_priority').val() != '0') {
            if ((parseInt(val) - parseInt(1)) == $(nNodes[i]).find(".preference_priority").val()) {
                flag = 'Y';
                generateSelectedAreas_preference();
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
});

function generateSelectedAreas_preference() {
    var selectedValues = [];
    var nNodes = oTable3.fnGetNodes();

    for (var i = 0; i < nNodes.length; i++) {
        $(nNodes[i]).find('.preference_priority option').each(function () {
            $(this).css('display', 'block');
        });
    }

    for (var i = 0; i < nNodes.length; i++) {
        $(nNodes[i]).find('.preference_priority option:selected').each(function () {
            var select = $(this).parent();
            optValue = $(this).val();
            if ($(this).val() != '0') {
                //$(this).not(select).children().css('display', 'none');
                $('.preference_priority').not(select).children().filter(function (e) {
                    if ($(this).val() == optValue)
                        return e
                }).css('display', 'none');
            }
        });
    }
}

function saveCoursePreference() {

    var validation_flag = true;

    $('#elective_preference tbody tr').each(function (i) {
        if ($(this).find('.preference_priority').val() == '0' || $(this).find('.preference_gpa').val() == '0') {
            bootbox.alert('Please select Priority and GPA/NGPA for all the courses.');
            validation_flag = false;
            return false;
        }
    });

    if (validation_flag) {
        for (var i = 0; i < $('#elective_preference tbody tr').length; i++) {
            var row_data_preference = oTable3.fnGetData($('#elective_preference tbody tr')[i]);

            for (var j = 0; j < $('#elective1 tbody tr').length; j++) {
                var row_data = oTable1.fnGetData($('#elective1 tbody tr')[j]);

                if (row_data['course_code'] == row_data_preference['course_code']) {
                    $($('#elective1 tbody tr')[j]).find('.priority')[0].value = $($('#elective_preference tbody tr')[i]).find('.preference_priority')[0].value;
                    $($('#elective1 tbody tr')[j]).find('.gpa')[0].value = $($('#elective_preference tbody tr')[i]).find('.preference_gpa')[0].value;
                }
            }
        }

        $('.btn_save')[0].click();
    }
}

function saveAgree() {

    if ($('#chk_agree_afidavite').is(':checked')) {
    }
    else {
        bootbox.alert("Please tick first chekbox");
        return false;
    }

    if ($('#chk_agree_reg_process').is(':checked')) {
    }
    else {
        bootbox.alert("Please tick Second chekbox");
        return false;
    }
    if ($('#chk_agree_consent_form').is(':checked')) {
    }
    else {
        bootbox.alert("Please tick I Accept chekbox");
        return false;
    }

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Save_registration_instruction_data",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d == true) {
                //bootbox.alert("Your Gender is updated successfully.");
                //$('#myModal').modal('hide');

                $('#my_instruction').modal('hide');
                $('#li_step' + (cur_tab + 1)).find('.cls_tab_a').click();
            }
            else {
                //bootbox.alert("Your Gender is not updated");
            }
        },
        Error: function (data) {
            alert(data.d);
        }
    });
}

function setConfirmCourses() {
    $('#spn_credit_choice2').html($('#spn_credit_choice').html());
    $('#td_mandatory_credits').html($('#txt_mandatory_credits').val());
    $('#td_elective_credits').html($('#txt_elective_credits').val());
    $('#td_sws_credits').html($('#txt_sws_credits').val());

    $('#tbl_disp_mandatory tbody').html('');
    $('#tbl_disp_elective tbody').html('');

    $('#example tbody tr').each(function (i) {
        if ($(this).find('.madaniyu')[0].checked) {
            var row_data = oTable.fnGetData(this);

            var back_color = $(this).children().eq(0)[0].style.backgroundColor;
            if (back_color != '') back_color = ' style="background-color:' + back_color + ';"';

            var str_html = '<tr><td' + back_color + '>' + row_data['semester'] + '</td>' +
                '<td' + back_color + '>' + row_data['course_code'] + '</td>' +
                '<td' + back_color + '>' + row_data['course_name'] + '</td>' +
                '<td' + back_color + '>' + row_data['credits'] + '</td>' +
                '<td' + back_color + '>' + row_data['instructor'] + '</td>' +
                '<td' + back_color + '>' + row_data['time'] + '</td>' +
                '<td' + back_color + '>' + row_data['days'] + '</td>' +
                '<td' + back_color + '>' + row_data['gpa_ngpa'] + '</td>' +
                '<td' + back_color + '>' + get_prerequisite(row_data['prerequisite']) + '</td>' +
                //'<td>Course Outline</td>' + 
                '</tr>';

            if ($.grep(thesis_typology, function (data) { return data['type_code'] == row_data['course_typology']; }).length > 0) {
                //uncomment to on this feature
                //$('#div_add_guide').css('display', 'block');
            }

            $('#tbl_disp_mandatory tbody').append(str_html);
        }
    });

    $('#elective1 tbody tr').each(function (i) {
        if ($(this).find('.chk_elective')[0].checked) {
            var row_data = oTable1.fnGetData(this);

            var str_html = '<tr><td>' + $(this).find('.priority')[0].value + '</td>' +
                '<td>' + row_data['course_code'] + '</td>' +
                '<td>' + row_data['course_name'] + '</td>' +
                '<td>' + row_data['credits'] + '</td>' +
                '<td>' + get_prerequisite(row_data['prerequisite']) + '</td>' +      // change By Ananth //
                '<td>' + row_data['department'] + '</td>' +
                '<td>' + row_data['instructor'] + '</td>' +
                '<td>' + row_data['time'] + '</td>' +
                '<td>' + row_data['days'] + '</td>' +
                '<td>' + row_data['area'] + '</td>' +
                '<td>' + $(this).find('.gpa')[0].value + '</td>' +
                '<td>' + row_data['semester'] + '</td>' +
                //'<td>Course Outline</td>' +
                '</tr>';

            $('#tbl_disp_elective tbody').append(str_html);
        }
    });
}
//Added By Ananth 21-06-2019
function sub_category_id(data) {
    if (data == "")
    {
        return '<center><input type="checkbox"  name="check1" value="1" class="madaniyu remove0" ></center>';
    } else {
        return '<center><input type="text" style="display:none" name="check1" value="1" class="madaniyu remove0" ></center>';
    }

    //var sub_category_id;
    //if (data != "") {
    //    try {
    //        sub_category_id = data;
    //    } catch (e) {
    //        return data;
    //    }
    //    if (sub_category_id != '1') {
    //        return '<center><input type="checkbox"  name="check1" value="1" class="madaniyu" ></center>';
    //    }
    //}
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
            debugger;
            if (data.d != null) {
                if (data.d[0] != null) {
                    fees_status = JSON.parse(data.d[0]);

                    if (fees_status[0]["fees_status"] != "") {
                        if (fees_status[0]["fees_status"] == "H") {
                            $('#txtcredit_choice').prop("disabled", true);
                            //$('#btn_save_credit').prop("disabled", true);
                            $('#spn_credit_choice').closest('tr').children()[0].innerHTML = 'Total credits I have applied for';
                        }
                        else if (fees_status[0]["fees_status"] == "F") {
                        }
                        else {
                            $('#btnsave').prop("disabled", true);
                            $('.btn_save').prop("disabled", true);
                            $('#txtcredit_choice').prop("disabled", true);
                            $('#btn_save_credit').prop("disabled", true);
                        }
                    }
                    else {
                        $('#btnsave').prop("disabled", true);
                        $('.btn_save').prop("disabled", true);
                        $('#txtcredit_choice').prop("disabled", true);
                        $('#btn_save_credit').prop("disabled", true);
                    }
                }
                else {

                    $('#btnsave').prop("disabled", true);
                    $('.btn_save').prop("disabled", true);
                    $('#txtcredit_choice').prop("disabled", true);
                    $('#btn_save_credit').prop("disabled", true);
                }

                if (data.d[1] != null) {
                    var choice_credits = data.d[1];

                    if (choice_credits != '') {
                        $('#txtcredit_choice').val(choice_credits);
                        $('#spn_credit_choice').html(choice_credits);
                        str_credit_choice = choice_credits;

                        // if (choice_credits < 16) {
                        if (choice_credits < 13) {
                            $('#txtcredit_choice').prop("disabled", true);
                            //$('#btn_save_credit').prop("disabled", true);
                            $('#spn_credit_choice').closest('tr').children()[0].innerHTML = 'Total credits I have applied for';
                        }
                    }
                }

                if (data.d[2] != '' && data.d[2] != null) {
                    var credits_bifurcation = JSON.parse(data.d[2]);
                    var spn_total_credits = 0;

                    $('#txt_mandatory_credits').val(credits_bifurcation[0]['mandatory_credits']);
                    $('#txt_elective_credits').val(credits_bifurcation[0]['elective_credits']);
                    $('#txt_sws_credits').val(credits_bifurcation[0]['sws_credits']);

                    if (credits_bifurcation[0]['mandatory_credits'].toString() != '' && parseInt(credits_bifurcation[0]['mandatory_credits'].toString()).toString() != 'NaN')
                        spn_total_credits += parseInt(credits_bifurcation[0]['mandatory_credits'].toString());

                    if (credits_bifurcation[0]['elective_credits'].toString() != '' && parseInt(credits_bifurcation[0]['elective_credits'].toString()).toString() != 'NaN')
                        spn_total_credits += parseInt(credits_bifurcation[0]['elective_credits'].toString());

                    if (credits_bifurcation[0]['sws_credits'].toString() != '' && parseInt(credits_bifurcation[0]['sws_credits'].toString()).toString() != 'NaN')
                        spn_total_credits += parseInt(credits_bifurcation[0]['sws_credits'].toString());

                    $('#spn_credit_choice').html(spn_total_credits);
                }

                if (data.d[3] == 'Registered') {
                    $('#li_step7').find('.cls_tab_a').click();
                    $('.copyright').html('');
                    $('#div_add_guide').html('');
                }

                if (data.d[4] != '') {
                    enroll_year = data.d[4];

                    if (enroll_year == 'Y2016' || enroll_year == 'Y2017' || enroll_year == 'Y2018' || enroll_year == 'Y2019' || enroll_year == 'Y2020' || enroll_year == 'Y2021' || enroll_year == 'Y2022' || enroll_year == 'Y2023' || enroll_year == 'Y2024' || enroll_year == 'Y2025' || enroll_year == 'Y2026' || enroll_year == 'Y2027' || enroll_year == 'Y2028') {
                        $('#txt_sws_credits').closest('tr').css('display', '');
                    }
                    else {
                        $('#txt_sws_credits').closest('tr').css('display', 'none');
                        $('#txt_sws_credits').val('0');
                        $('#txt_sws_credits').change();
                    }
                }
            }
            else {
                $('#btnsave').prop("disabled", true);
                $('.btn_save').prop("disabled", true);
                $('#txtcredit_choice').prop("disabled", true);
                $('#btn_save_credit').prop("disabled", true);
            }
        },
        error: function (data) {
            alert(data.d);
        }
    });
}

function check_portfolio_status() {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/get_student_marksheet_blocklist",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            if (data.d != "") {
                var result = JSON.parse(data.d);
                portfolio_status = true;
                if (result.status == "false") {
                    $('#btn_save_credit').prop("disabled", true);
                    bootbox.alert(result.message);
                    return false;
                }
            }
            else {
                portfolio_status = true;
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