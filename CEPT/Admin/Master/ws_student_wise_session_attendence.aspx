<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ws_student_wise_session_attendence.aspx.cs" Inherits="Admin_Master_ws_student_wise_session_attendence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js"></script>
     <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <script type="text/javascript">
        var oTable, oTable3;
        var table_headers, table_headers_xls, table_headers_xls_new;
        var no_of_held = '';
        var year = '';
        var sem = '';
        var course_code = '';
        var tempData = [];
        var isExamValidate = true;
        var submit_flag = false;
        var student_attendance;
        var attendance_dtl;
        var details = '';
        var session_dtl = '';
        var course_code_v2 = '';

        var data_value = { 'user_id': '', 'course_code': '', 'session_attended': '', 'semester_type': null, 'year_semester': null };

        $(document).ready(function () {
            course_code_v2 = $('#hdn_code').val();
            $('#course_code_v2').text(course_code_v2);
            get_course_wise_session_dtl();
            course_wise_student();
            get_course_wise_session_dtl_data();
            get_session_held_dtl();
        });


        function save_session_held() {
            course_code = hdn_code.value;
            sem = hdn_semester.value;
            year = hdn_year.value;
            no_of_held = no_held_txt.value;
            var held_value = no_held_txt.value;
            if (held_value == "") {
                bootbox.alert('Please Enter Total Number Of Session Held');
                $('#no_held_txt').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_save_attendance_dtl",
                async: true,
                data: "{Course_Code: '" + course_code + "',semester: '" + sem + "',year: '" + year + "',no_of_held: '" + no_of_held + "',user_id:''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "Update Data") {
                            bootbox.alert("Update Data Successfully");
                        }
                        else {
                            bootbox.alert("Save Data Successfully");
                            course_wise_student();
                        }
                    }
                    else {
                        bootbox.alert('Problem in Data');
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_session_held_dtl() {
            course_code = hdn_code.value;
            sem = hdn_semester.value;
            year = hdn_year.value;
            no_of_held = no_held_txt.value;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_number_of_session_held_dtl",
               // async: true,
                data: "{Course_Code: '" + course_code + "',semester: '" + sem + "',year: '" + year + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var data = JSON.parse(data.d);
                        no_held_txt.value = data[0]["no_of_session_held"];
                        if (data[0]["doc_pdf"] != "") {
                            $('#lbl_port_file_name').html('<b>' + data[0]["doc_pdf"] + '</b>');

                        }

                        course_wise_student();
                    }
                    else {
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function course_wise_student()
        {
            $.ajax({
                //async: true,
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_session_date_wise_dtl",
                data: "{course_code:'" + $('#hdn_code').val() + "', sem_code:'" + $('#hdn_semester').val() + "', year_code:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "")
                    {
                        attendance_dtl = "";
                        attendance_dtl = JSON.parse(data.d);
                        console.log("Second Step");
                        course_wise_student_dtl(data.d);
                        $('#div_course_list').css('display', 'block');
                    }
                    else
                    {
                        bootbox.alert("Data Not Found");
                        return false;
                    }


                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function user_dtl() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_attendance_user_dtl",
                //url: "../../WebService.asmx/get_attendance_allocate_dtl",
                //async: true,
                data: "{course_code:'" + $('#hdn_code').val() + "', sem_code:'" + $('#hdn_semester').val() + "', year_code:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        student_attendance = JSON.parse(data.d);
                        course_wise_student_dtl(data.d);

                        $('#div_course_list').css('display', 'block');
                    }
                    else {
                    }


                },
                error: function (result) {
                    alert(result);
                }
            });

            //return false;
        }
        var number_increment = 0;
        async function course_wise_student_dtl(data) {
            var date = '';
            table_headers_xls_new = [{ "sTitle": "Student Code", "mData": "sca_user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false }];
           // get_course_wise_session_dtl();
            if (details.length == 0)
            {
                get_course_wise_session_dtl();
            }
            console.log(details.length);
            if (details.length > 0) {
                for (var i = 0; i < details.length; i++) {
                    number_increment = 0;
                    var session_id;
                    //var name_col = details[i].session_name + ' (' + details[i].session_date + ')';
                    table_headers_xls_new.push({
                        "sTitle": details[i].session_name + ' (' + details[i].session_date + ')<br/><button id="' + details[i].session_date + '" type="button" class="btn btn-small btn-primary" style="margin-top:5px;" onclick="present_attendance(\'' + details[i].session_date + '\')">P</button><button id="' + details[i].session_date + '" type="button" class="btn btn-small btn-primary" style="margin-top:5px;margin-left: 3px;" onclick="absent_attendance(\'' + details[i].session_date + '\')">A</button>', "mData": details[i].session_name + ' (' + details[i].session_date + ')', "bSortable": false, fnRender: function (data)
                        {
                            if (number_increment == details.length - 1)
                            {
                                session_id = details[number_increment]["session_id"];
                                date = details[number_increment].session_date;
                                number_increment = 0;
                                console.log("first" + number_increment);
                            }
                            else
                            {
                                if (number_increment > 0)
                                {
                                    session_id = details[number_increment]["session_id"];
                                    date = details[number_increment].session_date;
                                    number_increment = number_increment + 1;
                                    console.log("first" + number_increment);
                                }
                                else {
                                    session_id = details[number_increment]["session_id"];
                                    date = details[number_increment].session_date;
                                    number_increment = number_increment + 1;
                                }
                            }

                            var id_value = data.aData.sca_user_id + "_" + session_id;
                            
                            if (data.aData.session_is_submit == 'Y')
                            {
                                return "<input type='text' id='" + id_value + "'  value='' class='inline_input' onkeypress='return IsNumeric(event);' style='text-transform:uppercase;width:50%' disabled/>";
                            }
                            else
                            {
                            var listItems = '<select class="' + date + '"  id="' + id_value + '" style="width:100%" onchange="setvalue(\'' + id_value + '\');">';
                            listItems += "<option value='0'>Select</option>";
                            listItems += "<option value='P'>P</option>";
                            listItems += "<option value='A'>A</option>";
                            listItems += '</select>';
                                return listItems;
                            }
                        }
                    });
                }
            }
            console.log("Thired Step");
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": table_headers_xls_new
            });
            if (attendance_dtl != "") {
                $("#example tbody tr").each(function (i)
                {
                    console.log("Count" + i);
                    console.log("attendance" + attendance_dtl.length);
                    console.log("details" + details.length);
                   // for (var j = 0; j < attendance_dtl.length; j++)
                    //{
                        for (var k = 0; k < details.length; k++)
                        {
                            var session_id = details[k].session_name + ' (' + details[k].session_date + ')';
                            if (attendance_dtl[i][session_id] != "") {
                                var id_session = attendance_dtl[i]["sca_user_id"] + '_' + details[k]["session_id"];
                                $(this).find("#" + id_session).val(attendance_dtl[i][session_id]);
                                //color changes 
                                if (attendance_dtl[i][session_id].trim() == "P")
                                {
                                    if (attendance_dtl[i]["session_is_submit"] != "Y") {
                                        $(this).find("#" + id_session).css('background-color', 'cadetblue', 'color', 'white');
                                    }
                                    else {
                                        
                                        $(this).find("#" + id_session).css('background-color', 'cadetblue', 'color', 'white');
                                    }

                                }
                                else if (attendance_dtl[i][session_id].trim() == "A") {
                                    if (attendance_dtl[i]["session_is_submit"] != "Y") {
                                        $(this).find("#" + id_session).css('background-color', 'palevioletred', 'color', 'white');
                                    }
                                    else {
                                        //$(this).find('input[disabled]' + ' '+ "#" + id_session).css('color', 'black');
                                        $(this).find("#" + id_session).css('background-color', 'palevioletred', 'color', 'white');
                                    }

                                }
                                $('.inline_input').css('color', 'black');
                            }
                        }
                    //}
                });
            }
            $('#DataList').css('display', 'block');
        }

        function display_data_for_present()
        {
            if (attendance_dtl != "")
            {
                $("#example tbody tr").each(function (i) {
                    for (var j = 0; j < attendance_dtl.length; j++) {
                        for (var i = 0; i < details.length; i++) {
                            var session_id = details[i].session_name + ' (' + details[i].session_date + ')';
                            var id_session = attendance_dtl[j]["sca_user_id"] + '_' + details[i]["session_id"];
                            $(this).find("#" + id_session).val('P');
                            $(this).find("#" + id_session).css('background-color', 'cadetblue', 'color', 'white');
                        }
                    }
                });
            }
        }

        function display_data_for_absent()
        {
            if (attendance_dtl != "") {
                $("#example tbody tr").each(function (i) {
                    for (var j = 0; j < attendance_dtl.length; j++)
                    {
                        for (var i = 0; i < details.length; i++)
                        {
                            var session_id = details[i].session_name + ' (' + details[i].session_date + ')';
                            var id_session = attendance_dtl[j]["sca_user_id"] + '_' + details[i]["session_id"];
                            $(this).find("#" + id_session).val('A');
                            $(this).find("#" + id_session).css('background-color', 'palevioletred', 'color', 'white');
                        }

                    }
                });
            }
        }

        function present_attendance(date_id_value) {
            if (date_id_value != "")
            {
                $("#example tbody tr").each(function (i) {
                    $(this).find("." + date_id_value).val('P');
                    $(this).find("." + date_id_value).css({ "background-color": "cadetblue", "color": "white" });
                });
            }
        }

        function absent_attendance(date_id_value) {
            if (date_id_value != "") {
                $("#example tbody tr").each(function (i) {
                    $(this).find("." + date_id_value).val('A');
                    $(this).find("." + date_id_value).css({ "background-color": "palevioletred", "color": "white" });
                });
            }
        }

        function setvalue(drp_id) {
            var select_value = $('#' + drp_id + ' ' + 'option:selected').val();

            if (select_value == "P") {
                $("#" + drp_id).css('background-color', 'cadetblue', 'color', 'white');
            }
            else if (select_value == "A") {
                $("#" + drp_id).css('background-color', 'palevioletred', 'color', 'white');
            }
            else {
                $("#" + drp_id).removeAttr('style');
                $("#" + drp_id).css('width', '100%');
            }


        }

        function set_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Student Code", "mData": "user_id", "bSortable": false });
            columns.push({ "sTitle": "Session Name", "mData": "session_name", "bSortable": false });
            columns.push({ "sTitle": "Session Date", "mData": "session_date", "bSortable": false });
            columns.push({ "sTitle": "Student Name", "mData": "full_name", "bSortable": false });
            columns.push({
                "sTitle": "Number Of Session Attended", "mData": "no_of_session_attended", "bSortable": false, mRender: function (data) {

                    return "<input type='text' value='" + data + "' class='inline_input' onkeypress='return IsNumeric(event);'/>";
                }
            });



            columns.push({ "sTitle": "Attendance Percentage", "mData": "attendance_percentage", "bSortable": false });
            return columns;
        }


        function IsNumeric(e) {
            //alert(e.which + " : " + e.keyCode);

            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 46) {
                if ($(document.activeElement).val().indexOf('.') != -1) {
                    return false;
                }

                if ($(document.activeElement).val() == '100') {
                    return false;
                }

            }

            if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {

                if (($(document.activeElement).val().indexOf('.') != -1) && ($(document.activeElement)[0].selectionStart > $(document.activeElement).val().indexOf('.'))) {

                    var no_held = $('#no_held_txt').val();


                    if ($(document.activeElement).val() > no_held) {
                        return false;
                    }

                    if ($(document.activeElement).val().substr($(document.activeElement).val().indexOf('.') + 1).length >= 2) {
                        return false;
                    }

                    else {
                        return true;
                    }

                }
                else {

                    var no_held = $('#no_held_txt').val();


                    if ($(document.activeElement).val() > no_held) {
                        return false;
                    }

                    if (parseInt($(document.activeElement).val()) > 10) {
                        return false;
                    }
                    else if (parseInt($(document.activeElement).val()) == 10) {
                        if (keyCode != 48) {
                            return false;
                        }
                        else {
                            if ($(document.activeElement).val().indexOf('.') != -1) {
                                return false;
                            }
                        }
                    }
                }

                return true;
            }
            else {
                return false;
            }
        }

        function save_student_attendance_Data() {

            get_course_wise_session_dtl_data();
            var stause_att = false;
            tempData = [];
            data_value = { 'user_id': '', 'course_code': '', 'session_attended': '', 'session_id': '', 'semester_type': null, 'year_semester': null };
            $("#example tbody tr").each(function (i)
            {
                for (var j = 0; j < session_dtl.length; j++)
                {
                    var user_id = $(this).children().eq(0).html();
                    var user_id_session = user_id + '_' + session_dtl[j].session_id;
                    data_value.user_id = $(this).children().eq(0).html();
                    var session_id = session_dtl[j].session_id;
                    data_value.session_id = session_id;
                    var select_value = $('#' + user_id_session).val();
                    if (select_value != '0')
                    {
                        data_value.session_attended = select_value; //$(this).children().eq(3)[0].children[0].value;
                    }
                    else
                    {
                        data_value.session_attended = null;
                        if (submit_flag)
                        {
                            alert("Please Select Session Attended Value Student Id : " + user_id);
                            stause_att = true;
                            return false;
                        }

                    }

                    data_value.course_code = $('#hdn_code').val();
                    data_value.semester_type = $('#hdn_semester').val();
                    data_value.year_semester = $('#hdn_year').val();
                    tempData.push(data_value);
                    data_value = { 'user_id': '', 'course_code': '', 'session_attended': '', 'session_id': '', 'semester_type': null, 'year_semester': null };
                }
                
                data_value = { 'user_id': '', 'course_code': '', 'session_attended': '', 'session_id': '', 'semester_type': null, 'year_semester': null };
            });

            if (stause_att == false) {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/ws_save_all_students_wise_session_value",
                        //async: false,
                        //async: true,
                        data: "{student_att_Data:'" + JSON.stringify(tempData) + "',status:'" + submit_flag + "'}",
                        dataType: "json",
                        success: function (data) {
                            tempData = [];
                            if (data.d != "" && data.d != "[]") {
                                if (data.d == 'Data Saved Successfully') {
                                    bootbox.alert("Data Saved Successfully");
                                    course_wise_student();
                                    return false;
                                    //if (submit_flag) {
                                    //    location.reload();
                                    //}
                                    
                                }
                                else {
                                    bootbox.alert(data.d);
                                }
                            }
                        },
                        error: function (result) {
                            tempData = [];
                            alert(result);
                        }
                    });
            }
        }


        function submit_attendance()
        {
            isExamValidate = true;
            if (isExamValidate)
            {
                submit_flag = true;
                save_student_attendance_Data();
                get_course_wise_session_dtl();
            }
        }

        function GetFileNameFromPath(strFilepath) {

            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return strName[0];
            }
        }

        function CheckMarksDocumentExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'xls':
                    case 'xlxs':
                    case 'xlsx':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function UploadAttendance() {
            try {

                var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
                var ses_data = $('#hdn_session').val();
                if (CheckMarksDocumentExtension(fileToUpload)) {
                    ses_data = ses_data.replace(/"/g, "'");
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        type: "POST",
                        url: '../../Handler/ws_student_wise_session_dtl_upload.ashx',
                        secureuri: false,
                        data: { "session_data": ses_data, "course_code": $('#hdn_code').val(), "semester_type": $('#hdn_semester').val(), "year_code": $('#hdn_year').val() },
                        fileElementId: 'reservation_upload_document',
                        dataType: 'text',
                        success: function (data, status) {

                            if (data == 'Data Saved Successfully')
                            {
                                bootbox.alert(data);
                                $('#reservation_upload_document').val('');
                                course_wise_student();
                                return false;

                            }
                            else if (data == 'Problem in update DATA.')
                            {
                                bootbox.alert('Problem in update Data.');
                                $("#UploadingProgress").fadeOut(200);
                                $('#reservation_upload_document').val('');
                            }
                            else if (data == 'Problem in save data')
                            {
                                bootbox.alert('Problem in save data.');
                                $("#UploadingProgress").fadeOut(200);
                                $('#reservation_upload_document').val('');
                            }
                            else
                            {
                                data = JSON.parse(data);
                                $("#UploadingProgress").fadeOut(200);
                                bootbox.alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                $('#reservation_upload_document').val('');

                            }
                            if (typeof (data.error) != 'undefined') {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {
                                    alert("Data Saved Successfully ");
                                    return false;

                                }
                            }
                        },
                        error: function (data, status, e) {
                            $("#UploadingProgress").fadeOut(200);
                            alert(data.responseText);
                            window.location.reload();
                        }
                    });
                    
                }
                else {
                    alert('Invalid File Type. Please upload .xls file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }
        function display_data_for_excel() {

            var str = '<div id="DataList_xls_format" style="display: none;"><table cellpadding="0" cellspacing="0" border="0" id="example_xls_format" class="display table table-striped table-bordered table-hover" width="100%"><thead></thead><tbody></tbody></table></div>';

            $('#mynewModal3 .modal-body').html(str);

            table_headers_xls = [{ "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "No Of Session Attended", "mData": "no_of_session_attended", "bSortable": false },
            { "sTitle": "Attendance Percentage", "mData": "attendance_percentage", "bSortable": false }];

            if (oTable3 != null) {
                oTable3.fnDestroy();
                $("#DataList_xls_format").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_xls_format" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable3 = $("#example_xls_format").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },

                //"aaData": JSON.parse(data),
                "aaData": student_attendance,

                "aoColumns": table_headers_xls
            });

            $('#DataList_xls_format').css('display', 'block');
            $('#btn_show_modal3').click();
        }
        function display_excel_format() {

            var str = '<div id="DataList_xls_format" style="display: none;"><table cellpadding="0" cellspacing="0" border="0" id="example_xls_format" class="display table table-striped table-bordered table-hover" width="100%"><thead></thead><tbody></tbody></table></div>';

            $('#mynewModal3 .modal-body').html(str);

            table_headers_xls = [{ "sTitle": "STUDENT_CODE", "mData": "user_id", "bSortable": false },
            { "sTitle": "NO_OF_SESSION_ATTENDED", "mData": null, "bSortable": false }
            ];



            if (oTable3 != null) {
                oTable3.fnDestroy();

                $("#DataList_xls_format").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_xls_format" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable3 = $("#example_xls_format").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",

                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]

                        }

                    ]
                },


                //"aaData": JSON.parse(data),
                "aaData": student_attendance,

                "aoColumns": table_headers_xls
            });

            $('#DataList_xls_format').css('display', 'block');
            $('#btn_show_modal3').click();
        }
        function CheckUserPDFExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'pdf':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }


        function UploadPdfFile() {
            try {

                var fileToUpload = GetFileNameFromPath($('#att_submit_pdf').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPDFExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {
                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/ws_course_wise_attendance_pdf_upload.ashx',
                                secureuri: false,
                                data: { 'UploadType': 'att_submit_pdf', "course_code": $('#hdn_code').val(), "semester_type": $('#hdn_semester').val(), "year_code": $('#hdn_year').val() },
                                fileElementId: 'att_submit_pdf',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#att_submit_pdf').val("");
                                            $('#lbl_port_file_name').html('<b>' + fileToUpload + '</b>');
                                            FileName = data.upfile;
                                            bootbox.alert('PDF File Uploaded Successfully.');
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    $('#att_submit_pdf').val('');
                    alert('Invalid File Type. Please upload .pdf format file.');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function display_excel()
        {
            $("#btnDownloadExcelDocuments").click();
        }
        function preview_page() {
            window.location = "Sws_course_wise_enter_session_dtl.aspx?c=" + $('#hdn_code').val() + "&s=" + $('#hdn_semester').val() + "&y=" + $('#hdn_year').val();
        }

        async function get_course_wise_session_dtl() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_course_wise_session_dtl",
                //async: true,
                data: "{Course_Code:'" + $('#hdn_code').val() + "', semester:'" + $('#hdn_semester').val() + "', year:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        console.log("First Step");
                        details = JSON.parse(data.d);
                        if (details[0]["is_submit"] == "Y")
                        {
                            $('#btnsave_data').prop('disabled', true);
                            $('#btn_submit').prop('disabled', true);
                            $('#btn_excel_data').prop('disabled', true);
                            $('#btn_excel_format').prop('disabled', true);
                            $('#reservation_upload_document').prop('disabled', true);
                            $('#att_submit_pdf').prop('disabled', true);

                        }

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_course_wise_session_dtl_data() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_get_course_wise_session_dtl",
                //async: true,
                data: "{Course_Code:'" + $('#hdn_code').val() + "', semester:'" + $('#hdn_semester').val() + "', year:'" + $('#hdn_year').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        console.log("Get Session Details");
                        session_dtl = JSON.parse(data.d);

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            //return false;
        }


        

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Student Wise Attendace
            </h1>
        </div>
    </div>
     <div class="well" style="background-color: White;">
        <h4><b>Note :</b></h4>
         <p><b>Step 2 - Attendance Entry</b></p>
        <p>1: You can upload Student Wise Attendace for each student. Click on <span style="color:blue;"><b>Excel Format</b></span> button to Export and save a .xlsx File.</p>
        <p>2: Open the .xlsx file in Excel. Enter Session Attended Value for each student, and save the file as a .xlsx file.</p>
        <p>3: Scroll down, <span style="color:blue;"><b>Choose File</b></span> to Upload Excel File you just saved. It saves the student-wise attendance to the Connect database.</p>
        <p>4: You can also manually enter the Number of Sessions Attended Values for each student. Click <span style="color:blue;"><b>Save</b></span> Button at the bottom of the page to save the entered data.</p>
        <p>5: Once you are ready to submit the attendance data, Click <span style="color:blue;"><b>Submit</b></span> Button.</p>
        <p>6: You can export all data into Excel by clicking the <span style="color:blue;"><b>Excel Format</b></span> Button.</p>
        <p style="color:red;">Note: You can not change once you final submit all Student Wise Attendace You cannot edit the data once you Submit the attendance data.</p>
         <p style="color:blue;">P = Present, A = Absent</p>

    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Number Of Session Held</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                   Total Number Of Session Held :
                                </td>
                                <td>
                                    <input type="text" id="no_held_txt" />
                                </td>
                                <td>
                                     <button class="btn btn-primary" id="btnsave">
                                        Save
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Student Wise Entered Attendance Detail (Course Code : <span id="course_code_v2" style="color: blue;"></span> )</strong>
                <span style="float: right;">
                    
                    
                   <input id="btn_excel_data" type="button" class="btn btn-primary" value="All Present" style="height: 40px; margin-top: -10px;float:left;margin-right: 11px; display:block;" onclick="display_data_for_present()" />
                   <input id="btn_excel_format" type="button" class="btn btn-primary" value="All Absent" style="height: 40px; margin-top: -10px; float:left;margin-right: 11px; display:block;" onclick="display_data_for_absent()"  />
                    <input id="btn_excel" type="button" class="btn btn-primary" value="Excel Format" style="height: 40px; margin-top: -10px; float:left;" onclick="display_excel()" />
                    
                </span>
                 
            </div>
            <div>
                <div id="DataList" style="display: none;overflow: auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%" >
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            
     <div style="border: 1px solid black;padding:10px;" id="upload_div">
    <div style="margin-top: 1%; display:block;">
        <div style="float: left; width: 25%;">1. Upload PDF File :</div>
        <input type="file" name="att_submit_pdf" id="att_submit_pdf" onchange="javascript:return UploadPdfFile();" " />
        <span id="lbl_port_file_name" style="vertical-align: super;"></span>
    </div>
        
		<div style="margin-top: 1%;">
        <div style="float: left; width: 25%;">2. Upload Excel File:</div>
        <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                        onchange="javascript:return UploadAttendance();" />
    </div>
		<div style="margin-top: 1%;">
             <table style="width: 62%; margin-left: 15%;">

            <tr>
                <td align="right">
                    <button id="btn_preview" type="button" class="btn btn-lg btn-primary" onclick="preview_page()"><< Previous</button>
                </td>
                <td align="center">
                    <button id='btnsave_data' type='button' style='display: block;' class='btn btn-lg btn-primary' onclick='save_student_attendance_Data()'>
                        <i class='icon-save bigger-160'></i>Save
                    </button>
                </td>
               
                <td>
                    <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_attendance()">Submit</button>
                </td>
            </tr>
            
        </table>
            </div>
        </div>
        </div>
        <div id="div_btn" style="text-align: center;">
        </div>
        
    </div>

    <div class="modal fade" id="mynewModal2" style="display: none; top: 5%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H2">Hello</h4>
                </div>

                <div class="modal-body">
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close2" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <%--<button id="btn_modal_save2" type="button" class="btn btn-primary" onclick="updateColumn()">Save changes</button>--%>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="mynewModal3" style="display: none; top: 5%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="H3">Excel Download</h4>
                </div>

                <div class="modal-body">
                    <div id="DataList_xls_format" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_xls_format" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="modal-footer">
                    <button id="btn_modal_close3" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
     <input type="hidden" id="hdn_code" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_semester" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_session" runat="server" clientidmode="Static" />
    <asp:Button ID="btnDownloadExcelDocuments" Style="display: none;" runat="server" Text="Button" ClientIDMode="Static" OnClick="btnDownloadExcelDocuments_Click" />
</asp:Content>

