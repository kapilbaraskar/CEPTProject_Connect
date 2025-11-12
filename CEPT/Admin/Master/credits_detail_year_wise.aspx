<%@ Page Title="Credits Detail Year Wise" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="credits_detail_year_wise.aspx.cs" Inherits="Admin_Master_credits_detail_year_wise" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        var asInitVals = new Array();

        $(document).ready(function () {
            get_credit_detail_year_wise();
        });

        function get_credit_detail_year_wise() {
            $('#DataList').css('display', 'none');

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_credit_detail_year_wise",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]') {
                        display_credit_detail_year_wise(data.d);
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }

        function display_credit_detail_year_wise(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
				//        "print",
            	//        {
            	//            "sExtends": "collection",
            	//            "sButtonText": 'Export',
            	//            "aButtons": ["xls"]
            	//        }
                //    ]
                //},
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Year Code", "mData": "year_code", "bSortable": false, "mRender": function (year_code) {
                        if (year_code == 'Y1') return 'Y2013';
                        else return year_code;
                    }
                    },
                    //{ "sTitle": "Department", "mData": "dept_code", "bSortable": false },
                    { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
                    //{ "sTitle": "Program", "mData": "prog_code", "bSortable": false },
                    { "sTitle": "Program", "mData": "prog_name", "bSortable": false },
                    //{ "sTitle": "Program Level", "mData": "prog_level_code", "bSortable": false },
                    { "sTitle": "Program Level", "mData": "prog_level_desc", "bSortable": false },
                    { "sTitle": "Total Credits", "mData": "total_credits", "bSortable": false },
                    { "sTitle": "Mandatory Credits", "mData": "mandatory_credits", "bSortable": false },
                    { "sTitle": "Elective Credits", "mData": "elective_credits", "bSortable": false },
                    { "sTitle": "SWS Credits", "mData": "sws_credits", "bSortable": false },
                    { "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
                        return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                    }
                    }
                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            //$("#example tr:nth-child(2) th").length (Remove because of Edit)
            for (var i = 0; i < 8; i++) {
                var title = $('#example thead th').eq(i).text();
                $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            };

            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("thead input").index(this));
            });

            $("thead input").each(function (i) {
                asInitVals[i] = this.value;
            });

            $("thead input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("thead input").index(this)];
                }
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function rowClick(row) {
            var year = oTable.fnGetData($(row).closest('tr')[0])['year_code'];
            var prog = oTable.fnGetData($(row).closest('tr')[0])['prog_code'];
            var dept = oTable.fnGetData($(row).closest('tr')[0])['dept_code'];
            var prog_level = oTable.fnGetData($(row).closest('tr')[0])['prog_level_code'];

            window.location = "credits_detail_year_wise_edit.aspx?y=" + year + "&p=" + prog + "&d=" + dept + "&pl=" + prog_level;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid" style="margin-top:10px;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Credits Detail Year Wise
            </h1>
        </div>
    </div>

    <div id="pnl_choose_credits" class="panel panel-default" style="margin-bottom:50px;">
        <div class="panel-heading">
            <strong>Credits Detail</strong>

            <div style="float:right;margin-top: -6px;">
                <input type="button" id="btn_add_new" value="Add New" class="btn btn-primary btn-small" onclick="location.href='credits_detail_year_wise_edit.aspx';" />
            </div>
        </div>
        
        <div id="DataList" style="display: none; overflow: auto;clear:both;">
            <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>

