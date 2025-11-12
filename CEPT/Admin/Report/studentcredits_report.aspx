<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="studentcredits_report.aspx.cs" Inherits="Admin_Report_studentcredits_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            bindyeardata();
            
            $('#btnreterive').on('click', function () {
                retrieve_Data();
                return false;
            });

            $('#drpyear').on('change', function () {
                $('#DataList').css('display', 'none');
                brndstudentdata();
                return false;
            });
        });

        function brndstudentdata() {

            debugger;

            if ($('#drpyear').val() == "") {

                bootbox.alert("Please select year.");

                return false;
            }

         
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_student_data_for_coordinator_wise",

                data: "{year_code:'" + $('#drpyear').val() + "' }",
                dataType: "json",
                success: function (data) {

                    debugger;


                    if (data.d != "") {


                        var data = JSON.parse(data.d)



                        $('#drpstudent').empty().append($("<option></option>").val("").html("-- Please Select Student --"));
                        for (var i = 0; i < data.length; i++) {


                            $('#drpstudent').append($("<option></option>").val(data[i]["user_id"]).html(data[i]["user_id"]));
                        }

                        $('#drpstudent').chosen();
                        $('#drpstudent').trigger("liszt:updated");
                    }
                    else {
                        $('#drpstudent')
                .find('option')
                .remove()
                .end()
                .append('<option value="">No Student found</option>')
                .val('');
                        $('#drpstudent').chosen();

                        $('#drpstudent').val('').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function retrieve_Data() {
            $('#DataList').css('display', 'none');


        

           var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

                var student_code = $('#drpstudent').val();
                if (student_code == "") {
                bootbox.alert('Please select student code');
                $('#drpstudent').focus();
                return false;
            }

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_studentscredits_report_data",
                data: "{student_code:'" + student_code + "' }",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {
                        display_Student_Data(data.d);
                        $('#div_data_list').css('display', 'block');
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester or Year');
                        $('#div_data_list').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        }

        function display_Student_Data(data) {

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

                "aaData": JSON.parse(data),
                "aoColumns": [
                   { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                  { "sTitle": "Semester", "mData": "semester_type", "bSortable": false },
                                  { "sTitle": "Year", "mData": "year_semester", "bSortable": false },
                     { "sTitle": "Mandatory Credit Applied", "mData": "mandatory_applied", "bSortable": false },
                           { "sTitle": "Elective Credit Applied", "mData": "elective_applied", "bSortable": false },
                      { "sTitle": "Mandatory Credit Allocated", "mData": "mandatory_allocated", "bSortable": false },
                           { "sTitle": "Elective Credit Allocated", "mData": "elective_allocated", "bSortable": false },
                            { "sTitle": "Mandatory Credit completed", "mData": "mandatory_completed", "bSortable": false },
                             // { "sTitle": "Elective Credit Passed", "mData": "E_Passed", "bSortable": false },
                                { "sTitle": "Elective GPA Completed", "mData": "gpa_completed", "bSortable": false },
                                  { "sTitle": "Elective Non GPA Completed", "mData": "non_gpa_completed", "bSortable": false }

                                 

                ]
            });

            $('#DataList').css('display', 'block');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; Student Credits Report
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    Student :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpstudent">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_data_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Data List</strong> <span style="float: right;">
                    <%--<asp:Button ID="btn_download_all" class="btn btn-primary" runat="server" Text="Download All" OnClick="Button1_Click" style="height: 40px;margin-top: -10px;"/>--%>
                </span>
            </div>
            <div>
                <%--class="panel-body"--%>
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
    </div>
</asp:Content>
