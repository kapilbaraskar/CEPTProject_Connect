<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="New_User_dtl.aspx.cs" Inherits="Admin_Master_New_User_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            get_user_dtl();


            $('#btnadd').on('click', function () {
                window.open("create_new_user_admin_side.aspx?c=N", "_blank");
                return false;
            });

            return false;
        });

        function rowClick(row) {
            var data_value = row.id;
            var origin = window.location.origin;
            //window.open("Edit_Installment_dtl.aspx?c=" + data_value[0] + "&i=" + data_value[1] + "&s=" + sem_code + "&y=" + year_code, "_blank");
            window.open("create_new_user_admin_side.aspx?c=E&i=" + data_value, "_blank");
        }
        function get_user_dtl() {
            $('#DataList').css('display', 'none');

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_save_user_dtl",
                data: "{user_id: ''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        Bind_user_dtl(data.d);
                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


        function Bind_user_dtl(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Faculty Id", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Faculty Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Email Id", "mData": "mail", "bSortable": false },
                    { "sTitle": "Gender", "mData": "gender", "bSortable": false },
                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                            return '<center><button type="button" id=' + data.user_id + ' onclick="rowClick(this)">Edit</button></center>';
                        }
                    }
                    //{ "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    //{ "sTitle": "Program Name", "mData": "ProgramName", "bSortable": false },
                    //{ "sTitle": "Program Level Name", "mData": "prog_level_name", "bSortable": false }
                ]
            });
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; New User Details
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Create New User</strong>
            </div>

            <div>
                 <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnadd">
                                Add New User
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="DataList" class="panel panel-default" style="display: none; margin-bottom: 40px;">
            <div class="panel-heading">
                <strong id="panel_head">New User Details</strong>
            </div>

            <div>
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

