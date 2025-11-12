var oTable;
var oTable1;
var oTable2;
var oTable3;
var oTable4;
var oTable5;
var oTable6;
var oTable7;
var oTable_allapproved_courses;
var cur_sem;
var cur_year;
var prog_code;
var prog_level_code;
var dept_code;
var download_rights_user_wise = 'false';

$(document).ready(function () {
    $('#btnRetrieve').on('click', function () {
        if ($('#drpyear').val() == "") {
            bootbox.alert('please select year.');
            return false;
        }

        cur_sem = $('#drpsem').val()
        cur_year = $('#drpyear').val();
        prog_code = $('#drpprog').val();
        prog_level_code = $('#drpproglevel').val();
        dept_code = $('#drpdepartment').val();
        $("#inital_pendingcourse").removeClass("in active");
        $("#pendingcourse").removeClass("in active");
        $("#approvedcourses").removeClass("in active");
        $("#mycourses").removeClass("in active");
        $("#allpendingcac").removeClass("in active");//changes 30032022

        if ($("#hdnusertype").val() == 'A1') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');
            var strHtml = "<ul class='nav nav-tabs' id='myTab' style='margin-bottom:0px;'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Courses Offered&nbsp;</a></li>" +
                "<li><a data-toggle='tab' href='#approvedcourses'>Approved Courses &nbsp; </a></li></ul>";
            $("#div_myTab").html(strHtml);
            $("#pendingcourse").addClass("in active");
            $('#btn_download_all').css('display', 'block');
            pending_course_list();//1 done //1
            approved_course_list();//2 done //2
        }
        else if ($("#hdnusertype").val() == 'PC') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');
            var strHtml = "<ul class='nav nav-tabs' id='myTab' style='margin-bottom:0px;'><li class='active'><a data-toggle='tab' href='#inital_pendingcourse'>Pending Initial Approval&nbsp;</a></li><li><a data-toggle='tab' href='#allpendingcac'>Pending At CAC&nbsp; </a></li><li><a data-toggle='tab' href='#pendingcourse'>Courses Offered&nbsp;</a></li>" +
                "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li><li><a data-toggle='tab' href='#approvedcourses'>Approved Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li>"+
            "</ul>";
            $("#div_myTab").html(strHtml);
            $("#inital_pendingcourse").addClass("in active");
            initial_course_list();//5
            pending_CAC_course_list();//30032022 //6
            pending_course_list();//1 done
            my_course_list();//4 done
            approved_course_list();// 2 done
            All_approved_course_list();//3 done
            
        }
        else if ($("#hdnusertype").val() == 'I2') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');
            var strHtml = "<ul class='nav nav-tabs' id='myTab' style='margin-bottom:0px;'><li class='active'><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li></ul>";
            $("#div_myTab").html(strHtml);
            $("#mycourses").addClass("in active");
            my_course_list();// 4 done
            All_approved_course_list();// 3 done
        }
        else if ($("#hdnusertype").val() == 'D') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');
            var strHtml = "<ul class='nav nav-tabs' id='myTab' style='margin-bottom:0px;'><li class='active'><a data-toggle='tab' href='#approvedcourses'>Courses Offered&nbsp;</a></li>" +
                "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li></ul>";
            $("#div_myTab").html(strHtml);
            $("#approvedcourses").addClass("in active");
            approved_course_list();//2 done
            my_course_list();// 4 done
            All_approved_course_list();// 3 done
        }
        else if ($("#hdnusertype").val() == 'FA') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');
            var strHtml = "<ul class='nav nav-tabs' id='myTab' style='margin-bottom:0px;'><li class='active'><a data-toggle='tab' href='#inital_pendingcourse'>Pending Initial Approval&nbsp;</a></li><li><a data-toggle='tab' href='#allpendingcac'>Pending At CAC&nbsp; </a></li><li><a data-toggle='tab' href='#approvedcourses'>Courses Offered&nbsp;</a></li><li><a data-toggle='tab' href='#approvedcourses_fa'>Approved Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li></ul>";
            $("#div_myTab").html(strHtml);
            $("#inital_pendingcourse").addClass("in active");
            initial_course_list();//5
            pending_CAC_course_list();//30032022 //6
            approved_course_list();//2 done 
            approved_course_list_fa();//7
            All_approved_course_list();// 3 done
            
        }

    });

    $('#btn_print_outline').on('click', function () {
        var mywindow = window.open('', 'print_data', 'height=400,width=600');
        //mywindow.document.write('<link href=\"DesignCss/bootstrap.min.css\" rel=\"stylesheet\" />  <link href=\"DesignCss/ace.min.css\" rel=\"stylesheet\" /><link href=\"Style/dataTables.bootstrap.css\" rel=\"stylesheet\" type="text/css" />');
        mywindow.document.write('');
        //mywindow.document.write('<style type="text/css"> th, td, .table-bordered {border-radius: 0!important;} .table-bordered {border: 1px solid #ddd;border-collapse: separate;border-left: 0}table {border-spacing: 0;}body {padding-bottom: 0;background-color: #e4e6e9;min-height: 100%;font-family: 'Open Sans';font-size: 13px;color: #393939;} </style>');
        //mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} .dxc-markers circle{display:none;}</style>');
        mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
        /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
        mywindow.document.write('</head><body>');
        mywindow.document.write($('#my_print_outline').html());
        mywindow.document.write('</body></html>');

        mywindow.print();
        mywindow.close();

        return false;
    });

    $('#btn_all_download_print').on('click', function () {
        var mywindow = window.open('', 'print_data', 'height=400,width=600');
        //mywindow.document.write('<link href=\"DesignCss/bootstrap.min.css\" rel=\"stylesheet\" />  <link href=\"DesignCss/ace.min.css\" rel=\"stylesheet\" /><link href=\"Style/dataTables.bootstrap.css\" rel=\"stylesheet\" type="text/css" />');
        mywindow.document.write('');
        //mywindow.document.write('<style type="text/css"> th, td, .table-bordered {border-radius: 0!important;} .table-bordered {border: 1px solid #ddd;border-collapse: separate;border-left: 0}table {border-spacing: 0;}body {padding-bottom: 0;background-color: #e4e6e9;min-height: 100%;font-family: 'Open Sans';font-size: 13px;color: #393939;} </style>');
        //mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} .dxc-markers circle{display:none;}</style>');
        mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
        /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
        mywindow.document.write('</head><body>');
        mywindow.document.write($('#div_print_all').html());
        mywindow.document.write('</body></html>');

        mywindow.print();
        mywindow.close();

        return false;
    });

    var all_data = ''

    $('#btn_download_all').on('click', function () {
        all_data = '';

        $('#div_download_all_outline').modal('hide');

        var data = oTable2.fnGetData()

        for (var i = 0; i < data.length; i++) {
            $('.txtcourse_outline').html('');
            $('.txt_week1').html('');
            $('.txt_week2').html('');
            $('.txt_week3').html('');
            $('.txt_week4').html('');
            $('.txt_week5').html('');
            $('.txt_week6').html('');
            $('.txt_week7').html('');
            $('.txt_week8').html('');
            $('.txt_week9').html('');
            $('.txt_week10').html('');
            $('.txt_week11').html('');
            $('.txt_week12').html('');
            $('.txt_week13').html('');
            $('.txt_week14').html('');
            $('.txt_week15').html('');
            $('.txt_week16').html('');

            $('.txt_reference1').html('');
            $('.txt_reference2').html('');
            $('.txt_reference3').html('');
            $('.txt_reference4').html('');
            $('.txt_reference5').html('');
            $('.txt_reference6').html('');
            $('.txt_reference7').html('');
            $('.txt_reference8').html('');
            $('.txt_reference9').html('');
            $('.txt_reference10').html('');
            $('.txt_reference11').html('');
            $('.txt_reference12').html('');
            $('.txt_reference13').html('');
            $('.txt_reference14').html('');
            $('.txt_reference15').html('');
            $('.txt_reference16').html('');

            $('.txtcourse_structure').html('');
            $('.txt_course_code').html('');

            $('.txt_reference').html('');
            $('.txt_eval_method').html('');

            var flag = 'N';

            var course_code = data[i]["course_code"] + ' : ' + data[i]["title"];

            $('.txtcourse_outline').html(data[i]["course_outline"]);

            $('.txt_week1').html(data[i]["week1"]);
            $('.txt_week2').html(data[i]["week2"]);
            $('.txt_week3').html(data[i]["week3"]);
            $('.txt_week4').html(data[i]["week4"]);
            $('.txt_week5').html(data[i]["week5"]);
            $('.txt_week6').html(data[i]["week6"]);
            $('.txt_week7').html(data[i]["week7"]);
            $('.txt_week8').html(data[i]["week8"]);
            $('.txt_week9').html(data[i]["week9"]);
            $('.txt_week10').html(data[i]["week10"]);
            $('.txt_week11').html(data[i]["week11"]);
            $('.txt_week12').html(data[i]["week12"]);
            $('.txt_week13').html(data[i]["week13"]);
            $('.txt_week14').html(data[i]["week14"]);
            $('.txt_week15').html(data[i]["week15"]);
            $('.txt_week16').html(data[i]["week16"]);

            $('.txt_course_code').html(course_code);

            $('.spn_prog_level_code').html(data[i]["program_level_code"]);
            $('.spn_instructor').html(data[i]["instructor"]);
            $('.txtcourse_structure').html(data[i]["course_structure"]);
            $('.spn_faculty').html(data[i]["faculty"]);

            var semester = '';

            if ($('#drpsem').val() == 'M') {
                semester = 'Monsoon';
            }
            else {
                semester = 'Spring';
            }

            $('.spn_semester').html(semester);
            $('.spn_year').html($('#drpyear').val());

            if (data[i]["remark"] != "") {
                $('.txt_reference').html(data[i]["remark"]);
            }
            else {
                //$('.txt_reference').html('NA');
            }

            if (data[i]["eval_method1"] != "") {
                $('.txt_eval_method').html(data[i]["eval_method1"]);
            }
            else {
                //$('.txt_eval_method').html('NA');
            }

            if (data[i]["prerequisite"] != "") {
                var data1 = get_prerequisite(data[i]["prerequisite"]);

                if (data1 != "") {
                    $('.txt_Prerequisite').html(data1);
                }
                else {
                    //$('.txt_Prerequisite').html('NA');
                }
            }

            if (data[i]["course_structure"] != '') {
                $('.divweeklyplan').css('display', 'none');
                $('.divcoursestructure').css('display', 'block');
            }
            else if (data[i]["week1"] != '' || data[i]["week2"] != '' || data[i]["week3"] != '' || data[i]["week4"] != '' || data[i]["week5"] != '' || data[i]["week6"] != '' || data[i]["week7"] != '' || data[i]["week8"] != '' || data[i]["week9"] != '' || data[i]["week10"] != '' || data[i]["week11"] != '' || data[i]["week12"] != '' || data[i]["week13"] != '' || data[i]["week14"] != '' || data[i]["week15"] != '' || data[i]["week16"] != '') {
                $('.divweeklyplan').css('display', 'block');
                $('.divcoursestructure').css('display', 'none');
            }
            else {
                $('.divweekly_plan').css('display', 'none');
                $('.divcoursestructure').css('display', 'none');
            }

            if (data[i]["week_reference1"] != '') {
                $('.txt_reference1').html(data[i]["week_reference1"]);
                $('.div_reference1').css('display', 'block');
            }
            else {
                //$('.txt_reference1').html('NA');
                $('.div_reference1').css('display', 'none');
            }

            if (data[i]["week_reference2"] != '') {
                $('.txt_reference2').html(data[i]["week_reference2"]);
                $('.div_reference2').css('display', 'block');
            }
            else {
                //$('.txt_reference2').html('NA');
                $('.div_reference2').css('display', 'none');
            }

            if (data[i]["week_reference3"] != '') {
                $('.txt_reference3').html(data[i]["week_reference3"]);
                $('.div_reference3').css('display', 'block');
            }
            else {
                //$('.txt_reference3').html('NA');
                $('.div_reference3').css('display', 'none');
            }

            if (data[i]["week_reference4"] != '') {
                $('.txt_reference4').html(data[i]["week_reference4"]);
                $('.div_reference4').css('display', 'block');
            }
            else {
                //$('.txt_reference4').html('NA');
                $('.div_reference4').css('display', 'none');
            }

            if (data[i]["week_reference5"] != '') {
                $('.txt_reference5').html(data[i]["week_reference5"]);
                $('.div_reference5').css('display', 'block');
            }
            else {
                //$('.txt_reference5').html('NA');
                $('.div_reference5').css('display', 'none');
            }

            if (data[i]["week_reference6"] != '') {
                $('.txt_reference6').html(data[i]["week_reference6"]);
                $('.div_reference6').css('display', 'block');
            }
            else {
                //$('.txt_reference6').html('NA');
                $('.div_reference6').css('display', 'none');
            }

            if (data[i]["week_reference7"] != '') {
                $('.txt_reference7').html(data[i]["week_reference7"]);
                $('.div_reference7').css('display', 'block');
            }
            else {
                //$('.txt_reference7').html('NA');
                $('.div_reference7').css('display', 'none');
            }

            if (data[i]["week_reference8"] != '') {
                $('.txt_reference8').html(data[i]["week_reference8"]);
                $('.div_reference8').css('display', 'block');
            }
            else {
                //$('.txt_reference8').html('NA');
                $('.div_reference8').css('display', 'none');
            }

            if (data[i]["week_reference9"] != '') {
                $('.txt_reference9').html(data[i]["week_reference9"]);
                $('.div_reference9').css('display', 'block');
            }
            else {
                //$('.txt_reference9').html('NA');
                $('.div_reference9').css('display', 'none');
            }

            if (data[i]["week_reference10"] != '') {
                $('.txt_reference10').html(data[i]["week_reference10"]);
                $('.div_reference10').css('display', 'block');
            }
            else {
                //$('.txt_reference10').html('NA');
                $('.div_reference10').css('display', 'none');
            }

            if (data[i]["week_reference11"] != '') {
                $('.txt_reference11').html(data[i]["week_reference11"]);
                $('.div_reference11').css('display', 'block');
            }
            else {
                //$('.txt_reference11').html('NA');
                $('.div_reference11').css('display', 'none');
            }

            if (data[i]["week_reference12"] != '') {
                $('.txt_reference12').html(data[i]["week_reference12"]);
                $('.div_reference12').css('display', 'block');
            }
            else {
                //$('.txt_reference12').html('NA');
                $('.div_reference12').css('display', 'none');
            }

            if (data[i]["week_reference13"] != '') {
                $('.txt_reference13').html(data[i]["week_reference13"]);
                $('.div_reference13').css('display', 'block');
            }
            else {
                //$('.txt_reference13').html('NA');
                $('.div_reference13').css('display', 'none');
            }

            if (data[i]["week_reference14"] != '') {
                $('.txt_reference14').html(data[i]["week_reference14"]);
                $('.div_reference14').css('display', 'block');
            }
            else {
                //$('.txt_reference14').html('NA');
                $('.div_reference14').css('display', 'none');
            }

            if (data[i]["week_reference15"] != '') {
                $('.txt_reference15').html(data[i]["week_reference15"]);
                $('.div_reference15').css('display', 'block');
            }
            else {
                //$('.txt_reference15').html('NA');
                $('.div_reference15').css('display', 'none');
            }

            if (data[i]["week_reference16"] != '') {
                $('.txt_reference16').html(data[i]["week_reference16"]);
                $('.div_reference16').css('display', 'block');
            }
            else {
                //$('.txt_reference16').html('NA');
                $('.div_reference16').css('display', 'none');
            }

            all_data = all_data + $('#downloadoutline').html();
        }

        $('#downloadoutline').css('display', 'none');
        $('#div_download_all_outline').modal('show');
        $('#div_print_all').html('');
        $('#div_print_all').append(all_data);
        $('#div_print_all .panel').css('margin-bottom', '12px');
    });

    //pending_course_list();
    //my_course_list();
    //get_Current();
    user_wise_rights_module();
    bindyeardata_for_cross_reg();
    bindprogrammedata();
   // bindproglevel();
    bind_program_level_code();
    binddepartment();

    $('#drpdepartment').on('change', function () {
        bind_program_level_code();
    });

    $('#drpprog').on('change', function () {
        bind_program_level_code();
    });
    //get_fauser_detail();
});

function binddepartment() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_department_data",
        data: "{}",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var sem_data = JSON.parse(data.d)

                $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));

                for (var i = 0; i < sem_data.length; i++) {
                    $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                }

                $('#drpdepartment').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function user_wise_rights_module() {
    var page_name = document.location.href.match(/[^\/]+$/)[0];
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/User_wise_Rights_for_Module",
        async: false,
        data: "{page_name:'" + page_name + "',rights_type:'download'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                download_rights_user_wise = 'true';

            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindyeardata_for_cross_reg() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_year_data",
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

function bindprogrammedata() {
    if ($('#hdnusertype').val() == 'FA') {
        $('.cls_dept_prog').css('display', 'none');

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_Admin_wise_Program_user_dtl",
            async: false,
            data: "{}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var user_data = JSON.parse(data.d);

                    $('#drpprog').empty();

                    for (var i = 0; i < user_data.length; i++) {

                        if (user_data[i]['prog_code'] == "1") {
                            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                        }
                        else if (user_data[i]['prog_code'] == "2") {
                            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                        }
                        else if (user_data[i]['prog_code'] == "3") {
                            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                        }
                    }

                }
                else {
                    $('#drpprog').val('1');
                    $("#drpprog").attr('disabled', 'disabled');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
    else if ($('#hdn_utype').val() == 'PC') {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_programme_coordinator_dtl",
            async: false,
            data: "{}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var user_data = JSON.parse(data.d);

                    $('#drpprog').empty();

                    for (var i = 0; i < user_data.length; i++) {
                        if (user_data[i]['prog_code'] == "1") {
                            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                        }
                        else if (user_data[i]['prog_code'] == "2") {
                            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                        }
                        else if (user_data[i]['prog_code'] == "3") {
                            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                        }
                    }
                    //$('#drpprog').val(user_data[0]['prog_code']);
                }
                else {
                    $('#drpprog').val('1');
                    $("#drpprog").attr('disabled', 'disabled');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
    else {
        $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
        $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
        $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
        $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

        if ($("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
            $('#drpprog').chosen();
        }
    }
}

function bindproglevel() {
    //$('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
    //$('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
    //$('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_program_level_data_rights_wise",
        data: "{}",
        dataType: "json",
        async: false,
        success: function (data) {
            if (data.d != "") {
                var prog_level_data = JSON.parse(data.d)

                $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                for (var i = 0; i < prog_level_data.length; i++) {
                    $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                }

                //if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                $('#drpproglevel').chosen();
                //}
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bind_program_level_code() {
    var dept_code = $('#drpdepartment').val();
    var prog_code = $('#drpprog').val();

    if (dept_code == '' && prog_code == '') {

        return false;
    }
    //if (prog_code == '') {
    //    return false;
    //}

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_programme_level_dept_wise",
        data: "{dept_code : '" + dept_code + "',prog_code:'" + prog_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Program level Code course --"));

                for (var i = 0; i < year_data.length; i++) {
                    $('#drpproglevel').append($("<option></option>").val(year_data[i]["prog_level_code"]).html(year_data[i]["prog_level_desc"]));
                }

                $('#drpproglevel').chosen();
                $('#drpproglevel').trigger("liszt:updated");
            }
            else {
                $('#drpproglevel')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Program level found</option>')
                    .val('');
                $('#drpproglevel').chosen();

                $('#drpproglevel').val('').trigger("liszt:updated");
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}



function get_Current() {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_Current_Semester_Detail",
            data: "{}",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    var cur_data = JSON.parse(data.d);
                    if (cur_data.length > 0) {
                        cur_sem = cur_data[0]["sem_code"];
                        cur_year = cur_data[0]["year_code"];
                    }
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}

$(document).on("click", ".course_outlin_oTable1", function (event) {
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

    $('#img1').css("display", "none");
    $('#img2').css("display", "none");
    $('#img3').css("display", "none");
    $('#img4').css("display", "none");
    $('#img5').css("display", "none");
    $('#img6').css("display", "none");
    $('#img7').css("display", "none");
    $('#mainimg').css("display", "none");
    $('#img567').css("display", "none");

    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);

    var flag = 'N';

    var course_code = aData["course_code"] + ' : ' + aData["title"];

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

    $('#txt_course_code').html(course_code);

    $('#spn_prog_level_code').html(aData.program_level_code);
    $('#spn_instructor').html(aData["instructor"]);
    $('#txtcourse_structure').html(aData["course_structure"]);
    $('#spn_faculty').html(aData.faculty);

    var semester = '';
    if ($('#drpsem').val() == 'M') {
        semester = 'Monsoon';
    }
    else {
        semester = 'Spring';
    }

    $('#spn_semester').html(semester);
    $('#spn_year').html($('#drpyear').val());

    if (aData["remark"] != "") {
        $('#txt_reference').html(aData["remark"]);
    }
    else {
        //$('#txt_reference').html('NA');
    }

    if (aData["eval_method1"] != "") {
        $('#txt_eval_method').html(aData["eval_method1"]);
    }
    else {
        //$('#txt_eval_method').html('NA');
    }

    if (aData["prerequisite"] != "") {
        var data = get_prerequisite(aData["prerequisite"]);

        if (data != "") {
            $('#txt_Prerequisite').html(data);
        }
        else {
            //$('#txt_Prerequisite').html('NA');
        }
    }

    if (aData["eval_method4"] != "" && aData["eval_method4"] != null) {

        var CourseImg = JSON.parse(aData["eval_method4"]);
        if (CourseImg.length > 2)
            $('#img567').removeAttr('style');
        if (CourseImg.length > 0) {
            $('#mainimg').removeAttr('style');
            for (var i = 1; i <= CourseImg.length; i++) {

                $('#img' + i).attr("src", "../../CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
                //$('#img' + i).css("display", "block");
                $('#img' + i).removeAttr('style');
            }
        }
    }

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

    if (aData.week_reference1 != '') {
        $('#txt_reference1').html(aData.week_reference1);
        $('#div_reference1').css('display', 'block');
    }
    else {
        //$('#txt_reference1').html('NA');
        $('#div_reference1').css('display', 'none');
    }

    if (aData.week_reference2 != '') {
        $('#txt_reference2').html(aData.week_reference2);
        $('#div_reference2').css('display', 'block');
    }
    else {
        //$('#txt_reference2').html('NA');
        $('#div_reference2').css('display', 'none');
    }

    if (aData.week_reference3 != '') {
        $('#txt_reference3').html(aData.week_reference3);
        $('#div_reference3').css('display', 'block');
    }
    else {
        //$('#txt_reference3').html('NA');
        $('#div_reference3').css('display', 'none');
    }

    if (aData.week_reference4 != '') {
        $('#txt_reference4').html(aData.week_reference4);
        $('#div_reference4').css('display', 'block');
    }
    else {
        //$('#txt_reference4').html('NA');
        $('#div_reference4').css('display', 'none');
    }

    if (aData.week_reference5 != '') {
        $('#txt_reference5').html(aData.week_reference5);
        $('#div_reference5').css('display', 'block');
    }
    else {
        //$('#txt_reference5').html('NA');
        $('#div_reference5').css('display', 'none');
    }

    if (aData.week_reference6 != '') {
        $('#txt_reference6').html(aData.week_reference6);
        $('#div_reference6').css('display', 'block');
    }
    else {
        //$('#txt_reference6').html('NA');
        $('#div_reference6').css('display', 'none');
    }

    if (aData.week_reference7 != '') {
        $('#txt_reference7').html(aData.week_reference7);
        $('#div_reference7').css('display', 'block');
    }
    else {
        //$('#txt_reference7').html('NA');
        $('#div_reference7').css('display', 'none');
    }

    if (aData.week_reference8 != '') {
        $('#txt_reference8').html(aData.week_reference8);
        $('#div_reference8').css('display', 'block');
    }
    else {
        //$('#txt_reference8').html('NA');
        $('#div_reference8').css('display', 'none');
    }

    if (aData.week_reference9 != '') {
        $('#txt_reference9').html(aData.week_reference9);
        $('#div_reference9').css('display', 'block');
    }
    else {
        //$('#txt_reference9').html('NA');
        $('#div_reference9').css('display', 'none');
    }

    if (aData.week_reference10 != '') {
        $('#txt_reference10').html(aData.week_reference10);
        $('#div_reference10').css('display', 'block');
    }
    else {
        //$('#txt_reference10').html('NA');
        $('#div_reference10').css('display', 'none');
    }

    if (aData.week_reference11 != '') {
        $('#txt_reference11').html(aData.week_reference11);
        $('#div_reference11').css('display', 'block');
    }
    else {
        //$('#txt_reference11').html('NA');
        $('#div_reference11').css('display', 'none');
    }

    if (aData.week_reference12 != '') {
        $('#txt_reference12').html(aData.week_reference12);
        $('#div_reference12').css('display', 'block');
    }
    else {
        //$('#txt_reference12').html('NA');
        $('#div_reference12').css('display', 'none');
    }

    if (aData.week_reference13 != '') {
        $('#txt_reference13').html(aData.week_reference13);
        $('#div_reference13').css('display', 'block');
    }
    else {
        //$('#txt_reference13').html('NA');
        $('#div_reference13').css('display', 'none');
    }

    if (aData.week_reference14 != '') {
        $('#txt_reference14').html(aData.week_reference14);
        $('#div_reference14').css('display', 'block');
    }
    else {
        //$('#txt_reference14').html('NA');
        $('#div_reference14').css('display', 'none');
    }

    if (aData.week_reference15 != '') {
        $('#txt_reference15').html(aData.week_reference15);
        $('#div_reference15').css('display', 'block');
    }
    else {
        //$('#txt_reference15').html('NA');
        $('#div_reference15').css('display', 'none');
    }

    if (aData.week_reference16 != '') {
        $('#txt_reference16').html(aData.week_reference16);
        $('#div_reference16').css('display', 'block');
    }
    else {
        //$('#txt_reference16').html('NA');
        $('#div_reference16').css('display', 'none');
    }

    //if (aData["course_typology"] == '') {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //else if (aData["course_typology"] == '3' || aData["course_typology"] == '4' || aData["course_typology"] == '6' || aData["course_typology"] == '8') {
    //    $('#div_weekly_plan').css('display', 'block');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //else {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'block');
    //}

    return false;
});

$(document).on("click", ".course_outlin_oTable2", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable2.fnGetData(row);
    var course_code = aData["course_code"];

    $('#ifrm_outline').html('<iframe src="' + location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + cur_sem + '&year_code=' + cur_year + '&new_tab=Y" width="1" height="1"></iframe>');
});

$(document).on("click", ".course_outlin_oTable2_download", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable2.fnGetData(row);
    var course_code = aData["course_code"];

    $('#hdn_course_code').val(course_code);
    $('#hdn_sem_code').val(cur_sem);
    $('#hdn_year_code').val(cur_year);
    $('#btn_download').click();
});

$(document).on("click", ".course_outlin_oTable2_old", function (event) {
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

    $('#img1').css("display", "none");
    $('#img2').css("display", "none");
    $('#img3').css("display", "none");
    $('#img4').css("display", "none");
    $('#img5').css("display", "none");
    $('#img6').css("display", "none");
    $('#img7').css("display", "none");
    $('#mainimg').css("display", "none");
    $('#img567').css("display", "none");

    var row = $(this).closest("tr").get(0);
    var aData = oTable2.fnGetData(row);

    var flag = 'N';

    var course_code = aData["course_code"] + ' : ' + aData["title"];


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

    $('#spn_prog_level_code').html(aData.program_level_code);
    $('#spn_instructor').html(aData["instructor"]);
    $('#txtcourse_structure').html(aData["course_structure"]);
    $('#spn_faculty').html(aData.faculty);

    var semester = '';
    if ($('#drpsem').val() == 'M') {
        semester = 'Monsoon';
    }
    else {
        semester = 'Spring';
    }

    if (aData["prerequisite"] != "") {
        var data = get_prerequisite(aData["prerequisite"]);

        if (data != "") {
            $('#txt_Prerequisite').html(data);
        }
        else {
            // $('#txt_Prerequisite').html('NA');
        }

    }


    $('#spn_semester').html(semester);
    $('#spn_year').html($('#drpyear').val());

    if (aData["remark"] != "") {
        $('#txt_reference').html(aData["remark"]);
    }
    else {
        // $('#txt_reference').html('NA');
    }

    if (aData["eval_method1"] != "") {
        $('#txt_eval_method').html(aData["eval_method1"]);
    }
    else {
        // $('#txt_eval_method').html('NA');
    }

    if (aData["eval_method4"] != "" && aData["eval_method4"] != null) {

        var CourseImg = JSON.parse(aData["eval_method4"]);
        if (CourseImg.length > 2)
            $('#img567').removeAttr('style');
        if (CourseImg.length > 0) {
            $('#mainimg').removeAttr('style');
            for (var i = 1; i <= CourseImg.length; i++) {

                $('#img' + i).attr("src", "../../CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
                $('#div_caption' + i).html(CourseImg[i - 1]["img_caption"]);
                $('#img' + i).removeAttr('style');
            }
        }
    }

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

    if (aData.week_reference1 != '') {
        $('#txt_reference1').html(aData.week_reference1);
        $('#div_reference1').css('display', 'block');
    }
    else {
        // $('#txt_reference1').html('NA');
        $('#div_reference1').css('display', 'none');
    }

    if (aData.week_reference2 != '') {
        $('#txt_reference2').html(aData.week_reference2);
        $('#div_reference2').css('display', 'block');
    }
    else {
        // $('#txt_reference2').html('NA');
        $('#div_reference2').css('display', 'none');
    }

    if (aData.week_reference3 != '') {
        $('#txt_reference3').html(aData.week_reference3);
        $('#div_reference3').css('display', 'block');
    }
    else {
        //  $('#txt_reference3').html('NA');
        $('#div_reference3').css('display', 'none');
    }

    if (aData.week_reference4 != '') {
        $('#txt_reference4').html(aData.week_reference4);
        $('#div_reference4').css('display', 'block');
    }
    else {
        // $('#txt_reference4').html('NA');
        $('#div_reference4').css('display', 'none');
    }

    if (aData.week_reference5 != '') {
        $('#txt_reference5').html(aData.week_reference5);
        $('#div_reference5').css('display', 'block');
    }
    else {
        //  $('#txt_reference5').html('NA');
        $('#div_reference5').css('display', 'none');
    }

    if (aData.week_reference6 != '') {
        $('#txt_reference6').html(aData.week_reference6);
        $('#div_reference6').css('display', 'block');
    }
    else {
        // $('#txt_reference6').html('NA');
        $('#div_reference6').css('display', 'none');
    }

    if (aData.week_reference7 != '') {
        $('#txt_reference7').html(aData.week_reference7);
        $('#div_reference7').css('display', 'block');
    }
    else {
        //   $('#txt_reference7').html('NA');
        $('#div_reference7').css('display', 'none');
    }

    if (aData.week_reference8 != '') {
        $('#txt_reference8').html(aData.week_reference8);
        $('#div_reference8').css('display', 'block');
    }
    else {
        // $('#txt_reference8').html('NA');
        $('#div_reference8').css('display', 'none');
    }

    if (aData.week_reference9 != '') {
        $('#txt_reference9').html(aData.week_reference9);
        $('#div_reference9').css('display', 'block');
    }
    else {
        // $('#txt_reference9').html('NA');
        $('#div_reference9').css('display', 'none');
    }

    if (aData.week_reference10 != '') {
        $('#txt_reference10').html(aData.week_reference10);
        $('#div_reference10').css('display', 'block');
    }
    else {
        // $('#txt_reference10').html('NA');
        $('#div_reference10').css('display', 'none');
    }

    if (aData.week_reference11 != '') {
        $('#txt_reference11').html(aData.week_reference11);
        $('#div_reference11').css('display', 'block');
    }
    else {
        //  $('#txt_reference11').html('NA');
        $('#div_reference11').css('display', 'none');
    }

    if (aData.week_reference12 != '') {
        $('#txt_reference12').html(aData.week_reference12);
        $('#div_reference12').css('display', 'block');
    }
    else {
        //$('#txt_reference12').html('NA');
        $('#div_reference12').css('display', 'none');
    }

    if (aData.week_reference13 != '') {
        $('#txt_reference13').html(aData.week_reference13);
        $('#div_reference13').css('display', 'block');
    }
    else {
        //  $('#txt_reference13').html('NA');
        $('#div_reference13').css('display', 'none');
    }

    if (aData.week_reference14 != '') {
        $('#txt_reference14').html(aData.week_reference14);
        $('#div_reference14').css('display', 'block');
    }
    else {
        //  $('#txt_reference14').html('NA');
        $('#div_reference14').css('display', 'none');
    }

    if (aData.week_reference15 != '') {
        $('#txt_reference15').html(aData.week_reference15);
        $('#div_reference15').css('display', 'block');
    }
    else {
        //  $('#txt_reference15').html('NA');
        $('#div_reference15').css('display', 'none');
    }

    if (aData.week_reference16 != '') {
        $('#txt_reference16').html(aData.week_reference16);
        $('#div_reference16').css('display', 'block');
    }
    else {
        //  $('#txt_reference16').html('NA');
        $('#div_reference16').css('display', 'none');
    }
    //    if (aData["course_typology"] == '') {
    //        $('#div_weekly_plan').css('display', 'none');
    //        $('#div_course_structure').css('display', 'none');
    //    }
    //    else if (aData["course_typology"] == '3' || aData["course_typology"] == '4' || aData["course_typology"] == '6' || aData["course_typology"] == '8') {
    //        $('#div_weekly_plan').css('display', 'block');
    //        $('#div_course_structure').css('display', 'none');
    //    }
    //    else {
    //        $('#div_weekly_plan').css('display', 'none');
    //        $('#div_course_structure').css('display', 'block');
    //    }

    return false;

});

$(document).on("click", ".course_outline_oTable_allapprovedcourses", function (event) {
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

    $('#img1').css("display", "none");
    $('#img2').css("display", "none");
    $('#img3').css("display", "none");
    $('#img4').css("display", "none");
    $('#img5').css("display", "none");
    $('#img6').css("display", "none");
    $('#img7').css("display", "none");
    $('#mainimg').css("display", "none");
    $('#img567').css("display", "none");

    var row = $(this).closest("tr").get(0);
    var aData = oTable_allapproved_courses.fnGetData(row);

    var flag = 'N';

    var course_code = aData["course_code"] + ' : ' + aData["title"];

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

    $('#spn_prog_level_code').html(aData.program_level_code);
    $('#spn_instructor').html(aData["instructor"]);
    $('#txtcourse_structure').html(aData["course_structure"]);
    $('#spn_faculty').html(aData.faculty);

    var semester = '';
    if ($('#drpsem').val() == 'M') {
        semester = 'Monsoon';
    }
    else {
        semester = 'Spring';
    }

    if (aData["prerequisite"] != "") {
        var data = get_prerequisite(aData["prerequisite"]);

        if (data != "") {
            $('#txt_Prerequisite').html(data);
        }
        else {
            //$('#txt_Prerequisite').html('NA');
        }

    }

    $('#spn_semester').html(semester);
    $('#spn_year').html($('#drpyear').val());

    if (aData["remark"] != "") {
        $('#txt_reference').html(aData["remark"]);
    }
    else {
        //$('#txt_reference').html('NA');
    }

    if (aData["eval_method1"] != "") {
        $('#txt_eval_method').html(aData["eval_method1"]);
    }
    else {
        //$('#txt_eval_method').html('NA');
    }
    if (aData["eval_method4"] != "" && aData["eval_method4"] != null) {

        var CourseImg = JSON.parse(aData["eval_method4"]);
        if (CourseImg.length > 2)
            $('#img567').removeAttr('style');
        if (CourseImg.length > 0) {
            $('#mainimg').removeAttr('style');
            for (var i = 1; i <= CourseImg.length; i++) {

                $('#img' + i).attr("src", "../../CourseImageUpload/" + CourseImg[i - 1]["img_name"]);
                $('#div_caption' + i).html(CourseImg[i - 1]["img_caption"]);
                $('#img' + i).removeAttr('style');
            }
        }
    }

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

    if (aData.week_reference1 != '') {
        $('#txt_reference1').html(aData.week_reference1);
        $('#div_reference1').css('display', 'block');
    }
    else {
        //$('#txt_reference1').html('NA');
        $('#div_reference1').css('display', 'none');
    }

    if (aData.week_reference2 != '') {
        $('#txt_reference2').html(aData.week_reference2);
        $('#div_reference2').css('display', 'block');
    }
    else {
        //$('#txt_reference2').html('NA');
        $('#div_reference2').css('display', 'none');
    }

    if (aData.week_reference3 != '') {
        $('#txt_reference3').html(aData.week_reference3);
        $('#div_reference3').css('display', 'block');
    }
    else {
        //$('#txt_reference3').html('NA');
        $('#div_reference3').css('display', 'none');
    }

    if (aData.week_reference4 != '') {
        $('#txt_reference4').html(aData.week_reference4);
        $('#div_reference4').css('display', 'block');
    }
    else {
        //$('#txt_reference4').html('NA');
        $('#div_reference4').css('display', 'none');
    }

    if (aData.week_reference5 != '') {
        $('#txt_reference5').html(aData.week_reference5);
        $('#div_reference5').css('display', 'block');
    }
    else {
        //$('#txt_reference5').html('NA');
        $('#div_reference5').css('display', 'none');
    }

    if (aData.week_reference6 != '') {
        $('#txt_reference6').html(aData.week_reference6);
        $('#div_reference6').css('display', 'block');
    }
    else {
        //$('#txt_reference6').html('NA');
        $('#div_reference6').css('display', 'none');
    }

    if (aData.week_reference7 != '') {
        $('#txt_reference7').html(aData.week_reference7);
        $('#div_reference7').css('display', 'block');
    }
    else {
        //$('#txt_reference7').html('NA');
        $('#div_reference7').css('display', 'none');
    }

    if (aData.week_reference8 != '') {
        $('#txt_reference8').html(aData.week_reference8);
        $('#div_reference8').css('display', 'block');
    }
    else {
        //$('#txt_reference8').html('NA');
        $('#div_reference8').css('display', 'none');
    }

    if (aData.week_reference9 != '') {
        $('#txt_reference9').html(aData.week_reference9);
        $('#div_reference9').css('display', 'block');
    }
    else {
        //$('#txt_reference9').html('NA');
        $('#div_reference9').css('display', 'none');
    }

    if (aData.week_reference10 != '') {
        $('#txt_reference10').html(aData.week_reference10);
        $('#div_reference10').css('display', 'block');
    }
    else {
        //$('#txt_reference10').html('NA');
        $('#div_reference10').css('display', 'none');
    }

    if (aData.week_reference11 != '') {
        $('#txt_reference11').html(aData.week_reference11);
        $('#div_reference11').css('display', 'block');
    }
    else {
        //$('#txt_reference11').html('NA');
        $('#div_reference11').css('display', 'none');
    }

    if (aData.week_reference12 != '') {
        $('#txt_reference12').html(aData.week_reference12);
        $('#div_reference12').css('display', 'block');
    }
    else {
        //$('#txt_reference12').html('NA');
        $('#div_reference12').css('display', 'none');
    }

    if (aData.week_reference13 != '') {
        $('#txt_reference13').html(aData.week_reference13);
        $('#div_reference13').css('display', 'block');
    }
    else {
        //$('#txt_reference13').html('NA');
        $('#div_reference13').css('display', 'none');
    }

    if (aData.week_reference14 != '') {
        $('#txt_reference14').html(aData.week_reference14);
        $('#div_reference14').css('display', 'block');
    }
    else {
        //$('#txt_reference14').html('NA');
        $('#div_reference14').css('display', 'none');
    }

    if (aData.week_reference15 != '') {
        $('#txt_reference15').html(aData.week_reference15);
        $('#div_reference15').css('display', 'block');
    }
    else {
        //$('#txt_reference15').html('NA');
        $('#div_reference15').css('display', 'none');
    }

    if (aData.week_reference16 != '') {
        $('#txt_reference16').html(aData.week_reference16);
        $('#div_reference16').css('display', 'block');
    }
    else {
        //$('#txt_reference16').html('NA');
        $('#div_reference16').css('display', 'none');
    }

    //if (aData["course_typology"] == '') {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //else if (aData["course_typology"] == '3' || aData["course_typology"] == '4' || aData["course_typology"] == '6' || aData["course_typology"] == '8') {
    //    $('#div_weekly_plan').css('display', 'block');
    //    $('#div_course_structure').css('display', 'none');
    //}
    //else {
    //    $('#div_weekly_plan').css('display', 'none');
    //    $('#div_course_structure').css('display', 'block');
    //}

    return false;

});

function rowClick(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    //alert("ID : " + rowId);
    //window.location = "frmcoursemaster.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
    var url = "frmcoursemaster.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
    window.open(url, '_blank');
}

function rowClick_new_per(row, objtable) {
    
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var rowId = objtable.fnGetData($(row).closest('tr')[0])['course_code'];
    var personal_details_status = objtable.fnGetData($(row).closest('tr')[0])['studio_per_dtl_status'];//row.parentElement.parentElement.parentElement.childNodes[24].childNodes[0].nodeValue;
    var designation = objtable.fnGetData($(row).closest('tr')[0])['designation'];
    var type = objtable.fnGetData($(row).closest('tr')[0])['type'];
    if (personal_details_status == "False" && designation.toLowerCase() == "vf" && type.toLowerCase() == 'courses' && $("#hdnusertype").val() == 'I2')
    {
        var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor&per=p&icc=" + rowId+"";
        window.open(url, "_self");
    }
    else
    {
        window.location = "frmcoursemaster.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
    }
    
}

function rowClick_new(row, objtable) {
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].childNodes[0].childNodes[0];
    var rowId = objtable.fnGetData($(row).closest('tr')[0])['course_code'];

    // window.location = "frmcoursemaster.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
    window.open("frmcoursemaster.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year, target = "_blank");
}

function rowClick_View(row, objtable) {
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].childNodes[0].childNodes[0];
    var course_code = objtable.fnGetData($(row).closest('tr')[0])['course_code'];
    
    $('#ifrm_outline').html('<iframe src="' + location.origin + '/Student/OutLinePDF.aspx?course_id=' + course_code + '&sem_code=' + cur_sem + '&year_code=' + cur_year + '&new_tab=Y" width="1" height="1"></iframe>');
}

function rowClick_approve(row, delTable) {
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var rowId = delTable.fnGetData($(row).closest('tr')[0])['course_code'];

    var r = confirm("Are you sure you want to Approve course '" + rowId + "' ?");
    if (r == true) {
        initalapproveCourseData(rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function initalapproveCourseData(rowId) {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/inital_approve_course_I2",
            async: false,
            data: "{d_course_code:'" + rowId + "',semester:'" + cur_sem + "',year:'" + cur_year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "true") {
                        bootbox.alert("Course Approve Successfully", function (result) {
                            window.location = "admin_dashboard.aspx";
                        });
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}


//30032022
function rowClick_pending_cac(row, delTable) {
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var rowId = delTable.fnGetData($(row).closest('tr')[0])['course_code'];

    var r = confirm("Are you sure you want to Pending At CAC Course '" + rowId + "' ?");
    if (r == true) {
        pendingCACCourseData(rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function pendingCACCourseData(rowId) {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/pendingCACCourse",
            async: false,
            data: "{d_course_code:'" + rowId + "',semester:'" + cur_sem + "',year:'" + cur_year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "true") {
                        bootbox.alert("Course Pending CAC Successfully", function (result) {
                            window.location = "admin_dashboard.aspx";
                        });
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}



function rowClick_reject_cac(row, delTable) {
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var rowId = delTable.fnGetData($(row).closest('tr')[0])['course_code'];

    var r = confirm("Are you sure you want to Reject This Course '" + rowId + "' ?");
    if (r == true) {
        RejectCACCourseData(rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function RejectCACCourseData(rowId) {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/RejectCACCourseData", 
            async: false,
            data: "{d_course_code:'" + rowId + "',semester:'" + cur_sem + "',year:'" + cur_year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "true") {
                        bootbox.alert("Course Reject Successfully", function (result) {
                           // window.location = "admin_dashboard.aspx";
                            $('.reject_' + rowId).prop('disabled', true);
                        });
                        return false;
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}



function rowClick_send_for_review_cac(row, delTable) {
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var rowId = delTable.fnGetData($(row).closest('tr')[0])['course_code'];

    var r = confirm("Are you sure you want to Send For Review This Course '" + rowId + "' ?");
    if (r == true) {
        SendForReviewCACCourseData(rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function SendForReviewCACCourseData(rowId) {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/SendForReviewCACCourseData",
            async: false,
            data: "{d_course_code:'" + rowId + "',semester:'" + cur_sem + "',year:'" + cur_year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "true") {
                        bootbox.alert("Course Send For Review Successfully", function (result) {
                            window.location = "admin_dashboard.aspx";
                        });
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}



function rowClick_delete(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

    var r = confirm("Are you sure you want to delete course '" + rowId + "' ?");
    if (r == true) {
        removeCourseData(rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function rowClick_delete_new(row, delTable) {
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var rowId = delTable.fnGetData($(row).closest('tr')[0])['course_code'];

    var r = confirm("Are you sure you want to delete course '" + rowId + "' ?");
    if (r == true) {
        removeCourseData(rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function rowClick_review(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var r = confirm("Are you sure you want to send for review to program coordinator for course '" + rowId + "' ?");
    if (r == true) {
        sendforreviewCourseData(rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function rowClick_review_faculty(row) {
    var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var r = confirm("Are you sure you want to send for review to Faculty for course '" + rowId + "' ?");
    if (r == true) {
        sendforreviewCourseDatabyfaculty(rowId);
    }
    else {
    }
}

function removeCourseData(rowId) {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/delete_course_tables_data",
            async: false,
            data: "{d_course_code:'" + rowId + "',semester:'" + cur_sem + "',year:'" + cur_year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "Course Removed Successfully") {
                        bootbox.alert(data.d, function (result) {
                            window.location = "admin_dashboard.aspx";
                        });
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}


function sendforreviewCourseData(rowId) {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/send_course_for_review_PC",
            async: false,
            data: "{d_course_code:'" + rowId + "',semester:'" + cur_sem + "',year:'" + cur_year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "Course Successfully Sended for Review") {
                        pending_course_list();
                        approved_course_list();
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}

function sendforreviewCourseDatabyfaculty(rowId) {
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/send_course_for_review_Faculty",
            async: false,
            data: "{d_course_code:'" + rowId + "',semester:'" + cur_sem + "',year:'" + cur_year + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "Course Successfully Sended for Review") {
                        pending_course_list();
                        approved_course_list();
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}



function pending_course_list() {
    $('#DataList').css('display', 'none');
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_pending_course_list_new",
            //async: false,
            data: "{sem_code :'" + cur_sem + "',year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    if ($("#hdnusertype").val() == 'A1') {
                        display_pending_course_list(data.d);
                    }
                    else if ($("#hdnusertype").val() == 'PC') {
                        display_pending_course_list_PC(data.d);
                    }
                }
                else {
                    bootbox.alert('No Courses Found for Pending Approval');
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function display_pending_course_list(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
        //    "oTableTools": {
        //        "aButtons": [
        //            //"copy",
        //"print",
        //        	{
        //        	    "sExtends": "collection",
        //        	    "sButtonText": 'Export',
        //        	    "aButtons": ["xls"]
        //        	}
        //        ]
        //    },
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            {
                "sTitle": "Focuse",
                "mData": "Focuse",
                "bSortable": false,
                "render": function (data, type, row) {
                    // Check if data is null, undefined, or empty
                    if (!data) {
                        return '-'; // or any other placeholder you prefer
                    }
                    return data;
                }
            },
            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },

            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return  data["CouseSubTitle"] ;
                    }
                    else {
                        return '';
                    }

                }
            },

            
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },//kapil 01122020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            //{ "sTitle": "Remark", "mData": "remark", "bSortable": false },
            { "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            {
                "sTitle": "View", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable)">View</button></center >';//Mayur 28052019
                }
            },
            {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                }
            },
            {
                "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
                }
            },
            {
                "sTitle": "Send for Review to PC", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick_review(this)">Review</button></center>';
                }
            }
        ]
    });

    $('#DataList').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
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

function display_pending_course_list_PC(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //        "print",
        //        {
        //            "sExtends": "collection",
        //            "sButtonText": 'Export',
        //            "aButtons": ["xls"]
        //        }
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },

            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return data["CouseSubTitle"];
                    }
                    else {
                        return '';
                    }

                }
            },

            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },

            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },//kapil 01122020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            //{ "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            {
                "sTitle": "Faculty Status", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (data) {

                    if (data['faculty_approval'] == "Approved") {
                        //return '<center><button type="button" onclick="rowClick(this,oTable)">Edit</button></center>';
                        return '<center>Faculty Submitted</center>';
                    } else {
                        return 'Faculty yet not Submitted';
                    }
                }
            },
            {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                }
            },
            {
                "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
                }
            },
            {
                "sTitle": "Send for Review to Faculty", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["faculty_approval"] == "Approved" && data["progcoord_approval"] == "" && data["ugpg_approval"] == "") {
                        return '<center><button type="button" onclick="rowClick_review_faculty(this)">Review</button></center>';
                    }
                    else { return ""; }

                }
            }
        ]
    });

    $('#DataList').css('display', 'block');
}

function display_pending_course_list_inital_PC(data) {
    if (oTable3 != null) {
        oTable3.fnDestroy();
        $("#DataList_inital_PC").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_inital_pc" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable3 = $("#example_inital_pc").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        // "sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //        "print",
        //        {
        //            "sExtends": "collection",
        //            "sButtonText": 'Export',
        //            "aButtons": ["xls"]
        //        }
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            {
                "sTitle": "Focuse",
                "mData": "Focuse",
                "bSortable": false,
                "render": function (data, type, row) {
                    // Check if data is null, undefined, or empty
                    if (!data) {
                        return '-'; // or any other placeholder you prefer
                    }
                    return data;
                }
            },

            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return data["CouseSubTitle"];
                    }
                    else {
                        return '';
                    }

                }
            },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },

            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },//kapil 01122020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },


            {
                "sTitle": "Pending At CAC", "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'PC' || $("#hdnusertype").val() == 'FA') {
                        if (data['faculty_approval'] == 'Approved' && data['p_flag'] == 'P')
                        {
                            return '<center><button type="button" onclick="rowClick_pending_cac(this,oTable3)">Provisional Approve</button></center>';
                        }
                        else {
                            return '<center></center>';
                        }


                    }
                    else { return '<center></center>';}
                }
            },

            //{
            //    "sTitle": "View", "bSortable": false, "mData": null, "mRender": function () {
            //        //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>';
            //        return '<center><button type="button" onclick="rowClick_View(this,oTable)">View</button></center >';//Mayur 28052019
            //    }
            //},//10112020
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outline_oTable_allapprovedcourses">View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable3)">View</button></center >';
                }
            },
            {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (data) {
                    return '<center><button type="button" onclick="rowClick_new(this,oTable3)">Edit</button></center>';
                }
            },
            {
                "sTitle": "Faculty Status", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data['faculty_approved'] == "Y") {
                        return '<center><p>Approved</p></center>';
                    } else {
                        return '<center><p>Pending</p></center>';
                    }
                }
            },
            {
                "sTitle": "PC Initial Status", "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'PC')
                    {
                        //if (data['faculty_approval'] == "Pending_Y") {
                        //    return '<center><button type="button" onclick="rowClick_approve(this,oTable3)" disabled>Approve</button></center>';
                        //}
                        //else
                        //{
                        //Comment By Nitinbhai 16052024
                        if (data['type'].trim() == 'Studio')
                        {
                            //return '<center><button type="button" onclick="rowClick_approve(this,oTable3)">Approve</button></center>';
                            return '';
                        }
                        else
                        {
                            return '<center><button type="button" onclick="rowClick_approve(this,oTable3)">Approve</button></center>';
                        }
                        


                        //}
                    }

                    if ($("#hdnusertype").val() == 'FA')
                    {
                        //if(data['faculty_approval'] == "Pending_Y") {
                        //    return '<center><button type="button" onclick="rowClick_approve(this,oTable5)" disabled>Approve</button></center>';
                        //}
                        //else
                        if (data['p_flag'].trim() == "P") {
                            return '<center><p>Pending</p></center>';
                        }
                        else if (data['p_flag'].trim() == "N") {
                            return '<center><p>Approved</p></center>';
                        }
                        else { return '<center></center>';}

                    }
                }
            }
            , {
                "sTitle": "Action", "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'FA') {
                        if (data['p_flag'].trim() == "P") {
                            return '<center><button type="button" onclick="rowClick_delete_new(this,oTable3)">Delete</button></center>';
                        } else {
                            return '<center></center>';
                        }
                    } else {
                        return '<center></center>';
                    }
                }
            }
            
        ]
    });

    $('#DataList_inital_PC').css('display', 'block');
}


//30032022

function display_pending_CAC_PC(data) {
    if (oTable7 != null) {
        oTable7.fnDestroy();
        $("#DataList_pending_CAC").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_pending_CAC" width="100%"><thead></thead><tbody> </tbody></table>');
    }
    var columnname = 'PC Initial Status';
    if ($("#hdnusertype").val() == 'PC')
    {
        columnname = 'PC Final Approval';
    }
    oTable7 = $("#example_pending_CAC").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        "iDisplayLength": 60,
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            {
                "sTitle": "Focuse","mData": "Focuse","bSortable": false,
                "render": function (data, type, row) {
           
                    if (!data) {
                        return '-'; // or any other placeholder you prefer
                    }
                    return data;
                }
            },

            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },

            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },//kapil 01122020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },


            //{
            //    "sTitle": "View", "bSortable": false, "mData": null, "mRender": function () {
            //        //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>';
            //        return '<center><button type="button" onclick="rowClick_View(this,oTable)">View</button></center >';//Mayur 28052019
            //    }
            //},//10112020
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outline_oTable_allapprovedcourses">View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable7)">View</button></center >';
                }
            },
            {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (data) {
                    return '<center><button type="button" onclick="rowClick_new(this,oTable7)">Edit</button></center>';
                }
            },
            {
                "sTitle": "Faculty Status", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data['faculty_approved'] == "Y") {
                        return '<center><p>Approved</p></center>';
                    } else {
                        return '<center><p>Pending</p></center>';
                    }
                }
            },
            {
                "sTitle": columnname, "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'PC') {
                        //if (data['faculty_approval'] == "Pending_Y") {
                        //    return '<center><button type="button" onclick="rowClick_approve(this,oTable3)" disabled>Approve</button></center>';
                        //}
                        //else
                        //{
                        return '<center><button type="button" onclick="rowClick_approve(this,oTable7)">Approve</button></center>';
                        //}
                    }

                    if ($("#hdnusertype").val() == 'FA') {
                        //if(data['faculty_approval'] == "Pending_Y") {
                        //    return '<center><button type="button" onclick="rowClick_approve(this,oTable5)" disabled>Approve</button></center>';
                        //}
                        //else
                        if (data['p_flag'].trim() == "P") {
                            return '<center><p>Pending</p></center>';
                        }
                        else if (data['p_flag'].trim() == "N") {
                            return '<center><p>Approved</p></center>';
                        }
                        else { return '<center></center>';}


                    }
                }
            },
            {
                "sTitle": "Reject", "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'PC' || $("#hdnusertype").val() == 'FA')
                    {

                        if (data['p_flag'] != "R") {
                            return '<center><button type="button" class="reject_' + data['course_code'] + '" onclick="rowClick_reject_cac(this,oTable7)">Reject</button></center>';
                        }
                        else if (data['p_flag'] == "R") { return '<center>Reject</center>';}
                        

                    }
                    else { return '<center></center>'; }
                }
            },
            {
                "sTitle": "Send For Review", "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'PC' || $("#hdnusertype").val() == 'FA') {

                        return '';
                        //return '<center><button type="button" onclick="rowClick_send_for_review_cac(this,oTable7)">Review</button></center>';

                    }
                    else { return '<center></center>';}
                }
            }



            , {
                "sTitle": "Action", "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'FA') {
                        if (data['p_flag'].trim() == "P") {
                            return '<center><button type="button" onclick="rowClick_delete_new(this,oTable7)">Delete</button></center>';
                        } else {
                            return '<center></center>';
                        }
                    } else {
                        return '<center></center>';
                    }
                }
            }

        ]
    });

    $('#DataList_pending_CAC').css('display', 'block');
}

function my_course_list() {
    $('#DataList_mycourse').css('display', 'none');

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_my_course_list_new",
            //async: false,
            data: "{user_id:'" + $("#hdnuserid").val() + "',sem_code :'" + cur_sem + "',year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    if ($("#hdnusertype").val() == 'PC') {
                        display_my_course_list_progcoord(data.d);
                    }
                    else if ($("#hdnusertype").val() == 'I2') {
                        display_my_course_list_faculty(data.d);
                    }
                    else if ($("#hdnusertype").val() == 'D') {
                        display_my_course_list_faculty(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Assigned to you for Current Semester');
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function initial_course_list() {
    $('#DataList_inital_PC').css('display', 'none');

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_inital_pending_course",
            //async: false,
            data: "{sem_code :'" + cur_sem + "',year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code+"'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    display_pending_course_list_inital_PC(data.d);
                }
                else {
                    bootbox.alert('No Courses Found for Pending Initial Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


//30032022

function pending_CAC_course_list() {
    $('#DataList_pending_CAC').css('display', 'none');

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_pending_at_cac_course",
            //async: false,
            data: "{sem_code :'" + cur_sem + "',year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    display_pending_CAC_PC(data.d);
                }
                else {
                   // bootbox.alert('No Courses Found for Pending At CAC');
                   // return false;
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function display_my_course_list_progcoord(data) {
    if (oTable1 != null) {
        oTable1.fnDestroy();
        $("#DataList_mycourse").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_mycourse" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#example_mycourse").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
       // "sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //        "print",
        //        {
        //            "sExtends": "collection",
        //            "sButtonText": 'Export',
        //            "aButtons": ["xls"]
        //        }
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            {
                "sTitle": "Focuse",
                "mData": "Focuse",
                "bSortable": false,
                "render": function (data, type, row) {
                    // Check if data is null, undefined, or empty
                    if (!data) {
                        return '-'; // or any other placeholder you prefer
                    }
                    return data;
                }
            },
            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return data["CouseSubTitle"];
                    }
                    else {
                        return '';
                    }

                }
            },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },

            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },
            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },// kapil 01122020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            // { "sTitle": "Remark", "mData": "remark", "bSortable": false },
            { "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },
            { "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            //{ "sTitle": "", "mDataProp": "progcoord_approval", "bSortable": false, "mRender": function (data, type, full) {
            //    //alert(data);
            //    if (data != 'Approved') {
            //        return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
            //    }
            //    else {
            //        return '';
            //    }
            //}
            //}
            {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["faculty_approval"] != 'Approved' && data["progcoord_approval"] != 'Approved' && data["ugpg_approval"] != 'Approved') {
                        return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                    }
                    else {
                        return '';
                    }
                }
            },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    return '<center><a style="cursor:pointer" onclick="rowClick_View(this,oTable1)" >View</a></center>';
                }
            }
        ]
    });
    //class="course_outlin_oTable1"
    $('#DataList_mycourse').css('display', 'block');
}

function display_my_course_list_faculty(data) {
    if (oTable1 != null) {
        oTable1.fnDestroy();
        $("#DataList_mycourse").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_mycourse" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#example_mycourse").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
       // "sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

        // Nitinbhai Changes 09102024 By Mobile

        //"columnDefs": [
        //
        //    { 'visible': false, 'targets': [24, 25] }
        //],


        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //        "print",
        //        {
        //            "sExtends": "collection",
        //            "sButtonText": 'Export',
        //            "aButtons": ["xls"]
        //        }
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            {
                "sTitle": "Focuse",
                "mData": "Focuse",
                "bSortable": false,
                "render": function (data, type, row) {
                    // Check if data is null, undefined, or empty
                    if (!data) {
                        return '-'; // or any other placeholder you prefer
                    }
                    return data;
                }
            },
            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return data["CouseSubTitle"];
                    }
                    else {
                        return '';
                    }

                }
            },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            //kapil 08122021
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },

            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },//kapil 01122020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            // { "sTitle": "Remark", "mData": "remark", "bSortable": false },
            { "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },
            { "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["faculty_approval"] != 'Approved' && data["progcoord_approval"] != 'Approved' && data["ugpg_approval"] != 'Approved')
                    {
                        return '<center><button type="button" onclick="rowClick_new_per(this,oTable1)">Edit</button></center>';
                    }
                    else {
                        return ' ';
                    }
                }
            },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    return '<center><a style="cursor:pointer" onclick="rowClick_View(this,oTable1)" >View</a></center>';
                }
            },

            {
                "sTitle": "Personal Details Status", "bSortable": false, "mData": null, "mRender": function ()
                {
                    if (data["studio_per_dtl_status"] == "false") {
                        return 'Personal Details Not Submit';
                    }
                    else { return '';}
                //    return '<center><a style="cursor:pointer" onclick="rowClick_View(this,oTable1)" >View</a></center>';
                }
            },
            { "sTitle": "Designation", "mData": "designation", "bSortable": false }
        ]
    });
    //class="course_outlin_oTable1"
    //{ "sTitle": "", "mDataProp": "faculty_approval", "bSortable": false, "mRender": function (data, type, full) {
    //    //alert(data);
    //    if (data != 'Approved') {
    //        return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
    //    }
    //    else {
    //        return '';
    //    }
    //}
    //}
    $('#DataList_mycourse').css('display', 'block');
}

function approved_course_list_fa() {
    $('#DataList_approvedcourses_fa').css('display', 'none');

    $.ajax(
        { 
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_approved_course_list_new_fa",
            //async: false,
            data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    if ($("#hdnusertype").val() == 'FA') {
                        display_approved_course_list_FA_user(data.d);
                    }

                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function display_approved_course_list_FA_user(data) {
    if (oTable4 != null) {
        oTable4.fnDestroy();
        $("#DataList_approvedcourses_fa").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_approvedcourses_fa" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable4 = $("#example_approvedcourses_fa").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        // "sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //        "print",
        //        {
        //            "sExtends": "collection",
        //            "sButtonText": 'Export',
        //            "aButtons": ["xls"]
        //        }
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return data["CouseSubTitle"];
                    }
                    else {
                        return '';
                    }

                }
            },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },

            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },//kapil 01122020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },

            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>'
                    return '<center><button type="button" onclick="rowClick_View(this,oTable4)">View</button></center >' +  //Ananth 29062019
                        '<center><a style="cursor:pointer" class="course_outlin_oTable6_download" >PDF</a></center>';
                }
            }

        ]
    });

    $('#DataList_approvedcourses_fa').css('display', 'block');
}

$(document).on("click", ".course_outlin_oTable6_download", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable4.fnGetData(row);
    var course_code = aData["course_code"];

    $('#hdn_course_code').val(course_code);
    $('#hdn_sem_code').val(cur_sem);
    $('#hdn_year_code').val(cur_year);
    $('#btn_download').click();
});

$(document).on("click", ".oTable_allapproved_courses_download", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable_allapproved_courses.fnGetData(row);
    var course_code = aData["course_code"];

    $('#hdn_course_code').val(course_code);
    $('#hdn_sem_code').val(cur_sem);
    $('#hdn_year_code').val(cur_year);
    $('#btn_download').click();
});
function approved_course_list() {
    $('#DataList_approvedcourses').css('display', 'none');

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_approved_course_list_new",
            //async: false,
            data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    if ($("#hdnusertype").val() == 'A1') {
                        display_approved_course_list_UGPG(data.d);
                    }
                    else {
                        display_approved_course_list(data.d);
                    }
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }

            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}


function display_approved_course_list(data) {
    if (oTable2 != null) {
        oTable2.fnDestroy();
        $("#DataList_approvedcourses").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_approvedcourses" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable2 = $("#example_approvedcourses").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //        "print",
        //        {
        //            "sExtends": "collection",
        //            "sButtonText": 'Export',
        //            "aButtons": ["xls"]
        //        }
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            //{ "sTitle": "Focuse", "mData": "Focuse", "bSortable": false },
            {
                "sTitle": "Focuse",
                "mData": "Focuse",
                "bSortable": false,
                "render": function (data, type, row) {
                    // Check if data is null, undefined, or empty
                    if (!data) {
                        return '-'; // or any other placeholder you prefer
                    }
                    return data;
                }
            },

            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return data["CouseSubTitle"];
                    }
                    else {
                        return '';
                    }

                }
            },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },

            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },// kapil 12012020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            //{ "sTitle": "Remark", "mData": "remark", "bSortable": false },      
            {
                "sTitle": "Faculty Approval", "bSortable": false, "mData": null, "mRender": function (data)
                {
                    //if (data["faculty_approval"] == "Approved" && data["progcoord_approval"] == "" && data["ugpg_approval"] == "")
                    if (data["faculty_approval"] == "Approved")
                    {
                        return 'Approved';
                    }
                    else { return 'Yet not Submitted'; }
                }
            },
            {
                "sTitle": "Coordinator Approval", "bSortable": false, "mData": null, "mRender": function (data) {
                    //if (data["faculty_approval"] == "Approved" && data["progcoord_approval"] == "" && data["ugpg_approval"] == "")
                    if (data["progcoord_approval"] == "Approved") {
                        return 'Approved';
                    }
                    else { return 'Yet not Submitted'; }
                }
            },

            {
                "sTitle": "UGPG Approval", "bSortable": false, "mData": null, "mRender": function (data)
                {
                    if (data["ugpg_approval"] == "Approved") {
                        return 'Approved';
                    }
                    else { return 'Yet not Submitted'; }
                }
            },
            //change by mahroof sir 29062022
            //{ "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
           // { "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            //{ "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },

            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>' +
                        '<center><a style="cursor:pointer" class="course_outlin_oTable2_download" >Download</a></center>';
                }
            },
            {
                "sTitle": "Send for Review to Faculty", "mData": null, "bSortable": false, "mRender": function (data)
                {
                    if ($("#hdnusertype").val() == 'FA') {
                        if (data["faculty_approval"] == "Approved" && data["progcoord_approval"] == "" && data["ugpg_approval"] == "") {
                            return '<center><button type="button" onclick="rowClick_review_faculty(this)">Review</button></center>';
                        }
                        else { return ''; }
                    }
                    else { return '';}
                    

                }
            }
            //{ "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //    //alert(course_code);
            //    return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
            //}
            //},
            //{ "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //    //alert(course_code);
            //    return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
            //}
            //}
        ]
    });

    $('#DataList_approvedcourses').css('display', 'block');
}

function display_approved_course_list_UGPG(data) {
    if (oTable2 != null) {
        oTable2.fnDestroy();
        $("#DataList_approvedcourses").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_approvedcourses" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable2 = $("#example_approvedcourses").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
        //    "oTableTools": {
        //        "aButtons": [
        //        //"copy",
        //"print",
        //        	{
        //        	    "sExtends": "collection",
        //        	    "sButtonText": 'Export',
        //        	    "aButtons": ["xls"]
        //        	}
        //        ]
        //    },
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            {
                "sTitle": "Focuse",
                "mData": "Focuse",
                "bSortable": false,
                "render": function (data, type, row) {
                    // Check if data is null, undefined, or empty
                    if (!data) {
                        return '-'; // or any other placeholder you prefer
                    }
                    return data;
                }
            },
            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return data["CouseSubTitle"];
                    }
                    else {
                        return '';
                    }

                }
            },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },//kapil 01122020
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            // { "sTitle": "Remark", "mData": "remark", "bSortable": false },
            { "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },
            { "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>' +
                        '<center><a style="cursor:pointer" class="course_outlin_oTable2_download" >Download</a></center>';
                }
            },
            {
                "sTitle": "Send for Review to PC", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick_review(this)">Review</button></center>';
                }
            }
            
            //{ "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //    //alert(course_code);
            //    return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
            //}
            //},
            //{ "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //    //alert(course_code);
            //    return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
            //}
            //}
        ]
    });

    $('#DataList_approvedcourses').css('display', 'block');
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

//"mRender": function (rowIndex) {
//            alert(rowindex);
//            btnD = '<button id="btnDepth' + rowindex + '" data-keyindex="' + rowindex + '" data-type="Depth" data-action="Show" class="addDepthGraph" title="Show Depth">D</button>';
//            btnG = '<button id="btnGraph' + rowindex + '" data-keyindex="' + rowindex + '" data-type="Graph"  data-action="Show" class="addDepthGraph" title="Show Graph">G</button>';
//            var returnButton = btnD + btnG;
//            return returnButton;
//        }

function All_approved_course_list() {
    $('#DataList_allapprovedcourses').css('display', 'none');

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_all_approved_course_list_new",
            //async: false,
            data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "" && data.d != "[]") {
                    display_allapproved_course_list_for_all(data.d);
                }
                else {
                    //bootbox.alert('No Courses Found for Pending Approval');
                }
            },
            error: function (result) {
                alert(result);
            }
        });

    return false;
}

function display_allapproved_course_list_for_all(data) {
    if (oTable_allapproved_courses != null) {
        oTable_allapproved_courses.fnDestroy();
        $("#DataList_allapprovedcourses").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_allapprovedcourses" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable_allapproved_courses = $("#example_allapprovedcourses").dataTable({
        "bPaginate": true,
        "bSortable": false,
        "bSort": false,
        //"bStateSave": true,
        "iDisplayLength": 60,
       // "sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //        //"copy",
        //        "print",
        //        {
        //            "sExtends": "collection",
        //            "sButtonText": 'Export',
        //            "aButtons": ["xls"]
        //        }
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            {
                "sTitle": "Focuse",
                "mData": "Focuse",
                "bSortable": false,
                "render": function (data, type, row) {
                    // Check if data is null, undefined, or empty
                    if (!data) {
                        return '-'; // or any other placeholder you prefer
                    }
                    return data;
                }
            },
            { "sTitle": "Typology", "mData": "type", "bSortable": false },
            { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            { "sTitle": "Title", "mData": "title", "bSortable": false },
            {
                "sTitle": "Course SubTilte", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["CouseSubTitle"] != "") {
                        return data["CouseSubTitle"];
                    }
                    else {
                        return '';
                    }

                }
            },
            { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            //{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            //{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            { "sTitle": "AA", "mData": "instructor_AA", "bSortable": false },
            { "sTitle": "TA", "mData": "instructor_TA", "bSortable": false },
            //{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            //{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            { "sTitle": "Program", "mData": "program", "bSortable": false },
            { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            {
                "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
                    return get_prerequisite(data);
                }
            },
            { "sTitle": "Semester", "mData": "semester", "bSortable": false },
            { "sTitle": "Day", "mData": "day", "bSortable": false },
            { "sTitle": "Time", "mData": "time", "bSortable": false },
            //{ "sTitle": "Area", "mData": "area", "bSortable": false },
            { "sTitle": "Intake", "mData": "intake", "bSortable": false },
            {
                "sTitle": "Studio Level", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["studio_level"] == "L2" || data["studio_level"] == "L3" || data["studio_level"] == "L4") {
                        return '<center>' + data["studio_level"] + '</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },
            { "sTitle": "BackLog", "mData": "backlog", "bSortable": false },
            { "sTitle": "Mode", "mData": "studio_mode", "bSortable": false },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    /*return '<center><a style="cursor:pointer" class="course_outline_oTable_allapprovedcourses" >View</a></center>';*/
                    var str = '';
                    str = '<center><a style="cursor:pointer" onclick="rowClick_View(this,oTable_allapproved_courses)">View</a></center>';
                    if (download_rights_user_wise == 'true')
                    {
                        //<center><a style="cursor:pointer" class="course_outlin_oTable6_download" >PDF</a></center>
                        str = str + '<center><a style="cursor:pointer" class="oTable_allapproved_courses_download" >PDF</a></center>';
                    }
                    //return '<center><a style="cursor:pointer" onclick="rowClick_View(this,oTable_allapproved_courses)">View</a></center>';
                    return str;
                }
            }
        ]
    });

    $('#DataList_allapprovedcourses').css('display', 'block');
}
