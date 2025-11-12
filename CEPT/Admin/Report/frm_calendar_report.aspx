<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="frm_calendar_report.aspx.cs" Inherits="Admin_Report_frm_calendar_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/comman.js" type="text/javascript"></script>
    <script type="text/javascript">
        var oTable;

        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindsemdata();

            $('#btnreterive').on('click', function () {

                get_data();

                return false;

            });

            $('#btn_print').on('click', function () {

                window.open('popup_calendar_report.aspx?sem_code=' + $('#drpsemester').val() + '&year_code=' + $('#drpyear').val() , 'PrintMe', 'height=500px,width=700px,scrollbars=1');

//                var mywindow = window.open('', 'Print_data', 'height=400,width=600');
//                // mywindow.document.write('<link href=\"DesignCss/bootstrap.min.css\" rel=\"stylesheet\" />  <link href=\"DesignCss/ace.min.css\" rel=\"stylesheet\" /><link href=\"Style/dataTables.bootstrap.css\" rel=\"stylesheet\" type="text/css" />');
//                mywindow.document.write('');
//                // mywindow.document.write('<style type="text/css"> th, td, .table-bordered {border-radius: 0!important;} .table-bordered {border: 1px solid #ddd;border-collapse: separate;border-left: 0}table {border-spacing: 0;}body {padding-bottom: 0;background-color: #e4e6e9;min-height: 100%;font-family: 'Open Sans';font-size: 13px;color: #393939;} </style>');
//                //        mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} .dxc-markers circle{display:none;}</style>');
//                mywindow.document.write('<html><head><title>Print_data</title>  ');
//                /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
//                mywindow.document.write('</head><body><style>.panel{ margin-bottom: 20px;border: 1px solid transparent; border-radius: 4px; } .table-striped tbody>tr:nth-child(odd)>td, .table-striped tbody>tr:nth-child(odd)>th {background-color: #f9f9f9;} </style>');
//                mywindow.document.write($('#div_print').html());
//                mywindow.document.write('</body></html>');

//                               mywindow.print();
//                //                mywindow.close();

                return false;

            });

            return false;

        });


        function get_data() {

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

            var sem_name = "";

            if (semester == "S") {
                sem_name = "Spring"
            }
            else {
                sem_name = "Monsoon";
            }

            $('#lbl_current_sem').text(sem_name + "-" + $('#drpyear').val());


            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_current_sem_dates",
                async: false,
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
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
                //async: false,
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Calendar Report
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
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btn_print">
                                        Print
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
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
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
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
    </div>
</asp:Content>
