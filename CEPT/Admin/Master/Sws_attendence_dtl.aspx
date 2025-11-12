<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Sws_attendence_dtl.aspx.cs" Inherits="Admin_Master_Sws_attendence_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript">

        var oTable, oTable2;
        $(document).ready(function () {

            bindsemdata();
            bindyeardata_for_cross_reg();
            //bindprogramme();
            get_fauser_detail();
            //bindproglevel();

            $('#btnreterive').on('click', function () {
                course_wise_entered_attendence();
                return false;
            });

            //setCurrentSemester();

        });

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_current_grade_semester",
                //async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            $('#btnreterive').click();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

            $('#drpsemester').chosen();

         }
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

            if ($('#hdnusertype').val() == 'FA')
            {

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


        var semester = '';
        var year_code = '';
        var prog_code = '';
        var prog_level_code = '';
        var asInitVals = new Array();

        function course_wise_entered_attendence() {
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

            prog_code = "";
            prog_level_code = "";
            var dept_code = $('#drpdepartment').val();
            if ($('#hdnusertype').val() == 'FA') {
                if (dept_code == "") {
                    bootbox.alert('Please select department');
                    $('#drpdepartment').focus();
                    return false;
                }
                
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/SWS_course_wise_session_submit_list",
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',dept_code:'" + dept_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            course_wise_entered_attendence_list(data.d);
                            $('#div_course_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            $('#div_course_list').css('display', 'none');
                           
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

         function course_wise_entered_attendence_list(data)
         {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                
                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },
                    { "sTitle": "Attendance Status", "mData": "attendance_status", "bSortable": false },
                    {
                        "sTitle": "", "mData": null, "bSortable": false, mRender: function (data)
                        {return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';     }
                    },
                    {
                        "sTitle": "Download PDF", "mData": null, "bSortable": false, fnRender: function (data) {
                            if (data['aData'].doc_pdf != '') {
                                return '<center><button type="button" id=' + data['aData'].doc_pdf +' onclick="rowClick_download_visa(this)">Download</button></center>';
                            }
                            else { return ''; }

                        }
                    },
                ]
            });

            $('#DataList').css('display', 'block');
            $('#div_btn').html('');
          }
                                                                                     
          function rowClick(row)
          {
              var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

              window.location = "Sws_course_wise_enter_session_dtl.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
          }

          function rowClick_download(row) {
              var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
              $('#hdn_code').val(rowId);
              $('#hdn_semester').val(semester);
              $('#hdn_year').val(year_code);
              $("#btnDownloadExcelDocuments").click();
             
         }

         function rowClick_download_visa(row) {
            
             //var rowId = row.parentElement.parentElement.parentElement.childNodes[1].childNodes[0].nodeValue;
             var rowId = row.id;
             document.getElementById('Link').download = 'Attendence';
             document.getElementById('Link').href = '';
             document.getElementById('Link').href = window.location.origin + '\\AttendancePdfUpload\\' + rowId;
             document.getElementById('Link').click();
         }

     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>SWS Attendence Detail
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>
                                    Year of allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    Department
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                               <%-- <td>
                                    Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>--%>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
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
                <strong>SWS Attendence Detail</strong>
            </div>
            <div>
                <div id="DataList" style="display: none;">
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
        <div id="div_btn" style="text-align: center;">
        </div>
        
    </div>
     <input type="hidden" id="hdn_code" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_semester" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
     <div style="display: none;">
        <a href="#" id="Link" download="outline.pdf">Download</a>
    </div>
</asp:Content>

