<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="student_wise_drp_dtl.aspx.cs" Inherits="Student_student_wise_drp_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var oTable;
        var status;
        $(document).ready(function () {
            bindsemdata();
            bindType();
            bindyeardata_for_cross_reg();
            binddepartment();
            bindprogrammedata();

            $('#btnreterive').on('click', function () {
                get_drp_dtl();
                return false;
            });


        });
        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            $('#drpsemester').chosen();
        }
        function bindType() {
            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("S").html("DRP Course Topic"));
            $('#drptype').append($("<option></option>").val("A").html("My DRP Topic"));
            $('#drptype').chosen();
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


        function get_drp_dtl() {
            $('#DataList').css('display', 'none');


            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            status = $('#drptype').val();
            if (status == "") {
                bootbox.alert('Please select Type');
                $('#drptype').focus();
                return false;
            }

            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();



            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Student_wise_drp_dtl",
                    //async: false,
                    data: "{student_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',status:'" + status + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            $('#div_drp_list').css('display', 'none');
                            display_drp_detail(data.d);
                            $('#div_drp_list').css('display', 'block');
                        }
                        else {
                            $('#div_drp_list').css('display', 'none');
                            bootbox.alert('No data Found For Selected Semester and Year');
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
            var path = window.location.origin;
            columns.push({ "sTitle": "DRP Code", "mData": "drp_code" });
            columns.push({ "sTitle": "Course Code", "mData": "course_code" });
            columns.push({ "sTitle": "Faculty Name", "mData": "full_name" });
            columns.push({ "sTitle": "Topic Name", "mData": "topic" });
            columns.push({ "sTitle": "Abstracts", "mData": "abstracts" });
            columns.push({ "sTitle": "Reference", "mData": "reference" });
            columns.push({
                "sTitle": "PDF", "mData": null, mRender: function (row) {

                    if (row.doc_path != "") {

                        var path_value = "../../DRPTopicBriefDocs/" + row.doc_path;
                        return "<a href='" + path_value + "' download>Downlod PDF</a>";

                        //return row.doc_path;
                    }
                    return 'PDF Not Available';

                }
            });
            //columns.push({
            //    "sTitle": "PDF", "mData": null, mRender: function (row) {
            //
            //        if (row.doc_path != "") {
            //            
            //            return '<center><a href="#" style="text-decoration:none;" class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
            //            
            //        }
            //        return '';
            //
            //    }
            //});

            return columns;
        }

        function set_student_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Student Code", "mData": "user_id" });
            columns.push({ "sTitle": "Student Name", "mData": "full_name" });
            columns.push({ "sTitle": "Course Code", "mData": "course_code" });
            columns.push({ "sTitle": "DRP Code", "mData": "drp_code" });
            columns.push({ "sTitle": "Faculty Name", "mData": "instructor_name" });
            columns.push({ "sTitle": "Seat Type", "mData": "seat_type" });
            columns.push({ "sTitle": "Topic Name", "mData": "topic" });
            columns.push({ "sTitle": "Abstracts", "mData": "abstracts" });
            columns.push({ "sTitle": "Reference", "mData": "reference" });
            columns.push({
                "sTitle": "PDF", "mData": null, mRender: function (row) {

                    if (row.doc_path != "") {
                        var path_value = "../../DRPTopicBriefDocs/" + row.doc_path;
                        return "<a href='" + path_value + "' download>Downlod PDF</a>";
                        // return '<center><a href="#" style="text-decoration:none;" class="proposal_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    }
                    return 'PDF Not Available';

                }
            });

            return columns;
        }

        function display_drp_detail(data) {
            var columns;
            if (status == 'S') {
                columns = set_table_columns(JSON.parse(data)[0]);
            }
            else {
                columns = set_student_table_columns(JSON.parse(data)[0]);
            }


            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                //"sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');

        }


        $(document).on("click", ".proposal_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var doc_path = aData["doc_path"];
            var path = window.location.origin;
            window.open(path + '/DRPTopicBriefDocs/' + doc_path, "_blank");
            return false;
        });

        function binddepartment() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                aSync: false,
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

        function bindprogrammedata() {

            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;DRP Details
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

                                <td>Type :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drptype">
                                    </select>
                                </td>
                                </tr>
                                <tr>
                                <td>Department
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                <td>Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
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

        <div id="div_drp_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Details</strong>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow: auto">
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

