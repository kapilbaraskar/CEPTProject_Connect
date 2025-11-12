<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="StudentList.aspx.cs" Inherits="Admin_Master_StudentList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        var asInitVals = new Array();
        $(document).ready(function () {
            //if (getParameterByName("param") == "true" && $('#hdn_msg').val() != '') {
            //    bootbox.alert($('#hdn_msg').val(), function () {
            //        location.replace('Home.aspx');
            //    });
            //}
            var url_dtl = getUrlVars();
            if (url_dtl["i"] != null && url_dtl["i"] != undefined && url_dtl["i"] != "") {
               

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_student_course_data_for_admin_dashboard",
                        async: true,
                        data: "{course_code : '" + url_dtl["i"] + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                display_student_dtl(data.d);
                                //$('#DataList1').css('display', 'block');
                            }
                            else {
                                //display_student_dtl_empty();
                            }

                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                return false;

            }

            if (url_dtl["w"] != null && url_dtl["w"] != undefined && url_dtl["w"] != "") {


                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/ws_get_student_course_data_for_admin_dashboard",
                        async: true,
                        data: "{course_code : '" + url_dtl["w"] + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                display_student_dtl(data.d);
                                //$('#DataList1').css('display', 'block');
                            }
                            else {
                                //display_student_dtl_empty();
                            }

                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                return false;

            }
        });

        function display_student_dtl(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 60,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },


                "aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Email", "mData": "mail", "bSortable": false },
                    { "sTitle": "Phone no", "mData": "mobile_no", "bSortable": false },
                    { "sTitle": "Selection Type", "mData": "studio_type", "bSortable": false }


                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            //$("#example tr:nth-child(2) th").length (Remove because of Download)
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {

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

            //$('#example_wrapper').css('overflow', 'auto');

            $('#DataList1').css('display', 'block');
            $('#student_view_list').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
        function display_student_dtl_ws(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 60,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },


                "aaData": JSON.parse(data),
                "aoColumns": [

                   
                    { "sTitle": "Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Email", "mData": "mail", "bSortable": false },
                    { "sTitle": "Phone no", "mData": "mobile_no", "bSortable": false }


                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            //$("#example tr:nth-child(2) th").length (Remove because of Download)
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {

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

            //$('#example_wrapper').css('overflow', 'auto');

            $('#DataList1').css('display', 'block');
            $('#student_view_list').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
       <div id="student_view_list" style="display: block">
            <div style="background-color: White;">
                <div class="panel panel-default ">
                    <div class="panel-heading">
                        <strong>Student Details</strong>
                    </div>

                    <div id="DataList1" style="display: none">
                        <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <div id="DataList2" style="display: none">
                        <table cellpadding="0" cellspacing="0" border="0" id="ws_example" class="display table table-striped table-bordered table-hover"
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

