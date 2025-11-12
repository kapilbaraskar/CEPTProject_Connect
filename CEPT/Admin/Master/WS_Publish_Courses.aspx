<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_Publish_Courses.aspx.cs" Inherits="Admin_Master_WS_Publish_Courses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Publish Courses
            </h1>
        </div>
    </div>



    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="">

            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year of allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td class="cls_dept_prog" style="display: none;">Department :
                                </td>
                                <td class="cls_dept_prog" style="display: none;">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="submit" id="btnretrieve">
                                        Retrieve
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
                <strong>Course Detail</strong>
            </div>

            <div>
                <div id="DataList" style="display: none; overflow: auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
            <div class="container">
                <div class="row-fluid">
                    <div id="submitBtnDiv" class="controls" style="text-align: right; width: 50%;">
                    </div>
                </div>
                <!--/row-fluid-->
            </div>
            <!--/container-->
        </div>
         <a href="#" id="Link" style="display:none;" download="outline.pdf">Download</a>
    </div>

    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var dept_code = '';
        var oTable;

        $(document).ready(function () {
            if (getParameterByName("autho") == 'false') {
                //bootbox.alert('You are not authorized to view this page.', function (result) {
                //    window.location.replace('Course_wise_entered_marks.aspx');
                //});
            }
            else if (getParameterByName("autho") == 'app') {
                if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D' || $('#hdnusertype').val() == 'FA') {
                    //bootbox.alert('You can not edit student marks after submit.', function (result) {
                    //    window.location.replace('Course_wise_entered_marks.aspx')
                    //});
                }
            }

            bindyeardata_for_cross_reg();
            bindwssemdata();
            binddepartment();

            setCurrentSemester();

            bindinstructor();

            $('#btnretrieve').on('click', function () {
                if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A' || $('#hdnusertype').val() == 'A1') {
                    retrieve_WS_approved_course_Data();
                }
                return false;
            });
        });

        function bindwssemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

            $('#drpsemester').chosen();
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type:'ws_course'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            get_acuser_detail();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var dept_options = [];
        function get_acuser_detail() {
            if ($('#hdnusertype').val() == 'AC' || $('#hdnusertype').val() == 'FA' || $('#hdnusertype').val() == 'D') {

                dept_options = $('#drpdepartment').children();
                semester = $('#drpsemester').val();
                year_code = $('#drpyear').val();

                if (semester == "" || year_code == "") {
                    return false;
                }

                $('#drpdepartment').html('');
                $('#drpdepartment').append(dept_options[0]);
                $('#drpdepartment').trigger("liszt:updated");

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_semyearwise_dean_user_dtl",
                        async: false,
                        data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                for (var i = 0; i < user_data.length; i++) {
                                    $('#drpdepartment').append(dept_options[user_data[i]['dept_code']]);
                                }

                                $('#drpdepartment').val(user_data[0]['dept_code']);

                                $('#drpdepartment').trigger("liszt:updated");
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }

            //$('#btnretrieve').click();
        }

        var instructor = '';
        function bindinstructor() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_faculty_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var instructor_data = JSON.parse(data.d)

                        instructor = "<option value=''></option>";

                        for (var i = 0; i < instructor_data.length; i++) {
                            instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                        }

                        $('#drp_instructor_list').html(instructor);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        //function rowClick(row) {
        //    var row_data = oTable.fnGetData(row.closest('tr'));
        //    var rowId = row_data['course_code'];
        //    window.location = "Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        //}

        //function rowClick_view(row) {
        //    var row_data = oTable.fnGetData(row.closest('tr'));
        //    var rowId = row_data['course_code'];
        //    window.location = "View_Student_wise_marks.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        //}

        function send_for_review(row) {
            var row_data = oTable.fnGetData(row.closest('tr'));

            var publish_data = [row_data['course_code']];

            if (publish_data.length > 0) {
                var str_publish_data = JSON.stringify(publish_data);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/ws_send_for_review_published_courses",
                    //async: false,
                    data: "{publish_data:'" + str_publish_data + "',sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var res = JSON.parse(data.d);
                            if (res["status"].toString() == 'True') bootbox.alert("Course Sent for Review Successfully", function () { $('#btnretrieve').click() });
                            else bootbox.alert(res["message"].toString());
                        }
                        else {
                            bootbox.alert(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            else {
                bootbox.alert('No Course Selected to Send for Review');
            }

            //$.ajax(
            //{
            //    type: "POST",
            //    contentType: "application/json; charset=utf-8",
            //    url: "../../WebService.asmx/send_for_review",
            //    //async: false,
            //    data: "{course_code:'" + course_code + "', sem_code:'" + semester + "', year_code:'" + year_code + "'}",
            //    dataType: "json",
            //    success: function (data) {
            //        if (data.d != "" && data.d != "[]") {
            //            bootbox.alert(data.d);
            //        }
            //    },
            //    error: function (result) {
            //        tempData = [];
            //        alert(result);
            //    }
            //});
        }

        function publish_all() {
            if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A' || $('#hdnusertype').val() == 'A1') {
                bootbox.confirm('Are you sure you want to Publish Selected Courses?', function (result) {
                    if (result == true) {
                        bootbox.confirm('After Publish you can not change Course Details , Are you sure you want to Publish Selected Courses?', function (result2) {
                            if (result2 == true) {
                                if (oTable != undefined) {
                                    if (oTable.fnGetData().length > 0) {
                                        var obj_selected_course = $('.cls_chk_course_select:checked');
                                        if (obj_selected_course.length > 0) {
                                            var publish_data = [];
                                            for (var i = 0; i < obj_selected_course.length; i++) {
                                                var row = obj_selected_course[i].closest('tr');
                                                var row_data = oTable.fnGetData(row);
                                                if (row_data['dean_approved'] == 'A' && row_data['ws_course_code'] != '' && row_data['course_type'] != '') {
                                                    publish_data.push({ 'course_code': row_data['course_code'], 'course_type': $(row).find('.cls_course_type').val(), 'course_fees': $(row).find('.cls_txt_course_fees').val() });
                                                }
                                            }

                                            if (publish_data.length > 0) {
                                                var str_publish_data = JSON.stringify(publish_data);

                                                $.ajax({
                                                    type: "POST",
                                                    contentType: "application/json; charset=utf-8",
                                                    url: "../../WebService.asmx/ws_publish_selected_courses",
                                                    //async: false,
                                                    data: "{publish_data:'" + str_publish_data + "',sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                                                    dataType: "json",
                                                    success: function (data) {
                                                        if (data.d != "" && data.d != "[]") {
                                                            if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A' || $('#hdnusertype').val() == 'A1') {
                                                                var res = JSON.parse(data.d);
                                                                if (res["status"].toString() == 'True') bootbox.alert("Courses Published Successfully", function () { $('#btnretrieve').click() });
                                                                else bootbox.alert(res["message"].toString());
                                                            }
                                                        }
                                                        else {
                                                            bootbox.alert(data.d);
                                                        }
                                                    },
                                                    error: function (result) {
                                                        alert(result);
                                                    }
                                                });
                                            }
                                            else {
                                                bootbox.alert('No Courses Selected to Publish Course');
                                            }
                                        }
                                        else {
                                            bootbox.alert('No Courses Selected to Publish Course');
                                        }
                                    }
                                }
                            }
                        });
                    }
                });
            }
            else {
                bootbox.alert('You are not Authorized to Publish Course');
            }
        }

        function retrieve_WS_approved_course_Data() {
            $('#DataList').css('display', 'none');
            $('#div_course_list').css('display', 'none');

            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            //dept_code = $('#drpdepartment').val();
            //if ($('#hdnusertype').val() == 'D') {
            //    if (dept_code == "") {
            //        bootbox.alert('Please select Department');
            //        $('#drpdepartment').focus();
            //        return false;
            //    }
            //}

            //prog_code = $('#drpprog').val();

            var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code };
            $('#hdn_filter').val(JSON.stringify(filter_criteria));

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_ws_approved_course_list",
                    data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "") {
                            display_approved_course_Data(data.d);
                            //setDataTableHeaderFooter('example');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester or Year');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            return false;
        }

        function display_approved_course_Data(data) {
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
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
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
                        "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, mRender: function (data) {
                            if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A' || $('#hdnusertype').val() == 'A1') {
                                if (data.is_publish != 'Y') {
                                    return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" />';
                                }
                                else return '';
                            }
                            else return '';
                        }
                    },
                    { "sTitle": "Course Code", "mData": "ws_course_code", "bSortable": false },
                    {
                        "sTitle": "Course Type", "mData": null, "bSortable": false, mRender: function (data) {
                            if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A' || $('#hdnusertype').val() == 'A1') {
                                if (data.is_publish != 'Y') {
                                    return '<select class="cls_course_type" style="width:140px;"><option value="SWS">Summer Winter</option><option value="HS">High School</option></select>';
                                }
                                else {
                                    if (data.course_type1 == "M") return "Mandatory";
                                    else if (data.course_type1 == "E") return "Elective";
                                    else return data.course_type1;
                                } 
                            }
                            else return '';
                        }
                    },
                    {
                        "sTitle": "Type", "mData": "course_type", "bSortable": false, "mRender": function (data) {
                            if (data == "M") return "Mandatory";
                            else if (data == "E") return "Elective";
                            else return "";
                        }
                    },
                    {
                        "sTitle": "Course Fees", "mData": null, "bSortable": false, mRender: function (data) {
                            if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A' || $('#hdnusertype').val() == 'A1') {
                                if (data.is_publish != 'Y') {
                                    return '<input type="text" class="cls_txt_course_fees" style="width:60px;" onkeypress="return IsNumeric(event);" />';
                                }
                                else return data.fees1;
                            }
                            else return '';
                        }
                    },
                    { "sTitle": "Course Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Instructors", "mData": "instructors", "bSortable": false },
                    {
                        "sTitle": "Inhabitation", "mData": "inhabitation", "bSortable": false, "mRender": function (data) {
                            if (data == "1") return "Architecture";
                            else if (data == "2") return "Design";
                            else if (data == "3") return "Management";
                            else if (data == "4") return "Planning";
                            else if (data == "5") return "Technology";
                            else return "";
                        }
                    },
                    { "sTitle": "Intake Capacity", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "Credits", "mData": "course_credits", "bSortable": false },
                    { "sTitle": "Category Location Wise", "mData": "category_location_wise", "bSortable": false },
                    { "sTitle": "Location", "mData": "location", "bSortable": false },

                    {
                        "sTitle": "Start Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", mRender: function (data) {
                            if (data.start_date != '') {
                                var temp_date = new Date(data.start_date);
                                return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                            }
                            else
                                return '';
                        }
                    },
                    {
                        "sTitle": "End Date", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", mRender: function (data) {
                            if (data.end_date != '') {
                                var temp_date = new Date(data.end_date);
                                return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                            }
                            else
                                return '';
                        }
                    },
                    {
                        "sTitle": "Course Budget File", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", mRender: function (data) {
                            if (data.coursebudget_filepath != '') {
                              
                                return '<center><a href="#" style="text-decoration:none;" class="coursebudget_download" id=' + data.coursebudget_filepath + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                            }
                            return '';
                        }
                    },
                    {
                        "sTitle": "Send for Review", "mData": null, "bSortable": false, mRender: function (data) {
                            if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A' || $('#hdnusertype').val() == 'A1') {
                                if (data.is_publish == 'Y') {
                                    return "<center><a onclick='send_for_review(this)'>Send</button></a>";
                                }
                                else return '';
                            }
                            else return '';
                        }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            $('#div_course_list').css('display', 'block');
            if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A' || $('#hdnusertype').val() == 'A1') {
                $('#submitBtnDiv').html('<button id="btn_publish_all" type="button" class="btn btn-lg btn-primary" onclick="publish_all()">Publish All</button>');
            }
        }

        function select_all_change() {
            if ($('#chk_select_all')[0].checked) {
                $('.cls_chk_course_select').attr('checked', 'checked');
            }
            else {
                $('.cls_chk_course_select').removeAttr('checked');
            }
        }

        function course_select_change(cur_ele) {
            if (cur_ele.checked) {
                if ($('.cls_chk_course_select').length == $('.cls_chk_course_select:checked').length)
                    $('#chk_select_all')[0].checked = true;
            }
            else {
                $('#chk_select_all')[0].checked = false;
            }
        }

        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                return true;
            }
            else {
                return false;
            }
        }
        $(document).on("click", ".coursebudget_download", function (event) {
           
            //var row = $(this).closest("tr").get(0);
            //var aData = oTable.fnGetData(row);
            //var cv_file_name = aData["cv_file_name"];
            var file_name = event.currentTarget.id;
            var root = window.location.origin;
            //alert(root);
            document.getElementById('Link').download = file_name + '.xlsx';
            document.getElementById('Link').href = window.location.origin + "\\CourseBudget" + "\\" + file_name ;
            document.getElementById('Link').click();
            return false;
        });
        

    </script>
</asp:Content>

