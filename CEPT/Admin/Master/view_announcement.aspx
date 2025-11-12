<%@ Page Title="Add & View Announcement" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="view_announcement.aspx.cs" Inherits="Admin_Master_view_announcement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
      <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style type="text/css">
        .cls_is_enable
        {
            width: 65px;
        }

        .cls_disable
        {
            width: 40px;
        }

        .cls_enable
        {
            width: 40px;
        }

        .cls_date
        {
            width: 70px;
        }
        .edit_cls
        {
            width:1px;
        }
    </style>

    <script type="text/javascript">
        var oTable;
        var filter;

        $(document).ready(function () {
            get_announcement_dtl();
        });
        function get_announcement_dtl() {
            $('#DataList').css('display', 'none');

            filter = "";

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_news_announcement_dtl",
                //async: false,
                data: "{filter:'" + filter + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        display_news_announcement_dtl(data.d);
                    }
                    else {
                        bootbox.alert('No News and Announcement Found');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }
        function display_news_announcement_dtl(data) {
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
                //"oLanguage": { "sSearch": "Search all columns with Space:" },
                //"oTableTools": { "aButtons": ["print", { "sExtends": "collection", "sButtonText": 'Export', "aButtons": ["xls"] }] },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    //{
                    //    "sTitle": "Type", "mData": "type", "bSortable": false, "mRender": function (ddata) {
                    //        if (ddata == 'N') return "News";
                    //        else if (ddata == 'A') return "Announcement";
                    //    }
                    //},
                    { "sTitle": "Title", "mData": "title", "bSortable": false },
                    { "sTitle": "Description", "mData": "description", "bSortable": false },
                    {
                        "sTitle": "Date", "mData": "date", "bSortable": false, "sClass": "cls_date", "mRender": function (ddata) {
                            if (ddata != '' && ddata != undefined && ddata != null) {
                                var temp_date = new Date(ddata);
                                var str_day = '0' + temp_date.getDate().toString();
                                var str_month = '0' + (temp_date.getMonth() + 1).toString();
                                var str_date = '';
                                str_date += str_day.substring(str_day.length, (str_day.length - 2)) + '/';
                                str_date += str_month.substring(str_month.length, (str_month.length - 2)) + '/' + temp_date.getFullYear().toString();
                                return str_date;
                            }
                            else return '';
                        }
                    },
                     {
                         "sTitle": "Expiry Date", "mData": "expiry_date", "bSortable": false, "sClass": "cls_date", "mRender": function (ddata) {
                             if (ddata != '' && ddata != undefined && ddata != null) {
                                 var temp_date = new Date(ddata);
                                 var str_day = '0' + temp_date.getDate().toString();
                                 var str_month = '0' + (temp_date.getMonth() + 1).toString();
                                 var str_date = '';
                                 str_date += str_day.substring(str_day.length, (str_day.length - 2)) + '/';
                                 str_date += str_month.substring(str_month.length, (str_month.length - 2)) + '/' + temp_date.getFullYear().toString();
                                 return str_date;
                             }
                             else return '';
                         }
                     },
                     {
                         "sTitle": "View Announcement", "mData": "user_type", "bSortable": false, "sClass": "cls_date", "mRender": function (ddata) {
                             var array = ddata.split(",");
                             var str = "";
                             for (i = 0; i < array.length; i++) {
                                 if (array[i] == 'S') str += "<span style='text-align: center;'>Student</span><br/>";
                                 if (array[i] == 'I2') str += "<span style='text-align: center;'>Instructor</span><br/>";
                                 if (array[i] == 'D') str += "<span style='text-align: center;'>Dean</span><br/>";
                                 if (array[i] == 'PC') str += "<span style='text-align: center;'>Coordinator</span><br/>";
                                 if (array[i] == 'FA') str += "<span style='text-align: center;'>Faculty Admin</span><br/>";
                             }
                             return str;
                         }
                     },
                    {
                        "sTitle": "Is Enable", "mData": "cancel_flag", "bSortable": false, "sClass": "cls_is_enable", "mRender": function (ddata) {
                            if (ddata == 'N') return "<span style='text-align: center;'>Enabled</span>";
                            else if (ddata == 'Y') return "<span style='text-align: center;'>Disabled</span>";
                        }
                    },
                    {
                        "sTitle": "Disable", "mData": "cancel_flag", "bSortable": false, "sClass": "cls_disable", "mRender": function (ddata) {
                            if (ddata == 'N') return "<h3 onclick='disable_row(this)' style='text-align: center;'><a><i class='icon-remove'></i></a></h3>";
                            else if (ddata == 'Y') return "";
                        }
                    },
                    {
                        "sTitle": "Enable", "mData": "cancel_flag", "bSortable": false, "sClass": "cls_enable", "mRender": function (ddata) {
                            if (ddata == 'N') return "";
                            else if (ddata == 'Y') return "<h3 onclick='enable_row(this)' style='text-align: center;'><a><i class='icon-ok'></i></a></h3>";
                        }
                    }, {
                        "sTitle": "Edit", "mData": null, "bSortable": false, "sClass": "edit_cls", "mRender": function (doc_no) {
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

            var data = { 'doc_no': row_data["doc_no"], 'cancel_flag': 'N', 'action': 'Enable' };

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/enable_disable_news_announcement",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('Announcement Enabled Successfully');
                        $('#btn_modal_close').click();
                        $('#btn_modal_close2').click();
                        get_announcement_dtl();
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

            var data = { 'doc_no': row_data["doc_no"], 'cancel_flag': 'Y', 'action': 'Disable' };

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/enable_disable_news_announcement",
                data: "{ req_data: '" + JSON.stringify(data) + "' }",
                dataType: "json",
                success: function (data) {
                    res_data = JSON.parse(data.d);
                    if (res_data['status'] == 'True') {
                        bootbox.alert('Announcement Disabled Successfully');
                        $('#btn_modal_close').click();
                        $('#btn_modal_close2').click();
                        get_announcement_dtl();
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
        function add_announcement() {
            window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/add_announcement.aspx") %>";
        }
        function rowClick(row) {
            var rowId = oTable.fnGetData($(row).closest('tr')[0])['doc_no'];
            window.location = "add_announcement.aspx?announcement_id=" + rowId + "";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="div_news_announcement_list" class="panel panel-default">
            <div class="panel-heading">
                <strong>Announcement Details</strong>
                  <span style="float:right;">
                        <input type="button" class="btn btn-primary" value="Add Announcement" onclick="add_announcement()" style="height: 41px;width: 164px;margin-right: -15px;margin-top: -11px;"/>
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

