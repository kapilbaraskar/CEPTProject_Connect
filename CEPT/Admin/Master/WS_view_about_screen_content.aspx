<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_view_about_screen_content.aspx.cs" Inherits="Admin_Master_WS_view_about_screen_content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style type="text/css">
        .cls_is_enable {
            width: 65px;
        }

        .cls_disable {
            width: 40px;
        }

        .cls_enable {
            width: 40px;
        }

        .cls_date {
            width: 70px;
        }

        .edit_cls {
            width: 1px;
        }

        .type_style {
            width: 8% !important;
        }
    </style>

    <script type="text/javascript">
        var oTable;
        var filter;

        $(document).ready(function () {
            get_about_dtl();
        });
        function get_about_dtl() {
            $('#DataList').css('display', 'none');

            id = "";

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_about_screen_content",
                    //async: false,
                    data: "{id:'" + id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            display_news_announcement_dtl(data.d);
                        }
                        else {
                            bootbox.alert('No About Content Found');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function display_news_announcement_dtl(data) {
            debugger;
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                //"sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //   "oLanguage": { "sSearch": "Search all columns with Space:" },
                // "oTableTools": { "aButtons": ["print", { "sExtends": "collection", "sButtonText": 'Export', "aButtons": ["xls"] }] },
                "aaData": JSON.parse(data),
                "aoColumns": [

                    {
                        "sTitle": "Type", "mData": "type", "bSortable": false, "sClass": "type_style", "mRender": function (ddata) {
                            if (ddata == 'pdf') return "<span style='text-align: center;'>PDF</span>";
                            else if (ddata == 'text') return "<span style='text-align: center;'>Textual</span>";
                        }
                    },
                    { "sTitle": "Title", "mData": "title", "bSortable": false },
                    { "sTitle": "Position", "mData": "position", "bSortable": false, "sClass": "cls_is_enable" },
                    {
                        "sTitle": "Status", "mData": "status", "bSortable": false, "sClass": "cls_is_enable", "mRender": function (ddata) {
                            if (ddata == 'N') return "<span style='text-align: center;'>Enabled</span>";
                            else if (ddata == 'Y') return "<span style='text-align: center;'>Disabled</span>";
                        }
                    },
                    {
                        "sTitle": "Enable", "mData": "status", "bSortable": false, "sClass": "cls_enable", "mRender": function (ddata) {
                            if (ddata == 'N') return "";
                            else if (ddata == 'Y') return "<h3 onclick='enable_row(this)' style='text-align: center;'><a><i class='icon-ok'></i></a></h3>";
                        }
                    },
                    {
                        "sTitle": "Disable", "mData": "status", "bSortable": false, "sClass": "cls_disable", "mRender": function (ddata) {
                            if (ddata == 'N') return "<h3 onclick='disable_row(this)' style='text-align: center;'><a><i class='icon-remove'></i></a></h3>";
                            else if (ddata == 'Y') return "";
                        }
                    },
                    {
                        "sTitle": "Edit", "mData": null, "bSortable": false, "sClass": "edit_cls", "mRender": function (id) {
                            return '<center><button type="button" onclick="rowClick(this)" >Edit</button></center>';
                        }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
        function enable_row(cur_ele) {
            var row = $(cur_ele).closest('tr');

            var row_data = oTable.fnGetData(row[0]);

            var data = { 'id': row_data["id"], 'status': 'N', 'action': 'Enable' };

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/enable_disable_about_content",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('About Content Enabled Successfully');
                        $('#btn_modal_close').click();
                        $('#btn_modal_close2').click();
                        get_about_dtl();
                    }
                    else if (res_data == "False") {
                        alert(res_data);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function disable_row(cur_ele) {
            var row = $(cur_ele).closest('tr');

            var row_data = oTable.fnGetData(row[0]);

            var data = { 'id': row_data["id"], 'status': 'Y', 'action': 'Disable' };

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/enable_disable_about_content",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('About Content Disabled Successfully');
                        $('#btn_modal_close').click();
                        $('#btn_modal_close2').click();
                        get_about_dtl();
                    }
                    else if (res_data == "False") {
                        alert(res_data);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function add_about_content() {
            window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/WS_modify_about_screen_content.aspx") %>";
        }
        function rowClick(row) {
            var rowId = oTable.fnGetData($(row).closest('tr')[0])['id'];
            window.location = "WS_modify_about_screen_content.aspx?id=" + rowId + "";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="div_news_announcement_list" class="panel panel-default">
        <div class="panel-heading">
            <strong>About Content Details</strong>
            <span style="float: right;">
                <input type="button" class="btn btn-primary" value="Add About Content" onclick="add_about_content()" style="height: 41px; width: 164px; margin-right: -15px; margin-top: -11px;" />
            </span>
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
</asp:Content>

