var oTable;
var oTable1;
var oTable2;
var oTable5;
var oTable6;
var oTable7;

var oTable_allapproved_courses;
var cur_sem;
var cur_year;
var prog_code;
var prog_level_code;
var dept_code;
$(document).ready(function () {
    $('#btnRetrieve').on('click', function () { 
        if ($('#drpyear').val() == "") {
            bootbox.alert('please select year.');
            return false;
        }
        
        cur_sem = $('#drpsem').val()
        cur_year = $('#drpyear').val();
        //cur_year = "2018";
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
            var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pendingcourse'>Courses Offered&nbsp;</a></li>" +
                "<li><a data-toggle='tab' href='#approvedcourses'>Approved Courses &nbsp; </a></li>";
            if ($("#hdnuserid").val() == 'tlc') {
                strHtml += "<li style='display:none;'><a data-toggle='tab' href='#allpendingcac'>Pending At CAC&nbsp; </a></li>";
            }
            strHtml += "</ul>";
            $("#div_myTab").html(strHtml);
            $("#pendingcourse").addClass("in active");
            $('#btn_download_all').css('display', 'block');
            pending_course_list(); //1
            approved_course_list(); //2
            pending_CAC_course_list();//3 add by nitinbhai
        }
        else if ($("#hdnusertype").val() == 'PC') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');
            var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#inital_pendingcourse'>Pending Initial Approval&nbsp;</a></li><li style='display:none;'><a data-toggle='tab' href='#allpendingcac'>Pending At CAC&nbsp; </a></li><li><a data-toggle='tab' href='#pendingcourse'>Courses Offered&nbsp;</a></li>" +
                "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li><li><a data-toggle='tab' href='#approvedcourses'>Approved Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li>" +
                "</ul>";
            $("#div_myTab").html(strHtml);
            $("#inital_pendingcourse").addClass("in active");
            $("#btn_submit_all").css('display', 'block');
            initial_course_list();//3
            pending_CAC_course_list();//30032022 //7
            pending_course_list();//1
            my_course_list();//4
            approved_course_list(); //2
            All_approved_course_list();//5
            
            //display_bulk_pending_course_dtl();
        }
        else if ($("#hdnusertype").val() == 'I2') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');
            var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li></ul>";
            $("#div_myTab").html(strHtml);
            $("#mycourses").addClass("in active");
            my_course_list(); //4
            All_approved_course_list();//5
        }
        else if ($("#hdnusertype").val() == 'D') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');
            var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#approvedcourses'>Courses Offered&nbsp;</a></li>" +
                      "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li></ul>";
            $("#div_myTab").html(strHtml);
            $("#approvedcourses").addClass("in active");
            approved_course_list();//2
            my_course_list(); //4
            All_approved_course_list();//5
        }
        else if ($("#hdnusertype").val() == 'FA') {
            //$("#wel_msg").html("<h1>Welcome</h1>");
            $("#div_tab").css('display', 'block');//14122020
            var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#inital_pendingcourse'>Pending Initial Approval&nbsp;</a></li><li style='display:none;'><a data-toggle='tab' href='#allpendingcac'>Pending At CAC&nbsp; </a></li><li><a data-toggle='tab' href='#approvedcourses'>Courses Offered&nbsp;</a></li><li><a data-toggle='tab' href='#approvedcourses_fa'>Approved Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li></ul>";
            $("#div_myTab").html(strHtml);
            //$("#approvedcourses").addClass("in active");
            $("#inital_pendingcourse").addClass("in active");
            initial_course_list(); //3
            pending_CAC_course_list();//30032022 //7
            approved_course_list();//2
            //14122020
            approved_course_list_fa();//6
            All_approved_course_list();//5
            
        }

    });

    //else if ($("#hdnusertype").val() == 'PC') {
    //    //$("#wel_msg").html("<h1>Welcome</h1>");
    //    $("#div_tab").css('display', 'block');
    //    var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#inital_pendingcourse'>Initial Approved&nbsp;</a></li><li><a data-toggle='tab' href='#pendingcourse'>Courses Offered&nbsp;</a></li>" +
    //        "<li><a data-toggle='tab' href='#mycourses'>My Courses &nbsp; </a></li><li><a data-toggle='tab' href='#approvedcourses'>Approved Courses &nbsp; </a></li><li><a data-toggle='tab' href='#allapprovedcourses'>All Approved Courses &nbsp; </a></li></ul>";
    //    $("#div_myTab").html(strHtml);
    //    //$("#pendingcourse").addClass("in active");
    //    $("#inital_pendingcourse").addClass("in active");
    //    initial_course_list();
    //    pending_course_list();
    //    my_course_list();
    //    approved_course_list();
    //    All_approved_course_list();
    //}

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

    $('#download_Course_outline').on('click', function () {
       
        var data = oTable2.fnGetData();
        var course_code;
        for (var i = 0; i < data.length; i++) {
            if (i == 0) {
                course_code = '' + data[i]["course_code"] + '';
            }
            else {
                course_code = course_code + ',' + '' + data[i]["course_code"] + '';
            }
        }
        $('#hdn_all_course_code').val(course_code);
        $('#hdn_sem_code').val(cur_sem);
        $('#hdn_year_code').val(cur_year);
        $('#ifrm_outline').html('<iframe src="' + location.origin + '/Student/Outlinepdfdownload.aspx?course_id=' + course_code + '&sem_code=' + cur_sem + '&year_code=' + cur_year + '&new_tab=Y" width="1" height="1"></iframe>');
        //$('#btn_all_download').click();
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

    bindyeardata_for_cross_reg();
    bindprogrammedata();
    //bindproglevel();
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

function initial_course_list() {
    $('#DataList_inital_PC').css('display', 'none');

    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_inital_pending_course",
            //async: false,
            data: "{sem_code :'" + cur_sem + "',year_code :'" + cur_year + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
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

function display_pending_course_list_inital_PC(data) {
    if (oTable5 != null) {
        oTable5.fnDestroy();
        $("#DataList_inital_PC").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_inital_pc" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable5 = $("#example_inital_pc").dataTable({
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
            {
                //"sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
                "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    var day_arr = course_data['day'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                    if (course_data['studio_mode'] != "")//Mode kapil 01122020
                    {
                        str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                        str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                    }
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'><b>Intake Capacity: </b> " + course_data['intake'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'><b>Course Type:</b> ";

                    if (course_data['course_type'] == "M")
                    {
                        str += "Mandatory";
                    }
                    else if (course_data['course_type'] == "E")
                    {
                        str += "Elective";
                    }

                    str += "</div>";
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'><b>Backlog:</b> ";

                    if (course_data['backlog'] == "Y")
                    {
                        str += "Yes";
                    }
                    else if (course_data['backlog'] == "N")
                    {
                        str += "No";
                    }

                    str += "</div>";
                    str += "<div style='width:75%;float: left;'><b>Course SubTitle:</b> " + course_data['CouseSubTitle']+"";
                    str += "</div>";
                    str += "<div style='width:25%;float: right;color:#A9A9A9;text-overflow:  ellipsis'>";//margin-left: 3%;

                    for (i = 0; i < day_arr.length; i++)
                    {
                        str += "<div style='word-wrap: break-word;width: 120px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                    }

                    str += "</div>";
                    str += "</div></div>";

                    return str;
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
                    return '<center><button type="button" onclick="rowClick_View(this,oTable5)">View</button></center >';
                }
            },
            {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (data)
                {
                    if ($("#hdnusertype").val() == 'FA') {
                        return '<center><button type="button" onclick="rowClick(this,oTable5)">Edit</button></center>';
                    }
                    else
                    {
                        return '<center>Course edit rights are given only by FA</center>';
                    }
                    
                }
            },// changes by 28082025 nitnbhai
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
                        var str = '';
                        if (data['type'] == 'Studio')
                        {
                            str = '';
                        }
                        else
                        {
                            str = '<center><button type="button" onclick="rowClick_approve(this,oTable5)">Approve</button></center>';
                        }
                       
                        if (data['faculty_approval'] == 'Approved' && data['p_flag'] == 'P')
                        {
                            str += '<center style=padding-top:3px;><button type="button" id=' + data['course_code']+' onclick="rowClick_pending_cac(this,oTable5)">Provisional Approve</button></center>';
                        }
                        return str;
                    }

                    if($("#hdnusertype").val() == 'FA')
                    {
                        var str = '';
                        if (data['faculty_approval'] == 'Approved' && data['p_flag'] == 'P') {
                            str += '<center style=padding-top:3px;><button type="button" id=' + data['course_code'] +' onclick="rowClick_pending_cac(this,oTable5)">Provisional Approve</button></center>';
                        }
                        else if (data['p_flag'] == "P") {
                            str += '<center><p>Pending</p></center>';
                        }
                        else if (data['p_flag'] == "N") {
                            str += '<center><p>Approved</p></center>';
                        }
                        
                        return str;
                    }
                    return "";
                }
            }
            ,{
                "sTitle": "Action", "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'FA')
                    {
                        if (data['p_flag'] == "P")
                        {
                            return '<center><button type="button" onclick="rowClick_delete(this,oTable5)">Delete</button></center>';
                        } else
                        {
                            return '<center></center>';
                        }
                    }
                    else
                    {
                        return '<center></center>';
                    }
                }
            }
            //{
            //    "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //        return '<center><button type="button" onclick="rowClick_delete(this,oTable)">Delete</button></center>';
            //    }
            //}
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
    if ($("#hdnusertype").val() == 'PC') {
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
            {
                //"sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
                "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    var day_arr = course_data['day'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                    if (course_data['studio_mode'] != "")//Mode kapil 01122020
                    {
                        str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                        str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                    }
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'><b>Intake Capacity: </b> " + course_data['intake'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'><b>Course Type:</b> ";

                    if (course_data['course_type'] == "M") {
                        str += "Mandatory";
                    }
                    else if (course_data['course_type'] == "E") {
                        str += "Elective";
                    }

                    str += "</div>";
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'><b>Backlog:</b> ";

                    if (course_data['backlog'] == "Y") {
                        str += "Yes";
                    }
                    else if (course_data['backlog'] == "N") {
                        str += "No";
                    }

                    str += "</div>";
                    str += "<div style='width:25%;float: right;color:#A9A9A9;text-overflow:  ellipsis'>";//margin-left: 3%;

                    for (i = 0; i < day_arr.length; i++) {
                        str += "<div style='word-wrap: break-word;width: 120px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                    }

                    str += "</div>";
                    str += "</div></div>";

                    return str;
                }
            },


           
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outline_oTable_allapprovedcourses">View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable7)">View</button></center >';
                }
            },
            {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (data) {
                    return '<center><button type="button" onclick="rowClick(this,oTable7)">Edit</button></center>';
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
                    if ($("#hdnusertype").val() == 'PC')
                    {
                        var row_index = '';
                        row_index += '<center style=padding-bottom:6px;><button type="button" onclick="rowClick_approve(this,oTable7)">Approve</button></center>';
                        if (data['p_flag'] == 'R') {
                            row_index += '<center style=padding-bottom:6px;>Reject</center>'
                        }
                        else
                        {
                            row_index += '<center style=padding-bottom:6px;> <button type="button" class="reject_' + data['course_code'] + '" onclick="rowClick_reject_cac(this,oTable7)">Reject</button></center><center><button type="button" onclick="rowClick_send_for_review_cac(this,oTable7)">Review</button></center>';
                        }
                        return row_index;
                    }

                    if ($("#hdnusertype").val() == 'FA')
                    {
                        var row_index = '';
                        if (data['p_flag'] == "P") {
                            row_index += '<center><p>Pending</p></center>';
                        }
                        else if (data['p_flag'] == "N") {
                            row_index += '<center><p>Approved</p></center>';
                        }
                        else if (data['p_flag'] == 'R') {
                            row_index += '<center style=padding-bottom:6px;>Reject</center><center><button type="button" onclick="rowClick_send_for_review_cac(this,oTable7)">Review</button></center>'
                        }
                        else if (data['p_flag'] == "PA") {
                            row_index += '<center style=padding-bottom:6px;> <button type="button" class="reject_' + data['course_code'] + '" onclick="rowClick_reject_cac(this,oTable7)">Reject</button></center><center><button type="button" onclick="rowClick_send_for_review_cac(this,oTable7)">Review</button></center>';
                        }
                            
                        
                        return row_index;
                    }
                    return "";
                }
            }
            , {
                "sTitle": "Action", "mData": null, "bSortable": false, "mRender": function (data) {
                    if ($("#hdnusertype").val() == 'FA') {
                        if (data['p_flag'] == "P") {
                            return '<center><button type="button" onclick="rowClick_delete(this,oTable7)">Delete</button></center>';
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

//14122020
$(document).on("click", ".course_outlin_oTable6_download", function (event) {
    var row = $(this).closest("tr").get(0);
    var aData = oTable6.fnGetData(row);
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

function rowClick(row, objtable) {
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

function rowClick_delete(row,delTable) {
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

function rowClick_review(row,obTable) {
    //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
    var rowId = obTable.fnGetData($(row).closest('tr')[0])['course_code'];

    var r = confirm("Are you sure you want to send for review to program coordinator for course '" + rowId + "' ?");
    if (r == true) {
        sendforreviewCourseData(rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function rowClick_review_faculty(row, obTable) {
    var rowId = obTable.fnGetData($(row).closest('tr')[0])['course_code'];
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
                //bootbox.alert('No Courses Found for Pending Approval');
            }

        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

//kapil
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
        pendingCACCourseData(row,rowId);
        //window.location = "admin_dashboard.aspx";
    }
    else {
    }
}

function pendingCACCourseData(row,rowId) {
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
                           // window.location = "admin_dashboard.aspx";
                            $('#' + row.id).attr('disabled', true);
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
                        bootbox.alert("Course Reject Successfully", function (result)
                        {
                            $('.reject_' + rowId).prop('disabled', true);
                            
                         //   window.location = "admin_dashboard.aspx";
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
        //"sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
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
            //{ "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            //{ "sTitle": "Typology", "mData": "type", "bSortable": false },
            //{ "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            //{ "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            //{ "sTitle": "Title", "mData": "title", "bSortable": false },
            //{ "sTitle": "Credits", "mData": "credit", "bSortable": false },
            ////{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            ////{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            //{ "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            ////{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            ////{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            //{ "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            //{ "sTitle": "Program", "mData": "program", "bSortable": false },
            //{ "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            //{
            //    "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
            //        return get_prerequisite(data);
            //    }
            //},
            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            //{ "sTitle": "Day", "mData": "day", "bSortable": false },
            //{ "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            //{ "sTitle": "Time", "mData": "time", "bSortable": false },
            ////{ "sTitle": "Area", "mData": "area", "bSortable": false },
            //{ "sTitle": "Intake", "mData": "intake", "bSortable": false },
            ////{ "sTitle": "Remark", "mData": "remark", "bSortable": false },
            //{ "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            //{ "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            //{
            //    "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //        return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
            //    }
            //},
            //{
            //    "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //        return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
            //    }
            //},
            //{
            //    "sTitle": "Send for Review to PC", "mData": null, "bSortable": false, "mRender": function (course_code) {
            //        return '<center><button type="button" onclick="rowClick_review(this)">Review</button></center>';
            //    }
            //}

            {
                //"sTitle": "Description", "mData": "course_desc","sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                "sTitle": "Description", "mData": null,"sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    //var day_arr = course_data.aData['day'].split(',');
                    var day_arr = course_data['day'].split(',');
                    //var time_arr = course_data.aData['time'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    if (course_data['studio_mode'] != "")//Mode kapil 30112020
                    {
                        str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                        str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                    }
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width: 72%; text-align:justify;float: left; word-break: break-all;'>" + course_data['course_desc'] + "";//5
                    var pre_req = get_prerequisite(course_data['prerequisite']);
                    if (pre_req != "") {
                        str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b> " + pre_req + "</p>";
                    }
                    str += "</div>";

                    str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:  ellipsis'>";
                    for (i = 0; i < day_arr.length; i++) {
                        str += "<div style='word-wrap: break-word;width: 87px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                    }
                    str += "</div>";
                    str += "</div></div>";

                    return str;
                }
            },{
                "sTitle": "View", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable)">View</button></center >';//Mayur 28052019
                }
            }
            ,{
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick(this,oTable)">Edit</button></center>';
                }
            },
            {
                "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick_delete(this,oTable)">Delete</button></center>';
                }
            },
            {
                "sTitle": "Send for Review to PC", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick_review(this,oTable)">Review</button></center>';
                }
            }
        ]
    });

    $('#DataList').css('display', 'block');

    //var str = "";

    //str += "<div>";
    //str += "<div style='border-top: thin solid #000000; '>";
    //str += "<b>1005-A: The purpose of Architecture: Home</b><br/>";
    //str += "<div style='width:78%;float: left;'><b>Instructor/s:</b> Anand Patel</div>"
    //str += "<div style='width:22%;float: left;'><b>Typology </b> <span style='float:right;'>Studio</span></div><br/>";
    //str += "<div style='width:78%;float: left;'>&nbsp;</div>"
    //str += "<div style='width:22%;float: left;'><b>Credits </b> <span style='float:right;'>12</span></div><br/>";
    //str += "<div style='width: 75%; text-align:justify;float: left;'>For a young student of architecture, the question that arises often, is - What is the Purpose of Architecture? In this Unit we will attempt to analyze this query through the making of a ‘home’. This home is not your typical house. This home is a physical realm that is a result of the primary instinct of all animals - to shelter.</div>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Monday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Wednesday  <span style='float:right;'>10.30-13.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Friday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<p style='width: 772px;text-align:justify;color:#A9A9A9;    margin-top: -13px;'><b>Prerequisite:</b> For 2nd year and 3rd year undergraduate Architecture students only</p><br/>";
    //str += "</div>";
    //str += "</div>";
    
    //str += "<div>";
    //str += "<div style='border-top: thin solid #000000; '>";
    //str += "<b>1005-A: The purpose of Architecture: Home</b><br/>";
    //str += "<div style='width:78%;float: left;'><b>Instructor/s:</b> Anand Patel</div>"
    //str += "<div style='width:22%;float: left;'><b>Typology </b> <span style='float:right;'>Studio</span></div><br/>";
    //str += "<div style='width:78%;float: left;'>&nbsp;</div>"
    //str += "<div style='width:22%;float: left;'><b>Credits </b> <span style='float:right;'>12</span></div><br/>";
    //str += "<div style='width: 75%; text-align:justify;float: left;'>For a young student of architecture, the question that arises often, is - What is the Purpose of Architecture? In this Unit we will attempt to analyze this query through the making of a ‘home’. This home is not your typical house. This home is a physical realm that is a result of the primary instinct of all animals - to shelter.</div>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Monday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Wednesday  <span style='float:right;'>10.30-13.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Friday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Friday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<p style='width: 772px;text-align:justify;color:#A9A9A9;    margin-top: -13px;'><b>Prerequisite:</b> For 2nd year and 3rd year undergraduate Architecture students only</p><br/>";
    //str += "</div>";
    //str += "</div>";

    //str += "<div>";
    //str += "<div style='border-top: thin solid #000000; '>";
    //str += "<b>1005-A: The purpose of Architecture: Home</b><br/>";
    //str += "<div style='width:78%;float: left;'><b>Instructor/s:</b> Anand Patel</div>"
    //str += "<div style='width:22%;float: left;'><b>Typology </b> <span style='float:right;'>Studio</span></div><br/>";
    //str += "<div style='width:78%;float: left;'>&nbsp;</div>"
    //str += "<div style='width:22%;float: left;'><b>Credits </b> <span style='float:right;'>12</span></div><br/>";
    //str += "<div style='width: 75%; text-align:justify;float: left;'>For a young student of architecture, the question that arises often, is - What is the Purpose of Architecture? In this Unit we will attempt to analyze this query through the making of a ‘home’. This home is not your typical house. This home is a physical realm that is a result of the primary instinct of all animals - to shelter.</div>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Monday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Friday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<p style='width: 772px;text-align:justify;color:#A9A9A9;    margin-top: -13px;'><b>Prerequisite:</b> For 2nd year and 3rd year undergraduate Architecture students only</p><br/>";
    //str += "</div>";
    //str += "</div>";

    //str += "<div>";
    //str += "<div style='border-top: thin solid #000000; '>";
    //str += "<b>1005-A: The purpose of Architecture: Home</b><br/>";
    //str += "<div style='width:78%;float: left;'><b>Instructor/s:</b> Anand Patel</div>"
    //str += "<div style='width:22%;float: left;'><b>Typology </b> <span style='float:right;'>Studio</span></div><br/>";
    //str += "<div style='width:78%;float: left;'>&nbsp;</div>"
    //str += "<div style='width:22%;float: left;'><b>Credits </b> <span style='float:right;'>12</span></div><br/>";
    //str += "<div style='width: 75%; text-align:justify;float: left;'>For a young student of architecture, the question that arises often, is - What is the Purpose of Architecture? In this Unit we will attempt to analyze this query through the making of a ‘home’. This home is not your typical house. This home is a physical realm that is a result of the primary instinct of all animals - to shelter.</div>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Monday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Wednesday  <span style='float:right;'>10.30-13.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Friday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<p style='width: 772px;text-align:justify;color:#A9A9A9;    margin-top: -13px;'><b>Prerequisite:</b> For 2nd year and 3rd year undergraduate Architecture students only</p><br/>";
    //str += "</div>";

    //str += "<div>";
    //str += "<div style='border-top: thin solid #000000; '>";
    //str += "<b>1005-A: The purpose of Architecture: Home</b><br/>";
    //str += "<div style='width:78%;float: left;'><b>Instructor/s:</b> Anand Patel</div>"
    //str += "<div style='width:22%;float: left;'><b>Typology </b> <span style='float:right;'>Studio</span></div><br/>";
    //str += "<div style='width:78%;float: left;'>&nbsp;</div>"
    //str += "<div style='width:22%;float: left;'><b>Credits </b> <span style='float:right;'>12</span></div><br/>";
    //str += "<div style='width: 75%; text-align:justify;float: left;'>For a young student of architecture, the question that arises often, is - What is the Purpose of Architecture? In this Unit we will attempt to analyze this query through the making of a ‘home’. This home is not your typical house. This home is a physical realm that is a result of the primary instinct of all animals - to shelter.</div>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Monday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Wednesday  <span style='float:right;'>10.30-13.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Friday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Friday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<p style='width: 772px;text-align:justify;color:#A9A9A9;    margin-top: -13px;'><b>Prerequisite:</b> For 2nd year and 3rd year undergraduate Architecture students only</p><br/>";
    //str += "</div>";
    //str += "</div>";

    //str += "</div>";
    //str += "<div>";
    //str += "<div style='border-top: thin solid #000000; '>";
    //str += "<b>1005-A: The purpose of Architecture: Home</b><br/>";
    //str += "<div style='width:78%;float: left;'><b>Instructor/s:</b> Anand Patel</div>"
    //str += "<div style='width:22%;float: left;'><b>Typology </b> <span style='float:right;'>Studio</span></div><br/>";
    //str += "<div style='width:78%;float: left;'>&nbsp;</div>"
    //str += "<div style='width:22%;float: left;'><b>Credits </b> <span style='float:right;'>12</span></div><br/>";
    //str += "<div style='width: 75%; text-align:justify;float: left;'>For a young student of architecture, the question that arises often, is - What is the Purpose of Architecture? In this Unit we will attempt to analyze this query through the making of a ‘home’. This home is not your typical house. This home is a physical realm that is a result of the primary instinct of all animals - to shelter.</div>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Monday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<p style='width: 772px;text-align:justify;color:#A9A9A9;    margin-top: -13px;'><b>Prerequisite:</b> For 2nd year and 3rd year undergraduate Architecture students only</p><br/>";
    //str += "</div>";
    //str += "</div>";

    //str += "</div>";
    //str += "<div>";
    //str += "<div style='border-top: thin solid #000000; '>";
    //str += "<b>1005-A: The purpose of Architecture: Home</b><br/>";
    //str += "<div style='width:78%;float: left;'><b>Instructor/s:</b> Anand Patel</div>"
    //str += "<div style='width:22%;float: left;'><b>Typology </b> <span style='float:right;'>Studio</span></div><br/>";
    //str += "<div style='width:78%;float: left;'>&nbsp;</div>"
    //str += "<div style='width:22%;float: left;'><b>Credits </b> <span style='float:right;'>12</span></div><br/>";
    //str += "<div style='width: 75%; text-align:justify;float: left;'>For a young student of architecture, the question that arises often, is - What is the Purpose of Architecture? In this Unit we will attempt to analyze this query through the making of a ‘home’. This home is not your typical house. This home is a physical realm that is a result of the primary instinct of all animals - to shelter.</div>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Monday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<div style='width:22%;float: right;margin-left: 3%;color:#A9A9A9;'>Monday  <span style='float:right;'>10.30-17.30</span></div><br/>";
    //str += "<p style='width: 772px;text-align:justify;color:#A9A9A9;    margin-top: -13px;'><b>Prerequisite:</b> For 2nd year and 3rd year undergraduate Architecture students only</p><br/>";
    //str += "</div>";
    //str += "</div>";

    //$('#Corse_Offered').append(str);
    //$('#Corse_Offered').css('display', 'block');
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
            //{ "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            //{ "sTitle": "Typology", "mData": "type", "bSortable": false },
            //{ "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            //{ "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            //{ "sTitle": "Title", "mData": "title", "bSortable": false },
            //{ "sTitle": "Credits", "mData": "credit", "bSortable": false },
            ////{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            ////{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            //{ "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            ////{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            ////{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            //{ "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            //{ "sTitle": "Program", "mData": "program", "bSortable": false },
            //{ "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            ////{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            //{ "sTitle": "Day", "mData": "day", "bSortable": false },
            //{ "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            //{ "sTitle": "Time", "mData": "time", "bSortable": false },
            ////{ "sTitle": "Area", "mData": "area", "bSortable": false },
            //{ "sTitle": "Intake", "mData": "intake", "bSortable": false },
            //// { "sTitle": "Remark", "mData": "remark", "bSortable": false },
            //{ "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            {
                //"sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
                "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    var day_arr = course_data['day'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    if (course_data['studio_mode'] != "")//Mode kapil 30112020
                    {
                        str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                        str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                    }
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width: 72%; text-align:justify;float: left;word-break: break-all;'>" + course_data['course_desc'] + "";//6
                    var pre_req = get_prerequisite(course_data['prerequisite']);
                    if (pre_req != "") {
                        str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b> " + pre_req + "</p>";
                    }
                    str += "</div>";

                    str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:  ellipsis'>";
                    for (i = 0; i < day_arr.length; i++) {
                        str += "<div style='word-wrap: break-word;width: 120px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                    }
                    str += "</div>";
                    str += "</div></div>";

                    return str;
                }
            }, {
                "sTitle": "View", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable)">View</button></center >';//Mayur 28052019
                }
            },
            {
                "sTitle": "Faculty Status", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                   
                    if (course_data['faculty_approval'] == "Approved") {
                        //return '<center><button type="button" onclick="rowClick(this,oTable)">Edit</button></center>';
                        return '<center>Faculty Submitted</center>';
                    } else {
                        return 'Faculty yet not Submitted';
                    }
                }
            },
            {
                "sTitle": "Edit", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    return '<center><button type="button" onclick="rowClick(this,oTable)">Edit</button></center>';
                }
            },
            {
                "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick_delete(this,oTable)">Delete</button></center>';
                }
            }, {
                "sTitle": "Send for Review to Faculty", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["faculty_approval"] == "Approved" && data["progcoord_approval"] == "" && data["ugpg_approval"] == "") {
                        return '<center><button type="button" onclick="rowClick_review_faculty(this,oTable)">Review</button></center>';
                    }
                    else { return ""; }

                }
            }
        ]
    });

    $('#DataList').css('display', 'block');
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
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
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
            //{ "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            //{ "sTitle": "Typology", "mData": "type", "bSortable": false },
            //{ "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            //{ "sTitle": "Title", "mData": "title", "bSortable": false },
            //{ "sTitle": "Credits", "mData": "credit", "bSortable": false },
            ////{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            ////{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            //{ "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            ////{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            ////{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            //{ "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            //{ "sTitle": "Program", "mData": "program", "bSortable": false },
            //{ "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            ////{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            //{ "sTitle": "Day", "mData": "day", "bSortable": false },
            //{ "sTitle": "Time", "mData": "time", "bSortable": false },
            ////{ "sTitle": "Area", "mData": "area", "bSortable": false },
            //{ "sTitle": "Intake", "mData": "intake", "bSortable": false },
            //// { "sTitle": "Remark", "mData": "remark", "bSortable": false },
            //{ "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },
            //{ "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            //{ "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
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
                //"sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
                "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    var day_arr = course_data['day'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                    if (course_data['studio_mode'] != "")//Mode kapil 01122020
                    {
                        str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                        str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                    }
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width: 72%; text-align:justify;float: left;word-break: break-all;'>" + course_data['course_desc'] + "";//7
                    var pre_req = get_prerequisite(course_data['prerequisite']);
                    if (pre_req != "") {
                        str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b> " + pre_req + "</p>";
                    }
                    str += "<p style='text-align:justify;clear:both;'><b>Course SubTitle:</b> " + course_data['CouseSubTitle'] + "</p>";
                    str += "</div>";

                    str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:  ellipsis'>";
                    for (i = 0; i < day_arr.length; i++) {
                        str += "<div style='word-wrap: break-word;width: 135px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                    }
                    str += "</div>";
                    str += "</div></div>";

                    return str;
                }
            },
            {
                "sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.faculty_approval != 'Approved' && data.progcoord_approval != 'Approved' && data.ugpg_approval != 'Approved') {
                        return '<center><button type="button" onclick="rowClick(this,oTable1)">Edit</button></center>';
                    }
                    else {
                        return '';
                    }
                }
            },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable1)">View</button></center >'; //Ananth 29062019
                }
            }
        ]
    });

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
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
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
            //{ "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            //{ "sTitle": "Typology", "mData": "type", "bSortable": false },
            //{ "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            //{ "sTitle": "Title", "mData": "title", "bSortable": false },
            //{ "sTitle": "Credits", "mData": "credit", "bSortable": false },
            ////{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            ////{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            //{ "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            ////{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            ////{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            //{ "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            //{ "sTitle": "Program", "mData": "program", "bSortable": false },
            //{ "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            ////{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            //{ "sTitle": "Day", "mData": "day", "bSortable": false },
            //{ "sTitle": "Time", "mData": "time", "bSortable": false },
            ////{ "sTitle": "Area", "mData": "area", "bSortable": false },
            //{ "sTitle": "Intake", "mData": "intake", "bSortable": false },
            //// { "sTitle": "Remark", "mData": "remark", "bSortable": false },
            //{ "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },
            //{ "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            //{ "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
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
            {
                //"sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
                "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    var day_arr = course_data['day'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                    if (course_data['studio_mode'] != "")//Mode kapil 30112020
                    {
                        str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                        str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                    }
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width: 72%; text-align:justify;float: left;word-break: break-all;'>" + course_data['course_desc'] + "";//4
                    var pre_req = get_prerequisite(course_data['prerequisite']);
                    if (pre_req != "") {
                        str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b> " + pre_req + "</p>";
                    }
                    str += "<p style='text-align:justify;clear:both;'><b>Course SubTitle:</b> " + course_data['CouseSubTitle'] + "</p>";
                    str += "</div>";

                    str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:  ellipsis'>";
                    for (i = 0; i < day_arr.length; i++) {
                        str += "<div style='word-wrap: break-word;width: 135px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                    }
                    str += "</div>";
                    str += "</div></div>";

                    return str;
                }
            },
            {
                "sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                    if (data.faculty_approval != 'Approved' && data.progcoord_approval != 'Approved' && data.ugpg_approval != 'Approved') {
                        return '<center><button type="button" onclick="rowClick(this,oTable1)">Edit</button></center>';
                    }
                    else {
                        return '';
                    }
                }
            },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable1)">View</button></center >'; //Ananth 29062019
                }
            }
        ]
    });

    $('#DataList_mycourse').css('display', 'block');
}
 //14122020
function approved_course_list_fa() {
    $('#DataList_approvedcourses').css('display', 'none');

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

//14122020
function display_approved_course_list_FA_user(data) {
    if (oTable6 != null) {
        oTable6.fnDestroy();
        $("#DataList_approvedcourses_fa").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_approvedcourses_fa" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable6 = $("#example_approvedcourses_fa").dataTable({
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
            {
                //"sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
                "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    var day_arr = course_data['day'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width: 72%; text-align:justify;float: left;word-break: break-all;'>" + course_data['course_desc'] + "";//1
                    var pre_req = get_prerequisite(course_data['prerequisite']);
                    if (pre_req != "") {
                        str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b> " + pre_req + "</p>";
                    }
                    str += "<p style='text-align:justify;clear:both;'><b>Course SubTitle:</b> " + course_data['CouseSubTitle'] + "</p>";
                    str += "</div>";

                    str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:  ellipsis'>";
                    for (i = 0; i < day_arr.length; i++) {
                        str += "<div style='word-wrap: break-word;width: 120px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                    }
                    str += "</div>";
                    str += "</div></div>";

                    return str;
                }
            },
            
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>'
                    return '<center><button type="button" onclick="rowClick_View(this,oTable6)">View</button></center >' +  //Ananth 29062019
                        '<center><a style="cursor:pointer" class="course_outlin_oTable6_download" >PDF</a></center>';
                }
            }
            
        ]
    });

    $('#DataList_approvedcourses_fa').css('display', 'block');
}

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
                else if ($("#hdnusertype").val() == 'FA') {
                    display_approved_course_list_FA(data.d);
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

function display_approved_course_list_FA(data) {
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
            //    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            //    { "sTitle": "Typology", "mData": "type", "bSortable": false },
            //    { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            //    { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            //    { "sTitle": "Title", "mData": "title", "bSortable": false },
            //    { "sTitle": "Credits", "mData": "credit", "bSortable": false },
            ////{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            ////{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            //    { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            ////{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            ////{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            //    { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            //    { "sTitle": "Program", "mData": "program", "bSortable": false },
            //    { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            ////{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            //    { "sTitle": "Day", "mData": "day", "bSortable": false },
            //    { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            //    { "sTitle": "Time", "mData": "time", "bSortable": false },
            ////{ "sTitle": "Area", "mData": "area", "bSortable": false },
            //    { "sTitle": "Intake", "mData": "intake", "bSortable": false },
            ////{ "sTitle": "Remark", "mData": "remark", "bSortable": false },
            //    { "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },
            //    { "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            //    { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
            {
                //"sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
                "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    var day_arr = course_data['day'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width: 72%; text-align:justify;float: left;word-break: break-all;'>" + course_data['course_desc'] + "";//1
                    var pre_req = get_prerequisite(course_data['prerequisite']);
                    if (pre_req != "") {
                        str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b> " + pre_req + "</p>";
                    }
                    str += "<p style='text-align:justify;clear:both;'><b>Course SubTitle:</b> " + course_data['CouseSubTitle'] + "</p>";
                    str += "</div>";

                    str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:  ellipsis'>";
                    for (i = 0; i < day_arr.length; i++) {
                        str += "<div style='word-wrap: break-word;width: 120px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                    }
                    str += "</div>";
                    str += "</div></div>";

                    return str;
                }
            },
            {
                "sTitle": "Faculty Status", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    if (course_data['faculty_approval'] == "Approved") {
                        return 'Submitted';
                    } else {
                        return 'Yet not Submitted';
                    }
                }
            },
            {
                "sTitle": "PC Status", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    if (course_data['progcoord_approval'] == "Approved") {
                        return 'Submitted';
                    } else {
                        return 'Yet not Submitted';
                    }
                }
            },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>'
                    return '<center><button type="button" onclick="rowClick_View(this,oTable2)">View</button></center >' +  //Ananth 29062019
                        '<center><a style="cursor:pointer" class="course_outlin_oTable2_download" >PDF</a></center>';
                }
            },
            {
                "sTitle": "Send for Review to Faculty", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["faculty_approval"] == "Approved" && data["progcoord_approval"] == "" && data["ugpg_approval"] == "") {
                        return '<center><button type="button" onclick="rowClick_review_faculty(this,oTable2)">Review</button></center>';
                    }
                    else { return ""; }

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
        //    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
        //    { "sTitle": "Typology", "mData": "type", "bSortable": false },
        //    { "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
        //    { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
        //    { "sTitle": "Title", "mData": "title", "bSortable": false },
        //    { "sTitle": "Credits", "mData": "credit", "bSortable": false },
        ////{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
        ////{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
        //    { "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
        ////{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
        ////{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
        //    { "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
        //    { "sTitle": "Program", "mData": "program", "bSortable": false },
        //    { "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
        ////{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
        //    { "sTitle": "Day", "mData": "day", "bSortable": false },
        //    { "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
        //    { "sTitle": "Time", "mData": "time", "bSortable": false },
        ////{ "sTitle": "Area", "mData": "area", "bSortable": false },
        //    { "sTitle": "Intake", "mData": "intake", "bSortable": false },
        ////{ "sTitle": "Remark", "mData": "remark", "bSortable": false },
        //    { "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },
        //    { "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
        //    { "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
        {
           // "sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
            "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                var day_arr = course_data['day'].split(',');
                var time_arr = course_data['time'].split(',');
                var str = "";
                str += "<div><div>";
                //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                if (course_data['studio_mode'] != "")//Mode kapil 30112020
                {
                    str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                    str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                }
                str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                str += "<div style='width: 72%; text-align:justify;float: left;word-break: break-all;'>" + course_data['course_desc'] + "";//1
                var pre_req = get_prerequisite(course_data['prerequisite']);
                if (pre_req != "") {
                    str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b> " + pre_req + "</p>";
                }
                str += "<p style='text-align:justify;clear:both;'><b>Course SubTitle:</b> " + course_data['CouseSubTitle'] + "</p>";
                str += "</div>";

                str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:  ellipsis'>";
                for (i = 0; i < day_arr.length; i++) {
                    str += "<div style='word-wrap: break-word;width: 120px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                }
                str += "</div>";
                str += "</div></div>";

                return str;
            }
        },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>'
                    return '<center><button type="button" onclick="rowClick_View(this,oTable2)">View</button></center >' +  //Ananth 29062019
                            '<center><a style="cursor:pointer" class="course_outlin_oTable2_download" >PDF</a></center>';
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
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
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
            //{ "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            //{ "sTitle": "Typology", "mData": "type", "bSortable": false },
            //{ "sTitle": "TypologyGroup", "mData": "typegroup", "bSortable": false },
            //{ "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            //{ "sTitle": "Title", "mData": "title", "bSortable": false },
            //{ "sTitle": "Credits", "mData": "credit", "bSortable": false },
            ////{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            ////{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            //{ "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            ////{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            ////{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            //{ "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            //{ "sTitle": "Program", "mData": "program", "bSortable": false },
            //{ "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            //{
            //    "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
            //        return get_prerequisite(data);
            //    }
            //},
            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            //{ "sTitle": "Day", "mData": "day", "bSortable": false },
            //{ "sTitle": "Room ID", "mData": "roomid", "bSortable": false },
            //{ "sTitle": "Time", "mData": "time", "bSortable": false },
            ////{ "sTitle": "Area", "mData": "area", "bSortable": false },
            //{ "sTitle": "Intake", "mData": "intake", "bSortable": false },
            //// { "sTitle": "Remark", "mData": "remark", "bSortable": false },
            //{ "sTitle": "UGPG Approval", "mData": "ugpg_approval", "bSortable": false },
            //{ "sTitle": "Coordinator Approval", "mData": "progcoord_approval", "bSortable": false },
            //{ "sTitle": "Faculty Approval", "mData": "faculty_approval", "bSortable": false },
           {
               //"sTitle": "Description", "mData": "course_desc", "sClass": "cls_desc", "bSortable": false, "fnRender": function (course_data) {
               "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                   var day_arr = course_data['day'].split(',');
                   var time_arr = course_data['time'].split(',');
                   var str = "";
                   str += "<div><div>";
                   //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                   str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                   str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                   if (course_data['studio_mode'] != "")//Mode kapil 30112020
                   {
                       str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                       str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                   }
                   str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                   str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                   str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                   str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                   str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                   str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                   str += "<div style='width: 72%; text-align:justify;float: left;word-break: break-all;'>" + course_data['course_desc'] + "";//2
                   var pre_req = get_prerequisite(course_data['prerequisite']);
                   if (pre_req != "") {
                       str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b> " + pre_req + "</p>";
                   }
                   str += "</div>";

                   str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:ellipsis'>";
                   for (i = 0; i < day_arr.length; i++) {
                       str += "<div style='word-wrap: break-word;width: 118px;float: left;'>" + day_arr[i] + "  </div><span style='float:right;'>" + time_arr[i] + " </span><br/>";
                   }
                   str += "</div>";
                   str += "</div></div>";

                   return str;
               }
           },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    // return '<center><a style="cursor:pointer" class="course_outlin_oTable2" >View</a></center>'
                    return '<center><button type="button" onclick="rowClick_View(this,oTable2)">View</button></center >' + //Ananth 29062019
                            '<center><a style="cursor:pointer" class="course_outlin_oTable2_download" >PDF</a></center>';
                }
            },
            {
                "sTitle": "Send for Review to PC", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick_review(this,oTable2)">Review</button></center>';
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
        //"sDom": 't',
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        //"oLanguage": {
        //    "sSearch": "Search all columns with Space:"
        //},
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
            //{ "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            //{ "sTitle": "Typology", "mData": "type", "bSortable": false },
            //{ "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
            //{ "sTitle": "Title", "mData": "title", "bSortable": false },
            //{ "sTitle": "Credits", "mData": "credit", "bSortable": false },
            ////{ "sTitle": "Occurence Per Week", "mData": "occurence_week", "bSortable": false },
            ////{ "sTitle": "Course Outline", "mData": "course_outline", "bSortable": false },
            //{ "sTitle": "Instructor", "mData": "instructor", "bSortable": false },
            ////{ "sTitle": "Description", "mData": "course_desc", "bSortable": false },
            ////{ "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
            //{ "sTitle": "Faculty", "mData": "faculty", "bSortable": false },
            //{ "sTitle": "Program", "mData": "program", "bSortable": false },
            //{ "sTitle": "Prog level Code", "mData": "program_level_code", "bSortable": false },
            //{
            //    "sTitle": "Prerequisite", "mDataProp": "prerequisite", "bSortable": false, "mRender": function (data, type, full) {
            //        return get_prerequisite(data);
            //    }
            //},
            //{ "sTitle": "Semester", "mData": "semester", "bSortable": false },
            //{ "sTitle": "Day", "mData": "day", "bSortable": false },
            //{ "sTitle": "Time", "mData": "time", "bSortable": false },
            ////{ "sTitle": "Area", "mData": "area", "bSortable": false },
            //{ "sTitle": "Intake", "mData": "intake", "bSortable": false },
            {
                "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (course_data) {
                    var day_arr = course_data['day'].split(',');
                    var time_arr = course_data['time'].split(',');
                    var str = "";
                    str += "<div><div>";
                    //str += "<b>" + course_data.aData['course_code'] + " : " + course_data.aData['course_name'] + "</b><br/>";
                    str += "<b>" + course_data['course_code'] + " : " + course_data['title'] + "</b><br/>";
                    str += "<b> Focus :</b> " + course_data['Focuse'] + " <br/>";
                    if (course_data['studio_mode'] != "")//Mode kapil 01122020
                    {
                        str += "<div style='width:75%;float: left;'><b>Mode:</b> " + course_data['studio_mode'] + "</div>";
                        str += "<div style='width:25%;float: left;'><b></b> <span style='float:right;'></span></div>";
                    }
                    str += "<div style='width:75%;float: left;'><b>Instructor/s:</b> " + course_data['instructor'] + "</div>"
                    str += "<div style='width:25%;float: left;'><b>Typology </b> <span style='float:right;'>" + course_data['type'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>Credits </b> <span style='float:right;'>" + course_data['credit'] + "</span></div><br/>";
                    str += "<div style='width:75%;float: left;'>&nbsp;</div>"
                    str += "<div style='width:25%;float: left;'><b>GPA/NonGPA </b> <span style='float:right;'>" + course_data['gpa_ngpa'] + "</span></div><br/>";
                    str += "<div style='width: 72%; text-align:justify;float: left;word-break: break-all;'>" + course_data['course_desc'] + "";//3
                    var pre_req = get_prerequisite(course_data['prerequisite']);
                    if (pre_req != "") {
                        str += "<p style='text-align:justify;color:#A9A9A9;clear:both;'><b>Prerequisite:</b>" + pre_req + "</p>";
                    }
                    str += "<p style='text-align:justify;clear:both;'><b>Course SubTitle:</b> " + course_data['CouseSubTitle'] + "</p>";
                    str += "</div>";

                    str += "<div style='width:25%;float: right;margin-left: 3%;color:#A9A9A9;text-overflow:ellipsis'>";
                    for (i = 0; i < day_arr.length; i++) {
                        str += "<div style='word-wrap: break-word;width: 135px;float: left;'>" + day_arr[i] + "</div><span style='float:right;'>" + time_arr[i] + "</span><br/>";
                    }
                    str += "</div>";
                    str += "</div></div>";

                    return str;
                }
            },
            {
                "sTitle": "Course Outline", "bSortable": false, "mData": null, "mRender": function () {
                    //return '<center><a style="cursor:pointer" class="course_outline_oTable_allapprovedcourses">View</a></center>';
                    return '<center><button type="button" onclick="rowClick_View(this,oTable_allapproved_courses)">View</button></center >';
                }
            }
        ]
    });

    $('#DataList_allapprovedcourses').css('display', 'block');
}
