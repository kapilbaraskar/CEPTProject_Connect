




$(document).ready(function () {


    bindsemdata();
    bindyeardata_for_cross_reg();



    $('#btnreterive').on('click', function () {


        var semester = $('#drpsemester').val();
        if (semester == "") {
            bootbox.alert('Please select semester')
            $('#drpsemester').focus();
            return false;
        }

        var year_code = $('#drpyear').val();
        if (year_code == "") {
            bootbox.alert('Please select year')
            $('#drpyear').focus();
            return false;
        }


        debugger;
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_chart_data_for_registration",

            data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "'}",
            dataType: "json",
            success: function (data) {


                debugger;


                if (data.d != "") {

                    debugger;
                    var reg_data = JSON.parse(data.d);

                    var reg = 0;
                    var cross_reg = 0;

                    if (reg_data[0]["registration"] != '') {

                        reg = reg_data[0]["registration"];
                    }

                    if (reg_data[0]["cross_registration"] != '') {

                        cross_reg = reg_data[0]["cross_registration"];
                    }


                    //                    var dataSource = [
                    //                                                { continent: 'Registration', population: parseInt(reg) },
                    //                                                { continent: 'Cross Registration', population: parseInt(cross_reg) }

                    //                                                ];

                    //                    $("#pieChartContainer").dxPieChart({
                    //                        dataSource: dataSource,
                    //                        series: {
                    //                            argumentField: 'continent',
                    //                            valueField: 'population',
                    //                            border: { visible: true },
                    //                            label: { visible: true }
                    //                        },
                    //                        title: 'Registration Chart',
                    //                        tooltip: { enabled: true }
                    //                    });


                    var chart = new CanvasJS.Chart("pieChartContainer",
		{
		    title: {
		        text: "Registration Chart",
		        fontFamily: "arial black"

		    },
		    legend: {
		        verticalAlign: "bottom",
		        horizontalAlign: "center"
		    },
		    toolTip: {
		        enabled: true
		    },
		    theme: "theme1",
		    data: [
			{
			    type: "pie",
			    indexLabelFontFamily: "Garamond",
			    indexLabelFontSize: 20,
			    indexLabelFontWeight: "bold",
			    startAngle: 0,
			    indexLabelFontColor: "MistyRose",
			    indexLabelLineColor: "darkgrey",
			    indexLabelPlacement: "inside",
			    toolTipContent: "{name}: {indexLabel}",
			    showInLegend: true,
			    dataPoints: [
				{ y: reg, indexLabel: reg, name: "Registration", legendMarkerType: "triangle" },
				{ y: cross_reg, indexLabel: cross_reg, name: "Cross Registration", legendMarkerType: "square" }
				

				]
			}
			]
		});

                    chart.render();


                    return false;
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
    debugger;



});

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