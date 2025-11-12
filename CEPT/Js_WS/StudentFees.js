var oTable;
var user_data;

var cad_user_data = "";

var fees_data = '';

$(document).ready(function () {

    bindsemesterdata();
    binddepartment();
    bindyeardata();
    bindprogrammedata();



    ///Retrive data click on button event
    $('#btnreterive').on('click', function () {



        //        var semester = $('#drpsemester').val();
        //        if (semester == "") {
        //            bootbox.alert('Please select semester')
        //            $('#drpsemester').focus();
        //            return false;
        //        }





        var dept_code = $('#drpdepartment').val();
        if (dept_code == "") {
            $('#drpdepartment').focus();
            bootbox.alert('Please select department')
            return false;
        }

        var prog_code = "";
        var year = "";
        if (dept_code == "7") {

        }
        else {

            year = $('#drpyear').val();
            if (year == "") {
                bootbox.alert('Please select year')
                $('#drpyear').focus();
                return false;
            }

            prog_code = $('#drpprog').val();
            if (prog_code == "") {
                bootbox.alert('Please select programme')
                $('#drpprog').focus();
                return false;
            }
        }

        var data1 = "{ 'dept_code': '" + $('#drpdepartment').val() + "', 'year_code' : '" + $('#drpyear').val() + "','prog_code' : '" + prog_code + "'}";
        var inner = "{ 'dept_code': '" + $('#drpdepartment').val() + "', 'year_code' : '" + $('#drpyear').val() + "'}";

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/Get_ws_user_userfees",

            data: data1,
            dataType: "json",
            success: function (data) {

                if (data.d != "") {

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService_WS.asmx/Get_ws_student_fees_saved_data",
                        async: false,
                        data: inner,
                        dataType: "json",
                        success: function (data1) {

                            if (data1.d != "") {



                                fees_data = JSON.parse(data1.d);




                            }
                            else {

                                fees_data = '';
                            }


                        },
                        error: function (result) {
                            alert('error');
                        }
                    });



                    DisplayData(data.d);

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
    //save data on button event
    $('#btnsave').on('click', function () {

        var datalist = [];

        var oSettings = oTable.fnSettings();

        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }

        oSettings.oPreviousSearch.sSearch = '';
        oTable.fnDraw();

        $('#example tbody tr').each(function (i) {

            var aPos = oTable.fnGetPosition(this);
            //            var aData = oTable.fnGetData(aPos[i]);
            //            var a = aData[i];
            var a = oTable.fnGetData(aPos);

            var obj = {};

            obj["user_id"] = a["user_id"];



            obj["fees_status"] = 'N';

            if ($(this).find(".chk_full_child").is(':checked')) {
                obj["fees_status"] = "Y";


            }

            obj["fees_type"] = $(this).find(".fees_type").val();
            obj["installment1"] = $(this).find(".Inst1").val();

            obj["installment2"] = $(this).find(".Inst2").val();





            //            obj["fees_status"] = $(this).find(".cad_user").val();

            obj["dept_code"] = $('#drpdepartment').val();
            obj["year_code"] = $('#drpyear').val();

            datalist.push(obj);


        });


        //        var comman = {};

        //        comman["datalist"] = datalist;
        //        comman["dept_code"] = $('#drpdepartment').val();
        //        comman["sem_code"] = $('#drpsemester').val();
        //        comman["year_code"] = $('#drpyear').val();

        //        var comman1 = [];

        //        comman1.push(comman);

        //    var data = JSON.stringify({ fees_data: JSON.stringify(datalist), dept_code: $('#drpdepartment').val(), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val() });
        var data = JSON.stringify({ fees_data: JSON.stringify(datalist), dept_code: $('#drpdepartment').val(), year_code: $('#drpyear').val(), flag: 'fees' });

        //  var data = JSON.stringify({ fees_data: JSON.stringify({ fees_data: JSON.stringify(comman1) }) });

        $.ajax({
            type: "POST",
            url: "../../WebService_WS.asmx/save_ws_user_fees",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {


                bootbox.alert(data.d);
                // DisplayData(data.d);
                $('#btnsave').css("display", "none");
                $('#DataList').css('display', 'none');


            },
            error: function (msg) { alert(msg.d); }
        });

        return false;
    });


    $('#btnreterive_feestype').on('click', function () {



        //        var semester = $('#drpsemester').val();
        //        if (semester == "") {
        //            bootbox.alert('Please select semester')
        //            $('#drpsemester').focus();
        //            return false;
        //        }





        var dept_code = $('#drpdepartment').val();
        if (dept_code == "") {
            $('#drpdepartment').focus();
            bootbox.alert('Please select department')
            return false;
        }

        var prog_code = "";
        var year = "";
        if (dept_code == "7") {

        }
        else {

            year = $('#drpyear').val();
            if (year == "") {
                bootbox.alert('Please select year')
                $('#drpyear').focus();
                return false;
            }

            prog_code = $('#drpprog').val();
            if (prog_code == "") {
                bootbox.alert('Please select programme')
                $('#drpprog').focus();
                return false;
            }
        }


        var data1 = "{ 'dept_code': '" + $('#drpdepartment').val() + "', 'year_code' : '" + $('#drpyear').val() + "','prog_code' : '" + prog_code + "'}";
        var inner = "{ 'dept_code': '" + $('#drpdepartment').val() + "', 'year_code' : '" + $('#drpyear').val() + "'}";

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/Get_ws_user_userfees",

            data: data1,
            dataType: "json",
            success: function (data) {

                if (data.d != "") {

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService_WS.asmx/Get_ws_student_fees_saved_data",
                        async: false,
                        data: inner,
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "") {



                                fees_data = JSON.parse(data.d);




                            }
                            else {

                                fees_data = '';
                            }


                        },
                        error: function (result) {
                            alert('error');
                        }
                    });



                    DisplayData_feestype(data.d);

                    $('#btnsave_feestype').css("display", "block");
                    $('#DataList').css('display', 'block');
                }
                else {

                    bootbox.alert("There is no data found");
                    $('#btnsave_feestype').css("display", "none");
                    $('#DataList').css('display', 'none');
                }


            },
            error: function (result) {
                alert('error');
            }
        });
        return false;
    });

    $('#btnsave_feestype').on('click', function () {

        var datalist = [];

        var flag = 'N';

        var oSettings = oTable.fnSettings();

        for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
            oSettings.aoPreSearchCols[iCol].sSearch = '';
        }
        oSettings.oPreviousSearch.sSearch = '';
        oTable.fnDraw();

        $('#example tbody tr').each(function (i) {

            var aPos = oTable.fnGetPosition(this);
            //            var aData = oTable.fnGetData(aPos[i]);
            //            var a = aData[i];

            var a = oTable.fnGetData(aPos);

            var obj = {};

            obj["user_id"] = a["user_id"];



            obj["installment_status"] = 'N';
            obj["fees_type"] = 'N';

            if ($(this).find(".chk_full_child").is(':checked')) {
                obj["installment_status"] = "Y";


            }


            obj["waiver_credits"] = $(this).find(".waiver_credits").val();

            if ($(this).find(".chk_fees_type_child").is(':checked')) {

                obj["fees_type"] = "Y";

                if ($(this).find(".fees_waiver_credits").val() == '') {
                    flag = 'Y';
                    bootbox.alert("Please Enter fees waiver credits for student code : " + a["user_id"]);
                    return false;

                }
            }
            obj["fees_waiver_credits"] = $(this).find(".fees_waiver_credits").val();





            //            obj["fees_status"] = $(this).find(".cad_user").val();

            obj["dept_code"] = $('#drpdepartment').val();
            obj["year_code"] = $('#drpyear').val();

            datalist.push(obj);


        });


        //        var comman = {};

        //        comman["datalist"] = datalist;
        //        comman["dept_code"] = $('#drpdepartment').val();
        //        comman["sem_code"] = $('#drpsemester').val();
        //        comman["year_code"] = $('#drpyear').val();

        //        var comman1 = [];

        //        comman1.push(comman);

        //    var data = JSON.stringify({ fees_data: JSON.stringify(datalist), dept_code: $('#drpdepartment').val(), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val() });

        if (flag == 'N') {


            var data = JSON.stringify({ fees_data: JSON.stringify(datalist), dept_code: $('#drpdepartment').val(), year_code: $('#drpyear').val(), flag: 'waiver' });

            //  var data = JSON.stringify({ fees_data: JSON.stringify({ fees_data: JSON.stringify(comman1) }) });

            $.ajax({
                type: "POST",
                url: "../../WebService_WS.asmx/save_ws_user_fees",
                data: data,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {


                    bootbox.alert(data.d);
                    // DisplayData(data.d);
                    $('#btnsave_feestype').css("display", "none");
                    $('#DataList').css('display', 'none');




                },
                error: function (msg) { alert(msg.d); }
            });
        }

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


    $(document).on("click", ".chk_fees_type_parent", function (event) {
        var $this = $(this), $table = $this.closest("table"), $madaniya = null;
        if ($table.hasClass("dataTable")) {
            $table = $table.closest(".dataTables_wrapper");
        }
        $table.find(".chk_fees_type_child").prop("checked", this.checked).change();
    }).on("click", ".chk_fees_type_child", function () {
        var $this = $(this), $table = $this.closest("table"), $madaniya = null; $madaniya = null, checkedLength = 0;
        if ($table.hasClass("dataTable")) {
            $table = $table.closest(".dataTables_wrapper");
        }
        $madaniya = $table.find(".chk_fees_type_child");
        checkedLength = $madaniya.filter(":checked").length;
        $table.find(".chk_fees_type_parent").prop({ "indeterminate": checkedLength && checkedLength !== $madaniya.length, "checked": checkedLength === $madaniya.length });
    }).on("change", ".chk_fees_type_child", function () {
        if (this.checked) {
            //  alert('checked');

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);


            //  $(row).find(".fees_waiver_credits").val('');
            $(row).find(".fees_waiver_credits").prop('disabled', false);
            // addSelection(this.value);
        } else {
            //  alert('unchecked');  // removeSelection(this.value);

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);


            $(row).find(".fees_waiver_credits").val('');
            $(row).find(".fees_waiver_credits").prop('disabled', true);

        }
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


$(document).on("click", ".chk_fees_type_child", function (event) {

    var row = $(this).closest("tr").get(0);
    var aData = oTable.fnGetData(row);

    if (this.checked) {
        $(row).find(".fees_waiver_credits").prop('disabled', false);
    }
    else {
        $(row).find(".fees_waiver_credits").val('');
        $(row).find(".fees_waiver_credits").prop('disabled', true);
    }



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
            { "sTitle": "Student Code", "mData": "student_no", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            //           { "sTitle": "Half Fees<center><input type='checkbox' name='checkheader'  class='chk_half_parent'></input></center>",
            //               "mData": null,
            //               "bSortable": false,
            //               "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_half_child" ></center>'
            //           },
            //         {"sTitle": "Fees Type",
            //         "bSortable": false,
            //         "mData": null,

            //         fnRender: function (oObj) {

            //             var listItems = '<select class="fees_type">';
            //             listItems += "<option value='0'>--Select--</option>";
            //             listItems += "<option value='F'>Fees Waiver</option>";
            //             listItems += "<option value='I'>Installment</option>";


            //             listItems += '</select>';



            //             return listItems;



            //         }
            //     },
            //        { "sTitle": "Installmant1",
            //            "mData": null,
            //            "bSortable": false,
            //            "sDefaultContent": '<center><input type="textbox"  class="Inst1" ></center>'
            //        },
            //             { "sTitle": "Installmant2",
            //                 "mData": null,
            //                 "bSortable": false,
            //                 "sDefaultContent": '<center><input type="textbox"  class="Inst2" ></center>'
            //             },

            {
                "sTitle": "Fees Status<center><input type='checkbox' name='checkheader1'  class='chk_full_parent'></input></center>",
                "mData": null,
                "bSortable": false,
                "sDefaultContent": '<center><input type="checkbox"  name="check2" value="2" class="chk_full_child" ></center>'
            }
            //  {"sTitle": "Name", "mData": "full_name", "sWidth": "500px", "bSortable": false },
            //                 {"sTitle": "Fees",
            //                 "bSortable": false,
            //                 "mData": null,

            //                 fnRender: function (oObj) {

            //                     var listItems = '<select class="cad_user" id="' + oObj.aData['user_id'] + '" >';
            //                     listItems += "<option value='0'>---Select---</option>";
            //                     listItems += "<option value='H'>Half Fee</option>";
            //                     listItems += "<option value='F'>Full Fee</option>";
            //                     listItems += '</select>';
            //                     return listItems;



            //                 }
            //             }

        ]


    });

    //    new FixedHeader(oTable);

    $("#example tbody tr").each(function (i) {


        if (fees_data != "") {

            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            for (var j = 0; j < fees_data.length; j++) {

                if (fees_data[j]["user_id"] == a["user_id"]) {

                    if (fees_data[j]["fees_status"] == "Y") {
                        $(this).find(".chk_full_child").prop('checked', true);
                    }



                }
            }
        }
        else {

        }

    });





}

function DisplayData_feestype(data) {


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
            { "sTitle": "Student Code", "mData": "student_no", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },

            //{ "sTitle": "Fees Type","bSortable": false,"mData": null,fnRender: function (oObj) {

            //   var listItems = '<select class="fees_type">';
            //                         listItems += "<option value='0'>--Select--</option>";
            //                         listItems += "<option value='F'>Non Paying CEPT Student</option>";
            //                         listItems += "<option value='I'>Installment</option>";
            //                         listItems += '</select>';
            //                         return listItems;



            //                     }
            //                 },

            //{
            //    "sTitle": "Fee waiver<center><input type='checkbox' name='chk_fees_type1'  class='chk_fees_type_parent'></input></center>",
            //    "mData": null,
            //    "bSortable": false,
            //    "sDefaultContent": '<center><input type="checkbox"  name="chk_fees_type2" value="2" class="chk_fees_type_child" ></center>'
            //},

            {
                "sTitle": "Fee waiver<center><input type='checkbox' name='chk_fees_type1'  class='chk_fees_type_parent'></input></center>", "bSortable": false, "mData": null, fnRender: function (oObj) {
                    return '<center><input type="checkbox"  id=check_box_fees_waiver_' + oObj.aData.user_id + ' name="chk_fees_type2" value="2" class="chk_fees_type_child" ></center>'
                }
            },



            //{
            //    "sTitle": "Fees Waiver Credits",
            //    "mData": null,
            //    "bSortable": false,
            //    "sDefaultContent": '<input type="textbox"  class="fees_waiver_credits" disabled  >'
            //},

            {
                "sTitle": "Fees Waiver Credits", "bSortable": false, "mData": null, fnRender: function (oObj) {
                    return '<input type="textbox" id=fees_waiver_' + oObj.aData.user_id + ' class="fees_waiver_credits" disabled >'
                }
            },

            //{
            //    "sTitle": "Installment<center><input type='checkbox' name='checkheader1'  class='chk_full_parent'></input></center>",
            //    "mData": null,
            //    "bSortable": false,
            //    "sDefaultContent": '<center><input type="checkbox"  name="check2" value="2" class="chk_full_child" ></center>'
            //},

            {
                "sTitle": "Installment<center><input type='checkbox' name='checkheader1'  class='chk_full_parent'></input></center>", "bSortable": false, "mData": null, fnRender: function (oObj) {
                    return '<center><input type="checkbox" id=check_box_fees_installment_' + oObj.aData.user_id + '  name="check2" value="2" class="chk_full_child" ></center>';
                    
                }
            },



            {
                "sTitle": "Non Paying Credits", "bSortable": false, "mData": null, fnRender: function (oObj) {
                    return '<input type="textbox" id= NonPaying_' + oObj.aData.user_id+' class="waiver_credits" >'
                }
            }
            //,

            //{
            //    "sTitle": "Non Paying Credits","mData": null,"bSortable": false,"sDefaultContent": '<input type="textbox"  class="waiver_credits" >'
            //}
            //             { "sTitle": "Installmant2",
            //                 "mData": null,
            //                 "bSortable": false,
            //                 "sDefaultContent": '<center><input type="textbox"  class="Inst2" ></center>'
            //             },





        ]


    });

    //    new FixedHeader(oTable);

    $("#example tbody tr").each(function (i) {

        //console.log("No." + i + " " + $("#example tbody tr")[i].children[0]["innerHTML"]);
        if (fees_data != "") {

            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            for (var j = 0; j < fees_data.length; j++)
            {
                
                if (fees_data[j]["user_id"] == a["user_id"])
                {

                    if (fees_data[j]["fees_type"] == "Y") {
                        //   $(this).find(".fees_type").val(fees_data[j]["fees_type"]);
                        //if (fees_data[j]["dept_code"] == "1" && fees_data[j]["year_code"] == "Y2018" && a["prog_code"] == "1") {

                        $('#check_box_fees_waiver_' + a["user_id"]).attr('checked', true);

                        //if ($("#example tbody tr")[i].children[0]["innerHTML"] == a["user_id"])
                        //{
                        //    $(this).find(".chk_fees_type_child").prop('checked', true);
                        //}
                        //else
                        //{
                        //    if ($(this).prev("tr")[0].children[0]["innerHTML"] == a["user_id"])
                        //    {
                        //        $(this).prev("tr").find(".chk_fees_type_child").prop('checked', true);
                        //    }
                        //    else if ($(this).next("tr")[0].children[0]["innerHTML"] == a["user_id"])
                        //    {
                        //        $(this).next("tr").find(".chk_fees_type_child").prop('checked', true);
                        //    }
                        //}
                    }

                    if (fees_data[j]["installmant_status"] == "Y")
                    {
                        //if (fees_data[j]["dept_code"] == "1" && fees_data[j]["year_code"] == "Y2018" && a["prog_code"] == "1") {

                        //check_box_fees_installment_U21005
                        $('#check_box_fees_installment_' + a["user_id"]).attr('checked', true);

                        //if ($("#example tbody tr")[i].children[0]["innerHTML"] == a["user_id"])
                        //{
                        //    $(this).find(".chk_full_child").prop('checked', true);
                        //} else
                        //{
                        //    if ($(this).prev("tr")[0].children[0]["innerHTML"] == a["user_id"]) {
                        //        $(this).prev("tr").find(".chk_full_child").prop('checked', true);
                        //    }
                        //    else if ($(this).next("tr")[0].children[0]["innerHTML"] == a["user_id"]) {
                        //        $(this).next("tr").find(".chk_full_child").prop('checked', true);
                        //    }
                        //}
                    }

                    if (fees_data[j]["waiver_credits"] != "")
                    {
                        //if (fees_data[j]["dept_code"] == "1" && fees_data[j]["year_code"] == "Y2018" && a["prog_code"] == "1") {
                        $('#NonPaying_' + a["user_id"]).val(fees_data[j]["waiver_credits"])

                        //if ($("#example tbody tr")[i].children[0]["innerHTML"] == a["user_id"])
                        //{
                        //    $(this).find(".waiver_credits").val(fees_data[j]["waiver_credits"]);
                        //} else
                        //{
                        //    if ($(this).prev("tr")[0].children[0]["innerHTML"] == a["user_id"]) {
                        //        $(this).prev("tr").find(".waiver_credits").val(fees_data[j]["waiver_credits"]);
                        //    }
                        //    else if ($(this).next("tr")[0].children[0]["innerHTML"] == a["user_id"]) {
                        //        $(this).next("tr").find(".waiver_credits").val(fees_data[j]["waiver_credits"]);
                        //    }
                        //}
                    }
                    if (fees_data[j]["fees_waiver_credits"] != "") {
                        //if (fees_data[j]["dept_code"] == "1" && fees_data[j]["year_code"] == "Y2018" && a["prog_code"] == "1") {
                        $('#fees_waiver_' + a["user_id"]).val(fees_data[j]["fees_waiver_credits"])
                        $('#fees_waiver_' + a["user_id"]).prop('disabled', false);


                       // if ($("#example tbody tr")[i].children[0]["innerHTML"] == a["user_id"]) {
                       //     $(this).find(".fees_waiver_credits").val(fees_data[j]["fees_waiver_credits"]);
                       //     $(this).find(".fees_waiver_credits").prop('disabled', false);
                       // } else
                       // {
                       //     if ($(this).prev("tr")[0].children[0]["innerHTML"] == a["user_id"])
                       //     {
                       //         $(this).prev("tr").find(".fees_waiver_credits").val(fees_data[j]["fees_waiver_credits"]);
                       //         $(this).prev("tr").find(".fees_waiver_credits").prop('disabled', false);
                       //     }
                       //     else if ($(this).next("tr")[0].children[0]["innerHTML"] == a["user_id"]) {
                       //         $(this).next("tr").find(".fees_waiver_credits").val(fees_data[j]["fees_waiver_credits"]);
                       //         $(this).next("tr").find(".fees_waiver_credits").prop('disabled', false);
                       //     }
                       // }
                    }

                }
            }
        }
        else {

        }

    });





}



function bindyeardata() {

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


                    $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear').chosen();
            }

        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindsemesterdata() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_semester_data",

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
        url: "../../WebService_WS.asmx/Get_department_data",

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

    $('#drpprog').chosen();
}








