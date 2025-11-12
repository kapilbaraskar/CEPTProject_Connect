
var oTable;
var oTable1;
var fees_status;
var mandatory_time_day_data;
var total_creadit = 0;
var asInitVals = new Array();
var saved_data;

$(document).ready(function () {




    $('#rbtgpa').change(function () {
        if ((this).checked) {
            $('#rbtnongpa').prop('checked', false);
        }
        else {
            $('#rbtnongpa').prop('checked', true);
        }
    });
    $('#rbtnongpa').change(function () {
        if ((this).checked) {
            $('#rbtgpa').prop('checked', false);
        }
        else {
            $('#rbtgpa').prop('checked', true);
        }
    });

    $('#btn_save').on('click', function () {

        alert('hi');

        if (total_creadit == '0') {
            bootbox.alert('Please Select Course. You are not Selected Any course');

        }

        var mandatory_datalist = [];
        var elective_datalist = [];

        $("#example tbody tr").each(function (i) {


            if ($(this).find(".madaniyu").is(':checked')) {

                var obj = {};

                obj["semester_code"] = $(this).children().eq(1).html();
                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();

                mandatory_datalist.push(obj);
            }
        });

        $("#elective1 tbody tr").each(function (i) {


            if ($(this).find(".chk_elective").is(':checked')) {

                var obj = {};

                obj["department"] = $(this).children().eq(2).html();
                obj["semester_code"] = $(this).children().eq(3).html();
                obj["course_code"] = $(this).children().eq(4).html();
                obj["credits"] = $(this).children().eq(6).html();
                obj["gpa_nongpa"] = $(this).find(".gpa").val();
                obj["priority"] = $(this).find(".priority").val();

                elective_datalist.push(obj);
            }
        });


        var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'R' });

        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/Save_student_course_dtl",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {

                    if (data.d == "Fail to Save Details.") {
                        bootbox.alert(data.d);
                        return false;
                    }

                    if (data.d == "Data Saved Successfully") {

                        bind_sem_course_data();
                        total_creadit = 0;
                    }

                    bootbox.alert(data.d);

                }


            },
            error: function (msg) { alert(msg.d); }
        });


        return false;

    });

    $('#btn_print').on('click', function () {


        window.open('Print_pay_in_slip.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
        return false;

    });


    $('#btnsave').on('click', function () {



        if (total_creadit == '0') 
        {
            bootbox.alert('Please Select Course. You are not Selected Any course');

        }

        var mandatory_datalist = [];
        var elective_datalist = [];

        $("#example tbody tr").each(function (i) {


            if ($(this).find(".madaniyu").is(':checked')) {

                var obj = {};

                obj["semester_code"] = $(this).children().eq(1).html();
                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();

                mandatory_datalist.push(obj);
            }
        });

        $("#elective1 tbody tr").each(function (i) {


            if ($(this).find(".chk_elective").is(':checked')) {

                var obj = {};

                obj["department"] = $(this).children().eq(2).html();
                obj["semester_code"] = $(this).children().eq(3).html();
                obj["course_code"] = $(this).children().eq(4).html();
                obj["credits"] = $(this).children().eq(6).html();
                obj["gpa_nongpa"] = $(this).find(".gpa").val();
                obj["priority"] = $(this).find(".priority").val();

                elective_datalist.push(obj);
            }
        });


        var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist),status_flag: 'R' });

        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/Save_student_course_dtl",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {

                    if (data.d == "Fail to Save Details.") {
                        bootbox.alert(data.d);
                        return false;
                    }

                    if (data.d == "Data Saved Successfully") {

                        bind_sem_course_data();
                        total_creadit = 0;
                    }

                    bootbox.alert(data.d);

                }


            },
            error: function (msg) { alert(msg.d); }
        });


      
        return false;
    });




    bind_sem_course_data();



});


$(document).on("change", ".priority", function (event) {

    debugger;
    var val = $(this).val();

    var control = $(this);
    var flag = 'Y';
    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);
    var course_code = aData["course_code"];
    var counter = 0;
    var check_flag = 'N';
    //  var Faculty = aData["department"];

    $("#elective1 tbody tr").each(function (j) {
        debugger;
        if ($(this).find(".priority").val() != '0') {

            counter = counter + 1;

            if (course_code != $(this).children().eq(4).html()) {
                if (val == $(this).find(".priority").val()) {
                    bootbox.alert('You already Select this Priority for Course  Code : ' + $(this).children().eq(4).html());

                    control.val("0");

                    return false;
                }



            }




            //   alert($(this).children().eq(3).html());
        }
    });


    $("#elective1 tbody tr").each(function (j) {
        debugger;
        if ($(this).find(".priority").val() != '0') {





            if ((parseInt(val) - parseInt(1)) == $(this).find(".priority").val()) {
                flag = 'Y';
                return false;
            }
            else {
                flag = 'N';

            }


        }
    });


    if (counter == 1) {

        if (val > 1) {
            bootbox.alert("Please Select Priority in Sequence");
            control.val("0");
        }
    }
    else {

        if (flag == 'N') {
            bootbox.alert("Please Select Priority in Sequence");
            control.val("0");

        }
    }
});


$(document).on("click", ".madaniyu", function (event) {
    var checkbox = this;
    var datalist = [];
    var datalist1 = [];
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var course_code = aData["course_code"];
    var sem_code = aData["semester"];
    var creadits = aData["credits"];
    debugger;

    if (fees_status[0]["fees_status"] == 'H') {

        debugger;

        if (this.checked) {

            total_creadit = total_creadit + parseInt(aData["credits"]);


            if (total_creadit > fees_status[0]["fees_credits"]) {

                bootbox.alert("You Select Max 12 Creadits");
                $(this).prop("checked", false);

                total_creadit = total_creadit - parseInt(aData["credits"]);

                return false;

            }
            // alert(total_creadit);

        }
        else {

            total_creadit = total_creadit - parseInt(aData["credits"]);

            // alert(total_creadit);
        }

    }
    else if (fees_status[0]["fees_status"] == 'F') {

        if (this.checked) {

            total_creadit = total_creadit + parseInt(aData["credits"]);


            if (total_creadit > fees_status[0]["fees_credits"]) {

                bootbox.alert("You Select Max 24 Creadits");
                $(this).prop("checked", false);

                total_creadit = total_creadit - parseInt(aData["credits"]);
                return false;
            }
            //            alert(total_creadit);

        }
        else {

            total_creadit = total_creadit - parseInt(aData["credits"]);
            //            alert(total_creadit);
        }

    }

    if (this.checked) {
        $("#example tbody tr").each(function (i) {


            if ($(this).find(".madaniyu").is(':checked')) {





                var ob = {};

                ob["semester_code"] = $(this).children().eq(1).html();
                ob["course_code"] = $(this).children().eq(2).html();

                datalist.push(ob);


                $("#elective1 tbody tr").each(function (j) {


                    if ($(this).find(".chk_elective").is(':checked')) {

                        var ob1 = {};

                        ob1["semester_code"] = $(this).children().eq(3).html();
                        ob1["course_code"] = $(this).children().eq(4).html();

                        datalist1.push(ob1);

                        //   alert($(this).children().eq(3).html());
                    }
                });









                //}


            }


        });

        var data = JSON.stringify({ mandatory_time: JSON.stringify(datalist), elective_time: JSON.stringify(datalist1), course_code: course_code, sem_code: sem_code, flag: 'M' });
        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/Check_time_validation",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {
                    bootbox.alert(data.d);

                    checkbox.checked = false;
                    total_creadit = total_creadit - parseInt(aData["credits"]);
                }


            },
            error: function (msg) { alert(msg.d); }
        });

    }
    //
    //  alert(total_creadit);
});

$(document).on("click", ".chk_elective", function (event) {

    var checkbox = this;
    var datalist = [];
    var datalist1 = [];
    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);

    var flag = 'N';

    var course_code = aData["course_code"];
    var sem_code = aData["semester"];
    var creadits = aData["credits"];





    if (fees_status[0]["fees_status"] == 'H') {

        debugger;

        if (this.checked) {

            //alert(aData["course_code"]);
            total_creadit = total_creadit + parseInt(aData["credits"]);


            if (total_creadit > fees_status[0]["fees_credits"]) {

                bootbox.alert("You Select Max 12 Creadits");
                $(this).prop("checked", false);

                total_creadit = total_creadit - parseInt(aData["credits"]);
                return false;
            }
            //  alert(total_creadit);

        }
        else {

            total_creadit = total_creadit - parseInt(aData["credits"]);
            //alert(total_creadit);
        }

    }
    else if (fees_status[0]["fees_status"] == 'F') {

        if (this.checked) {

            total_creadit = total_creadit + parseInt(aData["credits"]);


            if (total_creadit > fees_status[0]["fees_credits"]) {

                bootbox.alert("You Select Max 24 Creadits");
                $(this).prop("checked", false);

                total_creadit = total_creadit - parseInt(aData["credits"]);
                return false;
            }


        }
        else {

            total_creadit = total_creadit - parseInt(aData["credits"]);

        }

    }

    if (this.checked) {
        $("#elective1 tbody tr").each(function (i) {


            if ($(this).find(".chk_elective").is(':checked')) {




                if (course_code == $(this).children().eq(4).html()) {
                    if ($(this).find(".gpa").val() == '0') {
                        bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);
                        total_creadit = total_creadit - parseInt(aData["credits"]);
                        checkbox.checked = false;
                        flag = 'Y';
                        return false;
                    }

                    if ($(this).find(".priority").val() == '0') {
                        bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                        total_creadit = total_creadit - parseInt(aData["credits"]);
                        checkbox.checked = false;
                        flag = 'Y';
                        return false;
                    }
                }


                var ob = {};

                ob["semester_code"] = $(this).children().eq(3).html();
                ob["course_code"] = $(this).children().eq(4).html();

                datalist1.push(ob);


                $("#example tbody tr").each(function (j) {


                    if ($(this).find(".madaniyu").is(':checked')) {

                        var ob1 = {};

                        ob1["semester_code"] = $(this).children().eq(1).html();
                        ob1["course_code"] = $(this).children().eq(2).html();

                        datalist.push(ob1);

                        //   alert($(this).children().eq(3).html());
                    }
                });
            }


        });

        if (flag == 'Y') {
            return false;
        }

        var data = JSON.stringify({ mandatory_time: JSON.stringify(datalist), elective_time: JSON.stringify(datalist1), course_code: course_code, sem_code: sem_code, flag: 'E' });
        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/Check_time_validation",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {
                 

                    if (data.d == "Error") {

                    }
                    else {

                        var split_data = data.d.split(":");

                        if (split_data[0] == "ok") {

                            bootbox.alert(split_data[1]);
                        }
                        else {
                            checkbox.checked = false;
                            total_creadit = total_creadit - parseInt(aData["credits"]);
                            bootbox.alert(data.d);
                        }

                      
                    }



                }

                return false;
            },
            error: function (msg) { alert(msg.d); }
        });

    }


});

//$(document).on("click", ".hathi", function (event) {
//    var $this = $(this), $table = $this.closest("table"), $madaniya = null;
//    if ($table.hasClass("dataTable")) {
//        $table = $table.closest(".dataTables_wrapper");
//    }
//    $table.find(".madaniyu").prop("checked", this.checked).change();
//}).on("click", ".madaniyu", function () {
//    var $this = $(this), $table = $this.closest("table"), $madaniya = null; $madaniya = null, checkedLength = 0;
//    if ($table.hasClass("dataTable")) {
//        $table = $table.closest(".dataTables_wrapper");
//    }
//    $madaniya = $table.find(".madaniyu");
//    checkedLength = $madaniya.filter(":checked").length;
//    $table.find(".hathi").prop({ "indeterminate": checkedLength && checkedLength !== $madaniya.length, "checked": checkedLength === $madaniya.length });
//}).on("change", ".madaniyu", function () {
//    if (this.checked) {
//        //  addSelection(this.value);
//    } else {
//        // removeSelection(this.value);
//    }
//});


$('#callbacks').multiSelect({

});

$('.ms-selectable .ms-list').on('mouseenter', '.ms-elem-selectable', function () {
    $('li', that.$container).removeClass('ms-hover');
    $(this).addClass('ms-hover');
    alert('hi');
}).on('mouseleave', function () {
    $('li', that.$container).removeClass('ms-hover');
});


function get_saved_data() {

    $.ajax({
        async: false,
        type: "POST",
        url: "../WebService_WS.asmx/Get_saved_student_course_data",
        data: {},
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                saved_data = JSON.parse(data.d);

                //  alert(saved_data);

                if (saved_data != "") {
                    for (var i = 0; i < saved_data.length; i++) {
                        total_creadit = total_creadit + parseInt(saved_data[i]["credits"]);
                        //                        alert(total_creadit);
                    }

                }


            }
            else {

                saved_data = "";
            }


        },
        error: function (msg) { alert(msg.d); }
    });


}


function bind_sem_course_data() {




    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_mandatory_course_data_for_student",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                if (data.d == "fees not found") {

                    bootbox.alert("Please Submmit Fees Of Current Semester")
                    return;
                }

                //                get_saved_data();


                $.ajax({
                    async: false,
                    type: "POST",
                    url: "../WebService_WS.asmx/Get_saved_student_course_data",
                    data: {},
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {

                        if (data.d != "") {

                            saved_data = JSON.parse(data.d);

                            //  alert(saved_data);

                            if (saved_data != "") {
                                for (var i = 0; i < saved_data.length; i++) {
                                    total_creadit = total_creadit + parseInt(saved_data[i]["credits"]);
                                    //                        alert(total_creadit);
                                }

                            }


                        }
                        else {
                            saved_data = "";
                        }


                    },
                    error: function (msg) { alert(msg.d); }
                });





                DisplayData(data.d);


            }
            else {
                alert('There is no data found');
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });


    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_elective_course_data_for_student",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                if (data.d == "fees not found") {


                    return false;


                }

                $.ajax({
                    async: false,
                    type: "POST",
                    url: "../WebService_WS.asmx/Get_saved_student_course_data",
                    data: {},
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {

                        if (data.d != "") {

                            saved_data = JSON.parse(data.d);

                            //  alert(saved_data);




                        }
                        else {

                            saved_data = "";
                        }

                    },
                    error: function (msg) { alert(msg.d); }
                });


                DisplayData1(data.d);
                //   get_saved_data();
                $('#btnsave').css("display", "block");
                $('#btn_save').css("display", "block");
                $('#btn_print').css("display", "block");
            }
            else {
                alert('There is no data found');
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });


}


function DisplayData(data) {


    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        "oTableTools": {
            "aButtons": [

						]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [
          { "sTitle": "Select",
              "mData": null,
              "bSortable": false,
              "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="madaniyu" ></center>'
          },

                     { "sTitle": "Semester", "mData": "semester", "bSortable": false },
                { "sTitle": "Code", "mData": "course_code", "bSortable": false },
                { "sTitle": "Name", "mData": "course_name", "bSortable": false },
                { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                { "sTitle": "faculty", "mData": "instructor", "bSortable": false },
                 { "sTitle": "Time", "mData": "time", "bSortable": false },
                 { "sTitle": "Days", "mData": "days", "bSortable": false }

           ]

    });

    //    .columnFilter({ sPlaceHolder: "head:before",
    //        aoColumns: [{ type: "text" },
    //				    	 		{ type: "date-range" },
    //                                    			{ type: "date-range" }
    //						]

    //    });

    get_fees_status();

    $("#example tbody tr").each(function (i) {

        debugger;
        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];
        debugger;
        if (saved_data != "") {


            for (var j = 0; j < saved_data.length; j++) {

                if (saved_data[j]["doc_no"] == a["doc_no"]) {


                    $(this).find(".madaniyu").prop('checked', true);

                }



            }
        }
        else {
            // listItems += "<option  value='" + exporess[i]["Document_number"] + "'>" + exporess[i]["expression"] + "</option>";
        }

    });





}


function get_fees_status() {

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_fees_status",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            //   alert('kamlesh');
            if (data.d != "") {

                fees_status = JSON.parse(data.d);





            }
            else {
              //  alert('There is no data found');
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });

    return false;


}
function get_mandatory_time_day_data() {


    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_mandatory_time_day_data",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                mandatory_time_day_data = JSON.parse(data.d);

                //alert(mandatory_time_day_data);

            }
            else {
                alert('There is no data found');
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });

    return false;


}


function DisplayData1(data) {


    if (oTable1 != null) {
        oTable1.fnDestroy();

        $("#datalist_elective").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="elective1"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#elective1").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',
        "bAutoWidth": false,
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "bJQueryUI": true,
        // "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oTableTools": {
            "aButtons": [

						]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [
          { "sTitle": "Select",
              "mData": null,
              "bSortable": false,

              "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_elective" ></center>'
          },
            { "sTitle": "Priority",
                "bSortable": false,
                "mData": null,

                fnRender: function (oObj) {

                    var listItems = '<select class="priority">';
                    listItems += "<option value='0'>Select</option>";
                    listItems += "<option value='1'>1</option>";
                    listItems += "<option value='2'>2</option>";
                    listItems += "<option value='3'>3</option>";
                    listItems += "<option value='4'>4</option>";
                    listItems += "<option value='5'>5</option>";
                    listItems += "<option value='6'>6</option>";
                    listItems += "<option value='7'>7</option>";
                    listItems += "<option value='8'>8</option>";
                    listItems += "<option value='9'>9</option>";
                    listItems += "<option value='10'>10</option>";
                    listItems += '</select>';



                    return listItems;



                }
            },
                { "sTitle": "Faculty", "mData": "department", "sWidth": "50px", "bSortable": false },
                { "sTitle": "Sem", "mData": "semester", "bSortable": false },
                { "sTitle": "Code", "mData": "course_code", "bSortable": false },
                { "sTitle": "Name", "mData": "course_name", "bSortable": false },
                { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                        { "sTitle": "faculty", "mData": "instructor", "bSortable": false },
                       { "sTitle": "Time", "mData": "time", "bSortable": false },
                         { "sTitle": "Days", "mData": "days", "bSortable": false },
                    { "sTitle": "Area", "mData": "area", "bSortable": false },
                                 { "sTitle": "GPA/Non GPA",
                                     "bSortable": false,
                                     "mData": null,

                                     fnRender: function (oObj) {

                                         var listItems = '<select class="gpa">';
                                         listItems += "<option value='0'>Select</option>";
                                         listItems += "<option value='G'>GPA</option>";
                                         listItems += "<option value='N'>Non GPA</option>";
                                         listItems += '</select>';



                                         return listItems;



                                     }
                                 }


           ]

    });




    $("#elective1 tbody tr").each(function (i) {

        debugger;
        var aPos = oTable1.fnGetPosition(this);
        var aData = oTable1.fnGetData(aPos[i]);
        var a = aData[i];

        if (saved_data != "") {

            for (var j = 0; j < saved_data.length; j++) {



                if (saved_data[j]["doc_no"] == a["doc_no"]) {


                    $(this).find(".chk_elective").prop('checked', true);

                    if (saved_data[j]["gpa_nongpa"] != '') {
                        $(this).find(".gpa").val(saved_data[j]["gpa_nongpa"]);
                        $(this).find(".priority").val(saved_data[j]["priority"]);
                    }

                }



            }
        }
        else {
            // listItems += "<option  value='" + exporess[i]["Document_number"] + "'>" + exporess[i]["expression"] + "</option>";
        }

    });


    //  new FixedHeader( oTable1 );
    //.columnFilter({

    //    aoColumns: [null,
    //    { sSelector: "#renderingEngineFilter" }

    //    				]
    //}
    //);

    //    $('#elective1 th').bind('mouseup', function (event) {
    //        var index = $(this).parent().children().index($(this));
    //        var colWidth = $(this).css('width');
    //        var input = $('#elective1 tfoot tr input:eq(' + index + ')');
    //        alert('kamlesh');
    //        input.css("width", colWidth);
    //    });

    //    $('#elective1 thead tr').find(':input').each(function (index) {
    //        var colWidth = $('#elective1 tbody tr th:eq(' + index + ')').css('width');
    //        var colWidth1 = $(this).css('width');
    //        var input = $('#elective1 tfoot tr input:eq(' + index + ')');
    //        alert(input + '-' + colWidth1);
    //        $(this).css("width", "42");
    //    });

    $("tfoot input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable1.fnFilter(this.value, $("tfoot input").index(this));
    });



    /*
    * Support functions to provide a little bit of 'user friendlyness' to the textboxes in
    * the footer
    */
    $("tfoot input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("tfoot input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("tfoot input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("tfoot input").index(this)];
        }
    });


}

