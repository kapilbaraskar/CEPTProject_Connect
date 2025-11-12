<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="VF_core_details.aspx.cs" Inherits="Admin_Report_VF_core_details" %>

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
            bindsemdata();
            bindyeardata_for_cross_reg();
            bindprogrammedata();
            bindtypedata();
            $('#btnreterive').on('click', function () {
           
                get_Report_data();


                return false;
            });

        });

        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            $('#drpsemester').chosen();

           }
        function bindtypedata() {

            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Report Type --"));
            $('#drptype').append($("<option></option>").val("C").html("Course Details"));
            $('#drptype').append($("<option></option>").val("W").html("Work Details"));
            $('#drptype').append($("<option></option>").val("A").html("Acedemic Details"));
            $('#drptype').append($("<option></option>").val("R").html("Reference Details"));
            $('#drptype').chosen();

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

        function bindprogrammedata() {

            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
         }

           function get_Report_data() {
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }
        
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

            if (type_code == "C") {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_instructor_course_details",
                        //async: false,
                        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {
        
                            if (data.d != "" && data.d != "[]") {
                                Course_data_list(data.d);
                                $('#div_VF_course_list').css('display', 'block');
                                $('#div_VF_work_list').css('display', 'none');
                                $('#div_VF_Acedemic_list').css('display', 'none');
                                $('#div_VF_reference_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_VF_course_list').css('display', 'none');
                                $('#div_VF_work_list').css('display', 'none');
                                $('#div_VF_Acedemic_list').css('display', 'none');
                                $('#div_VF_reference_list').css('display', 'none');
        
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if (type_code == "W") {
                if (type_code == "W") {
                    type_code = "Work";
                }
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_instructor_work_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {
        
                            if (data.d != "" && data.d != "[]") {
                                Work_data_list(data.d);
                                $('#div_VF_course_list').css('display', 'none');
                                $('#div_VF_work_list').css('display', 'block');
                                $('#div_VF_Acedemic_list').css('display', 'none');
                                $('#div_VF_reference_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_VF_course_list').css('display', 'none');
                                $('#div_VF_work_list').css('display', 'none');
                                $('#div_VF_Acedemic_list').css('display', 'none');
                                $('#div_VF_reference_list').css('display', 'none');
        
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if (type_code == "A") {
                if (type_code == "A") {
                    type_code = "education";
                }
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_instructor_acedemic_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Acedemic_data_list(data.d);
                                $('#div_VF_course_list').css('display', 'none');
                                $('#div_VF_work_list').css('display', 'none');
                                $('#div_VF_Acedemic_list').css('display', 'block');
                                $('#div_VF_reference_list').css('display', 'none');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_VF_course_list').css('display', 'none');
                                $('#div_VF_work_list').css('display', 'none');
                                $('#div_VF_Acedemic_list').css('display', 'none');
                                $('#div_VF_reference_list').css('display', 'none');

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    }
                );
            }
            else if (type_code == "R") {
                if (type_code == "R") {
                    type_code = "reference";
                }
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_instructor_Reference_details",
                        //async: false,
                        data: "{course_code:'',sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "',type_code:'" + type_code + "'}",
                        dataType: "json",
                        success: function (data) {

                            if (data.d != "" && data.d != "[]") {
                                Reference_data_list(data.d);
                                $('#div_VF_course_list').css('display', 'none');
                                $('#div_VF_work_list').css('display', 'none');
                                $('#div_VF_Acedemic_list').css('display', 'none');
                                $('#div_VF_reference_list').css('display', 'block');
                            }
                            else {
                                bootbox.alert('No data Found For Selected Semester and Year');
                                $('#div_VF_course_list').css('display', 'none');
                                $('#div_VF_work_list').css('display', 'none');
                                $('#div_VF_Acedemic_list').css('display', 'none');
                                $('#div_VF_reference_list').css('display', 'none');

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

           function Course_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#courseDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="course_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#course_example").dataTable({

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
                       { "sTitle": "Type ", "mData": "designation", "designation": false },
                       { "sTitle": "Mobile No. ", "mData": "mobile_no", "bSortable": false },
                       { "sTitle": "Mail ID ", "mData": "mail", "bSortable": false },
                       { "sTitle": "Course-1 ", "mData": "course1_name", "bSortable": false },
                       { "sTitle": "Course-2 ", "mData": "course2_name", "bSortable": false },
                       { "sTitle": "Course-3 ", "mData": "course3_name", "bSortable": false },
                       { "sTitle": "Course-4 ", "mData": "course4_name", "bSortable": false },
                       { "sTitle": "Course-5 ", "mData": "course5_name", "bSortable": false },
                       {
                           "sTitle": "CV File ", "mData": null, "bSortable": false, mRender: function (data) {
                               if (data["cv_file_name"] != "") {
                                   var path_value = "../../InstructorCVUpload/" + data["cv_file_name"];
                                   return "<a href='" + path_value + "' download>Downlod PDF</a>";
                               }
                               else {
                                   return "PDF Not Available";
                               }
                           }
                       },
                       {
                           "sTitle": "Portfolio File ", "mData": null, "bSortable": false, mRender: function (data) {
                               if (data["portfolio_file_name"] != "") {
                                   var path_value = "../../InstructorPortfolioUpload/" + data["portfolio_file_name"];
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
               $('#course_example thead th').each(function (i, r) {
                   var nm = $('#course_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#course_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#course_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#course_example thead th').eq(i).text();
                   $('#course_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#courseDataList').css('display', 'block');
           }

           function Work_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#workDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="work_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#work_example").dataTable({

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
                       { "sTitle": "Type ", "mData": "designation", "designation": false },
                       { "sTitle": "Work Type ", "mData": "detail_type", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Work Designation ", "mData": "work_designation", "bSortable": false },
                       { "sTitle": "Institute ", "mData": "work_institute", "bSortable": false },
                       { "sTitle": "StartDate ", "mData": "work_start_date", "bSortable": false },
                       { "sTitle": "EndDate ", "mData": "work_end_date", "bSortable": false },
                       { "sTitle": "Experience Type ", "mData": "work_experience_type", "bSortable": false },
                       { "sTitle": "Mode ", "mData": "work_mode", "bSortable": false },
                       {
                           "sTitle": "Work Experience Certificate ", "mData": null, "bSortable": false, mRender: function (data) {
                               if (data["work_experience_cert"] != "") {
                                   var path_value = "../../InstructorWorkExperiencecertificate/" + data["work_experience_cert"];
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
               $('#work_example thead th').each(function (i, r) {
                   var nm = $('#work_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#work_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#work_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#work_example thead th').eq(i).text();
                   $('#work_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#workDataList').css('display', 'block');

           }

           function Acedemic_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#acedemicDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="acedemic_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#acedemic_example").dataTable({

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
                       { "sTitle": "Designation ", "mData": "designation", "designation": false },
                       { "sTitle": "Education Type ", "mData": "detail_type", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Program ", "mData": "prog_name", "bSortable": false },
                       { "sTitle": "Degree ", "mData": "degree", "bSortable": false },
                       { "sTitle": "Specialization ", "mData": "specialization", "bSortable": false },
                       { "sTitle": "University ", "mData": "university", "bSortable": false },
                       { "sTitle": "Start Date ", "mData": "edu_start_date", "bSortable": false },
                       { "sTitle": "End Date ", "mData": "edu_end_date", "bSortable": false },
                       { "sTitle": "Education Mode Type ", "mData": "edu_type", "bSortable": false },
                       { "sTitle": "CGPA/Percentage ", "mData": "edu_percentage", "bSortable": false },
                       { "sTitle": "Education Mode ", "mData": "edu_mode", "bSortable": false }
                       
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#acedemic_example thead th').each(function (i, r) {
                   var nm = $('#acedemic_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#acedemic_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#acedemic_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#acedemic_example thead th').eq(i).text();
                   $('#acedemic_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#acedemicDataList').css('display', 'block');
           }

           function Reference_data_list(data) {

               if (oTable != null) {
                   oTable.fnDestroy();
                   $("#referenceDataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="reference_example" width="100%"><thead></thead><tbody> </tbody></table>');
               }

               oTable = $("#reference_example").dataTable({

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
                       { "sTitle": "Designation ", "mData": "designation", "designation": false },
                       { "sTitle": "Detail Type ", "mData": "detail_type", "bSortable": false },
                       { "sTitle": "SrNo. ", "mData": "sr_no", "bSortable": false },
                       { "sTitle": "Referee Name ", "mData": "referee_name", "bSortable": false },
                       { "sTitle": "Referee MobileNo. ", "mData": "referee_mobile_no", "bSortable": false },
                       { "sTitle": "Referee EmailID ", "mData": "referee_email_id", "bSortable": false }
                   ]
               });
               var thead = $('<tr class="dt"></tr>');
               $('#reference_example thead th').each(function (i, r) {
                   var nm = $('#reference_example thead th').eq($(this).index()).text();
                   thead.append('<th></th>');
               });
               $('#reference_example thead').append(thead);

               //adding input box in thead second row 

               for (var i = 0; i < $("#reference_example tr:nth-child(2) th").length - 1; i++) {
                   var title = $('#reference_example thead th').eq(i).text();
                   $('#reference_example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
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

               $('#referenceDataList').css('display', 'block');
           }

           $(document).on("click", "#btnDownloadAll", function () {
               downloadAllFilesAsZip();
           });

           $(document).on("click", "#btnDownloadAll_work", function () {
               downloadAllFilesAsZip_work();
           });

           
           function downloadAllFilesAsZip() {
               var tableData = oTable.fnGetData();
               var files = {
                   CV: [],
                   Portfolio: []
               };

               tableData.forEach(function (row) {
                   if (row.cv_file_name && row.cv_file_name.trim() !== "") {
                       files.CV.push(row.cv_file_name);
                   }
                   if (row.portfolio_file_name && row.portfolio_file_name.trim() !== "") {
                       files.Portfolio.push(row.portfolio_file_name);
                   }
               });

               if (files.CV.length === 0 && files.Portfolio.length === 0) {
                   bootbox.alert("No files available to download.");
                   return;
               }

               $.ajax({
                   url: "../../WebService.asmx/DownloadZip",
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

           function downloadAllFilesAsZip_work() {
               var tableData = oTable.fnGetData();
               var files = {
                   Work_Certificates: []
               };

               tableData.forEach(function (row) {
                   if (row.work_experience_cert && row.work_experience_cert.trim() !== "") {
                       files.Work_Certificates.push(row.work_experience_cert);
                   }
               });

               if (files.Work_Certificates.length === 0) {
                   bootbox.alert("No files available to download.");
                   return;
               }

               $.ajax({
                   url: "../../WebService.asmx/DownloadZip_work",
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
                <i class="icon-desktop"></i>VF Core Details Report
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
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                 <td>Report Type
                                </td>
                                <td>
                                    <select class="chosen-select" id="drptype">
                                    </select>
                                </td>
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
        <div id="div_VF_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>VF Course Details</strong>
                 <button id="btnDownloadAll" class="btn btn-primary btn-sm" style="float:right;margin-top: -10px;height: 40px;">
            Download All as ZIP
        </button>
            </div>
            <div>

                <div id="courseDataList" style="display: none; overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="course_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="div_VF_Acedemic_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>VF Acedemic Details</strong>
            </div>
            <div>
                <div id="acedemicDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="acedemic_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
          <div id="div_VF_work_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>VF Work Details</strong>
                <button id="btnDownloadAll_work" class="btn btn-primary btn-sm" style="float:right;margin-top: -10px;height: 40px;">
            Download All as ZIP
        </button>
            </div>
            <div>
                <div id="workDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="work_example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

          <div id="div_VF_reference_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>VF Reference Details</strong>
            </div>
            <div>
                <div id="referenceDataList" style="display: none;overflow: overlay;">
                    <table cellpadding="0" cellspacing="0" border="0" id="reference_example" class="display table table-striped table-bordered table-hover"
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

