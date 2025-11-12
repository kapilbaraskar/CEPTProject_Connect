var oTable;
var asInitVals = new Array();
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
        async: false,
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

function binddepartment() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_department_data",
        data: "{}",
        dataType: "json",
        async: false,
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

function bindMemberType() {

    $('#drmmtype').empty().append($("<option></option>").val("").html("-- Please Select MemberType --"));
    $('#drmmtype').append($("<option></option>").val("VF").html("VF"));
    $('#drmmtype').append($("<option></option>").val("CORE").html("Core"));
    //    for (var i = 0; i < sem_data.length; i++) {


    //        $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));

    //    }

    $('#drmmtype').chosen();

}

function get_instructor_details() {
    $('#DataList').css('display', 'none');

    var membertype = $('#drmmtype').val();
    if (membertype == "") {
        bootbox.alert('Please select MemberType');
        $('#drmmtype').focus();
        return false;
    }

    //if ($('#drpdepartment').val() == "") {
    //    bootbox.alert('Please select Department');
    //    $('#drpdepartment').focus();
    //    return false;
    //}

    //if ($('#drpsemester').val() == "") {
    //    bootbox.alert('Please Select Semester');
    //    $('#drpsemester').focus();
    //    return false;
    //}
    //if ($('#drpyear').val() == "") {
    //    bootbox.alert('Please Select Year');
    //    $('#drpyear').focus();
    //    return false;
    //}


    $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_vf_core_faculty_report",
        async: false,
        data: "{ member_type:'" + $('#drmmtype').val() + "',semester: '" + $('#drpsemester').val() + "',year_code: '" + $('#drpyear').val() + "',dept_code:'" + $('#drpdepartment').val() + "'}",
       // data:"{}",
        dataType: "json",
            success: function (data) {
                
            if (data.d != null)
            {

                if (data.d != "" && data.d != '[]')
                {
                    var jsostr = JSON.parse(data.d);
                    Display_Faculty_data(jsostr);
                    //   display_student_password_data(data.d);

                }
                else {
                    bootbox.alert('There is No data Found');
                    return false;
                }



            }
            else {

                bootbox.alert('There is No data Found');
                return false;
            }



        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

//function Display_Faculty_data(data) {

//    $('#DataList').css('display', 'block');


//    debugger;



//    $('#DataList').css('display', 'block');
//}


function Display_Faculty_data(data) {
    $('#DataList').css('display', 'inline-block');
    if (oTable != null) {
    
        oTable.fnDestroy();
        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="display table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    if (data != null && data != undefined) {
        oTable = $("#example").dataTable({
            "bSortable": false,
            "bSort": false,
            "pagingType": "full_numbers",
            "iDisplayLength": 100,
            //"sDom": "<'row'<'col-xs-6'T><'col-xs-6'f>r>t<'row'<'col-xs-6'i><'col-xs-6'p>>",
            "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            "aaData": data,
            "aoColumns": BindData(data)
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

}

function BindData(data) {
    var columns = [];
    if (data != null && data != undefined && data.length > 0) {
        var row = data[0];
        for (var attr in row) {
            columns.push({ "sTitle": attr, "mData": attr, "bSortable": false });
        }
    }
    return columns;
}