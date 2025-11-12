<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="student_wise_smartcard_dtl.aspx.cs" Inherits="Admin_Report_student_wise_smartcard_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

    <script type="text/javascript">
        // const { type } = require("jquery");
        // const { type } = require("jquery");

        var semester = '';
        var year_code = '';
        var oTable;
        var oTable1;
        var oTable2;
        var user_type = '';
        var dept_code_ = '';
        var prog_level = '';
        var studio_level = '';

        $(document).ready(function () {
            user_type = $('#hdn_user_type').val();
            bindtypedata();
            bindsemdata();
            bindprogrammedata();
            binddepartment();
            bindyeardata();
            //get_studio_detail();
            $('#btnreterive').on('click', function () {

                get_studio_detail();
                return false;
            });
        });

        function rowClick_approve(row, status) {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Smartcard_accept_reject",
                    data: "{doc_no:'" + row.id + "',status:'" + status + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true")
                            {
                                if (status == "R") {
                                    bootbox.alert("Rejected successfully");
                                }
                                else if (status == "A") {
                                    bootbox.alert("Approved successfully");
                                }   
                                get_studio_detail();
                            }
                            else {
                                bootbox.alert('Problem in Data');
                            }
                        }
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }

        function get_studio_detail() {
            debugger;
            var type = $('#drptype').val();
            var prog_code = $('#drpprog').val();
            var dept_code = $('#drpdepartment').val();
            var year_semester = $('#drp_year_semester').val();
            var semester_type = $('#drpsemester').val();
            

            $('#DataList').css('display', 'none');

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Student_wise_smartcard_dtl",
                    data: "{semester_type:'" + semester_type + "',year_semester:'" + year_semester + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',status:'" + type + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != "[]") {
                            display_studio_proposal_detail(data.d);
                            $('#div_studio_proposal_dtl').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function display_studio_proposal_detail(data) {
            var columns = [
                { "sTitle": "Sr No", "mData": "doc_no", "sClass": "cls_hide" },
                { "sTitle": "Student Code", "mData": "user_id" },
                { "sTitle": "Student Name", "mData": "full_name" },
                { "sTitle": "Email Id", "mData": "mail" },
                {
                    "sTitle": "Date of Birth", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.dob != "") {
                            return data.dob;
                        }
                        else { return ''; }


                    }
                },
                {
                    "sTitle": "Blood Group", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.blood_group != "") {
                            return data.blood_group;
                        }
                        else { return ''; }


                    }
                },

                {
                    "sTitle": "Address", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.address != "") {
                            return data.address;
                        }
                        else { return ''; }


                    }
                },

                {
                    "sTitle": "Emergency Contact No", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.emergency_contact_2 != "") {
                            return data.emergency_contact_2;
                        }
                        else { return ''; }


                    }
                },


                {
                    "sTitle": "Department Name", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.dept_name != "") {
                            return data.dept_name;
                        }
                        else { return ''; }


                    }
                },

                {
                    "sTitle": "Program Name", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.prog_name != "") {
                            return data.prog_name;
                        }
                        else { return ''; }


                    }
                },

                {
                    "sTitle": "Amount", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.amount != "") {
                            return data.amount;
                        }
                        else { return ''; }


                    }
                },
                { "sTitle": "Semester Type", "mData": "semester_type" },
                { "sTitle": "year Semester", "mData": "year_semester" },
                
                {
                    "sTitle": "Approve", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.status == "N" || data.status == "R") {
                            var rej = 'A';
                            return '<center><button type="button" id=' + data.doc_no + ' onclick="rowClick_approve(this,\'' + rej + '\')">Approve</button></center>';
                        }
                        else if (data.status == "A") {
                            return "<center>Approved</center>";
                        }
                        return '';
                    }
                },

                {
                    "sTitle": "Reject", "mData": null, "bSortable": false, mRender: function (data) {
                        var rej = 'R';
                        if (data.status != "R") {
                            return '<center><button type="button" id=' + data.doc_no + ' onclick="rowClick_approve(this,\'' + rej + '\')">Reject</button></center>';
                        }
                        else { return '<center>Rejected</center>'; }


                    }
                }

            ];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');
            $('#example thead tr')[0].children[0].style.display = 'none';
            $("#example tbody tr").each(function (i) {
                $('#example tbody tr')[i].children[0].style.display = 'none';

            });
        }


        function bindtypedata() {

            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("A").html("Approved"));
            $('#drptype').append($("<option></option>").val("R").html("Rejected"));
            $('#drptype').append($("<option></option>").val("N").html("Pending"));

            $('#drptype').chosen();

        }

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();
        }
        function bindyeardata() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        $('#drp_year_semester').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                            $('#drp_year_semester').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear').chosen();
                        $('#drp_year_semester').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

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
                <i class="icon-desktop"></i><span id="title_name">Student Smart Card Detail </span>
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
                                <td>Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester" />
                                </td>
                                <td>Year Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drp_year_semester">
                                    </select>
                                </td>
                                <td>Department
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                            </tr>
                            <tr>
                                <td>Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>Type :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drptype">
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

        <div id="div_studio_proposal_dtl" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">Student Smart Card Detail</strong>
            </div>
            <div id="DataList" style="display: none;overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>


        </div>

    </div>
    <asp:HiddenField ID="hdn_user_type" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_student_id" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_designation_type" runat="server" ClientIDMode="Static" />
    <div id="ifrm_outline" style="display: none;"></div>
</asp:Content>

