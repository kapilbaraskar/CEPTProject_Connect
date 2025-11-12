<%@ Page Language="C#" AutoEventWireup="true" CodeFile="feedbak_chart_report_for_faculty.aspx.cs"
    Inherits="Admin_Report_feedbak_chart_report_for_faculty" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">

    <title></title>
    <script src="../../Scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/knockout-3.0.0.js" type="text/javascript"></script>
    <script src="../../ChartJs/globalize.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/dx.chartjs.js" type="text/javascript"></script>
    <%--   <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />--%>
    <script type="text/javascript">

        $(document).ajaxStart(function () {

            //  alert('<%= Session["UserId"] %>');
            $("#loading").show();
        });

        $(document).ajaxStop(function () {
            $("#loading").hide();
        });

        var pdf_print_name = "";

        $(document).ready(function () {
            debugger;
            window.onscroll = set_svg;

            $('#btnprint').on('click', function () {

                if (pdf_print_name == "") {
                    var mywindow = window.open('', 'Print_data', 'height=400,width=600');
                    // mywindow.document.write('<link href=\"DesignCss/bootstrap.min.css\" rel=\"stylesheet\" />  <link href=\"DesignCss/ace.min.css\" rel=\"stylesheet\" /><link href=\"Style/dataTables.bootstrap.css\" rel=\"stylesheet\" type="text/css" />');
                    mywindow.document.write('');
                    // mywindow.document.write('<style type="text/css"> th, td, .table-bordered {border-radius: 0!important;} .table-bordered {border: 1px solid #ddd;border-collapse: separate;border-left: 0}table {border-spacing: 0;}body {padding-bottom: 0;background-color: #e4e6e9;min-height: 100%;font-family: 'Open Sans';font-size: 13px;color: #393939;} </style>');
                    //        mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} .dxc-markers circle{display:none;}</style>');
                    mywindow.document.write('<html><head><title>Print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
                    /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
                    mywindow.document.write('</head><body>');
                    mywindow.document.write($('#print_data').html());
                    mywindow.document.write('</body></html>');
                }
                else {
                    var mywindow = window.open('', pdf_print_name, 'height=400,width=600');
                    // mywindow.document.write('<link href=\"DesignCss/bootstrap.min.css\" rel=\"stylesheet\" />  <link href=\"DesignCss/ace.min.css\" rel=\"stylesheet\" /><link href=\"Style/dataTables.bootstrap.css\" rel=\"stylesheet\" type="text/css" />');
                    mywindow.document.write('');
                    // mywindow.document.write('<style type="text/css"> th, td, .table-bordered {border-radius: 0!important;} .table-bordered {border: 1px solid #ddd;border-collapse: separate;border-left: 0}table {border-spacing: 0;}body {padding-bottom: 0;background-color: #e4e6e9;min-height: 100%;font-family: 'Open Sans';font-size: 13px;color: #393939;} </style>');
                    //        mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} .dxc-markers circle{display:none;}</style>');
                    mywindow.document.write('<html><head><title>' + pdf_print_name + '</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
                    /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
                    mywindow.document.write('</head><body>');   
                    mywindow.document.write($('#print_data').html());
                    mywindow.document.write('</body></html>');
                }

                mywindow.print();
                mywindow.close();

                return false;

            });

            $('#Button1').on('click', function () {

                alert('hi');
            });

            var user_id = getParamValuesByName('user_id');
            var course_code = getParamValuesByName('course_code');
            var sem_code = getParamValuesByName('sem_code');
            var year_code = getParamValuesByName('year_code');

            if (user_id != '' && course_code != '' && sem_code != '' && year_code != '') {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/print_faculty_report_latest_from_link",

                    data: "{'year_code':'" + year_code + "','sem_code':'" + sem_code + "','course_type':'','course_code':'" + course_code + "','dept_code':'','selected_instructor':'" + user_id + "'}",
                    dataType: "json",
                    success: function (data) {


                        if (data.d != "") {
                            debugger;
                            if (data.d == "course") {

                                alert("No data found for selected course or course type");
                                $('#print_data').html('');
                                return false;
                            }

                            if (data.d == "Instructor") {

                                alert("No data found for Instructor selected course or course type");
                                $('#print_data').html('');
                                return false;
                            }

                            if (data.d == "Nofeedback") {
                                alert("No Feedback data found for selected course.");
                                $('#print_data').html('');
                                return false;
                            }

                            //var course_data = JSON.parse(data.d);

                            var course_data = JSON.parse(JSON.parse(data.d)["div_data"]);

                            if (JSON.parse(data.d)[1] != "") {
                                pdf_print_name = JSON.parse(data.d)["pdf_print_name"];
                                //   alert(pdf_print_name);

                            }


                            // alert(course_data);
                            $('#print_data').html('');


                            if (course_data[0]["message"] != '') {


                                if (course_data[0]["message"] == 1) {

                                }
                                else {

                                    alert('Feedback Calculation data is not saved in database.Some Problem of Saved Feedback calculation data in table.');
                                }
                            }
                            else {

                                alert('Feedback Calculation data is not saved in database.Some Problem of Saved Feedback calculation data in table.');
                            }

                            $('#print_data').append(course_data[0]["table"]);
                            $('#btnprint').css('display', 'block');

                            setTimeout(function () { set_svg(); $('#btnprint').click(); }, 2000);

                            return true;
                            //  display_feedback_receipt_report_course_wise(data.d);
                        }
                        else {

                            alert('No data found for selected criteria');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
                return false;
            }
            else {

                alert('Some problem in feeedback report');
                return false;
            }
        });

        function getParamValuesByName(querystring) {
            var qstring = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < qstring.length; i++) {
                var urlparam = qstring[i].split('=');
                if (urlparam[0] == querystring) {
                    return urlparam[1];
                }
            }
        }

        function set_svg() {


            $('.instructor .dxc-labels-group rect').attr('x', '955');
            $('.instructor .dxc-labels-group text tspan').attr('x', '970');

            var data = $('.course .dxc-h-axis .dxc-elements');
            var str = '';
            for (var i = 0; i < data.length; i++) {

                //data[i].firstElementChild.style.display = 'none';

                //data[i].lastElementChild.style.display = 'none';
                data[i].lastElementChild.previousSibling.setAttribute('x', '945');
                data[i].lastElementChild.setAttribute('x', '1000');
                data[i].lastElementChild.previousSibling.innerHTML = '<tspan x="945" y="30">COR</tspan><tspan x="945" y="49">AVG</tspan>';
                data[i].lastElementChild.innerHTML = '<tspan x="1000" y="30">FAC</tspan><tspan x="1000" y="49">AVG</tspan>';

                //str = data[i].innerHTML;
                //str = str + "<text x='1040' y='30' text-anchor='middle' transform='rotate(0,1098,49)' style='fill: rgb(0, 0, 0); font-family: 'Segoe UI', 'Helvetica Neue', 'Trebuchet MS', Verdana; font-weight: 400; font-size: 12px; cursor: default;'>FAC</text>";
            }

            data = $('.instructor .dxc-h-axis .dxc-elements');
            for (var i = 0; i < data.length; i++) {

                //data[i].firstElementChild.style.display = 'none';

                //data[i].lastElementChild.style.display = 'none';

                data[i].lastElementChild.previousSibling.setAttribute('x', '945');
                data[i].lastElementChild.setAttribute('x', '1000');
                data[i].lastElementChild.previousSibling.innerHTML = '<tspan x="945" y="30">IND</tspan><tspan x="945" y="49">AVG</tspan>';
                data[i].lastElementChild.innerHTML = '<tspan x="1000" y="30">FAC</tspan><tspan x="1000" y="49">AVG</tspan>';
            }

            data = $('.course .dxc-h-axis .dxc-grid');
            for (var i = 0; i < data.length; i++) {

                data[i].lastElementChild.style.display = 'none';
                data[i].lastElementChild.previousSibling.style.display = 'none';
            }

            data = $('.instructor .dxc-h-axis .dxc-grid');
            for (var i = 0; i < data.length; i++) {

                data[i].lastElementChild.style.display = 'none';
                data[i].lastElementChild.previousSibling.style.display = 'none';
            }

            $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text').attr('text-anchor', 'inherit');

            data = $('.course .dxc-axes-group .dxc-v-axis .dxc-elements tspan');
            for (var i = 0; i < data.length; i++) {

                if (data[i].innerHTML.length == 3) {
                    data[i].setAttribute('x', '935');

                    data[i].setAttribute('fill', '#85A9B1');
                }
                else if (data[i].innerHTML.length > 3) {
                    data[i].setAttribute('x', '0');
                }
            }

            data = $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text');

            for (var i = 0; i < data.length; i++) {
                if (data[i].children.length > 3) {
                    data[i].children[data[i].children.length - 1].setAttribute('dy', '-12');
                }
            }

            $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text').attr('text-anchor', 'inherit');

            data = $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements tspan');
            for (var i = 0; i < data.length; i++) {

                if (data[i].innerHTML.length == 3) {
                    data[i].setAttribute('x', '935');

                    data[i].setAttribute('fill', '#266473');
                }
                else if (data[i].innerHTML.length > 3) {
                    data[i].setAttribute('x', '0');
                }
            }

            data = $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text');

            for (var i = 0; i < data.length; i++) {
                if (data[i].children.length > 3) {
                    data[i].children[data[i].children.length - 1].setAttribute('dy', '-12');

                }

            }

            $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text').css("fill", "black");
            $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text').css("fill", "black");


            //    $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text').css("font-size", "13px");
            //    $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text').css("font-size", "13px");

            $('.course .dxc-axes-group .dxc-h-axis .dxc-elements text').css("fill", "black");
            $('.instructor .dxc-axes-group .dxc-h-axis .dxc-elements text').css("fill", "black");

            $('.course .dxc-labels-group text tspan').css("font-weight", "bold");
            $('.course .dxc-labels-group text tspan').css("font-size", "15px");

            $('.instructor .dxc-labels-group text tspan').css("font-weight", "bold");
            $('.instructor .dxc-labels-group text tspan').css("font-size", "15px");

            $('.course .dxc-labels-group rect').attr('x', '955');
            $('.course .dxc-labels-group text tspan').attr('x', '970');

            data = $('.course .dxc-series-group');
            for (var i = 0; i < data[0].children[0].children[1].children.length; i++) {
                data[0].children[0].children[1].children[i].setAttribute('fill', '#85A9B1');
            }
            //    $('.course .dxc-series-group .dxc-series .dxc-markers').attr('fill', '#85A9B1');
            $('.course .dxc-trackers .dxc-markers-trackers').attr('display', 'none');
            debugger;
            data = $('.instructor .dxc-labels-group');
            for (var i = 0; i < data.length; i++) {

                data[i].children[0].style.display = 'none';
            }

            data = $('#print_data').children().last();

            data.css('page-break-after','avoid');
            //  $('.instructor .dxc-labels-group .dxc-series-labels')[0].style.display = 'none';
        }

    </script>
   
<body>
    <form id="form1" runat="server">
   
            <div class="row-fluid" style="font-size: 13px; font-family: 'Open Sans'; width: 1060px; margin-left:150px;">
                <div>
                    <table style="float:right;" border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                <button style="display: none;" class="btn btn-primary" type="button" id="btnprint">
                                    Print
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="chartContainer" class="containers" style="height: 50px; width: 100%;">
                </div>
                <div id="print_data" style="display: block">
                    <table cellpadding="0" cellspacing="0" border="0" id="tbl_lecture" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
    
    </form>
    <div id="loading" class="ajax-loading" style="height: 100%; width: 100%; vertical-align: middle;
        text-align: center">
        <img src='<%= Page.ResolveClientUrl("~/image/301 (2).gif") %>' style="margin-top: 25%"
            alt="Loading please wait......" />
    </div>
</body>
</html>
