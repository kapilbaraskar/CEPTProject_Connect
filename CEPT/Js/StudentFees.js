var oTable;
var user_data;

var cad_user_data = "";

var fees_data = '';
var asInitVals = new Array();

$(document).ready(function () {


    $('#drpsemester,#drpdepartment,#drpyear,#drpprog').on('change', function () {

        $('#example tbody').html('');
        $('#btnsave').css('display', 'none');
    });

    bindyeardata_year();
    bindsemdata();
    binddepartment();
    bindyeardata();
    bindprogrammedata();
    ///Retrive data click on button event
    $('#btnreterive').on('click', function () {

        var semester = "";

        //        var semester = $('#drpsemester').val();
        //        if (semester == "") {
        //            bootbox.alert('Please select semester')
        //            $('#drpsemester').focus();
        //            return false;
        //        }
        var year_of_allocation = "";
        //        var year_of_allocation = $('#drp_year_allocation').val();
        //        if (year_of_allocation == "") {
        //            bootbox.alert('Please select year of allocation')
        //            $('#drp_year_allocation').focus();
        //            return false;
        //        }



        if ($('#drpsemester').val() == '')
        {
            bootbox.alert('Please select Semester')
            return false;
        }

        if ($('#drp_year').val() == '') {
            bootbox.alert('Please select Year')
            return false;
        }

        var dept_code = $('#drpdepartment').val();
        if (year == "") {
            $('#drpdepartment').focus();
            bootbox.alert('Please select department')
            return false;
        }

        var year = $('#drpyear').val();
        if (year == "") {
            bootbox.alert('Please select year of enrollment.')
            $('#drpyear').focus();
            return false;
        }

        var prog_code = $('#drpprog').val();
        if (prog_code == "") {
            bootbox.alert('Please select programme')
            $('#drpprog').focus();
            return false;
        }


        var data1 = "{ 'dept_code': '" + $('#drpdepartment').val() + "', 'sem_code':'" + semester + "',year_code : '" + $('#drpyear').val() + "',prog_code : '" + prog_code + "',year_of_allocation :'" + year_of_allocation + "', semster_code : '" + $('#drpsemester').val() + "', sem_year_code : '" + $('#drp_year').val() +"'}";

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_user_userfees",

            data: data1,
            dataType: "json",
            success: function (data) {

                if (data.d != "") {

                    //                    $.ajax({
                    //                        type: "POST",
                    //                        contentType: "application/json; charset=utf-8",
                    //                        url: "../../WebService.asmx/Get_student_fees_saved_data",
                    //                        async: false,
                    //                        data: data1,
                    //                        dataType: "json",
                    //                        success: function (data1) {

                    //                            if (data.d != "") {

                    //                                fees_data = JSON.parse(data1.d);

                    //                            }
                    //                            else {

                    //                                fees_data = '';
                    //                            }


                    //                        },
                    //                        error: function (result) {
                    //                            alert('error');
                    //                        }
                    //                    });



                    DisplayData(data.d);

                    $('#btnsave').css("display", "block");
                    $('#DataList').css('display', 'block');
                }
                else 
                {

                    bootbox.alert("There is no data found");
                    $('#btnsave').css("display", "none");
                    $('#DataList').css('display', 'none');
                }
            },
            error: function (result) {
                alert('error');
            }
        });
        return false;
    });

    $(document).on("click", ".send_mail", function (event) {

        debugger;
        var row = $(this).closest("tr").get(0);
        var aData = oTable.fnGetData(row);

        if (aData == null) {
            bootbox.alert("Problem in send mail");

            return false;
        }

        if (aData.mail == "") {

            bootbox.alert("Selected student's email id not found in master data.");

            return false;
        }
        else {

//            if (aData.mail != "kamlesh@aarintechnologies.com") {
//                return false;
//            }

        }
        if (aData.dept_code == "") {

            bootbox.alert("Selected student's department not Found in master data.");

            return false;
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/send_fees_status_mail",

            data: "{dept_code:'" + aData.dept_code + "',student_email:'" + aData.mail + "',user_id:'" + aData.user_id + "',user_name:'" + aData.user_name + "',prog_level_code:'" + aData.prog_level_code + "'}",

            dataType: "json",
            success: function (data) {

                debugger;
                if (data.d != "") {

                    if (data.d == "success") {
                        bootbox.alert('Mail sent');
                    }
                    else {
                        bootbox.alert(data.d);

                        return false;
                    }
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

    //save data on button event
    $('#btnsave').on('click', function () {
        debugger;
        var datalist = [];

        var oSettings = oTable.fnSettings();
        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }
        oSettings.oPreviousSearch.sSearch = '';
        oTable.fnDraw();
        // debugger;
        var checkbox_status = false;
        $('#example tbody tr').each(function (i) {

            var aPos = oTable.fnGetPosition(this);
            var a = oTable.fnGetData(aPos);
          //  var a = aData[aPos];

            var obj = {};
            if ($(this).find(".chk_select").is(':checked'))
            {
                checkbox_status = true;
            obj["user_id"] = a["user_id"];

            obj["fees_status"] = '';

            obj["installment_status"] = 'N';

            if ($(this).find(".chk_half_child").is(':checked')) {
                obj["fees_status"] = 'H';

            }
            else {

                if ($(this).find(".chk_full_child").is(':checked')) {
                    obj["fees_status"] = 'F';
                }

            }

            if ($(this).find(".chk_installment").is(':checked')) {
                obj["installment_status"] = 'Y';

            }

            // obj["fees_status"] = $(this).find(".cad_user").val();
            // obj["sem_code"] = $('#drpsemester').val();
            obj["dept_code"] = a["dept_code"];
            //obj["dept_code"] = $('#drpdepartment').val();
            obj["year_code"] = $('#drpyear').val();
            // obj["year_of_allocation"] = $('#drp_year_allocation').val();

                datalist.push(obj);
            }


        });
        if (checkbox_status == false)
        {
            bootbox.alert("Plese Select Student");
            return false;
        }
        //   var data = JSON.stringify({ fees_data: JSON.stringify(datalist), dept_code: $('#drpdepartment').val(), sem_code: "", year_code: $('#drpyear').val(), year_allocation: "" });
        var data = JSON.stringify({ fees_data: JSON.stringify(datalist), dept_code: $('#drpdepartment').val(), year_code: $('#drpyear').val() });
        //  var data = JSON.stringify({ fees_data: JSON.stringify({ fees_data: JSON.stringify(comman1) }) });

        $.ajax({
            type: "POST",
            url: "../../WebService.asmx/save_user_fees",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {


                bootbox.alert(data.d);
                // DisplayData(data.d);
                $('#btnsave').css("display", "block")


            },
            error: function (msg) { alert(msg.d); }
        });

        return false;
    });


    $(document).on("click", ".chk_half_parent", function (event) {
        var $this = $(this), $table = $this.closest("table"), $madaniya = null;
        if ($table.hasClass("dataTable")) {
            $table = $table.closest(".dataTables_wrapper");
        }
        $table.find(".chk_half_child").prop("checked", this.checked).change();
    }).on("click", ".chk_half_child", function () {
        var $this = $(this), $table = $this.closest("table"), $madaniya = null; $madaniya = null, checkedLength = 0;
        if ($table.hasClass("dataTable")) {
            $table = $table.closest(".dataTables_wrapper");
        }
        $madaniya = $table.find(".chk_half_child");
        checkedLength = $madaniya.filter(":checked").length;
        $table.find(".chk_half_parent").prop({ "indeterminate": checkedLength && checkedLength !== $madaniya.length, "checked": checkedLength === $madaniya.length });
    }).on("change", ".chk_half_child", function () {
        if (this.checked) {
            //  addSelection(this.value);
        } else {
            // removeSelection(this.value);
        }
    });


    $(document).on("click", ".chk_full_parent", function (event) {
        var $this = $(this), $table = $this.closest("table"), $madaniya = null;
        if ($table.hasClass("dataTable")) {
            $table = $table.closest(".dataTables_wrapper");
        }
        $table.find(".chk_full_child").prop("checked", this.checked).change();
    }).on("click", ".chk_full_child", function () {
        var $this = $(this), $table = $this.closest("table"), $madaniya = null; $madaniya = null, checkedLength = 0;
        if ($table.hasClass("dataTable")) {
            $table = $table.closest(".dataTables_wrapper");
        }
        $madaniya = $table.find(".chk_full_child");
        checkedLength = $madaniya.filter(":checked").length;
        $table.find(".chk_full_parent").prop({ "indeterminate": checkedLength && checkedLength !== $madaniya.length, "checked": checkedLength === $madaniya.length });
    }).on("change", ".chk_full_child", function () {
        if (this.checked) {
            //  addSelection(this.value);
        } else {
            // removeSelection(this.value);
        }
    });


    $('#btnreterive_fees_report').on('click', function () {

        var semester = "";

        //        var semester = $('#drpsemester').val();
        //        if (semester == "") {
        //            bootbox.alert('Please select semester')
        //            $('#drpsemester').focus();
        //            return false;
        //        }
        var year_of_allocation = "";
        //        var year_of_allocation = $('#drp_year_allocation').val();
        //        if (year_of_allocation == "") {
        //            bootbox.alert('Please select year of allocation')
        //            $('#drp_year_allocation').focus();
        //            return false;
        //        }



        var dept_code = $('#drpdepartment').val();
        if (year == "") {
            $('#drpdepartment').focus();
            bootbox.alert('Please select department')
            return false;
        }

        var year = $('#drpyear').val();
//        if (year == "") {
//            bootbox.alert('Please select year of enrollment.')
//            $('#drpyear').focus();
//            return false;
//        }

        var prog_code = $('#drpprog').val();
//        if (prog_code == "") {
//            bootbox.alert('Please select programme')
//            $('#drpprog').focus();
//            return false;
//        }


        var data1 = "{ 'dept_code': '" + $('#drpdepartment').val() + "', 'sem_code':'" + semester + "',year_code : '" + $('#drpyear').val() + "',prog_code : '" + prog_code + "',year_of_allocation :'" + year_of_allocation + "'}";

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_student_fees_with_credit_choice",

            data: data1,
            dataType: "json",
            success: function (data) {

                if (data.d != "") {


                    DisplayData_creditchoice(data.d);

                    $('#btnsave').css("display", "block");
                    $('#DataList').css('display', 'block');
                }
                else {

                    bootbox.alert("There is no data found");
                    $('#btnsave').css("display", "none");
                    $('#DataList').css('display', 'none');
                }
            },
            error: function (result) {
                alert('error');
            }
        });
        return false;
    });

});

$(document).on("click", ".chk_half_child", function (event) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);



    $(row).find(".chk_full_child").prop('checked', false);



});

$(document).on("click", ".chk_half_parent", function (event) {


    var $this = $(this);
    $table = $this.closest("table");
    $table.find(".chk_full_parent").prop("checked", false).change();


    $("#example tbody tr").each(function (j) {


        $(this).find(".chk_full_child").prop('checked', false);
    });

});


$(document).on("click", ".chk_full_child", function (event) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);



    $(row).find(".chk_half_child").prop('checked', false);



});

$(document).on("click", ".chk_full_parent", function (event) {


    var $this = $(this);
    $table = $this.closest("table");
    $table.find(".chk_half_parent").prop("checked", false).change();



    $("#example tbody tr").each(function (j) {

        $(this).find(".chk_half_child").prop('checked', false);
    });

});

function DisplayData(data) {


    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,

        "sDom": 't',
        "bSortable": false,
        //"sScrollY": "400px",

        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oTableTools": {
            "aButtons": [
            //							"copy",
            //							"print",
            //							{
            //							    "sExtends": "collection",
            //							    "sButtonText": 'Export',
            //							    "aButtons": ["csv", "xls", "pdf"]
            //							}
						]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [
            {
                "sTitle": "",
                "mData": null,
                "bSortable": false,
                "sDefaultContent": '<center><input type="checkbox" name="checkselect" value="3" class="chk_select" ></center>'
            },

         { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
          { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
           { "sTitle": "Credits applied for<center><input type='checkbox' name='checkheader'  class='chk_half_parent'></input></center>",
               "mData": null,
               "bSortable": false,
               "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_half_child" ></center>'
           },
           { "sTitle": " Full Fees<center><input type='checkbox' name='checkheader1'  class='chk_full_parent'></input></center>",
               "mData": null,
               "bSortable": false,
               "sDefaultContent": '<center><input type="checkbox"  name="check2" value="2" class="chk_full_child" ></center>'
           },
           { "sTitle": " Installment<center></center>",
               "mData": null,
               "bSortable": false,
               "sDefaultContent": '<center><input type="checkbox"  name="check3" value="2" class="chk_installment" ></center>'
           },
           { "sTitle": " Send mail<center></center>",
               "mData": null,
               "bSortable": false,
               "sDefaultContent": '<center><a href="#" style="text-decoration:none;" class="send_mail" title="Send Mail"><i class="icon-mail-forward"></i></a></center>'
           }


            ]


    });

    //    new FixedHeader(oTable);

    $("#example tbody tr").each(function (i) {


        //        if (fees_data != "") {

        var aPos = oTable.fnGetPosition(this);
        var a = oTable.fnGetData(aPos);

//        var aPos = oTable.fnGetPosition(this);
//        var aData = oTable.fnGetData(aPos[i]);
//        var a = aData[i];

        if (a["fees_status"] != "0") {

            if (a["fees_status"] == 'H') {
                $(this).find(".chk_half_child").prop('checked', true);
            }

            if (a["fees_status"] == 'F') {
                $(this).find(".chk_full_child").prop('checked', true);
            }

            if (a["installment_status"] == 'Y') {
                $(this).find(".chk_installment").prop('checked', true);
            }

        }

        //        for (var j = 0; j < fees_data.length; j++) {

        //                if (fees_data[j]["user_id"] == a["user_id"]) {

        //                    if (fees_data[j]["fees_status"] != "0") {

        //                        if (fees_data[j]["fees_status"] == 'H') {
        //                            $(this).find(".chk_half_child").prop('checked', true);
        //                        }

        //                        if (fees_data[j]["fees_status"] == 'F') {
        //                            $(this).find(".chk_full_child").prop('checked', true);
        //                        }

        //                        if (fees_data[j]["installment_status"] == 'Y') {
        //                            $(this).find(".chk_installment").prop('checked', true);
        //                        }

        //                    }
        //                }
        //  }
        //     }
        else {

        }

    });





}

function bindyeardata() {

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
                // $('#drp_year_allocation').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                for (var i = 0; i < year_data.length; i++) {


                    $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                    //  $('#drp_year_allocation').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear').chosen();
                // $('#drp_year_allocation').chosen();
            }

        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindsemdata() {

    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));


    $('#drpsemester').chosen();

}

function bindsemesterdata() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_semester_data",

        data: "{}",
        dataType: "json",
        success: function (data) {




            if (data.d != "") {


                var sem_data = JSON.parse(data.d)



                $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                for (var i = 0; i < sem_data.length; i++) {


                    $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));
                }

                $('#drpsemester').chosen();
            }

        },
        error: function (result) {
            alert(result);
        }
    });
}
function binddepartment() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_department_data",

        data: "{}",
        dataType: "json",
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

function bindprogrammedata() {

    $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

    $('#drpprog').chosen();
}

function DisplayData_creditchoice(data) {


    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,

        //"sDom": 't',
        "bSortable": false,
        //"sScrollY": "400px",


        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"oTableTools": {
        //    "aButtons": [
        //    //							"copy",
        //    //							"print",
        //    //							{
        //    //							    "sExtends": "collection",
        //    //							    "sButtonText": 'Export',
        //    //							    "aButtons": ["csv", "xls", "pdf"]
        //    //							}
		//				]
        //},

        "aaData": JSON.parse(data),
        "aoColumns": [
         { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
          { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
          { "sTitle": "Paid Fees Status", "mData": "paid_fees_status", "bSortable": false },
           { "sTitle": "Selected Fees Status", "mData": "fees_status", "bSortable": false },
                { "sTitle": "Selected Credit choice", "mData": "credit_choice", "bSortable": false }
//                 { "sTitle": "Selected Partial Credits", "mData": "credit_selected", "bSortable": false }
            ]
    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 
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

    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function bindyeardata_year() {
    debugger
    $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_year_data",
            async: false,
            data: "{}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    var year_data = JSON.parse(data.d)
                    $('#drp_year').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                    for (var i = 0; i < year_data.length; i++) {
                        $('#drp_year').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                    }

                    $('#drp_year').chosen();
                }
            },
            error: function (result) {
                alert(result);
            }
        });
}




    

