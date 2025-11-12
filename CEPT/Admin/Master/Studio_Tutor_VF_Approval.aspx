<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Studio_Tutor_VF_Approval.aspx.cs" Inherits="Admin_Master_Studio_Tutor_VF_Approval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var oTable;
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                get_temp_user_detail();
                return false;
            });
        });

        function rowClick_save(row,user_id)
        {
            var select_value = '';
            var values_user = $('#' + user_id + ' option:selected').val();
            if (values_user != '0') {
                select_value = row.id + '_' + values_user;
                
            }
            else {
                bootbox.alert('Please select User Type');
                return false;
            }
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
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_studio_user_type",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',detalis:'" + select_value + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "Update Data") {
                                bootbox.alert("Designation Updated Successfully.");
                                get_temp_user_detail();
                            }
                        }
                        else {
                            bootbox.alert('Problem in Update Designation.');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }
        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

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
        function get_temp_user_detail() {
            $('#DataList').css('display', 'none');

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
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_studio_tutor_vf_approval_dtl",
                    data: "{semester:'" + semester + "',year:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            display_studio_vf_detail(data.d);
                            $('#div_studio_vf_dtl').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function display_studio_vf_detail(data) {
            var columns = [

                { "sTitle": "Instructor Code", "mData": "instructor_code" },
                { "sTitle": "Name", "mData": "instructor_name" },
                { "sTitle": "Email id", "mData": "mail" },
                {
                    "sTitle": "Designation", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.user_id != "") {
                            var listItems = '<select id="' + data.user_id + '">';
                            listItems += "<option value='0'>Select User Type</option>";
                            listItems += "<option value='VF'>VF</option>";
                            listItems += "<option value='TA'>TA</option>";
                            listItems += "<option value='AA'>AA</option>";
                            listItems += '</select>';
                            return listItems;

                        }
                        else return '';
                    }
                },
                {
                    "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                                 //(this, \'' + data.semester_type + '\',\'' + data.year_semester + '\');
                        var details = data.instructor_code + "_" + data.first_name + "_" + data.last_name + "_" + data.mail ;
                        return '<center><button type="button" id=' + details + ' onclick="rowClick_save(this,\'' + data.user_id + '\')">Update</button></center>';

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
        }


    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Studio Tutor VF Approval
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
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_studio_vf_dtl" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">Studio Tutor VF Approval</strong>
            </div>
            <div id="DataList" style="display: none;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

        </div>

    </div>

</asp:Content>

