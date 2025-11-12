<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_calendar_report.aspx.cs"
    Inherits="Admin_Report_popup_calendar_report" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../DesignJS/jquery.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>
    <link href="../../DesignCss/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../../DesignCss/ace.min.css" rel="stylesheet" type="text/css" />
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var oTable;

        var sem_code = "";
        var year_code = "";
        var start_date = "";
        var end_date = "";

        $(document).ready(function () {

            sem_code = getParameterByName('sem_code');
            year_code = getParameterByName('year_code');
//          start_date = getParameterByName('start_date');
//          end_date = getParameterByName('end_date');

            get_data();

            window.print();
        
        });

        function get_data() {

            $('#DataList').css('display', 'none');

            var sem_name = "";

            if (sem_code == "S") {
                sem_name = "Spring"
            }
            else {
                sem_name = "Monsoon";
            }

            $('#lbl_current_sem').text(sem_name + "-" + year_code);


            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_current_sem_dates",
                async: false,
                data: "{sem_code:'" + sem_code + "',year_code:'" + year_code + "'}",
                dataType: "json",
                success: function (data) {

                    debugger;
                    if (data.d != "" && data.d != "[]") {

                        var cal_data = JSON.parse(data.d);

                        var st_date = new Date(cal_data[0]["start_date"]);

                        $('#lbl_start_date').text(st_date.getDate() + '/' + (st_date.getMonth() + 1) + '/' + st_date.getFullYear());

                        var end_date = new Date(cal_data[0]["end_date"]);

                        $('#lbl_end_date').text(end_date.getDate() + '/' + (end_date.getMonth() + 1) + '/' + end_date.getFullYear());
                    }
                    else {
                        $('#lbl_start_date').text('');
                        $('#lbl_end_date').text('');
                        bootbox.alert('Semester start date and end date not found.');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_calendare_report_data",
                async: false,
                data: "{sem_code:'" + sem_code + "',year_code:'" + year_code + "'}",
                dataType: "json",
                success: function (data) {

                    debugger;
                    if (data.d != "" && data.d != "[]") {

                        display_data(data.d);

                        var cal_data = JSON.parse(data.d);


                        $('#div_print_data').css('display', 'block');
                    }
                    else {

                        bootbox.alert('No data Found For Selected Semester and Year');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;


        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function set_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Event", "mData": "event_name" });
            columns.push({ "sTitle": "Hrs/Semester", "mData": "total" });
            //  columns.push({ "sTitle": "Total Week", "mData": "total_sem_week" });

            return columns;
        }

        function display_data(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody> <tfoot> <tr><th>Total:</th><th style="text-align: left"></th> </tr></tfoot></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //  "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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
                "fnFooterCallback": function (nRow, aaData, iStart, iEnd,
       aiDisplay) {

                    debugger;
                    var iTotalNuma = 0;

                    if (aaData.length > 0) {
                        for (var i = 0; i < aaData.length; i++) {
                            iTotalNuma += parseFloat(aaData[i].total);

                        }
                    }
                    /*
                    * render the total row in table footer
                    */
                    var nCells = $('#example tfoot tr th');

                    //            var nCells = nRow.getElementsByTagName("th");
                    nCells[1].innerHTML = iTotalNuma;


                },

                "aoColumns": columns
            });

            $('#DataList').css('display', 'block');
        }
    </script>
</head>
<body>
    <div id="div_print">
            <div id="div_print_data" class="panel panel-default" style="display: none;">
                <%--<div class="panel-heading">
                <strong>Course Result Detail</strong>
            </div>--%>
                <%--class="panel-body"--%>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                            Semester :
                        </td>
                        <td>
                            <label style="color: Red;" id="lbl_current_sem">
                            </label>
                        </td>
                        <td>
                            Start Date :
                        </td>
                        <td>
                            <label style="color: Red;" id="lbl_start_date">
                            </label>
                        </td>
                        <td>
                            End Date :
                        </td>
                        <td>
                            <label style="color: Red;" id="lbl_end_date">
                            </label>
                        </td>
                    </tr>
                </table>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" style="margin-left :9px;" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="98%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th>
                                    Total:
                                </th>
                                <th style="text-align: left">
                                </th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
</body>
</html>
