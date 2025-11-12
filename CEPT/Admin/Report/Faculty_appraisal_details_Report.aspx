<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Faculty_appraisal_details_Report.aspx.cs" Inherits="Admin_Report_Faculty_appraisal_details_Report" %>

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
            $('#drptype').append($("<option></option>").val("E").html("Education Details"));
            $('#drptype').append($("<option></option>").val("TC").html("Teaching Details with course Details"));
            $('#drptype').append($("<option></option>").val("DRP").html("Thesis and DRP Guided Details"));
            $('#drptype').append($("<option></option>").val("R").html("Research and Publication Details"));
            $('#drptype').append($("<option></option>").val("C").html("Conference Details"));
            $('#drptype').append($("<option></option>").val("OR").html("Completed ongoing Research Details"));
            $('#drptype').append($("<option></option>").val("O").html("Other Research Activities/Recoginization/awards"));
            $('#drptype').append($("<option></option>").val("V").html("Various activities Details"));
            $('#drptype').append($("<option></option>").val("PD").html("Professional Development Details"));
            $('#drptype').append($("<option></option>").val("A").html("Institutional/Administrative Details"));
            $('#drptype').append($("<option></option>").val("T").html("Training Programs Details"));
            $('#drptype').append($("<option></option>").val("F").html("Favourable Details"));
            $('#drptype').append($("<option></option>").val("UF").html("unFavourable Details"));
            $('#drptype').append($("<option></option>").val("TR").html("Training Required Details"));
            $('#drptype').append($("<option></option>").val("CERT").html("Certificate Details"));
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
                        url: "../../WebService.asmx/get_faculty_appraisal_personal_details",
                        //async: false,
                        data: "{year_code:'" + year_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {
        
                            if (data.d != "" && data.d != "[]") {
                                Personal_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'block');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
        
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if (type_code == "E") {
              
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_educational_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {
        
                            if (data.d != "" && data.d != "[]") {
                                Education_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'block');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
        
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if (type_code == "TC") {
               
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Teaching_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Teaching_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'block');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
            }
            else if (type_code == "DRP") {
               
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_DRP_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                DRP_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'block');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

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
                        url: "../../WebService.asmx/get_faculty_appraisal_Research_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Research_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'block');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
            }

            else if (type_code == "C") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Conference_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Conference_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'block');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
            }
            else if (type_code == "OR") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Ongoing_Research_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Ongoing_Research_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'block');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

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
                        url: "../../WebService.asmx/get_faculty_appraisal_Other_Research_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Other_Research_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'block');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "V") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Various_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Various_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'block');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "PD") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Proff_Development_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Proff_Development_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'block');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "A") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Administrative_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Administrative_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'block');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "T") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Training_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Training_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'block');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "F") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Favourable_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Favourable_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'block');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "UF") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Unfavourable_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                UnFavourable_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'block');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "TR") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Training_Required_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Training_Required_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'block');
                                $('#div_faculty_Certificate_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
               }
            else if (type_code == "CERT") {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_faculty_appraisal_Certificate_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Certificate_data_list(data.d);
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'block');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_faculty_Personal_list').css('display', 'none');
                                $('#div_faculty_Education_list').css('display', 'none');
                                $('#div_faculty_Teaching_list').css('display', 'none');
                                $('#div_faculty_Thesis_list').css('display', 'none');
                                $('#div_faculty_Research_list').css('display', 'none');
                                $('#div_faculty_Conference_list').css('display', 'none');
                                $('#div_faculty_Completed_ongoing_Research_list').css('display', 'none');
                                $('#div_faculty_Other_Research_Activities_list').css('display', 'none');
                                $('#div_faculty_Various_list').css('display', 'none');
                                $('#div_faculty_Professional_Development_list').css('display', 'none');
                                $('#div_faculty_Administrative_list').css('display', 'none');
                                $('#div_faculty_Training_Programs_list').css('display', 'none');
                                $('#div_faculty_Favourable_list').css('display', 'none');
                                $('#div_faculty_unFavourable_list').css('display', 'none');
                                $('#div_faculty_Training_Required_list').css('display', 'none');
                                $('#div_faculty_Certificate_list').css('display', 'none');

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
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "Designation ", "mData": "designation", "bSortable": false },
                       { "sTitle": "Department Name ", "mData": "dept_name", "bSortable": false },
                       { "sTitle": "Date of join CEPT ", "mData": "date_of_join_cept", "bSortable": false },
                       { "sTitle": "Total Year Experience ", "mData": "total_year_experience", "bSortable": false },
                       { "sTitle": "Teaching Year ", "mData": "teaching_year", "bSortable": false },
                       { "sTitle": "Total Teaching Experiance ", "mData": "total_teaching_experiance", "bSortable": false },
                       { "sTitle": "Confirmation Date ", "mData": "confirmation_date", "bSortable": false }
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

           function Education_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#EducationDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Education_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Education_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Sr No ", "mData": "sr_no", "designation": false },
                       { "sTitle": "Degree ", "mData": "degree", "bSortable": false },
                       { "sTitle": "Institution ", "mData": "institution", "bSortable": false },
                       { "sTitle": "Field ", "mData": "field", "bSortable": false },
                       { "sTitle": "Year of completion ", "mData": "year_of_completion", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Education_example thead th').each(function (i, r) {
                   var nm = $('#Education_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Education_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Education_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Education_example thead th').eq(i).text();
                   $('#Education_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#EducationDataList').css('display', 'block');

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
                       { "sTitle": "Course Code ", "mData": "course_code", "bSortable": false },
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Semester ", "mData": "semester", "bSortable": false },
                       { "sTitle": "Course Credits ", "mData": "course_credits", "designation": false },
                       { "sTitle": "Course Name ", "mData": "course_name", "bSortable": false },
                       { "sTitle": "Total Hours in Semester ", "mData": "total_hrs_in_semester", "bSortable": false },
                       { "sTitle": "Added Hours in Semester ", "mData": "add_total_hrs_in_semester", "bSortable": false },
                       { "sTitle": "Total No of Year Count ", "mData": "total_no_of_year_count", "bSortable": false }
                       
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

           function DRP_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#ThesisDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Thesis_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Thesis_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "Sr No. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Semester And Year ", "mData": "semesterandyear", "bSortable": false },
                       { "sTitle": "CourseName ", "mData": "coursename", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Thesis_example thead th').each(function (i, r) {
                   var nm = $('#Thesis_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Thesis_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Thesis_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Thesis_example thead th').eq(i).text();
                   $('#Thesis_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#ThesisDataList').css('display', 'block');
           }

           function Research_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#ResearchDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Research_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Research_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Title of Research ", "mData": "title_of_research", "bSortable": false },
                       { "sTitle": "Name of Journal ", "mData": "name_of_journal", "bSortable": false },
                       { "sTitle": "Conference Type ", "mData": "conference_type", "bSortable": false },
                       { "sTitle": "Co Author ", "mData": "co_author", "bSortable": false },
                       { "sTitle": "Publication month ", "mData": "publication_month", "bSortable": false },
                       { "sTitle": "Publication Year ", "mData": "publication_year", "bSortable": false },
                       { "sTitle": "Submitted to University ", "mData": "submitted_to_university", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false },
                       { "sTitle": "Impact factor of journal ", "mData": "impact_factor_of_journal", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Research_example thead th').each(function (i, r) {
                   var nm = $('#Research_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Research_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Research_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Research_example thead th').eq(i).text();
                   $('#Research_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#ResearchDataList').css('display', 'block');
           }

           function Conference_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#ConferenceDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Conference_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Conference_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Title ", "mData": "Title", "bSortable": false },
                       { "sTitle": "Type ", "mData": "Type", "bSortable": false },
                       { "sTitle": "Name Of Conference ", "mData": "NameOfConference", "bSortable": false },
                       { "sTitle": "conferencetype ", "mData": "conferencetype", "bSortable": false },
                       { "sTitle": "Authorship ", "mData": "Authorship", "bSortable": false },
                       { "sTitle": "StartDate ", "mData": "StartDate", "bSortable": false },
                       { "sTitle": "EndDate ", "mData": "EndDate", "bSortable": false },
                       { "sTitle": "Submitted To University ", "mData": "submittedToUniversity", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Conference_example thead th').each(function (i, r) {
                   var nm = $('#Conference_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Conference_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Conference_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Conference_example thead th').eq(i).text();
                   $('#Conference_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#ConferenceDataList').css('display', 'block');
           }

           function Ongoing_Research_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#CompletedongoingResearchDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Completed_ongoing_Research_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Completed_ongoing_Research_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Title ", "mData": "Title", "bSortable": false },
                       { "sTitle": "Funding Agency ", "mData": "funding_agency", "bSortable": false },
                       { "sTitle": "Fund Available ", "mData": "fund_available", "bSortable": false },
                       { "sTitle": "Duration ", "mData": "duration", "bSortable": false },
                       { "sTitle": "Status ", "mData": "status", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Completed_ongoing_Research_example thead th').each(function (i, r) {
                   var nm = $('#Completed_ongoing_Research_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Completed_ongoing_Research_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Completed_ongoing_Research_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Completed_ongoing_Research_example thead th').eq(i).text();
                   $('#Completed_ongoing_Research_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#CompletedongoingResearchDataList').css('display', 'block');
           }

           function Other_Research_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#OtherResearchActivitiesDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Other_Research_Activities_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Other_Research_Activities_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Other Research Activities ", "mData": "other_research_activities", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false },
                       { "sTitle": "Date ", "mData": "Date", "bSortable": false },
                       { "sTitle": "Type ", "mData": "Type", "bSortable": false },
                       { "sTitle": "Title ", "mData": "Title", "bSortable": false },
                       { "sTitle": "Type Code ", "mData": "TypeCode", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Other_Research_Activities_example thead th').each(function (i, r) {
                   var nm = $('#Other_Research_Activities_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Other_Research_Activities_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Other_Research_Activities_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Other_Research_Activities_example thead th').eq(i).text();
                   $('#Other_Research_Activities_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#OtherResearchActivitiesDataList').css('display', 'block');
           }

           function Various_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#VariousDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Various_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Various_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "Mail ", "mData": "mail", "designation": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "list of various activities ", "mData": "list_the_various_activities", "bSortable": false },
                       { "sTitle": "Role in the Activity ", "mData": "role_in_the_activity", "bSortable": false },
                       { "sTitle": "Status ", "mData": "status", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false },
                       { "sTitle": "Type ", "mData": "Type", "bSortable": false },
                       { "sTitle": "Organisation ", "mData": "Organisation", "bSortable": false },
                       { "sTitle": "StartDate ", "mData": "StartDate", "bSortable": false },
                       { "sTitle": "EndDate ", "mData": "EndDate", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Various_example thead th').each(function (i, r) {
                   var nm = $('#Various_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Various_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Various_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Various_example thead th').eq(i).text();
                   $('#Various_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#VariousDataList').css('display', 'block');
           }

           function Proff_Development_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#ProfessionalDevelopmentDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Professional_Development_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Professional_Development_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "list Professional Development Training ", "mData": "list_professional_development_training", "bSortable": false },
                       { "sTitle": "Description ", "mData": "description", "bSortable": false },
                       { "sTitle": "Duration ", "mData": "duration", "bSortable": false },
                       { "sTitle": "Organizers ", "mData": "organizers", "bSortable": false },
                       { "sTitle": "Number Of Participants ", "mData": "number_of_participants", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false },
                       { "sTitle": "Title ", "mData": "Title", "bSortable": false },
                       { "sTitle": "StartDate ", "mData": "StartDate", "bSortable": false },
                       { "sTitle": "EndDate ", "mData": "EndDate", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Professional_Development_example thead th').each(function (i, r) {
                   var nm = $('#Professional_Development_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Professional_Development_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Professional_Development_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Professional_Development_example thead th').eq(i).text();
                   $('#Professional_Development_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#ProfessionalDevelopmentDataList').css('display', 'block');
           }

           function Administrative_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#AdministrativeDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Administrative_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Administrative_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Administrative Work ", "mData": "administrative_work", "bSortable": false },
                       { "sTitle": "Status ", "mData": "status", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false },
                       { "sTitle": "Title ", "mData": "Title", "bSortable": false },
                       { "sTitle": "Type ", "mData": "Type", "bSortable": false },
                       { "sTitle": "StartDate ", "mData": "StartDate", "bSortable": false },
                       { "sTitle": "EndDate ", "mData": "EndDate", "bSortable": false },
                       { "sTitle": "Duration ", "mData": "Duration", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Administrative_example thead th').each(function (i, r) {
                   var nm = $('#Administrative_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Administrative_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Administrative_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Administrative_example thead th').eq(i).text();
                   $('#Administrative_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#AdministrativeDataList').css('display', 'block');
           }

           function Training_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#TrainingProgramsDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Training_Programs_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Training_Programs_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Trainings Programs Attended ", "mData": "trainings_programs_attended", "bSortable": false },
                       { "sTitle": "Total Hours ", "mData": "total_hours", "bSortable": false },
                       { "sTitle": "Type ", "mData": "Type", "bSortable": false },
                       { "sTitle": "Date ", "mData": "Date", "bSortable": false },
                       { "sTitle": "Organizer ", "mData": "Organizer", "bSortable": false },
                       { "sTitle": "Mode of Training ", "mData": "ModeofTraining", "bSortable": false },
                       { "sTitle": "Title ", "mData": "Title", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Training_Programs_example thead th').each(function (i, r) {
                   var nm = $('#Training_Programs_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Training_Programs_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Training_Programs_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Training_Programs_example thead th').eq(i).text();
                   $('#Training_Programs_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#TrainingProgramsDataList').css('display', 'block');
           }

           function Favourable_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#FavourableDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Favourable_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Favourable_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Mention Facilitating ", "mData": "mention_facilitating", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Favourable_example thead th').each(function (i, r) {
                   var nm = $('#Favourable_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Favourable_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Favourable_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Favourable_example thead th').eq(i).text();
                   $('#Favourable_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#FavourableDataList').css('display', 'block');
           }

           function UnFavourable_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#unFavourableDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="unFavourable_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#unFavourable_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Mention Inhibiting ", "mData": "mention_inhibiting", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#unFavourable_example thead th').each(function (i, r) {
                   var nm = $('#unFavourable_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#unFavourable_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#unFavourable_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#unFavourable_example thead th').eq(i).text();
                   $('#unFavourable_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#unFavourableDataList').css('display', 'block');
           }

           function Training_Required_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#TrainingRequiredDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Training_Required_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Training_Required_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Training Skill ", "mData": "training_skill", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Training_Required_example thead th').each(function (i, r) {
                   var nm = $('#Training_Required_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Training_Required_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Training_Required_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Training_Required_example thead th').eq(i).text();
                   $('#Training_Required_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#TrainingRequiredDataList').css('display', 'block');
           }

           function Certificate_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#CertificateDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Certificate_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#Certificate_example").dataTable({

                   "bPaginate": true,
                   "bSortable": false,
                   "bSort": false,
                   //"bStateSave": true,
                   "iDisplayLength": 60,
                   "sDom": 'b',
                   "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                   "aaData": JSON.parse(data),

                   "aoColumns": [
                       { "sTitle": "Instructor Code ", "mData": "instructor_code", "bSortable": false },
                       { "sTitle": "Instructor Name ", "mData": "instructor_name", "bSortable": false },
                       {
                           "sTitle": "Self Evaluation Certificate ", "mData": null, "bSortable": false, mRender: function (data) {
                               if (data["uplodaFile1"] != "") {
                                   var path_value = "../../ApprisalFileUploads/" + data["uplodaFile1"];
                                   return "<a href='" + path_value + "' download>Downlod PDF</a>";
                               }
                               else {
                                   return "PDF Not Available";
                               }
                           }
                       },
                       {
                           "sTitle": "AWP Actual Certificate ", "mData": null, "bSortable": false, mRender: function (data) {
                               if (data["uplodaFile2"] != "") {
                                   var path_value = "../../ApprisalFileUploads/" + data["uplodaFile2"];
                                   return "<a href='" + path_value + "' download>Downlod PDF</a>";
                               }
                               else {
                                   return "PDF Not Available";
                               }
                           }
                       },
                       {
                           "sTitle": "AWP Proposed Certificate ", "mData": null, "bSortable": false, mRender: function (data) {
                               if (data["uplodaFile3"] != "") {
                                   var path_value = "../../ApprisalFileUploads/" + data["uplodaFile3"];
                                   return "<a href='" + path_value + "' download>Downlod PDF</a>";
                               }
                               else {
                                   return "PDF Not Available";
                               }
                           }
                       },
                       {
                           "sTitle": "Certificate ", "mData": null, "bSortable": false, mRender: function (data) {
                               if (data["uplodaFile4"] != "") {
                                   var path_value = "../../ApprisalFileUploads/" + data["uplodaFile4"];
                                   return "<a href='" + path_value + "' download>Downlod PDF</a>";
                               }
                               else {
                                   return "PDF Not Available";
                               }
                           }
                       }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#Certificate_example thead th').each(function (i, r) {
                   var nm = $('#Certificate_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#Certificate_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#Certificate_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#Certificate_example thead th').eq(i).text();
                   $('#Certificate_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#CertificateDataList').css('display', 'block');
           }


           $(document).on("click", "#btnDownloadAll", function () {
               downloadAllFilesAsZip();
           });

           function downloadAllFilesAsZip() {
               var tableData = oTable.fnGetData();
               var files = {
                   Self_Evaluation: [],
                   Actual_AWP: [],
                   Proposed_AWP: [],
                   Certificate: []
               };

               tableData.forEach(function (row) {
                   if (row.uplodaFile1 && row.uplodaFile1.trim() !== "") {
                       files.Self_Evaluation.push(row.uplodaFile1);
                   }
                   if (row.uplodaFile2 && row.uplodaFile2.trim() !== "") {
                       files.Actual_AWP.push(row.uplodaFile2);
                   }
                   if (row.uplodaFile3 && row.uplodaFile3.trim() !== "") {
                       files.Proposed_AWP.push(row.uplodaFile3);
                   }
                   if (row.uplodaFile4 && row.uplodaFile4.trim() !== "") {
                       files.Certificate.push(row.uplodaFile4);
                   }
               });

               if (files.Self_Evaluation.length === 0 && files.Actual_AWP.length === 0 && files.Proposed_AWP.length === 0 && files.Certificate.length === 0) {
                   bootbox.alert("No files available to download.");
                   return;
               }

               $.ajax({
                   url: "../../WebService.asmx/DownloadFacultyAppraisalCertZip",
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   data: JSON.stringify({ files: files }),
                   success: function (res) {
                       var url = res.d;
                       if (url && url !== "ERROR") {
                           window.location.href = url;
                       } else {
                           bootbox.alert("Error creating ZIP.");
                       }
                   },
                   error: function (err) {
                       console.error(err);
                       bootbox.alert("Error downloading ZIP.");
                   }
               });
           }

       </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Faculty Appraisal Details Report
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
        <div id="div_faculty_Personal_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Personal Details</strong>
                 
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

        <div id="div_faculty_Education_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Education Details</strong>
            </div>
            <div>
                <div id="EducationDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Education_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
          <div id="div_faculty_Teaching_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Teaching Details</strong>
               
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

          <div id="div_faculty_Thesis_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal DRP/Thesis Details</strong>
            </div>
            <div>
                <div id="ThesisDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Thesis_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

           <div id="div_faculty_Research_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Research Details</strong>
            </div>
            <div>
                <div id="ResearchDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Research_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Conference_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Conference Details</strong>
            </div>
            <div>
                <div id="ConferenceDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Conference_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Completed_ongoing_Research_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Completed Ongoing Research Details</strong>
            </div>
            <div>
                <div id="CompletedongoingResearchDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Completed_ongoing_Research_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Other_Research_Activities_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Other Research Activities Details</strong>
            </div>
            <div>
                <div id="OtherResearchActivitiesDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Other_Research_Activities_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Various_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Various Details</strong>
            </div>
            <div>
                <div id="VariousDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Various_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Professional_Development_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Professional Developement Details</strong>
            </div>
            <div>
                <div id="ProfessionalDevelopmentDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Professional_Development_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Administrative_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Administrative Details</strong>
            </div>
            <div>
                <div id="AdministrativeDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Administrative_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Training_Programs_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Training Programs Details</strong>
            </div>
            <div>
                <div id="TrainingProgramsDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Training_Programs_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Favourable_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Favourable Details</strong>
            </div>
            <div>
                <div id="FavourableDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Favourable_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_unFavourable_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Unfavourable Details</strong>
            </div>
            <div>
                <div id="unFavourableDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="unFavourable_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Training_Required_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Training Required Details</strong>
            </div>
            <div>
                <div id="TrainingRequiredDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Training_Required_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
           <div id="div_faculty_Certificate_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Faculty Appraisal Certificate Details</strong>
                <button id="btnDownloadAll" class="btn btn-primary btn-sm" style="float:right;margin-top: -10px;height: 40px;">
            Download All as ZIP
        </button>
            </div>
            <div>
                <div id="CertificateDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="Certificate_example" class="display table table-striped table-bordered table-hover"
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


