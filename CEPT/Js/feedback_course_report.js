
$(document).ready(function () {
    bindsemdata();

    bindyeardata_for_cross_reg();
     window.onscroll = set_svg;

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


    $('#btnprint').on('click', function () {

        set_svg();


        var mywindow = window.open('', 'print_data', 'height=400,width=600');
        // mywindow.document.write('<link href=\"DesignCss/bootstrap.min.css\" rel=\"stylesheet\" />  <link href=\"DesignCss/ace.min.css\" rel=\"stylesheet\" /><link href=\"Style/dataTables.bootstrap.css\" rel=\"stylesheet\" type="text/css" />');
        mywindow.document.write('');
        // mywindow.document.write('<style type="text/css"> th, td, .table-bordered {border-radius: 0!important;} .table-bordered {border: 1px solid #ddd;border-collapse: separate;border-left: 0}table {border-spacing: 0;}body {padding-bottom: 0;background-color: #e4e6e9;min-height: 100%;font-family: 'Open Sans';font-size: 13px;color: #393939;} </style>');
        mywindow.document.write('<html><head><title>print_data</title>  <style>.boxclass{height: 10px;width: 10px;background-color: red;float: left;margin-top: 5px;margin-right: 1px;} .dxc-markers circle{display:none;}</style>');
        /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
        mywindow.document.write('</head><body>');
        mywindow.document.write($('#print_data').html());
        mywindow.document.write('</body></html>');


        mywindow.print();
        mywindow.close();

        return false;

    });

    $('#btnreterive').on('click', function () {

        debugger;

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
            bootbox.alert('Please select Course');
            return false;
        }

        var course_name = $("#drcourses :selected").text();

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/print_feedback_course_report",

            data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "' ,course_code : '" + course_code + "',course_name :'" + course_name + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != "") {

                    debugger;
                    var course_data = JSON.parse(data.d)

                    // alert(course_data);
                    $('#print_data').html('');


                    $('#print_data').append(course_data[0]["table"]);

                    set_svg();
                }


            },
            error: function (result) {
                debugger;
                alert(result);
            }


        });

        return false;
    });


});

function set_svg() {

    //  $('.instructor .dxc-markers rect').attr('y', '25');
    //  $('.instructor .dxc-axes-group .dxc-v-axis tspan').first().attr('y', '40');
    debugger;

    var data = $('.course .dxc-markers rect');

//    var a = 50;
//    for (var i = 0; i < data.length; i++) {

//        data[i].attr('y', '50');

//    }

    return false;
}


function bindsemdata() {

    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
    //    for (var i = 0; i < sem_data.length; i++) {


    //        $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));

    //    }

    $('#drpsemester').chosen();

}


function bindyeardata_for_cross_reg() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_year_data",

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



function bind_instructor_data() {


    var sem_code = $('#drpsemester').val();

    if (sem_code == '') {
        bootbox.alert('Please select semester');
    }

    var year_code = $('#drpyear').val();

    if (year_code == '') {
        bootbox.alert('Please select year');
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_course_mst_data_for_catalog_report",

        data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {




            if (data.d != "") {


                var instructor_data = JSON.parse(data.d)



                $('#drp_instructor').empty().append($("<option></option>").val("").html("-- Please Select course --"));
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

function bind_sem_course() {


    var sem_code = $('#drpsemester').val();

    if (sem_code == '') {
        bootbox.alert('Please select semester');
    }

    var year_code = $('#drpyear').val();

    if (year_code == '') {
        bootbox.alert('Please select year');
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_course_data_new",

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
