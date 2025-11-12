
var pdf_print_name = "";

$(document).ready(function () {

    $('#circle').css('display', 'none');

    var dataSource = [{ name: 'Overall Rating of Course- <div style="font-weight: bold; font-size: 16px;">4.0</div>', average: parseFloat(4.0), median: parseFloat(3.5) },
    { name: 'The course met my expectations. - <div style="font-weight: bold; font-size: 16px;"><b>3.8</div>', average: parseFloat(3.8), median: parseFloat(3.2) },
    { name: 'The assignments were promptly evaluated and comments were given. - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.5) },
    { name: 'The evaluation weightage of different components /  assignments of &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <br/> course was consistent with their workload. - <div style="font-weight: bold; font-size: 16px;"><b>4.3</div>', average: parseFloat(4.3), median: parseFloat(3.5) },
    { name: 'The course was well structured. - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.4) },
    { name: 'The assignments / field visits / practicals organized as a part of the course helped to improve my understanding of the subject. - <div style="font-weight: bold; font-size: 16px;"><b>3.8</div>', average: parseFloat(3.8), median: parseFloat(3.6) },
    { name: 'The course materials (e.g. text, lecture notes, reading, etc.) were helpful in learning and understanding the content taught. - <div style="font-weight: bold; font-size: 16px;"><b>3.9</div>', average: parseFloat(3.9), median: parseFloat(3.5) },
    //         { name: 'Course outline (including schedule of classes, reading and other resources, assignments and, evaluation scheme and criteria) was provided at the beginning and explained clearly. - <div style="font-weight: bold; font-size: 16px;"><b>3.9</div>', average: parseFloat(3.9), median: parseFloat(3.7) },
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


    //            var dataSource = [{ name: 'Overall Rating of Course- <b >4.3</b>', average: parseFloat(4.3), median: parseFloat(4.75) },
    //            { name: 'Over all Sessions were logically presented-<b>4.3</b>', average: parseFloat(4.3), median: parseFloat(5) },
    //            { name: 'Significant efforts for the course required-4.3', average: parseFloat(4.3), median: parseFloat(4.5) },
    //             { name: 'The assignments helped in consolidated understanding-4.5', average: parseFloat(4.5),
    //                 median: parseFloat(4.5)
    //             }, { name: 'The course material were helpful-4.3', average: parseFloat(4.3), median: parseFloat(4.5) },
    //               { name: 'Expectations of the course fulfilled-4.2', average: parseFloat(4.2), median: parseFloat(4) },
    //               { name: 'Cours achieved its objectives- <div style="font-weight: bold; font-size: 16px; background-color: aqua;height: 15px;width: 15px;">4.2</div>', average: parseFloat(4), median: parseFloat(4)}];
    //            var series = [{ argumentField: 'name', valueField: 'average', type: 'bar', label: { visible: false, precision: 1, horizontalOffset: 40} },
    //                { argumentField: 'name', valueField: 'median', type: 'scatter', label: { visible: true, precision: 1, position: 'inside'}}]; $('#chartContainer').dxChart({ size: { height: 300, width: 700 }, dataSource: dataSource, series: series, rotated: true, palette: 'Default', valueAxis: { position: 'top', min: 0, max: 5, tickInterval: 1, valueMarginsEnabled: false }, title: { text: 'Course Feedback', font: { color: 'steelblue', size: 25, weight: 400, horizontalAlignment: 'center' }, position: 'leftTop' }, commonSeriesSettings: { argumentField: 'state', type: 'bar', hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints', label: { visible: false, format: 'fixedPoint', precision: 1, alignment: 'center', dashStyle: 'longDash'} }, legend: { visible: false, legend: { visible: false, horizontalAlignment: 'center'}} });

    //        debugger;
    //            $("#chartContainer").dxChart({
    //            
    //             
    //                dataSource: [
    //                { day: "Monday", oranges: 2.2 },
    //                { day: "Tuesday", oranges: 2 },
    //                { day: "Wednesday", oranges: 3 },
    //                { day: "Thursday", oranges: 4 },
    //                { day: "Friday", oranges: 6 },
    //                { day: "Saturday", oranges: 11 },
    //                { day: "Sunday", oranges: 4}],

    //                series: {
    //                    argumentField: "day",
    //                    valueField: "oranges",
    //                    name: "My oranges",
    //                    type: "bar",
    //                    color: '#ffa500'
    //                }
    //            });


    ////    var dataSource = [{name: 'Overall Rating of Course- <div style="font-weight: bold; font-size: 16px;">3.6</div>', average: parseFloat(3.6), median: parseFloat(3.7)}
    ////    , {name: 'The course improved my ability to work in groups - <div style="font-weight: bold; font-size: 16px;"><b>2.9</div>', average: parseFloat(2.9), median: parseFloat(3.4)}, 
    ////    {name: 'The course helped to come up with practical solutions - <div style="font-weight: bold; font-size: 16px;"><b>3.7</div>', average: parseFloat(3.7), median: parseFloat(3.7)},
    ////     {name: 'The course helped me develop my skills to understand and analyze problems - <div style="font-weight: bold; font-size: 16px;"><b>4.0</div>', average: parseFloat(4.0), median: parseFloat(3.9)},
    ////      {name: 'The course achieved its objectives - <div style="font-weight: bold; font-size: 16px;"><b>3.7</div>', average: parseFloat(3.7), median: parseFloat(3.7)}, 
    ////      {name: 'The objectives for this course were clearly outlined and communicated by the instructor - <div style="font-weight: bold; font-size: 16px;"><b>3.8</div>', average: parseFloat(3.8), median: parseFloat(3.8)}];
    ////      var series = [  { argumentField: 'name', valueField: 'average', type: 'bar', name :'Average1', label: {visible: false,  precision: 1, horizontalOffset : 40   } }
    ////      , {  argumentField: 'name', name :'Average2',   valueField: 'median',type: 'scatter', label: {visible: true,precision: 1, position : 'inside' } }];

    ////      $('#chartContainer').dxChart({ size: { height: 300, width: 650 }, dataSource: dataSource, series: series, rotated: true, palette: 'Default', valueAxis: { position: 'top', min: 0, max: 5, tickInterval: 1, valueMarginsEnabled: false }, title: { text: '<div style="font-weight: bold; font-size: 19px;">Course Feedback</div>', font: { horizontalAlignment: 'center', opacity: 2 }, position: 'centerTop' }, commonSeriesSettings: { argumentField: 'state', type: 'bar', hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints', label: { visible: false, format: 'fixedPoint', precision: 1} }, legend: { visible: false, verticalAlignment: 'bottom', horizontalAlignment: 'center'} });
    //      </script></div><div style='border : 1px solid'><table  style=' width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px; font: 10px arial, san serif; border-collapse: collapse; border:0px solid #000000' cellpadding='0' cellspacing='0'  id='tbl_lecture'  width='100%'>  <thead> </thead><tbody><tr> <td style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='14'> <b>INSTRUCTOR NAME: Nitin Raje</b> </td><td align='right' style='padding-left:5px; font-size: 15px; font-style: italic; padding-right: 5px; border:5px solid white;border-bottom:0; background-color: white; color: black; height: 18px;' colspan='14'> <b>NO OF RESPONDENTS : 12 </b> </td> </tr></tbody></table></div> <div style = 'border: 1px solid;border-top: 0;'> <div  style = 'margin-left: 5px;' id='1015-113-1'></div> <script type='text/javascript'>var dataSource = [{name: 'Overall Rating of Instructor- <div style="font-weight: bold; font-size: 16px;">4.1</div>', average: parseFloat(4.1), median: parseFloat(3.8)}, {name: 'The course encouraged creative thinking - <div style="font-weight: bold; font-size: 16px;"><b>4.3</div>', average: parseFloat(4.3), median: parseFloat(3.7)}, {name: 'My queries were effectively addressed - <div style="font-weight: bold; font-size: 16px;"><b>4.0</div>', average: parseFloat(4.0), median: parseFloat(3.7)}, {name: 'Theory and practice were well integrated - <div style="font-weight: bold; font-size: 16px;"><b>4.3</div>', average: parseFloat(4.3), median: parseFloat(3.6)}, {name: 'Work progress was assessed regularly - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.8)}, {name: 'I received relevant and timely inputs from the instructors - <div style="font-weight: bold; font-size: 16px;"><b>4.2</div>', average: parseFloat(4.2), median: parseFloat(3.8)}, {name: 'The instructor was available during the scheduled studio time - <div style="font-weight: bold; font-size: 16px;"><b>3.9</div>', average: parseFloat(3.9), median: parseFloat(4.0)}];var series = [  { argumentField: 'name', valueField: 'average', type: 'bar', name :'Average1',  label: {visible: false,  precision: 1, horizontalOffset : 40   } }, {  argumentField: 'name', name :'Average2',   valueField: 'median',type: 'scatter', label: {visible: true,precision: 1, position : 'inside' } }]; $('#1015-113-1').dxChart({  size: { height: 300,  width: 650 },  dataSource: dataSource,series: series,  valueAxis: { position: 'top',   min: 0,    max: 5 ,  tickInterval: 1 ,  valueMarginsEnabled: false}, commonSeriesSettings: { argumentField: 'state', type: 'bar',  hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',    label: {  visible: true,format: 'fixedPoint', precision: 1 } },   title: {text: '<div style="font-weight: bold; font-size: 19px;">Instructor Feedback</div>',font: {   horizontalAlignment: 'center' }   },legend: {visible : false, verticalAlignment: 'bottom',  horizontalAlignment: 'center'},  rotated: true}); </script></div> <table style='border: 1px solid;width: 100%;border-collapse: collapse; margin-top:5px; font-size:10px'><tbody>   <tr style='font-size: 12px;'><td align='center' colspan='7' style='font-size: 15px; font-weight: bold; font-style: italic'>STUDENTS REGISTERED BY FACULTY</td></tr> <tr><td style='  border: 1px solid;padding-left: 5px; font-style: italic'>Name Of Faculty</td> <td style=' border: 1px solid;padding-left: 5px;font-style: italic'>FA <td style='border: 1px solid;padding-left: 5px;font-style: italic'>FD</td> <td style='  border: 1px solid;padding-left: 5px;font-style: italic'>FM</td>  </td> <td style='border: 1px solid;padding-left: 5px;font-style: italic'>FP</td><td style='  border: 1px solid;padding-left: 5px;font-style: italic'>FT</td><td style='border: 1px solid; font-style: italic'>Total</td></tr> <tr style='border: 1px solid; '><td style=' border: 1px solid;padding-left: 5px;font-style: italic' >No. of Students</td> <td style=' border: 1px solid;padding-left: 5px;' >27</td> <td style=' border: 1px solid;padding-left: 5px;' >0</td> <td style=' border: 1px solid;padding-left: 5px;' >0</td> <td style=' border: 1px solid;padding-left: 5px;' >0</td> <td style=' border: 1px solid;padding-left: 5px;' >0</td> <td style=' border: 1px solid;padding-left: 5px;' >27</td> </tr><tr style='border: 1px solid;'> <td style=' border: 1px solid;padding-left: 5px;font-style: italic' >Percentage(%)</td> <td style='border: 1px solid;padding-left: 5px;'>100</td> <td style='border: 1px solid;padding-left: 5px;'>0</td> <td style='border: 1px solid;padding-left: 5px;'>0</td> <td style='border: 1px solid;padding-left: 5px;'>0</td> <td style='border: 1px solid;padding-left: 5px;'>0</td> <td style='border: 1px solid;padding-left: 5px;'>100%</td> </tr> </tbody></table><div style ='font-size: 10px; font-style: italic'><div style=' margin-top: 2px;'><img style='float: left;margin-top: 3px; width: 9px; margin-right: 4px;' src='../../image/avg1.png'/><b>Average1:</b>This is the mean/average score for the question/s based on total responses for this course.  E.G. for Studio IV, where out of total 32 students 28 have responded, the Average1 represents the mean of all 28 responses.</div> <div style='margin-top: 2px;'><img style='float: left;margin-top: 3px; width: 9px; margin-right: 4px;' src='../../image/avg2.png'/><b>Average2:</b> This is the mean/average score for the question/s based on all responses for this course type within the faculty. E.G. for Studio IV offered by FA, the Average2 represents the mean of all responses for Studio courses offered in FA during the given semester.</div> </div><div style='font-weight: bold; font-size: 10px; margin-top: 2px;'>Scale: 1 = least agreement with the statement, 5 = most agreement with the statement</div></div> </div>

    bindsemdata();
    bindyeardata_for_cross_reg();
    bindcoursetype();
    binddepartment();

    window.onscroll = set_svg;

    // $('#print_data').html('');

    $('#drpsemester').on('change', function () {
        if ($('#drpsemester').val() != '') {

            if ($('#drpyear').val() != '') {
                bind_sem_course();
            }

        }
    });


    $('#drpyear').on('change', function () {
        if ($('#drpyear').val() != '') {

            if ($('#drpsemester').val() != '') {
                bind_sem_course();
            }

        }
    });

    $('#drcourses').on('change', function () {
        if ($('#drcourses').val() != '') {
            if ($('#drpyear').val() != '') {

                if ($('#drpsemester').val() != '') {
                    bind_sem_course_instructor();
                }

            }
        }
    });

    $('#drcourses,#drpyear,#drp_course_type,#drpdepartment,#drp_instructor').on('change', function () {

        $('#print_data').html('');
    });


    $('#btnprint').on('click', function () {

        set_svg();


        //   print_pdf();

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

    $('#btnreterive').on('click', function () {




        pdf_print_name = "";

        var semester = $('#drpsemester').val();
        if (semester == "") {
            bootbox.alert('Please select semester')
            $('#drpsemester').focus();
            return false;
        }

        var course_code = $('#drcourses').val();

        var year_code = $('#drpyear').val();
        if (year_code == "") {
            bootbox.alert('Please select year')
            $('#drpyear').focus();
            return false;
        }

        var instructor_code = "";
        if ($('#drp_instructor').val() != null && $('#drp_instructor').val() != undefined) {
            instructor_code = $('#drp_instructor').val();
        }


        //        var course_type = $('#drp_course_type').val();

        var course_type = "";

        var department = $('#drpdepartment').val();

        if (course_type == "") {

            if (course_code == "" && department == "") {


                bootbox.alert('Please select course type')
                $('#drp_course_type').focus();
                return false;
            }
        }


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/print_faculty_report_latest",

            data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_type':'" + course_type + "','course_code':'" + course_code + "','dept_code':'" + department + "','selected_instructor':'" + instructor_code + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {



                    if (data.d == "course") {

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

                    //var course_data = JSON.parse(data.d);

                    var course_data = JSON.parse(JSON.parse(data.d)["div_data"]);

                    if (JSON.parse(data.d)[1] != "") {
                        pdf_print_name = JSON.parse(data.d)["pdf_print_name"];
                    }


                    // alert(course_data);
                    $('#print_data').html('');


                    if (course_data[0]["message"] != '') {


                        if (course_data[0]["message"] == 1) {

                        }
                        else {

                            bootbox.alert('Feedback Calculation data is not saved in database.Some Problem of Saved Feedback calculation data in table.');

                        }
                    }
                    else {

                        bootbox.alert('Feedback Calculation data is not saved in database.Some Problem of Saved Feedback calculation data in table.');

                    }


                    $('#print_data').append(course_data[0]["table"]);


                    //  set_svg();




                    //                    $.ajax({
                    //                        type: "POST",
                    //                        contentType: "application/json; charset=utf-8",
                    //                        url: "../../WebService_WS.asmx/print_faculty_report_script",
                    //                        async: false,
                    //                        data: "{}",
                    //                        dataType: "json",
                    //                        success: function (data) {

                    //                            debugger;

                    //                            debugger;
                    //                            if (data.d != "") {
                    //                                debugger;




                    //                                $('#print_data').append(data.d);
                    //                                return false;






                    //                                debugger;





                    //                                return true;
                    //                                //  display_feedback_receipt_report_course_wise(data.d);
                    //                            }
                    //                            else {


                    //                            }

                    //                        },
                    //                        error: function (result) {
                    //                            alert(result);
                    //                        }
                    //                    });


                    //                    $.ajax({
                    //                        type: "POST",
                    //                        contentType: "application/json; charset=utf-8",
                    //                        url: "../../WebService_WS.asmx/print_faculty_report_script",
                    //                        aSync: false,
                    //                        data: "{}",
                    //                        dataType: "json",
                    //                        success: function (data) {

                    //                            debugger;

                    //                            debugger;
                    //                            if (data.d != "") {
                    //                                debugger;




                    //                                $('#print_data').append(data.d);
                    //                                return false;





                    //                                debugger;





                    //                                return true;
                    //                                //  display_feedback_receipt_report_course_wise(data.d);
                    //                            }
                    //                            else {


                    //                            }

                    //                        },
                    //                        error: function (result) {
                    //                            alert(result);
                    //                        }
                    //                    });






                    return true;
                    //  display_feedback_receipt_report_course_wise(data.d);
                }
                else {

                    bootbox.alert('No data found for selected criteria');

                }

            },
            error: function (result) {
                alert(result);
            }
        });
        return false;
    });



});

//function set_svg() {


//   $('.instructor .dxc-labels-group rect').attr('x', '1000');
//   $('.instructor .dxc-labels-group text tspan').attr('x', '1015');


////    $('.instructor .dxc-labels-group rect').attr('x', '980');
////    $('.instructor .dxc-labels-group text tspan').attr('x', '995');

//    var data = $('.course .dxc-h-axis .dxc-elements');
//    var str = '';
//    for (var i = 0; i < data.length; i++) {

//      //  data[i].firstElementChild.style.display = 'none';

//        //data[i].lastElementChild.style.display = 'none';
//        data[i].lastElementChild.previousSibling.setAttribute('x', '985');
//        data[i].lastElementChild.setAttribute('x', '1040');
//        data[i].lastElementChild.previousSibling.innerHTML = '<tspan x="985" y="30">IND</tspan><tspan x="985" y="49">AVG</tspan>';
//        data[i].lastElementChild.innerHTML = '<tspan x="1040" y="30">FAC</tspan><tspan x="1040" y="49">AVG</tspan>';
//        
//        str = data[i].innerHTML;
//        str = str + "<text x='1040' y='30' text-anchor='middle' transform='rotate(0,1098,49)' style='fill: rgb(0, 0, 0); font-family: 'Segoe UI', 'Helvetica Neue', 'Trebuchet MS', Verdana; font-weight: 400; font-size: 12px; cursor: default;'>FAC</text>";
//    }

//    data = $('.instructor .dxc-h-axis .dxc-elements');
//    for (var i = 0; i < data.length; i++) {

//      //  data[i].firstElementChild.style.display = 'none';

//        //data[i].lastElementChild.style.display = 'none';

//        data[i].lastElementChild.previousSibling.setAttribute('x', '995');
//        data[i].lastElementChild.setAttribute('x', '1050');
//        data[i].lastElementChild.previousSibling.innerHTML = '<tspan x="995" y="30">IND</tspan><tspan x="995" y="49">AVG</tspan>';
//        data[i].lastElementChild.innerHTML = '<tspan x="1050" y="30">FAC</tspan><tspan x="1050" y="49">AVG</tspan>';
//    }

//    data = $('.course .dxc-h-axis .dxc-grid');
//    for (var i = 0; i < data.length; i++) {

//        data[i].lastElementChild.style.display = 'none';
//        data[i].lastElementChild.previousSibling.style.display = 'none';
//    }

//    data = $('.instructor .dxc-h-axis .dxc-grid');
//    for (var i = 0; i < data.length; i++) {

//        data[i].lastElementChild.style.display = 'none';
//        data[i].lastElementChild.previousSibling.style.display = 'none';
//    }

////    data = $('.instructor .dxc-labels-group');

////    for (var i = 0; i < data.length; i++) {
////        debugger;
////        for (var j = 0; j < data[i].childNodes[1].childNodes.length; j++) {
////            data[i].childNodes[0].childNodes[j].childNodes[0].childNodes[0].x.value = '995';
////            data[i].childNodes[0].childNodes[j].childNodes[0].childNodes[1].x.baseVal.value = '1010';

////        }
////    }


//    $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text').attr('text-anchor', 'inherit');

//    data = $('.course .dxc-axes-group .dxc-v-axis .dxc-elements tspan');
//    for (var i = 0; i < data.length; i++) {

//        if (data[i].innerHTML.length == 3) {
//            data[i].setAttribute('x', '975');

//            data[i].setAttribute('fill', '#5f8b95');
//        }
//        else if (data[i].innerHTML.length > 3) {
//            data[i].setAttribute('x', '0');
//        }
//    }

//    $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text').attr('text-anchor', 'inherit');

//    data = $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements tspan');
//    for (var i = 0; i < data.length; i++) {

//        if (data[i].innerHTML.length == 3) {
//            data[i].setAttribute('x', '980');

//            data[i].setAttribute('fill', '#5f8b95');
//        }
//        else if (data[i].innerHTML.length > 3) {
//            data[i].setAttribute('x', '0');
//        }
//    }

//    $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text').css("fill", "black");
//    $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text').css("fill", "black");


////    $('.course .dxc-axes-group .dxc-v-axis .dxc-elements text tspan').css("font-size", "15px");
////    $('.instructor .dxc-axes-group .dxc-v-axis .dxc-elements text tspan').css("font-size", "15px");

//    $('.course .dxc-axes-group .dxc-h-axis .dxc-elements text').css("fill", "black");
//    $('.instructor .dxc-axes-group .dxc-h-axis .dxc-elements text').css("fill", "black");

//    $('.course .dxc-labels-group text tspan').css("font-weight", "bold");
//    $('.course .dxc-labels-group text tspan').css("font-size", "15px");

//    $('.instructor .dxc-labels-group text tspan').css("font-weight", "bold");
//    $('.instructor .dxc-labels-group text tspan').css("font-size", "15px");

//    $('.course .dxc-labels-group rect').attr('x', '995');
//        $('.course .dxc-labels-group text tspan').attr('x', '1010');

////    $('.course .dxc-labels-group rect').attr('x', '975');
////    $('.course .dxc-labels-group text tspan').attr('x', '990');

//}

function print_pdf() {
    var doc = new jsPDF();

    // We'll make our own renderer to skip this editor
    var specialElementHandlers = {
        '#chartContainer': function (element, renderer) {
            return true;
        }
    };

    // All units are in the set measurement for the document
    // This can be changed to "pt" (points), "mm" (Default), "cm", "in"

    var htmlString = "<html><body ><label>INPUT TYPE</label></body></html>";
    doc.fromHTML(htmlString, 15, 15, {
        'width': 500,
        'elementHandlers': specialElementHandlers
    });

    //  doc.text(20, 20, 'Hello world.');
    doc.save("a.pdf");
    //   doc.autoPrint()
    //   doc.output('datauri');
    //  doc.save("a.pdf");
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

    //    data = $('.instructor .dxc-labels-group');

    //    for (var i = 0; i < data.length; i++) {
    //        debugger;
    //        for (var j = 0; j < data[i].childNodes[1].childNodes.length; j++) {
    //            data[i].childNodes[0].childNodes[j].childNodes[0].childNodes[0].x.value = '995';
    //            data[i].childNodes[0].childNodes[j].childNodes[0].childNodes[1].x.baseVal.value = '1010';

    //        }
    //    }


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

    data = $('.instructor .dxc-labels-group');
    for (var i = 0; i < data.length; i++) {

        data[i].children[0].style.display = 'none';
    }
}

function bindcoursetype() {


    $('#drp_course_type').empty().append($("<option></option>").val("").html("--Please Select course type--"));
    $('#drp_course_type').append($("<option></option>").val("lecture").html("Lecture"));
    $('#drp_course_type').append($("<option></option>").val("seminar").html("Seminar"));
    $('#drp_course_type').append($("<option></option>").val("studio").html("Studio"));
    $('#drp_course_type').append($("<option></option>").val("workshop").html("Workshop"));

    $('#drp_course_type').chosen();
}


function bindsemdata() {

    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
    $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
    //    for (var i = 0; i < sem_data.length; i++) {


    //        $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));

    //    }

    $('#drpsemester').chosen();

}

function binddepartment() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_department_data",

        data: "{}",
        dataType: "json",
        aSync: false,
        success: function (data) {

            if (data.d != "") {

                var sem_data = JSON.parse(data.d)

                $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                for (var i = 0; i < sem_data.length; i++) {
                    $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                }
                $('#drpdepartment').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindyeardata_for_cross_reg() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_year_data",

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


function bind_sem_course() {


    var sem_code = $('#drpsemester').val();

    if (sem_code == '') {
        bootbox.alert('Please select semester');
        return false;
    }

    var year_code = $('#drpyear').val();

    if (year_code == '') {
        bootbox.alert('Please select year');

        return false;
    }


    $('#drp_instructor')
        .find('option')
        .remove()
        .end()
        //                .append('<option value="">No Data found</option>')
        .val('');
    $('#drp_instructor').chosen();

    $('#drp_instructor').val('').trigger("liszt:updated");

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_course_data",

        data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {




            if (data.d != "") {


                var course_data = JSON.parse(data.d)



                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));
                for (var i = 0; i < course_data.length; i++) {


                    $('#drcourses').append($("<option></option>").val(course_data[i]["course_code"]).html(course_data[i]["course_code"]));
                }

                $('#drcourses').chosen();


                $('#drcourses').trigger("liszt:updated");
            }
            else {
                $('#drcourses')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Data found</option>')
                    .val('');
                $('#drcourses').chosen();

                $('#drcourses').val('').trigger("liszt:updated");
            }

        },
        error: function (result) {
            alert(result);
        }
    });

}

function bind_sem_course_instructor() {


    var sem_code = $('#drpsemester').val();

    if (sem_code == '') {
        bootbox.alert('Please select semester');

        return false;
    }

    var year_code = $('#drpyear').val();

    if (year_code == '') {
        bootbox.alert('Please select year');

        return false;
    }


    var course_code = $('#drcourses').val();

    if (course_code == '') {
        bootbox.alert('Please select course');

        return false;
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_course_wise_instructor_data",

        data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code:'" + course_code + "'}",
        dataType: "json",
        success: function (data) {




            if (data.d != "") {


                var instructor_data = JSON.parse(data.d)



                $('#drp_instructor').empty().append($("<option></option>").val("").html("-- Please Select Instructor --"));
                for (var i = 0; i < instructor_data.length; i++) {


                    $('#drp_instructor').append($("<option></option>").val(instructor_data[i]["instructor_code"]).html(instructor_data[i]["instructor_name"]));
                }

                $('#drp_instructor').chosen();


                $('#drp_instructor').trigger("liszt:updated");
            }
            else {
                $('#drp_instructor')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Data found</option>')
                    .val('');
                $('#drp_instructor').chosen();

                $('#drp_instructor').val('').trigger("liszt:updated");
            }

        },
        error: function (result) {
            alert(result);
        }
    });

}
