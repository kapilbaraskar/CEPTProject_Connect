<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="AWP_Faculty_Details.aspx.cs" Inherits="Admin_Report_AWP_Faculty_Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
       <script type="text/javascript">
        var oTable;
        var oTable1;
        var semester = '';
        var year_code = '';
        var type_code = '';
        var prog_code = '';
        var asInitVals = new Array();
        var asInitVals_stu = new Array();
        $(document).ready(function () {
         
            bindyeardata_for_cross_reg();
       
            bindtypedata();
            $('#btnreterive').on('click', function () {
           
                get_Report_data();


                return false;
            });

        });

    
        function bindtypedata() {

            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Report Type --"));
            $('#drptype').append($("<option></option>").val("P").html("Personal Details"));
            $('#drptype').append($("<option></option>").val("T").html("Teaching Details"));
            $('#drptype').append($("<option></option>").val("F").html("Faculty Institutional work Details"));
            $('#drptype').append($("<option></option>").val("U").html("University Institutional work Details"));
            $('#drptype').append($("<option></option>").val("O").html("Other anticipated work Details"));
            $('#drptype').append($("<option></option>").val("PA").html("Total Planned and Allocated hours details"));
            $('#drptype').append($("<option></option>").val("UN").html("Total unallocated Hours Details"));
            $('#drptype').append($("<option></option>").val("PAU").html("Planned and actual unallocated hours details"));
            $('#drptype').append($("<option></option>").val("R").html("Remainder Hours Details"));
            $('#drptype').chosen();

        }


           function bindyeardata_for_cross_reg() {
               var year_data = [
                   { "year_desc": "2025-2026" },
                   { "year_desc": "2024-2025" },
                   { "year_desc": "2023-2024" },
                   { "year_desc": "2022-2023" },
                   { "year_desc": "2021-2022" },
                   { "year_desc": "2020-2021" },
                   { "year_desc": "2019-2020" }
               ];

               $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));

               for (var i = 0; i < year_data.length; i++) {
                   $('#drpyear').append(
                       $("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"])
                   );
               }
               $('#drpyear').chosen();
           }


           function get_Report_data() {
            
            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
        
            type_code = $('#drptype').val();
            if (type_code == "") {
                bootbox.alert('Please select Report Type');
                $('#drptype').focus();
                return false;
            }

            if (type_code == "P") {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_personal_details",
                        //async: false,
                        data: "{year_code:'" + year_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {
        
                            if (data.d != "" && data.d != "[]") {
                                Personal_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'block');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
        
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if (type_code == "T") {
              
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_Teaching_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {
        
                            if (data.d != "" && data.d != "[]") {
                                Teaching_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'block');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
        
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if (type_code == "F") {
               
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_Faculty_institional_work_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Faculty_Institutional_work_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'block');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
            }
            else if (type_code == "U") {
               
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_University_institutional_work_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                University_Institutional_work_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'block');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
            }
            else if (type_code == "O") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_Other_Anticiapated_work_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Other_anticipated_work_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'block');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
            }
            else if (type_code == "PA") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_total_planned_allocated_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Total_Planned_Allocated_hours_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'block');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
            }
            else if (type_code == "UN") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_total_unallocated_work_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Total_unallocated_Hours_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'block');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "PAU") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_Planned_actual_unallocated_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Planned_actual_unallocated_hours_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'block');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "R") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_AWP_Remainder_Hour_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Remainder_Hours_data_list(data.d);
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'block');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_AWP_Personal_list').css('display', 'none');
                                $('#div_AWP_Teaching_list').css('display', 'none');
                                $('#div_AWP_Faculty_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_University_Institutional_work_list').css('display', 'none');
                                $('#div_AWP_Other_anticipated_work_list').css('display', 'none');
                                $('#div_AWP_Total_Planned_Allocated_hours_list').css('display', 'none');
                                $('#div_AWP_Total_unallocated_Hours_list').css('display', 'none');
                                $('#div_AWP_Planned_actual_unallocated_hours_list').css('display', 'none');
                                $('#div_AWP_Remainder_Hours_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            
            return false;
        }

           function Personal_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#PersonalDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Personal_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Personal_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "email", "bSortable": false },
                       { "sTitle": "Designation ", "mData": "designation", "bSortable": false },
                       { "sTitle": "Department Name ", "mData": "department", "bSortable": false },
                       { "sTitle": "Contact No ", "mData": "contact", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Personal_example thead th').each(function (i, r) {
                   var nm = $('#Personal_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Personal_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Personal_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Personal_example thead th').eq(i).text();
                   $('#Personal_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#PersonalDataList').css('display', 'block');
           }

           function Teaching_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#TeachingDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Teaching_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Teaching_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "AWP Plan Code ", "mData": "awp_plan_code", "bSortable": false },
                       { "sTitle": "AWP Plan Name ", "mData": "awp_plan_name", "bSortable": false },
                       { "sTitle": "AWP Type Code ", "mData": "awp_type_code", "bSortable": false },
                       { "sTitle": "AWP Type Name ", "mData": "awp_type_name", "bSortable": false },
                       { "sTitle": "AWP Sub Type Code ", "mData": "awp_sub_type_code", "bSortable": false },
                       { "sTitle": "AWP Sub Type Name ", "mData": "awp_sub_type_name", "bSortable": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Remarks ", "mData": "remarks_note", "bSortable": false },
                       { "sTitle": "No of Hours ", "mData": "no_of_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Teaching_example thead th').each(function (i, r) {
                   var nm = $('#Teaching_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Teaching_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Teaching_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Teaching_example thead th').eq(i).text();
                   $('#Teaching_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#TeachingDataList').css('display', 'block');

           }

           function Faculty_Institutional_work_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#FacultyInstitutionalworkDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Faculty_Institutional_work_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Faculty_Institutional_work_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "AWP Plan Code ", "mData": "awp_plan_code", "bSortable": false },
                       { "sTitle": "AWP Plan Name ", "mData": "awp_plan_name", "bSortable": false },
                       { "sTitle": "AWP Type Code ", "mData": "awp_type_code", "bSortable": false },
                       { "sTitle": "AWP Type Name ", "mData": "awp_type_name", "bSortable": false },
                       { "sTitle": "AWP Sub Work Code ", "mData": "sub_work_code", "bSortable": false },
                       { "sTitle": "AWP Sub Work Name ", "mData": "sub_work_name", "bSortable": false },
                       { "sTitle": "AWP Work Type Code ", "mData": "work_type_code", "bSortable": false },
                       { "sTitle": "AWP Work Type Name ", "mData": "work_type_name", "bSortable": false },
                       { "sTitle": "AWP Hour Code ", "mData": "awp_hour_code", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Remarks ", "mData": "remarks_note", "bSortable": false },
                       { "sTitle": "No of Hours ", "mData": "no_of_hours", "bSortable": false }
                       
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Faculty_Institutional_work_example thead th').each(function (i, r) {
                   var nm = $('#Faculty_Institutional_work_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Faculty_Institutional_work_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Faculty_Institutional_work_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Faculty_Institutional_work_example thead th').eq(i).text();
                   $('#Faculty_Institutional_work_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#FacultyInstitutionalworkDataList').css('display', 'block');
           }

           function University_Institutional_work_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#FacultyUniversityworkDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Faculty_University_work_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Faculty_University_work_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "AWP Plan Code ", "mData": "awp_plan_code", "bSortable": false },
                       { "sTitle": "AWP Plan Name ", "mData": "awp_plan_name", "bSortable": false },
                       { "sTitle": "AWP Type Code ", "mData": "awp_type_code", "bSortable": false },
                       { "sTitle": "AWP Type Name ", "mData": "awp_type_name", "bSortable": false },
                       { "sTitle": "AWP Sub Work Code ", "mData": "sub_work_code", "bSortable": false },
                       { "sTitle": "AWP Sub Work Name ", "mData": "sub_work_name", "bSortable": false },
                       { "sTitle": "AWP Work Type Code ", "mData": "work_type_code", "bSortable": false },
                       { "sTitle": "AWP Work Type Name ", "mData": "work_type_name", "bSortable": false },
                       { "sTitle": "AWP Hour Code ", "mData": "awp_hour_code", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Remarks ", "mData": "remarks_note", "bSortable": false },
                       { "sTitle": "No of Hours ", "mData": "no_of_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Faculty_University_work_example thead th').each(function (i, r) {
                   var nm = $('#Faculty_University_work_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Faculty_University_work_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Faculty_University_work_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Faculty_University_work_example thead th').eq(i).text();
                   $('#Faculty_University_work_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#FacultyUniversityworkDataList').css('display', 'block');
           }

           function Other_anticipated_work_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#OtherAnticipatedWorkList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Other_Anticipated_work_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Other_Anticipated_work_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "AWP Plan Code ", "mData": "awp_plan_code", "bSortable": false },
                       { "sTitle": "AWP Plan Name ", "mData": "awp_plan_name", "bSortable": false },
                       { "sTitle": "AWP Type Code ", "mData": "awp_type_code", "bSortable": false },
                       { "sTitle": "AWP Type Name ", "mData": "awp_type_name", "bSortable": false },
                       { "sTitle": "AWP Sub Type Code ", "mData": "awp_sub_type_code", "bSortable": false },
                       { "sTitle": "AWP Sub Type Name ", "mData": "awp_sub_type_name", "bSortable": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Remarks ", "mData": "remarks_note", "bSortable": false },
                       { "sTitle": "No of Hours ", "mData": "no_of_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Other_Anticipated_work_example thead th').each(function (i, r) {
                   var nm = $('#Other_Anticipated_work_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Other_Anticipated_work_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Other_Anticipated_work_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Other_Anticipated_work_example thead th').eq(i).text();
                   $('#Other_Anticipated_work_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#OtherAnticipatedWorkList').css('display', 'block');
           }

           function Total_Planned_Allocated_hours_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#TotalPlannedAllocatedhoursList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Total_Planned_Allocated_hours_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Total_Planned_Allocated_hours_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "AWP Plan Code ", "mData": "awp_plan_code", "bSortable": false },
                       { "sTitle": "AWP Plan Name ", "mData": "awp_plan_name", "bSortable": false },
                       { "sTitle": "AWP Type Code ", "mData": "awp_type_code", "bSortable": false },
                       { "sTitle": "AWP Type Name ", "mData": "awp_type_name", "bSortable": false },
                       { "sTitle": "AWP Sub Type Code ", "mData": "awp_sub_type_code", "bSortable": false },
                       { "sTitle": "AWP Sub Type Name ", "mData": "awp_sub_type_name", "bSortable": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Remarks ", "mData": "remarks_note", "bSortable": false },
                       { "sTitle": "No of Hours ", "mData": "no_of_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Total_Planned_Allocated_hours_example thead th').each(function (i, r) {
                   var nm = $('#Total_Planned_Allocated_hours_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Total_Planned_Allocated_hours_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Total_Planned_Allocated_hours_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Total_Planned_Allocated_hours_example thead th').eq(i).text();
                   $('#Total_Planned_Allocated_hours_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#TotalPlannedAllocatedhoursList').css('display', 'block');
           }

           function Total_unallocated_Hours_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#TotalunallocatedHoursDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Total_unallocated_Hours_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Total_unallocated_Hours_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "AWP Plan Code ", "mData": "awp_plan_code", "bSortable": false },
                       { "sTitle": "AWP Plan Name ", "mData": "awp_plan_name", "bSortable": false },
                       { "sTitle": "AWP Type Code ", "mData": "awp_type_code", "bSortable": false },
                       { "sTitle": "AWP Type Name ", "mData": "awp_type_name", "bSortable": false },
                       { "sTitle": "AWP Sub Type Code ", "mData": "awp_sub_type_code", "bSortable": false },
                       { "sTitle": "AWP Sub Type Name ", "mData": "awp_sub_type_name", "bSortable": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Remarks ", "mData": "remarks_note", "bSortable": false },
                       { "sTitle": "No of Hours ", "mData": "no_of_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Total_unallocated_Hours_example thead th').each(function (i, r) {
                   var nm = $('#Total_unallocated_Hours_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Total_unallocated_Hours_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Total_unallocated_Hours_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Total_unallocated_Hours_example thead th').eq(i).text();
                   $('#Total_unallocated_Hours_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#TotalunallocatedHoursDataList').css('display', 'block');
           }

           function Planned_actual_unallocated_hours_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#PlannedactualunallocatedhoursDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Planned_actual_unallocated_hours_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Planned_actual_unallocated_hours_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "AWP Plan Code ", "mData": "awp_plan_code", "bSortable": false },
                       { "sTitle": "AWP Plan Name ", "mData": "awp_plan_name", "bSortable": false },
                       { "sTitle": "AWP Type Code ", "mData": "awp_type_code", "bSortable": false },
                       { "sTitle": "AWP Type Name ", "mData": "awp_type_name", "bSortable": false },
                       { "sTitle": "AWP Sub Type Code ", "mData": "awp_sub_type_code", "bSortable": false },
                       { "sTitle": "AWP Sub Type Name ", "mData": "awp_sub_type_name", "bSortable": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Remarks ", "mData": "remarks_note", "bSortable": false },
                       { "sTitle": "No of Hours ", "mData": "no_of_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Planned_actual_unallocated_hours_example thead th').each(function (i, r) {
                   var nm = $('#Planned_actual_unallocated_hours_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Planned_actual_unallocated_hours_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Planned_actual_unallocated_hours_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Planned_actual_unallocated_hours_example thead th').eq(i).text();
                   $('#Planned_actual_unallocated_hours_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#PlannedactualunallocatedhoursDataList').css('display', 'block');
           }

           function Remainder_Hours_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#RemainderHoursDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Remainder_Hours_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Remainder_Hours_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "usercode", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "AWP Plan Code ", "mData": "awp_plan_code", "bSortable": false },
                       { "sTitle": "AWP Plan Name ", "mData": "awp_plan_name", "bSortable": false },
                       { "sTitle": "AWP Type Code ", "mData": "awp_type_code", "bSortable": false },
                       { "sTitle": "AWP Type Name ", "mData": "awp_type_name", "bSortable": false },
                       { "sTitle": "AWP Sub Type Code ", "mData": "awp_sub_type_code", "bSortable": false },
                       { "sTitle": "AWP Sub Type Name ", "mData": "awp_sub_type_name", "bSortable": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Remarks ", "mData": "remarks_note", "bSortable": false },
                       { "sTitle": "No of Hours ", "mData": "no_of_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Remainder_Hours_example thead th').each(function (i, r) {
                   var nm = $('#Remainder_Hours_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Remainder_Hours_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Remainder_Hours_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Remainder_Hours_example thead th').eq(i).text();
                   $('#Remainder_Hours_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#RemainderHoursDataList').css('display', 'block');
           }

       </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>AWP Faculty Details Report
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                               <td>Report Type
                                </td>
                                <td>
                                    <select class="chosen-select" id="drptype">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                 
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>

                                
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_AWP_Personal_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Faculty Personal Details</strong>
                 
            </div>
            <div>

                <div id="PersonalDataList" style="display: none; overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Personal_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="div_AWP_Teaching_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Faculty Teaching Details</strong>
            </div>
            <div>
                <div id="TeachingDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Teaching_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
          <div id="div_AWP_Faculty_Institutional_work_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Faculty Institutional Work Details</strong>
               
            </div>
            <div>
                <div id="FacultyInstitutionalworkDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Faculty_Institutional_work_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

          <div id="div_AWP_University_Institutional_work_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Faculty University Work Details</strong>
            </div>
            <div>
                <div id="FacultyUniversityworkDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Faculty_University_work_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

           <div id="div_AWP_Other_anticipated_work_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Other Anticipated Work Details</strong>
            </div>
            <div>
                <div id="OtherAnticipatedWorkList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Other_Anticipated_work_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_AWP_Total_Planned_Allocated_hours_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Total Planned and Allocated Hours Details</strong>
            </div>
            <div>
                <div id="TotalPlannedAllocatedhoursList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Total_Planned_Allocated_hours_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_AWP_Total_unallocated_Hours_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Total Unallocated Hours Details</strong>
            </div>
            <div>
                <div id="TotalunallocatedHoursDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Total_unallocated_Hours_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_AWP_Planned_actual_unallocated_hours_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Planned and Actual Unallocated Details</strong>
            </div>
            <div>
                <div id="PlannedactualunallocatedhoursDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Planned_actual_unallocated_hours_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_AWP_Remainder_Hours_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>AWP Remainder Hours Details</strong>
            </div>
            <div>
                <div id="RemainderHoursDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Remainder_Hours_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
         
    </div>

</asp:Content>


