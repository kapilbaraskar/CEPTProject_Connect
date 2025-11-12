
var faculty_data;
var sem_data;




function bindfaculty() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_faculty_data",

        data: "{}",
        dataType: "json",
        success: function (data) {


            if (data.d != "") {


                var faculty_data = JSON.parse(data.d)
              


                $('#drpfaculty').empty().append($("<option></option>").val("").html("-- Please Select Faculty --"));
                for (var i = 0; i < faculty_data.length; i++) {


                    $('#drpfaculty').append($("<option></option>").val(faculty_data[i]["instructor_code"]).html(faculty_data[i]["instructor_name"]));
                }

                $('#drpfaculty').chosen();
            }

        },
        error: function (result) {
            alert(result);
        }
    });
}



function bindsemester() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_semester_data",

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

function bindsemester() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_semester_data",

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


