<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SWSFeedBackPDF.aspx.cs" Inherits="Admin_Report_WS_SWSFeedBackPDF" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <script src="../../Js_WS/SWSFeedback.js?t=01082024" type="text/javascript"></script><%--28082018--%>
   <%--//kapil--%>
     <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <script src="../../Js/jquery.base64.js"></script>
    <script src="../../Js/jquery.base64.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../Js/download-multiple-files.js"></script>
    <script src="https://rawgit.com/carlo/jquery-base64/master/jquery.base64.min.js"></script>

   <script src="../../Scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/knockout-3.0.0.js" type="text/javascript"></script>
    <script src="../../ChartJs/globalize.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/dx.chartjs.js" type="text/javascript"></script>
   <%-- <script src="../../Js/feedback_faculty_report_06062018.js" type="text/javascript"></script>--%>
    <script src="../../DesignJS/FileSaver.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.js" type="text/javascript"></script>
    <script src="https://html2canvas.hertzen.com/build/html2canvas.js"></script>
    
    
    <script src="../../Scripts/grabzit.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jspdf.min.js" type="text/javascript"></script>
    <script src="../../Scripts/svgToPdf.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://canvg.github.io/canvg/rgbcolor.js"></script>
    <script type="text/javascript" src="https://canvg.github.io/canvg/StackBlur.js"></script>
    <script type="text/javascript" src="https://canvg.github.io/canvg/canvg.js"></script>
    <script src="http://cdn.jsdelivr.net/g/filesaver.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.3.0/jszip.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip-utils/0.1.0/jszip-utils.js"></script>
    <style>
        td
        {
            padding-left: 5px;
        }
        <%--.dxc-markers circle
        {
            display: none;
        }--%>
    </style>

    <script type="text/javascript">
        var obj_typology_data = [];
        var course_code_data = [];
        var ints_code_data = [];
        var publish_data = [];

        var FileName = '';
        $(document).ready(function () {

            $('#circle').css('display', 'none');

            var dataSource = [{ name: 'Overall Rating of Course- <div style="font-weight: bold; font-size: 16px;">4.0</div>', average: parseFloat(4.0), median: parseFloat(3.5) },
            { name: 'The course met my expectations. - <div style="font-weight: bold; font-size: 16px;"><b>3.8</div>', average: parseFloat(3.8), median: parseFloat(3.2) },
            { name: 'The assignments were promptly evaluated and comments were given. - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.5) },
            { name: 'The evaluation weightage of different components /  assignments of &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <br/> course was consistent with their workload. - <div style="font-weight: bold; font-size: 16px;"><b>4.3</div>', average: parseFloat(4.3), median: parseFloat(3.5) },
            { name: 'The course was well structured. - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.4) },
            { name: 'The assignments / field visits / practicals organized as a part of the course helped to improve my understanding of the subject. - <div style="font-weight: bold; font-size: 16px;"><b>3.8</div>', average: parseFloat(3.8), median: parseFloat(3.6) },
            { name: 'The course materials (e.g. text, lecture notes, reading, etc.) were helpful in learning and understanding the content taught. - <div style="font-weight: bold; font-size: 16px;"><b>3.9</div>', average: parseFloat(3.9), median: parseFloat(3.5) },
            //{ name: 'Course outline (including schedule of classes, reading and other resources, assignments and, evaluation scheme and criteria) was provided at the beginning and explained clearly. - <div style="font-weight: bold; font-size: 16px;"><b>3.9</div>', average: parseFloat(3.9), median: parseFloat(3.7) },
            { name: 'The course achieved its stated objectives. - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.5) }];

            var series = [{ argumentField: 'name', valueField: 'average', type: 'bar', name: 'Average1', label: { visible: false, precision: 1, horizontalOffset: 40 } },
            { argumentField: 'name', name: 'Average2', valueField: 'median', type: 'scatter', label: { visible: true, precision: 1, position: 'inside' } }];

            $('#chartContainer').dxChart({
                size: { height: 300, width: 650 }, dataSource: dataSource, series: series,
                rotated: true, palette: 'Default', valueAxis: {
                    position: 'top', min: 0, max: 6, tickInterval: 1,
                    valueMarginsEnabled: false
                }, title: {
                    text: '<div style="font-weight: bold; font-size: 19px;">Course Feedback</div>',
                    font: { horizontalAlignment: 'center', opacity: 2 }, position: 'centerTop'
                },
                commonSeriesSettings: {
                    argumentField: 'state', type: 'bar', hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',
                    label: { visible: false, format: 'fixedPoint', precision: 1 }
                }, legend: { visible: false, verticalAlignment: 'bottom', horizontalAlignment: 'center' }
            });


            window.onscroll = set_svg;


            bindsemdata();
            binddepartment();
            
            //bindprogrammedata();
            bindyeardata_for_cross_reg();
            get_all_typology_group();
            bindproglevel();
            bindprogrammedata();
           
           
           
            function uploadfile() {
                 
                var getval = $('#print_data').html();

                var utf8 = [];
                for (var i = 0; i < getval.length; i++)
                {
                    var charcode = getval.charCodeAt(i);
                    if (charcode < 0x80) utf8.push(charcode);
                    else if (charcode < 0x800) {
                        utf8.push(0xc0 | (charcode >> 6),
                            0x80 | (charcode & 0x3f));
                    }
                    else if (charcode < 0xd800 || charcode >= 0xe000)
                    {
                        utf8.push(0xe0 | (charcode >> 12),
                            0x80 | ((charcode >> 6) & 0x3f),
                            0x80 | (charcode & 0x3f));
                    }
                    // surrogate pair
                    else
                    {
                        i++;
                        // UTF-16 encodes 0x10000-0x10FFFF by
                        // subtracting 0x10000 and splitting the
                        // 20 bits of 0x0-0xFFFFF into two halves
                        charcode = 0x10000 + (((charcode & 0x3ff) << 10)
                            | (getval.charCodeAt(i) & 0x3ff));
                        utf8.push(0xf0 | (charcode >> 18),
                            0x80 | ((charcode >> 12) & 0x3f),
                            0x80 | ((charcode >> 6) & 0x3f),
                            0x80 | (charcode & 0x3f));
                    }
                }

                var EncodeValue = utf8;
                //UnicodeEncoding encodingss = new UnicodeEncoding();
                //byte[] bytes = encodingss.GetBytes(getval);
                //var ss = parseInt(getval, 2).toString(10);
                //var EncodeValue = '';
                //let reverseStr = function (str) {
                //    return [...str]
                //};
                //var datastr = reverseStr(getval);

                //for (var i = 0; i < datastr.length; i++)
                //{
                //    if (i == 0)
                //    {
                //        EncodeValue = window.btoa(datastr[i]);
                //    }
                //    else
                //    {
                //        EncodeValue = EncodeValue + window.btoa(datastr[i]);
                //    }
                //    //EncodeValue = EncodeValue + window.btoa(datastr[i]);
                //}

                //var EncodeValue = window.btoa(getval);
               


               // var EncodeValue = toBinary(getval);
                //var EncodeValue = encodeURI(getval);//$.base64('encode', getval);//window.btoa(getval);//$.base64('encode', getval);
                var Filename = pdf_print_name;
                Filename = Filename.replace(/'/g, ' ');

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService_WS.asmx/SWSUploadPDFServer",
                    data: "{'EncodeValue':'" + EncodeValue + "','Filename':'" + Filename + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "")
                        {
                            if (data.d == "1") {
                                $('#btnreterive').click();
                                return false;
                            }
                            else
                            {
                                bootbox.alert(data.d);
                            }
                            return true;

                        }
                        else {
                            bootbox.alert('Fail Feedback Report PDF Download');

                           
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            }

           

            $('#btnreterive').on('click', function () {
                get_course_faculty_wise_feedback_report_for_send_pdf();
                return false;
            });

            $("#drpsemester,#drpyear,#drpdepartment ").on('change', function () {
                $('#DataList').css('display', 'none');
                return true;
            });

            $('#btncombain').on('click', function () {
                var obj_selected_course = $('.cls_chk_course_select:checked');
                if (obj_selected_course.length > 0)
                { 
                    course_code_data = [];
                    ints_code_data = [];
                    publish_data = [];
                    var course_code = ""; ;
                    var instructor_code ="" ;
                    for (var i = 0; i < obj_selected_course.length; i++)
                    {
                        var row_data = oTable.fnGetData(obj_selected_course[i].closest('tr'));

                        if (course_code == "")
                        {
                            course_code = row_data['course_code'];
                            instructor_code = row_data['instructor_code'];
                            course_code_data.push(row_data['course_code']);
                            ints_code_data.push(row_data['instructor_code']);
                        }
                        else
                        {
                            course_code = course_code + ',' + row_data['course_code'];
                            instructor_code = instructor_code + ',' + row_data['instructor_code']; 
                            course_code_data.push(row_data['course_code']);
                            ints_code_data.push(row_data['instructor_code']);
                        }
                        publish_data.push(row_data['course_code']);
                    }
                }
                else
                {
                    bootbox.alert('Please select CheckBox');
                    return false;
                }

              
                    var course_type = "";
                    var department = $('#drpdepartment').val();
                    var semester = $('#drpsemester').val();
                    var year_code = $('#drpyear').val();
                   

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/print_faculty_report_latest_rating_instructor_wise",
                        data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_type':'" + course_type + "','course_code':'" + course_code + "','dept_code':'" + department + "','selected_instructor':'" + instructor_code + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "Data Not Found") {
                                    bootbox.alert("No data found for selected course or course type");
                                    $('#print_data').html('');
                                    return false;
                                }

                                if (data.d == "Instructor") {
                                    bootbox.alert("No data found for Instructor selected course or course type");
                                    $('#print_data').html('');
                                    return false;
                                }

                                if (data.d == "Nofeedback") {
                                    bootbox.alert("No Feedback data found for selected course.");
                                    $('#print_data').html('');
                                    return false;
                                }
                                var course_data = JSON.parse(JSON.parse(data.d)["div_data"]);

                                if (JSON.parse(data.d)[1] != "") {
                                    pdf_print_name = JSON.parse(data.d)["pdf_print_name"];
                                }

                                $('#print_data').html('');

                                $('#print_data').append(course_data[0]["table"]);

                                setTimeout(function ()
                                {
                                    set_svg();
                                    $('#btnprint').click();
                                }, 2000);

                                return true;
                                
                            }
                            else {
                                bootbox.alert('No data found for selected criteria');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                //}



            });

            $('#btncombainpdf').on('click', function () {
                 
                var obj_selected_course = $('.cls_chk_course_select:checked');
                if (obj_selected_course.length > 0)
                {
                    var dep_name = "";
                    var FileName = "";
                    var sem = "";
                    var department = $('#drpdepartment').val();
                    var course_code = "";
                    var inst_name = "";
                    var course_type = "";
                    var semester = $('#drpsemester').val();
                    var status = true;
                    var year_code = $('#drpyear').val();
                    var instructor_code = "";
                    for (var i = 0; i < obj_selected_course.length; i++)
                    {
                        var row_data = oTable.fnGetData(obj_selected_course[i].closest('tr'));
                        if (semester == 'S') {
                            sem = 'Spring';
                        }
                        else {
                            sem = 'Monsoon';
                        }
                        switch (row_data["dept_name"]) {
                            case "Architecture":
                                dep_name = "FA";
                                break;
                            case "Design":
                                dep_name = "FD";
                                break;
                            case "Management":
                                dep_name = "FM";
                                break;
                            case "Planning":
                                dep_name = "FP";
                                break;
                            case "Technology":
                                dep_name = "FT";
                                break;
                            case "CEPT Foundation Program":
                                dep_name = "CFP";
                                break;
                            case "Doctoral Programs":
                                dep_name = "DP";
                                break;

                        }
                        if (status) {
                            FileName = dep_name + '_' + row_data['course_code'] + '_' + row_data['instructor_name'] + '_' + sem + '_' + $('#drpyear').val() + '.pdf';
                            status = false;
                            
                        }
                        else {
                            FileName = FileName + ',' + dep_name + '_' + row_data['course_code'] + '_' + row_data['instructor_name'] + '_' + sem + '_' + $('#drpyear').val() +'.pdf';
                            
                        }
                       
                    }
                }
                else {
                    bootbox.alert('Please select CheckBox');
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/CombinePDF",
                   // data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_type':'" + course_type + "','course_code':'" + course_code + "','dept_code':'" + department + "','selected_instructor':'" + instructor_code + "'}",
                    data: "{'FileName':'" + FileName + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "2") {
                                bootbox.alert("No Data Found");
                                return false;
                            }
                            else
                            {
                                window.open('https://connect.cept.ac.in/' + 'FeedbackPdf' + '/' + 'Feedback Report.zip');
                                bootbox.alert("Feedback PDF Download Sucessfully");
                            }

                            return true;

                        }
                        else {
                            bootbox.alert('No data found for selected criteria');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                
            });

            $('#btnprint').on('click', function () {   //set_svg();
                if (pdf_print_name == "") {
                    var mywindow = window.open('', 'Print_data', 'height=400,width=600');
                    mywindow.document.write('');
                    mywindow.document.write('<html><head><title>Print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
                    /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
                    mywindow.document.write('</head><body>');
                    mywindow.document.write($('#print_data').html());
                    mywindow.document.write('</body></html>');
                }
                else {
                    var mywindow = window.open('', pdf_print_name, 'height=400,width=600');
                    mywindow.document.write('');
                    mywindow.document.write('<html><head><title>' + pdf_print_name + '</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} </style>');
                    /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
                    mywindow.document.write('</head><body>');
                    mywindow.document.write($('#print_data').html());
                    mywindow.document.write('</body></html>');
                 
                   // download(pdf_print_name, $('#print_data').html());
                   
                }

                mywindow.print();
                mywindow.close();
                //uploadfile();
                //document.getElementsByClassName('print default')[0].click();
                return false;
            });

            $('#btnuplodserver').on('click', function ()
            {
                 
                var course_type = "";
                var department = $('#drpdepartment').val();
                var semester = $('#drpsemester').val();
                var year_code = $('#drpyear').val();
                var count = 0;
                var obj_selected_course = $('.cls_chk_course_select:checked');
                if (obj_selected_course.length > 0) {
                    course_code_data = [];
                    ints_code_data = [];
                    publish_data = [];
                    var course_code = "";;
                    var instructor_code = "";
                    for (var i = 0; i < obj_selected_course.length; i++)
                    {
                        var row_data = oTable.fnGetData(obj_selected_course[i].closest('tr'));

                        if (course_code == "") {
                            course_code = row_data['course_code'];
                            instructor_code = row_data['instructor_code'];
                            course_code_data.push(row_data['course_code']);
                            ints_code_data.push(row_data['instructor_code']);
                        }
                        else {
                            course_code = course_code + ',' + row_data['course_code'];
                            instructor_code = instructor_code + ',' + row_data['instructor_code'];
                            course_code_data.push(row_data['course_code']);
                            ints_code_data.push(row_data['instructor_code']);
                        }
                        publish_data.push(row_data['course_code']);

                        $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            //url: "../../WebService.asmx/print_faculty_report_latest_rating_instructor_wise",
                            url: "../../WebService_WS.asmx/print_faculty_report_latest_new",
                            data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_type':'" + course_type + "','course_code':'" + course_code_data[i] + "','dept_code':'" + department + "','selected_instructor':'" + ints_code_data[i] + "'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "")
                                {
                                    count++;
                                    if (data.d == "Data Not Found")
                                    {
                                       // bootbox.alert("No data found for selected course or course type");
                                        // $('#print_data').html('');
                                        return true;
                                    }
                                    //var course_data = JSON.parse(JSON.parse(data.d)["div_data"]);
                                    var course_data = JSON.parse(data.d)["div_data"]

                                    //if (JSON.parse(data.d)[1] != "")
                                    if (JSON.parse(data.d)["pdf_print_name"] != "")
                                    {
                                        pdf_print_name = JSON.parse(data.d)["pdf_print_name"];
                                    }

                                    //const indexpoint = 'div_data_0';
                                    //const namepdf = 'pdf_print_name_0';
                                    //
                                    //const parsedData = JSON.parse(data.d);
                                    //const course_data = parsedData[indexpoint];
                                    //pdf_print_name = parsedData[namepdf] || "";
                                    $('#print_data').html('');
                                    debugger;
                                    $('#print_data').append(JSON.parse(course_data)[0].table);


                                   // $('#print_data').html('');
                                   // $('#print_data').append(course_data[0]["table"]);
                                    setTimeout(function () {
                                        set_svg();
                                        uploadfile();
                                    }, 2000);
                                    if (count == i)
                                    {   //get_course_faculty_wise_feedback_report_for_send_pdf();
                                        bootbox.alert("Feedback File Sucessfully Upload Server");
                                        return false;
                                    }
                                    return true;

                                }
                                else
                                {
                                    bootbox.alert('No data found for selected criteria');
                                }
                            },
                            error: function (result) {
                                alert(result);
                            }
                        });


                    }
                }
                else
                {
                    bootbox.alert('Please select CheckBox');
                    return false;
                }
            });
//End 

            

        });

        

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="modal hide fade" id="myModal" style="left: 50%; width: 40%;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;</button>
                    <h4 class="modal-title">
                        <b>Enter Remark</b></h4>
                </div>
                <div class="modal-body">
                    <textarea class="form-control" rows="10" cols="500" id="txtRejectRemark" maxlength="10000"
                        style="width: 97%;"></textarea>
                    <asp:HiddenField ID="hdn_course" runat="server" ClientIDMode="Static" />
                     <asp:HiddenField ID="hdn_faculty_mail" runat="server" ClientIDMode="Static" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        Close</button>
                    <button id="btn_remark_submit" type="button" class="btn btn-primary" data-toggle="confirmation">
                        Submit</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
    </div>
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>SWS Course Instructor Feedback Report for send pdf file
            </h1>
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
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                             <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                            <td style="display:none;">
                               Program :
                            </td>
                            <td style="display:none;">
                                <select class="chosen-select" id="drpprog" />
                            </td>
                        </tr>
                        <tr>
                           
                            <td style="display:none;">
                               Program Level :
                            </td>
                            <td style="display:none;">
                                <select class="chosen-select" id="drpproglevel" />
                            </td>
                            
                            <td style="display:none;">
                                <label class="btn btn-primary">
                                <span><strong>Upload PDF</strong></span>
                                <input type="file" name="feedbackPDFUpload" id="feedbackPDFUpload" onchange="javascript:return UploadfeedbackPDF();" style="display: none;" />
                            </label>
                            <span id="lbl_courseimage_file_name" style="vertical-align: super;"></span>
                            </td>
                        </tr>
                        
                    </table>
                    <table>
                        <tr>
                            <td style="display:block-inline;">
                                 <button class="btn btn-primary" type="button" id="btnuplodserver">Generate PDF</button>
                            </td>
                         <%--<td style="display:block-inline;">--%>
                            <td style="display:block-inline;">
                            <button class="btn btn-primary send_feedback_pdf_mail_individual_bulk" type="button" id="mail_bulk">Mail Send </button>
                        </td>
                            <td style="display:block-inline;">
                            <button class="btn btn-primary download_pdf_bulk" type="button" id="download_pdf_bulk">Download PDF </button>
                        </td>

                         <td style="display:none;">
                            <button class="btn btn-primary" type="button" id="btncombain">Merge PDF Download </button>
                        </td>
                         <td style="display:none;">
                            <button class="btn btn-primary" type="button" id="btncombainpdf">Combine PDF Download </button>
                        </td>
                         <td style="display:none;">
                            <button class="btn btn-primary" type="button" id="btnprint">Print PDF</button>
                        </td>
                        </tr>
                    </table>

                </div>
            </div>
            <div id="DataList" style="display: none; overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

             <div id="chartContainer" class="containers" style="height: 440px; width: 100%; display:block; visibility:hidden;">
        </div>
            <div id="print_data" style="display:block;">
            <table cellpadding="0" cellspacing="0" border="0" id="tbl_lecture" class="display table table-striped table-bordered table-hover"
                width="100%">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

        </div>
        <div id="editor"></div>
    </div>
     <input type="hidden" id="filename" runat="server" clientidmode="Static" />  
</asp:Content>

