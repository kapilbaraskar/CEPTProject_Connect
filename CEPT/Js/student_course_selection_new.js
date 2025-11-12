
var oTable;
var oTable1;
var fees_status;
var mandatory_time_day_data;
var total_creadit = 0;
var mandatory_credit = 0;
var elective_credit = 0;
var asInitVals = new Array();
var saved_data;

$(document).ready(function () {


    $('[data-rel=tooltip]').tooltip();
    $('[data-rel=popover]').popover({ html: true });

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



        if (total_creadit == '0') {
            bootbox.alert('Please Select Course. You are not Selected Any course');
            return false;
        }


        var flag = "N";

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

                var course_code = $(this).children().eq(2).html();
                if ($(this).find(".gpa").val() == '0') {
                    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);
                    //                    total_creadit = total_creadit - parseInt(aData["credits"]);
                    //                    elective_credit = elective_credit - parseInt(aData["credits"]);

                    //                    $('#lbl_elective').html(elective_credit);
                    //                    checkbox.checked = false;
                    flag = 'Y';
                    return false;
                }

                if ($(this).find(".priority").val() == '0') {
                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                    //                    total_creadit = total_creadit - parseInt(aData["credits"]);
                    //                    elective_credit = elective_credit - parseInt(aData["credits"]);

                    //                    $('#lbl_elective').html(elective_credit);
                    //                    checkbox.checked = false;
                    flag = 'Y';
                    return false;
                }

                var obj = {};

                obj["department"] = $(this).children().eq(6).html();

                var aPos = oTable1.fnGetPosition(this);
                var aData = oTable1.fnGetData(aPos[i]);
                var a = aData[i];

                //                ob["semester_code"] = $(this).children().eq(3).html();


                obj["semester_code"] = a["semester"];

                // obj["semester_code"] = $(this).children().eq(3).html();
                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();
                obj["gpa_nongpa"] = $(this).find(".gpa").val();
                obj["priority"] = $(this).find(".priority").val();

                elective_datalist.push(obj);
            }
        });

        if (flag == "N") {


            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'S' });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Save_student_course_dtl",
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
        }


        return false;

    });



    $('#btn_print').on('click', function () {


        window.open('Print_pay_in_slip.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
        return false;

    });


    $('#btnsave').on('click', function () {



        if (total_creadit == '0') {
            bootbox.alert('Please Select Course. You are not Selected Any course');
            return false;
        }


        //        if (total_creadit > 0) {


        //            // alert(total_creadit);
        //            if (fees_status != '') {



        //                if (fees_status[0]["fees_status"] == 'H') {

        //                    if (total_creadit > 12) {

        //                        bootbox.alert("You Can Select Max 12 Creadits because You paid Half Fees.Your current total credit selection is " + total_creadit);
        //                        return false;

        //                    }



        //                }
        //                else if (fees_status[0]["fees_status"] == 'F') {

        //                    if (total_creadit > 24) {

        //                        bootbox.alert("You Can Select Max 24 Creadits.Your current total credit selection is " + total_creadit);
        //                        return false;

        //                    }



        //                }
        //            }

        //        }




        var flag = "N";
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

                var course_code = $(this).children().eq(2).html();
                if ($(this).find(".gpa").val() == '0') {
                    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);

                    flag = 'Y';
                    return false;
                }

                if ($(this).find(".priority").val() == '0') {
                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);

                    flag = 'Y';
                    return false;
                }



                var obj = {};

                obj["department"] = $(this).children().eq(6).html();


                var aPos = oTable1.fnGetPosition(this);
                var aData = oTable1.fnGetData(aPos[i]);
                var a = aData[i];

                //                ob["semester_code"] = $(this).children().eq(3).html();


                obj["semester_code"] = a["semester"];

                // obj["semester_code"] = $(this).children().eq(3).html();
                obj["course_code"] = $(this).children().eq(2).html();
                obj["credits"] = $(this).children().eq(4).html();
                obj["gpa_nongpa"] = $(this).find(".gpa").val();
                obj["priority"] = $(this).find(".priority").val();

                elective_datalist.push(obj);
            }
        });



        if (flag == "N") {

            bootbox.confirm("Please check all the courses you have selected. \nOnce registered for course you will not be able to change the courses.", function (result) {

                if (result == true) {

                    bootbox.confirm("Are you sure for register?", function (result1) {

                        if (result1 == true) {

                            var data = JSON.stringify({ mandatory_course: JSON.stringify(mandatory_datalist), elective_course: JSON.stringify(elective_datalist), status_flag: 'R' });

                            $.ajax({
                                type: "POST",
                                url: "../WebService.asmx/Save_student_course_dtl",
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
                        }

                    });

                }
                else {


                }

            });




        }


        return false;
    });




    bind_sem_course_data();

    chek_fees_status();



});


$(document).on("change", ".priority", function (event) {


    var val = $(this).val();



    var control = $(this);
    var flag = 'Y';
    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);
    var course_code = aData["course_code"];
    var counter = 0;
    var check_flag = 'N';
    //  var Faculty = aData["department"];

    //generateSelectedAreas();

    $("#elective1 tbody tr").each(function (j) {
        //        var $selects = $('.priority');
        //        $('.priority').change(function () {
        //            debugger;
        //            alert('loop');
        //            $('option:hidden', $selects).each(function () {
        //                debugger;
        //                var self = this,
        //		            toShow = true;
        //                $selects.not($(this).parent()).each(function () {
        //                    if (self.value == this.value) toShow = false;
        //                })
        //                if (toShow) $(this).show();
        //            });
        //            if (this.value != 0) //to keep default option available
        //                $selects.not(this).children('option[value=' + this.value + ']').hide();
        //        });

        if ($(this).find(".priority").val() != '0') {

            counter = counter + 1;

            if (course_code != $(this).children().eq(2).html()) {
                if (val == $(this).find(".priority").val()) {
                    bootbox.alert('You already Select this Priority for Course  Code : ' + $(this).children().eq(2).html());

                    control.val("0");

                    return false;
                }



            }




            //   alert($(this).children().eq(3).html());
        }
    });


    debugger;

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

            if (val == 0) {

            }
            else {
                bootbox.alert("Please Select Priority in Sequence");
                control.val("0");
            }

        }
    }
    generateSelectedAreas();
});
function generateSelectedAreas() {
    var selectedValues = [];


    //enable all options, otherwise they overlap and cause probl
    $('.priority option').each(function () {
        $(this).css('display', 'block');
    });

    $('.priority option:selected').each(function () {
        var select = $(this).parent(),
           optValue = $(this).val();

        if ($(this).val() != '0') {
            $('.priority').not(select).children().filter(function (e) {
                if ($(this).val() == optValue)
                    return e
            }).css('display', 'none');
        }
    });
}

$(document).on("click", ".madaniyu", function (event) {
    var checkbox = this;
    var datalist = [];
    var datalist1 = [];
    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);
    var course_code = aData["course_code"];
    var sem_code = aData["semester"];
    var creadits = aData["credits"];





    //    if (fees_status != '') {


    //        if (fees_status[0]["fees_status"] == 'H') {

    //            debugger;

    //            if (this.checked) {

    //                total_creadit = total_creadit + parseInt(aData["credits"]);


    //                if (total_creadit > fees_status[0]["fees_credits"]) {

    //                    bootbox.alert("You Select Max 12 Creadits");
    //                    $(this).prop("checked", false);

    //                    total_creadit = total_creadit - parseInt(aData["credits"]);

    //                    return false;

    //                }
    //                // alert(total_creadit);

    //            }
    //            else {

    //                total_creadit = total_creadit - parseInt(aData["credits"]);

    //                // alert(total_creadit);
    //            }

    //        }
    //        else if (fees_status[0]["fees_status"] == 'F') {

    //            if (this.checked) {

    //                total_creadit = total_creadit + parseInt(aData["credits"]);


    //                if (total_creadit > fees_status[0]["fees_credits"]) {

    //                    bootbox.alert("You Select Max 24 Creadits");
    //                    $(this).prop("checked", false);

    //                    total_creadit = total_creadit - parseInt(aData["credits"]);
    //                    return false;
    //                }
    //                //            alert(total_creadit);

    //            }
    //            else {

    //                total_creadit = total_creadit - parseInt(aData["credits"]);
    //                //            alert(total_creadit);
    //            }

    //        }
    //    }



    if (this.checked) {

        total_creadit = total_creadit + parseInt(aData["credits"]);

        mandatory_credit = mandatory_credit + parseInt(aData["credits"]);

        $('#lbl_mandatory').html(mandatory_credit);
        if (total_creadit > 30) {

            bootbox.alert("You Select Max 30 Creadits for save your courses.");
            $(this).prop("checked", false);

            total_creadit = total_creadit - parseInt(aData["credits"]);

            mandatory_credit = mandatory_credit - parseInt(aData["credits"]);

            $('#lbl_mandatory').html(mandatory_credit);

            return false;

        }
        // alert(total_creadit);
        // alert(total_creadit);

    }
    else {

        total_creadit = total_creadit - parseInt(aData["credits"]);


        mandatory_credit = mandatory_credit - parseInt(aData["credits"]);

        $('#lbl_mandatory').html(mandatory_credit);
        // alert(total_creadit);
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

                        var aPos = oTable1.fnGetPosition(this);
                        var aData = oTable1.fnGetData(aPos[i]);
                        var a = aData[i];

                        //                ob["semester_code"] = $(this).children().eq(3).html();


                        ob1["semester_code"] = a["semester"];

                        //                        ob1["semester_code"] = $(this).children().eq(3).html();




                        ob1["course_code"] = $(this).children().eq(2).html();

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
            url: "../WebService.asmx/Check_time_validation",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {
                    bootbox.alert(data.d);

                    checkbox.checked = false;
                    total_creadit = total_creadit - parseInt(aData["credits"]);

                    mandatory_credit = mandatory_credit - parseInt(aData["credits"]);

                    $('#lbl_mandatory').html(mandatory_credit);
                }


            },
            error: function (msg) { alert(msg.d); }
        });

    }
    //
    //  alert(total_creadit);
});

$(document).on("click", ".chk_elective", function (event) {
    debugger;
    //var nNodes = oTable1.fnGetNodes();
    //oTable1.fnFilter('');
    //    var oSettings = oTable1.fnSettings();
    //    for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
    //        oSettings.aoPreSearchCols[iCol].sSearch = '';
    //    }
    //    oSettings.oPreviousSearch.sSearch = '';
    //    oTable1.fnDraw();
    var checkbox = this;
    var datalist = [];
    var datalist1 = [];
    var row = $(this).closest("tr").get(0);
    var aData = oTable1.fnGetData(row);

    var flag = 'N';

    var course_code = aData["course_code"];
    var sem_code = aData["semester"];
    var creadits = aData["credits"];



    //    if (fees_status != '') {



    //        if (fees_status[0]["fees_status"] == 'H') {

    //            debugger;

    //            if (this.checked) {

    //                //alert(aData["course_code"]);
    //                total_creadit = total_creadit + parseInt(aData["credits"]);


    //                if (total_creadit > fees_status[0]["fees_credits"]) {

    //                    bootbox.alert("You Select Max 12 Creadits");
    //                    $(this).prop("checked", false);

    //                    total_creadit = total_creadit - parseInt(aData["credits"]);
    //                    return false;
    //                }
    //                //  alert(total_creadit);

    //            }
    //            else {

    //                total_creadit = total_creadit - parseInt(aData["credits"]);
    //                //alert(total_creadit);
    //            }

    //        }
    //        else if (fees_status[0]["fees_status"] == 'F') {

    //            if (this.checked) {

    //                total_creadit = total_creadit + parseInt(aData["credits"]);


    //                if (total_creadit > fees_status[0]["fees_credits"]) {

    //                    bootbox.alert("You Select Max 24 Creadits");
    //                    $(this).prop("checked", false);

    //                    total_creadit = total_creadit - parseInt(aData["credits"]);
    //                    return false;
    //                }


    //            }
    //            else {

    //                total_creadit = total_creadit - parseInt(aData["credits"]);

    //            }

    //        }
    //    }


    if (this.checked) {

        total_creadit = total_creadit + parseInt(aData["credits"]);

        elective_credit = elective_credit + parseInt(aData["credits"]);
        $('#lbl_elective').html(elective_credit);
        if (total_creadit > 30) {

            bootbox.alert("You Select Max 30 Creadits for save your courses.");
            $(this).prop("checked", false);

            total_creadit = total_creadit - parseInt(aData["credits"]);
            elective_credit = elective_credit - parseInt(aData["credits"]);

            $('#lbl_elective').html(elective_credit);
            return false;

        }

        // alert(total_creadit);

    }
    else {

        total_creadit = total_creadit - parseInt(aData["credits"]);
        elective_credit = elective_credit - parseInt(aData["credits"]);
        $('#lbl_elective').html(elective_credit);

        // alert(total_creadit);
    }


    if (this.checked) {


        $("#elective1 tbody tr").each(function (i) {

            debugger;
            if ($(this).find(".chk_elective").is(':checked')) {



                //commet by kamlesh///
                //                if (course_code == $(this).children().eq(4).html()) {
                //                    if ($(this).find(".gpa").val() == '0') {
                //                        bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);
                //                        total_creadit = total_creadit - parseInt(aData["credits"]);
                //                        elective_credit = elective_credit - parseInt(aData["credits"]);

                //                        $('#lbl_elective').html(elective_credit);
                //                        checkbox.checked = false;
                //                        flag = 'Y';
                //                        return false;
                //                    }

                //                    if ($(this).find(".priority").val() == '0') {
                //                        bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                //                        total_creadit = total_creadit - parseInt(aData["credits"]);
                //                        elective_credit = elective_credit - parseInt(aData["credits"]);

                //                        $('#lbl_elective').html(elective_credit);
                //                        checkbox.checked = false;
                //                        flag = 'Y';
                //                        return false;
                //                    }
                //                }


                var ob = {};


                debugger;

                var aPos = oTable1.fnGetPosition(this);
                var aData = oTable1.fnGetData(aPos[i]);
                var a = aData[i];

                //                ob["semester_code"] = $(this).children().eq(3).html();


                ob["semester_code"] = a["semester"];
                ob["course_code"] = $(this).children().eq(2).html();

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

        //        if (flag == 'Y') {
        //            return false;
        //        }

        var data = JSON.stringify({ mandatory_time: JSON.stringify(datalist), elective_time: JSON.stringify(datalist1), course_code: course_code, sem_code: sem_code, flag: 'E' });
        $.ajax({
            type: "POST",
            url: "../WebService.asmx/Check_time_validation",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {
                    debugger;



                    if (data.d == "Error") {

                    }
                    else {



                        var split_data = data.d.split(":");

                        if (split_data[0] == "ok") {




                            $("#elective1 tbody tr").each(function (i) {


                                if ($(this).find(".chk_elective").is(':checked')) {



                                    //commet by kamlesh///

                                    if (course_code == $(this).children().eq(2).html()) {
                                        if ($(this).find(".priority").val() == '0') {
                                            bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                                            total_creadit = total_creadit - parseInt(aData["credits"]);
                                            elective_credit = elective_credit - parseInt(aData["credits"]);

                                            $('#lbl_elective').html(elective_credit);
                                            checkbox.checked = false;

                                            //return false;
                                        }

                                        if ($(this).find(".gpa").val() == '0') {
                                            bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);

                                            if ($(this).find(".priority").val() != '0') {
                                                total_creadit = total_creadit - parseInt(aData["credits"]);
                                                elective_credit = elective_credit - parseInt(aData["credits"]);

                                                $('#lbl_elective').html(elective_credit);
                                                checkbox.checked = false;
                                            }

                                            // return false;
                                        }

                                    }
                                }
                            });

                            bootbox.alert(split_data[1]);



                        }
                        else {
                            checkbox.checked = false;
                            total_creadit = total_creadit - parseInt(aData["credits"]);
                            elective_credit = elective_credit - parseInt(aData["credits"]);

                            $('#lbl_elective').html(elective_credit);
                            bootbox.alert(data.d);
                        }


                    }




                }
                else {

                    $("#elective1 tbody tr").each(function (i) {


                        if ($(this).find(".chk_elective").is(':checked')) {



                            //commet by kamlesh///

                            if (course_code == $(this).children().eq(2).html()) {


                                if ($(this).find(".gpa").val() == '0') {
                                    bootbox.alert('Please Select GPA/Non GPA For Course Code : ' + course_code);

                                    total_creadit = total_creadit - parseInt(aData["credits"]);
                                    elective_credit = elective_credit - parseInt(aData["credits"]);

                                    $('#lbl_elective').html(elective_credit);
                                    checkbox.checked = false;

                                    return false;
                                    // return false;
                                }

                                if ($(this).find(".priority").val() == '0') {
                                    bootbox.alert('Please Select Priority No. For Course Code : ' + course_code);
                                    total_creadit = total_creadit - parseInt(aData["credits"]);
                                    elective_credit = elective_credit - parseInt(aData["credits"]);

                                    $('#lbl_elective').html(elective_credit);
                                    checkbox.checked = false;

                                    return false;
                                }

                            }
                        }
                    });

                }

                return false;
            },
            error: function (msg) { alert(msg.d); }
        });

    }


});



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
        url: "../WebService.asmx/Get_saved_student_course_data",
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
        url: "../WebService.asmx/Get_mandatory_course_data_for_student",
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

                if (data.d == 'There are no mandatory courses available') {

                    bootbox.alert('There are no mandatory courses available for your department');
                    return false;

                }

                $.ajax({
                    async: false,
                    type: "POST",
                    url: "../WebService.asmx/Get_saved_student_course_data",
                    data: {},
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    success: function (data) {

                        if (data.d != "") {


                            mandatory_credit = 0;
                            elective_credit = 0;
                            saved_data = JSON.parse(data.d);

                            //  alert(saved_data);

                            if (saved_data != "") {
                                for (var i = 0; i < saved_data.length; i++) {
                                    total_creadit = total_creadit + parseInt(saved_data[i]["credits"]);

                                    if (saved_data[i]["course_type"] == "M") {
                                        mandatory_credit = mandatory_credit + parseInt(saved_data[i]["credits"]);
                                    }
                                    else {
                                        elective_credit = elective_credit + parseInt(saved_data[i]["credits"]);
                                    }
                                    //                        alert(total_creadit);
                                }
                                $('#lbl_mandatory').html(mandatory_credit);
                                $('#lbl_elective').html(elective_credit);

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
        url: "../WebService.asmx/Get_elective_course_data_for_student",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                if (data.d == "fees not found") {


                    return false;


                }

                if (data.d == "no data") {
                    bootbox.alert("There are no elective courses available for your department");
                    return false;
                }

                $.ajax({
                    async: false,
                    type: "POST",
                    url: "../WebService.asmx/Get_saved_student_course_data",
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

    debugger;

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> <tfoot id="abc"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 5px; display: none" name="search_engine" value=""class="search_init" /></th><th><input type="text" style="width: 35px" name="search_engine" value="" class="search_init" /></th><th><center><input type="text" style="width: 54px;" name="search_Faculty" value="" class="search_init" /></center></th><th><input type="text" style="width: 86px" name="search_semester" value="" class="search_init" /></th><th><input type="text" style="width: 25px" name="search_code" value="" class="search_init" /></th><th><center><input type="text" style="width: 95px" name="search_name" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 47px" name="search_credits" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 50px" name="search_pre" value="" class="search_init" /></center></th><th><center><input type="text" style="width: 100px" name="search_instructor" value="" class="search_init" /></center></th></tr></tfoot> </tbody> </table>');
    }


    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
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

                     { "sTitle": "Sem.", "mData": "semester", "bSortable": false },
                { "sTitle": "Code", "mData": "course_code", "bSortable": false },
                { "sTitle": "Name", "mData": "course_name", "bSortable": false },
                { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                { "sTitle": "faculty", "mData": "instructor", "bSortable": false },
                 { "sTitle": "Time", "mData": "time", "bSortable": false },
                 { "sTitle": "Days", "mData": "days", "bSortable": false },
                     { "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false }

           ],
        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            /* imagine aData[0] is an object, not a string {text: 'X1', title: 'Title X1'} */
            $('td:eq(3)', nRow).attr('title', aData.course_desc).tooltip();
            $('td:eq(3)', nRow).css({ cursor: "pointer" });
            return nRow;
        }

    });

    //    .columnFilter({ sPlaceHolder: "head:before",
    //        aoColumns: [{ type: "text" },
    //				    	 		{ type: "date-range" },
    //                                    			{ type: "date-range" }
    //						]

    //    });

    get_fees_status();

    $("#example tbody tr").each(function (i) {


        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];

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

    debugger;
    $("#abc input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("#abc input").index(this));
    });



    /*
    * Support functions to provide a little bit of 'user friendlyness' to the textboxes in
    * the footer
    */
    $("#abc input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("#abc input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("#abc input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("#abc input").index(this)];
        }
    });



}


function get_fees_status() {

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_fees_status",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            //   alert('kamlesh');
            if (data.d != "") {

                fees_status = JSON.parse(data.d);





            }
            else {
                fees_status = '';
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
        url: "../WebService.asmx/Get_mandatory_time_day_data",
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

        $("#datalist_elective").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="elective1"><thead></thead><tbody> </tbody><tfoot id="abc1"><tr><th>Search <i class="icon-on-right icon-arrow-right"></i><input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th><input type="text" style="width: 10px; display: none" name="search_engine" value="Search engines"class="search_init" /></th><th><input type="text" style="width: 30px" name="search_code" value="" class="search_init" /></th><th><input type="text" style="width: 79px" name="search_name" value="" class="search_init" /></th><th><input type="text" style="width: 10px" name="search_credits" value="" class="search_init" /></th><th><input type="text" style="width: 70px;" name="search_pre" value="" class="search_init" /></th><th><input type="text" style="width: 50px;" name="search_Faculty" value="" class="search_init" /></th><th><input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" /></th><th> <input type="text" style="width: 48px" name="search_time" value="" class="search_init"></th><th><input type="text" style="width: 48px" name="search_days" value="" class="search_init" /></th><th><input type="text" style="width: 72px" name="search_Area" value="" class="search_init" /></th><th><input type="text" style="width: 1px; display: none" name="search_Area" value="Area"class="search_init" /></th> </tr></tfoot></table>');

    }

    oTable1 = $("#elective1").dataTable({

        "bPaginate": false,
        "bStateSave": false,

        //        "fnStateLoad": function (oSettings) {
        //            return false;
        //        },
        //        "sDom": 't',
        "bAutoWidth": false,
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "bJQueryUI": true,
        // "sScrollY": '400px',
        //        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
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

                { "sTitle": "Code", "mData": "course_code", "bSortable": false },
                { "sTitle": "Name", "mData": "course_name", "bWidth": "5px", "bSortable": false },
                { "sTitle": "Credits", "mData": "credits", "bSortable": false },
                    { "sTitle": "Prerequisite", "mData": "prerequisite", "bSortable": false },
                { "sTitle": "Faculty", "mData": "department", "bSortable": false },

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
                                 },
                                       { "sTitle": "Sem", "mData": "semester", "bSortable": false, "bVisible": false, "aTargets": [0] }



           ],
        "fnRowCallback": function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
            /* imagine aData[0] is an object, not a string {text: 'X1', title: 'Title X1'} */
            $('td:eq(3)', nRow).attr('title', aData.course_desc).tooltip();
            $('td:eq(3)', nRow).css({ cursor: "pointer" });
            return nRow;
        }

    });
    //    .columnFilter({
    //        aoColumns: [null
    //        //        { sSelector: "#renderingEngineFilter" }

    //                                    				]
    //    });

    //    new FixedHeader(oTable1);


    $("#elective1 tbody tr").each(function (i) {


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





    //    .columnFilter({

    //        aoColumns: [null,
    //        { sSelector: "#renderingEngineFilter" }

    //        				]
    //    }
    //    );

    generateSelectedAreas();

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

    $("#abc1 input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable1.fnFilter(this.value, $("#abc1 input").index(this));
    });



    /*
    * Support functions to provide a little bit of 'user friendlyness' to the textboxes in
    * the footer
    */
    $("#abc1 input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("#abc1 input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("#abc1 input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("#abc1 input").index(this)];
        }
    });


}

function chek_fees_status() {

    $.ajax({
        type: "POST",
        url: "../WebService.asmx/Get_fees_status",
        data: {},
        contentType: "application/json",
        datatype: "json",
        async: false,
        success: function (data) {

            debugger;
            //   alert('kamlesh');
            if (data.d != "") {

                fees_status = JSON.parse(data.d);

                if (fees_status[0]["fees_status"] != "") {



                    if (fees_status[0]["fees_status"] == "H") {


                    }
                    else if (fees_status[0]["fees_status"] == "F") {


                    }
                    else {
                        $('#btnsave').prop("disabled", true);
                    }
                }
                else {
                    $('#btnsave').prop("disabled", true);
                }



            }
            else {
                $('#btnsave').prop("disabled", true);
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });

}