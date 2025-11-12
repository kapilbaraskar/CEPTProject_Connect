<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="faculty_visa.aspx.cs" Inherits="Admin_Master_faculty_visa" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script type="text/javascript" src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/printcsv.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;


        $(document).ready(function () {

            bindsemdata();
            bindyeardata_for_cross_reg();
            get_fauser_detail();
            // bindprogramme();
            // bindproglevel();

            $('#btnreterive').on('click', function () {
                get_vf_workload_detail();
                return false;
            });

            setCurrentSemester();
        });

        function get_fauser_detail() {

            var url_dept = "";

            if ($('#hdnusertype').val() == 'FA') {
                url_dept = "../../WebService.asmx/get_ws_department_wise_user_dtl";
            }
            else {
                url_dept = "../../WebService.asmx/Get_department_data";
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_dept,
                    async: false,
                    data: "{}",
                    dataType: "json",
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

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').chosen();
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

        function bindprogramme() {

            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                    {
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
            else {

                $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
                $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

                if ($("#hdnusertype").val() != 'PC' && $("#hdnusertype").val() != 'FA') {
                    $('#drpprog').chosen();
                }
            }
        }

        function bindproglevel() {

            //    $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            //    $('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
            //    $('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

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

                        // if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                        $('#drpproglevel').chosen();
                        //  }

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

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
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            //$('#btnreterive').click();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function rowClick(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
            //alert("ID : " + rowId);
            window.location = "faculty_visa_download.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }

        var semester = '';
        var year_code = '';
        var prog_code = '';
        var prog_level_code = '';

        function get_vf_workload_detail() {
            $('#DataList').css('display', 'none');
            $('#div_btn').html('');


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

            //prog_code = $('#drpprog').val();
            //prog_level_code = $('#drpproglevel').val();
            department = $('#drpdepartment').val();
            if (department == "" && $('#hdnusertype').val() == 'FA') {
                bootbox.alert('Please select department');
                $('#drpdepartment').focus();
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetWSCourseWiseInstructorData",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',department:'" + department + "',course_status:''}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {

                            display_get_vf_workload_detail(data.d);

                            $('#div_course_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            if ($('#hdnusertype').val() != 'PC') {
                                $('#div_course_list').css('display', 'none');
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function set_table_columns(row) {
            var columns = [];
            //    for (var attr in row) {
            //        columns.push({ "sTitle": attr, "mData": attr });
            //    }

            columns.push({ "sTitle": "Course Code", "mData": "course_code", "sClass": "cls_desc" });
            columns.push({ "sTitle": "Course Name", "mData": "course_name", "sClass": "cls_desc" });
            columns.push({ "sTitle": "Instructor Code", "mData": "instructor_code", "sClass": "cls_desc"  });
            columns.push({ "sTitle": "Instructor Name", "mData": "instructor_name", "sClass": "cls_desc" });
            //columns.push({
            //    "sTitle": "CV", "mData": null, "sClass": "cls_action", mRender: function (data)
            //    {

            //        if (data.cv_file_name != '') {
            //            // return 'Y';
            //            return '<center><a href="#" style="text-decoration:none;" onclick="rowClick_cv_download(this)" class="cv_download" id=' + data.cv_file_name + ' title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
            //        }
            //        return '';

            //    }
            //});

            var edit_column = {
                "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                }
            };

            columns.push(edit_column);

            return columns;
        }

        function display_get_vf_workload_detail(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

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
                //     "oTableTools": {
                //         "aButtons": [
                //         //"copy",
                //	"print",
                //         	{
                //         	    "sExtends": "collection",
                //         	    "sButtonText": 'Export',
                //         	    "aButtons": ["xls"]
                //         	}
                //]
                //     },
              

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');
           // $(".cls_desc").css('width', '20%');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Download Faculty Visa
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
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
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>Department :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                <%--<td>Programme :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>--%>                                                         
                            </tr>
                            <%--<tr>
                                <td>Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>--%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Visa Detail</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div id="DataList" style="display: none; overflow:auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

