var oTable;
var oTable1;
var oTable2;
var sem_data = '';

var course_seat_data = '';


function get_total_offered_course() {
    $('#DataList').css("display", "none");

    $.ajax({
        type: "POST",
        url: "../../WebService_WS.asmx/get_total_offered_course_report",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            //            bootbox.alert(data.d);
            display_offered_course_report(data.d);


        },
        error: function (msg) { alert(msg.d); }
    });

    return false;

}

function display_offered_course_report(data) {
    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }





    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
            //            							    "copy",
            							    "print",
            //            							    {
            //            							        "sExtends": "collection",
            //            							        "sButtonText": 'Export',
            //            							        "aButtons": ["xls", "pdf"]
            //            							    }
						]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [

          { "sTitle": "", "mData": "no", "bSortable": false },
          { "sTitle": "Total No. of Mandatory subjects Offered", "mData": "mandatory", "bSortable": false },
          { "sTitle": "Total No. of Elective subjects Offered", "mData": "elective", "bSortable": false },
            { "sTitle": "Total", "mData": "total", "bSortable": false }

          ]


    });






    $('#DataList').css('display', 'block');


    return false;
}

function get_faculty_wise_total_course() {
    $('#DataList').css("display", "none");

    $.ajax({
        type: "POST",
        url: "../../WebService_WS.asmx/get_faculty_wise_total_course_report",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            //            bootbox.alert(data.d);
            display_faculty_wise_total_course(data.d);


        },
        error: function (msg) { alert(msg.d); }
    });

    return false;

}

function display_faculty_wise_total_course(data) {
    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }





    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
            //            							    "copy",
            							    "print",
            //            							    {
            //            							        "sExtends": "collection",
            //            							        "sButtonText": 'Export',
            //            							        "aButtons": ["xls", "pdf"]
            //            							    }
						]
        },

        "aaData": JSON.parse(data),
        "fnFooterCallback": function (nRow, aaData, iStart, iEnd,
       aiDisplay) {

            debugger;
            var iTotalNuma = 0;
            var iTotalNumb = 0;
            if (aaData.length > 0) {
                for (var i = 0; i < aaData.length; i++) {
                    iTotalNuma += parseInt(aaData[i].course_code);
                    iTotalNumb += parseInt(aaData[i].credits);
                }
            }
            /*
            * render the total row in table footer
            */
            var nCells = $('#example tfoot tr th');

            //            var nCells = nRow.getElementsByTagName("th");
            nCells[1].innerHTML = iTotalNuma;
            nCells[2].innerHTML = iTotalNumb;

        },
        "aoColumns": [

          { "sTitle": "", "mData": "dept_name", "bSortable": false },
          { "sTitle": "Total no of Core + Elective Subjects Offered", "mData": "course_code", "bSortable": false },
          { "sTitle": "Total Credits (Core + Elective) Offered", "mData": "credits", "bSortable": false }


          ]


    });






    $('#DataList').css('display', 'block');


    return false;
}

function get_faculty_type_wise_total_course() {
    $('#DataList').css("display", "none");
    $('#DataList1').css('display', 'none');

    $.ajax({
        type: "POST",
        url: "../../WebService_WS.asmx/get_faculty_type_wise_total_course_report",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            //            bootbox.alert(data.d);
            display_faculty_type_wise_total_course(data.d);


        },
        error: function (msg) { alert(msg.d); }
    });

    return false;

}
function display_faculty_type_wise_total_course(data) {
    if (oTable1 != null) {
        oTable1.fnDestroy();

        $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example1"><thead></thead><tbody> </tbody></table>');
    }





    oTable1 = $("#example1").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
            //            							    "copy",
            							    "print",
            //            							    {
            //            							        "sExtends": "collection",
            //            							        "sButtonText": 'Export',
            //            							        "aButtons": ["xls", "pdf"]
            //            							    }
						]
        },

        "aaData": JSON.parse(data),
        "fnFooterCallback": function (nRow, aaData, iStart, iEnd,
       aiDisplay) {

            debugger;
            var mandatory_course = 0, elective_course = 0, total_course = 0, mandatory_credits = 0, elective_credits = 0, total_credits = 0;
            var iTotalNumb = 0;
            if (aaData.length > 0) {
                for (var i = 0; i < aaData.length; i++) {
                    mandatory_course += parseInt(aaData[i].mandatory_course);
                    elective_course += parseInt(aaData[i].elective_course);
                    total_course += parseInt(aaData[i].total_course);
                    mandatory_credits += parseInt(aaData[i].mandatory_credits);
                    elective_credits += parseInt(aaData[i].elective_credits);
                    total_credits += parseInt(aaData[i].total_credits);
                }
            }
            /*
            * render the total row in table footer
            */
            var nCells = $('#example1 tfoot tr th');


            //            var nCells = nRow.getElementsByTagName("th");
            nCells[1].innerHTML = mandatory_course;
            nCells[2].innerHTML = elective_course;
            nCells[3].innerHTML = total_course;
            nCells[4].innerHTML = mandatory_credits;
            nCells[5].innerHTML = elective_credits;
            nCells[6].innerHTML = total_credits;

        },
        "aoColumns": [

          { "sTitle": "", "mData": "dept_name", "bSortable": false },
          { "sTitle": "Total No. of Core Subjects Offered", "mData": "mandatory_course", "bSortable": false },
          { "sTitle": "Total  No. of Elective Subjects Offered", "mData": "elective_course", "bSortable": false },
                  { "sTitle": "Total no of Core + Elective Subjects Offered", "mData": "total_course", "bSortable": false },
                   { "sTitle": "Total Core Subject Credits Offered", "mData": "mandatory_credits", "bSortable": false },
                     { "sTitle": "Elective Subjects Credit Offered", "mData": "elective_credits", "bSortable": false },
                         { "sTitle": "Total Credit (Core + Elective) Offered", "mData": "total_credits", "bSortable": false }


          ]


    });






    $('#DataList').css('display', 'block');
    $('#DataList1').css('display', 'block');


    return false;
}

function get_course_type_offered_report() {
    $('#DataList').css("display", "none");
    $('#DataList1').css('display', 'none');

    $.ajax({
        type: "POST",
        url: "../../WebService_WS.asmx/get_course_type_offered_report",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            //            bootbox.alert(data.d);
            display_course_type_offered_report(data.d);


        },
        error: function (msg) { alert(msg.d); }
    });

    return false;

}

function display_course_type_offered_report(data) {
    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }





    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": true,

        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
            //            							    "copy",
            							    "print",
            //            							    {
            //            							        "sExtends": "collection",
            //            							        "sButtonText": 'Export',
            //            							        "aButtons": ["xls", "pdf"]
            //            							    }
						]
        },

        "aaData": JSON.parse(data),
        "fnFooterCallback": function (nRow, aaData, iStart, iEnd,
       aiDisplay) {

            debugger;
            var iTotalNuma = 0;
            var iTotalNumb = 0;
            if (aaData.length > 0) {
                for (var i = 0; i < aaData.length; i++) {
                    iTotalNuma += parseInt(aaData[i].course_code);
                    iTotalNumb += parseInt(aaData[i].course_credits);
                }
            }
            /*
            * render the total row in table footer
            */
            var nCells = $('#example tfoot tr th');

            //            var nCells = nRow.getElementsByTagName("th");
            nCells[1].innerHTML = iTotalNuma;
            nCells[2].innerHTML = iTotalNumb;

        },
        "aoColumns": [

          { "sTitle": "Course Typology", "mData": "course_type", "bSortable": false },
          { "sTitle": "No. of Courses", "mData": "course_code", "bSortable": false },
          { "sTitle": "No. of Credits", "mData": "course_credits", "bSortable": false }


          ]



    });





    $('#DataList').css('display', 'block');


    return false;
}

function get_course_type_and_credits_offered_report() {
    $('#DataList').css("display", "none");
    $('#DataList1').css('display', 'none');

    $.ajax({
        type: "POST",
        url: "../../WebService_WS.asmx/get_course_type_various_offered_report",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            //            bootbox.alert(data.d);
            display_course_type_by_faculty_offered_report(data.d);


        },
        error: function (msg) { alert(msg.d); }
    });

    return false;

}

function display_course_type_by_faculty_offered_report(data) {
    if (oTable1 != null) {
        oTable1.fnDestroy();

        $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example1"><thead></thead><tbody> </tbody></table>');
    }





    oTable1 = $("#example1").dataTable({

        "bPaginate": false,
        "bStateSave": true,

        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
            //            							    "copy",
            							    "print",
            //            							    {
            //            							        "sExtends": "collection",
            //            							        "sButtonText": 'Export',
            //            							        "aButtons": ["xls", "pdf"]
            //            							    }
						]
        },

        "aaData": JSON.parse(data),
        "fnFooterCallback": function (nRow, aaData, iStart, iEnd,
               aiDisplay) {

            debugger;
            var lecture = 0, seminar = 0, studio = 0, workshop = 0, design_workshop = 0, ghuided_research = 0, independent = 0, intership = 0, total = 0;
            if (aaData.length > 0) {
                for (var i = 0; i < aaData.length; i++) {
                lecture += parseInt(aaData[i].lecture);
                    seminar += parseInt(aaData[i].seminar);
                    studio += parseInt(aaData[i].studio);
                    workshop += parseInt(aaData[i].workshop);
                    design_workshop += parseInt(aaData[i].design_workshop);
                    ghuided_research += parseInt(aaData[i].ghuided_research);
                    independent +=parseInt(aaData[i].independent_study);
                    intership += parseInt(aaData[i].intership);
                    total += parseInt(aaData[i].total);
                }
            }
            /*
            * render the total row in table footer
            */
            var nCells = $('#example1 tfoot tr th');

            //            var nCells = nRow.getElementsByTagName("th");
            nCells[1].innerHTML = lecture;
            nCells[2].innerHTML = seminar;
            nCells[3].innerHTML = studio;
            nCells[4].innerHTML = workshop;
            nCells[5].innerHTML = design_workshop;
            nCells[6].innerHTML = ghuided_research;
            nCells[7].innerHTML = independent;
            nCells[8].innerHTML = intership;
            nCells[9].innerHTML = total;

        },
        "aoColumns": [

          { "sTitle": "", "mData": "dept_name", "bSortable": false },
          { "sTitle": "Lecture", "mData": "lecture", "bSortable": false },
          { "sTitle": "Seminar", "mData": "seminar", "bSortable": false },
              { "sTitle": "Studio", "mData": "studio", "bSortable": false },
                  { "sTitle": "Workshop", "mData": "workshop", "bSortable": false },
                      { "sTitle": "Design Workshop", "mData": "design_workshop", "bSortable": false },
                          { "sTitle": "Guided Research", "mData": "ghuided_research", "bSortable": false },
                          { "sTitle": "Independent Study", "mData": "independent_study", "bSortable": false },
                          { "sTitle": "Internship", "mData": "intership", "bSortable": false },
                              { "sTitle": "Total No. of Courses Offered", "mData": "total", "bSortable": false }

          ]



    });





    $('#DataList').css('display', 'block');
    $('#DataList1').css('display', 'block');

    return false;
}

function get_course_type_credits_offered_report() {
    $('#DataList').css("display", "none");
    $('#DataList1').css('display', 'none');

    $.ajax({
        type: "POST",
        url: "../../WebService_WS.asmx/get_course_type_credit_various_offered_report",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {


            //            bootbox.alert(data.d);
            display_course_type_credit_by_faculty_offered_report(data.d);


        },
        error: function (msg) { alert(msg.d); }
    });

    return false;

}

function display_course_type_credit_by_faculty_offered_report(data) {
    if (oTable2 != null) {
        oTable2.fnDestroy();

        $("#DataList2").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example2"><thead></thead><tbody> </tbody></table>');
    }





    oTable2 = $("#example2").dataTable({

        "bPaginate": false,
        "bStateSave": true,

        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
            //            							    "copy",
            							    "print",
            //            							    {
            //            							        "sExtends": "collection",
            //            							        "sButtonText": 'Export',
            //            							        "aButtons": ["xls", "pdf"]
            //            							    }
						]
        },

        "aaData": JSON.parse(data),
        "fnFooterCallback": function (nRow, aaData, iStart, iEnd,
               aiDisplay) {

            debugger;
            var lecture = 0, seminar = 0, studio = 0, workshop = 0, design_workshop = 0, ghuided_research = 0, independent = 0, intership = 0, total = 0;

            debugger;
            if (aaData.length > 0) {
                for (var i = 0; i < aaData.length; i++) {

                    lecture += parseInt(aaData[i].lecture);
                    seminar += parseInt(aaData[i].seminar);
                    studio += parseInt(aaData[i].studio);
                    workshop += parseInt(aaData[i].workshop);
                    design_workshop += parseInt(aaData[i].design_workshop);
                    ghuided_research += parseInt(aaData[i].ghuided_research);
                    independent += parseInt(aaData[i].independent_study);
                    intership += parseInt(aaData[i].intership);
                    total += parseInt(aaData[i].total);
                }
            }
            /*
            * render the total row in table footer
            */
            var nCells = $('#example2 tfoot tr th');

            //            var nCells = nRow.getElementsByTagName("th");
            nCells[1].innerHTML = lecture;
            nCells[2].innerHTML = seminar;
            nCells[3].innerHTML = studio;
            nCells[4].innerHTML = workshop;
            nCells[5].innerHTML = design_workshop;
            nCells[6].innerHTML = ghuided_research;
            nCells[7].innerHTML = independent;
            nCells[8].innerHTML = intership;
            nCells[9].innerHTML = total;

        },
        "aoColumns": [

          { "sTitle": "", "mData": "dept_name", "bSortable": false },
          { "sTitle": "Lecture", "mData": "lecture", "bSortable": false },
          { "sTitle": "Seminar", "mData": "seminar", "bSortable": false },
              { "sTitle": "Studio", "mData": "studio", "bSortable": false },
                  { "sTitle": "Workshop", "mData": "workshop", "bSortable": false },
                      { "sTitle": "Design Workshop", "mData": "design_workshop", "bSortable": false },
                          { "sTitle": "Guided Research", "mData": "ghuided_research", "bSortable": false },
                             { "sTitle": "Independent Study", "mData": "independent_study", "bSortable": false },
                          { "sTitle": "Internship", "mData": "intership", "bSortable": false },
                              { "sTitle": "Total  No of CreditOffered", "mData": "total", "bSortable": false }

          ]



    });





    $('#DataList').css('display', 'block');
    $('#DataList1').css('display', 'block');
    $('#DataList2').css('display', 'block');

    return false;
}