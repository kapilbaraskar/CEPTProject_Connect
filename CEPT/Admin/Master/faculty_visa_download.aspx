<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="faculty_visa_download.aspx.cs" Inherits="Admin_Master_faculty_visa_download" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

     <script type="text/javascript">
        var oTable;
        $(document).ready(function () {

            Get_student_visa_dtl();
            $('#btndownload').on('click', function () {
                BulkDownloadVisa();
                return false;
            });

        });
        function rowClick_download_visa(row) {
            debugger;
            var rowId = row.parentElement.parentElement.parentElement.childNodes[1].childNodes[0].nodeValue;

            var course_code = getParameterByName('c');
            var semester = getParameterByName('s');
            var year_code = getParameterByName('y');



            if (semester == 'S') {
                semester = 'Summer';
            }
            else { semester = 'Winter'; }
            document.getElementById('Link').download = rowId + ' ' + 'Faculty Visa';
            document.getElementById('Link').href = '';
            document.getElementById('Link').href = window.location.origin + '\\FacultyVisa\\' + rowId + '_' + course_code + '_' + semester + '_' + year_code + '.pdf';
            document.getElementById('Link').click();



            //$.ajax(
            //    {
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/Genrate_Visa_PDF",
            //        async: true,
            //        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',student_code:'" + rowId + "',course_code:'" + course_code + "'}",
            //        dataType: "json",
            //        success: function (data) {
            //            if (data.d != "" && data.d != "[]") {
            //               
            //                if (semester == 'S') {
            //                    semester = 'Summer';
            //                }
            //                //PSD21038_Summer_2022.pdf
            //                else { semester = 'Winter';}
            //                document.getElementById('Link').download = rowId +' ' + 'Student Visa';
            //                document.getElementById('Link').href = '';
            //                document.getElementById('Link').href = window.location.origin + '\\StudentVisa\\' + rowId + '_' + semester +'_' + year_code + '.pdf';
            //                document.getElementById('Link').click();
            //                //course_wise_entered_marks_list_PC(data.d);
            //                //$('#div_course_list').css('display', 'block');
            //            }
            //            else {
            //                //bootbox.alert('No data Found For Selected Semester and Year');
            //                //$('#div_course_list').css('display', 'none');
            //            }
            //        },
            //        error: function (result) {
            //            alert(result);
            //        }
            //    });

            //window.location = "download_visa.aspx?c=" + rowId + "&s=" + semester + "&y=" + year_code;
        }
        var semester = '';
        var year_code = '';
        var prog_code = '';
        var prog_level_code = '';
        var asInitVals = new Array();

        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }
        function Get_student_visa_dtl() {
            $('#DataList').css('display', 'none');
            $('#div_btn').html('');

            semester = getParameterByName('s');


            year_code = getParameterByName('y');


            var course_code = getParameterByName('c');
            //prog_code = $('#drpprog').val();
            //prog_level_code = $('#drpproglevel').val();

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    //url: "../../WebService.asmx/Get_Course_Wise_Student_dtl",
                    url: "../../WebService.asmx/Get_Course_Wise_instructor_dtl",
                    async: false,
                    data: "{semester_type:'" + semester + "',year_semester:'" + year_code + "',course_code:'" + course_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var json_data = JSON.parse(data.d);
                            $('#course_code').text(json_data[0]['course_code']);
                            $('#course_name').text(json_data[0]['course_name']);
                            //$('#faculty_name').text(json_data[0]['instructors']);
                            //$('#ta_faculty_name').text(json_data[0]['TAinstructors']);

                            visa_details(data.d);

                            $('#div_course_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });



            return false;
        }
        function visa_details(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"oLanguage": {
                //"sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //"aButtons": [
                ////"copy",
                //"print",
                //{
                //"sExtends": "collection",
                //"sButtonText": 'Export',
                //"aButtons": ["xls"]
                //}
                //]
                //},

                "aaData": JSON.parse(data),
                
                "aoColumns": [
                    {
                        "sTitle": "<center><input type='checkbox' id='chk_select_all_student' onchange='select_all_student()' /> Select</center>", "mData": null, "bSortable": false, mRender: function (data) {
                            //&& data.category_location_wise != "On CEPT Campus Courses"
                            var row_value = data.instructor_code;
                            if (data.category_location_wise == "On CEPT Campus Courses" || data.category_location_wise == "Travel Based Within India" )
                            {
                                if (data.country.trim().toLowerCase() != 'india' && data.country.trim().toLowerCase() != 'indian' && data.country.trim().toLowerCase() != 'india.')
                                {
                                    return '<center><input type="checkbox"  name="check_all_student" value="1" class="chk_course" id="' + row_value + '" /></center>';
                                }

                            }

                            if (data.category_location_wise == "Online Course" && data.category_location_wise == "") {
                                return '';
                            }
                            else if (data.category_location_wise == "Travel Based Outside India") { return '<center><input type="checkbox"  name="check_all_student" value="1" class="chk_course" id="' + row_value + '" /></center>'; }
                            else { return '';}

                        }

                    },
                    { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
                    { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },

                    //{ "sTitle": "Total No of Exams", "mData": "total_exams", "bSortable": false },
                    //{ "sTitle": "Total No of Students", "mData": "total_students", "bSortable": false },

                    { "sTitle": "Category Location Wise", "mData": "category_location_wise", "bSortable": false },

                    {
                        "sTitle": "Designation", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.designation != "") {
                                return data.designation;
                            }
                            else { return ''; }

                        }
                    },


                    {
                        "sTitle": "Download PDF", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.visa_file_name == "true") {
                                return '<center><button type="button" onclick="rowClick_download_visa(this)">Download</button></center>';
                            }
                            else { return ''; }

                        }
                    }
                ]
            });

            //var thead = $('<tr class="dt"></tr>');
            //$('#example thead th').each(function (i, r) {
            //    var nm = $('#example thead th').eq($(this).index()).text();
            //    thead.append('<th></th>');
            //});
            //$('#example thead').append(thead);
            ////adding input box in thead second row  
            //for (var i = 0; i < 4; i++) {
            //    var title = $('#example thead th').eq(i).text();
            //    $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            //};
            //$("thead input").keyup(function () {
            //    /* Filter on the column (the index) of this element */
            //    oTable.fnFilter(this.value, $("thead input").index(this));
            //});
            //$("thead input").each(function (i) {
            //    asInitVals[i] = this.value;
            //});
            //$("thead input").focus(function () {
            //    if (this.className == "search_init") {
            //        this.className = "";
            //        this.value = "";
            //    }
            //});
            //$("thead input").blur(function (i) {
            //    if (this.value == "") {
            //        this.className = "search_init";
            //        this.value = asInitVals[$("thead input").index(this)];
            //    }
            //});

            $('#DataList').css('display', 'block');


        }

        function BulkDownloadVisa() {
            var oSettings = oTable.fnSettings();

            for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                oSettings.aoPreSearchCols[iCol].sSearch = '';
            }

            oSettings.oPreviousSearch.sSearch = '';
            oTable.fnDraw();

            var flag = "N";
            
            var datalist = [];
            $("#example tbody tr").each(function (i) {
                var obj = {};
                if ($(this).find(".chk_course").is(':checked')) {
                    flag = 'Y';
                    obj = {};
                    obj["user_id"] = $(this).children().eq(0)[0].children[0].childNodes[0].id;
                    obj["designation"] = $(this).children().eq(4).html();
                    datalist.push(obj);
                }
            });

            if (flag == "Y") {
                var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: getParameterByName('s'), year_code: getParameterByName('y'), course_code: getParameterByName('c') });

                $.ajax({
                    type: "POST",
                    url: "../../WebService.asmx/BulkDownloadFacultyVisa",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "Problem in save data") {
                                bootbox.alert("Problem in save data");
                                return false;
                            }
                            bootbox.alert("Faculty Visa Genrate Successfully");
                            location.reload();
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
            }
            else {
                bootbox.alert("Please Checked Checkbox");
                return false;
            }
        }


     </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Download Faculty Wisa
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Course Code :
                                </td>
                                <td>
                                   <b><span id="course_code"></span></b>
                                </td>
                                </tr>
                            <tr>
                                <td>
                                    Course Name  :
                                </td>
                                <td>
                                   <b><span id="course_name"></span></b>
                                </td>
                                </tr>

                            <%--<tr>
                                <td>
                                    Faculty Name :
                                </td>
                                <td>
                                    <b><span id="faculty_name"></span></b>
                                </td>
                                </tr>
                            <tr>
                                <td>
                                   TA Faculty Name :
                                </td>
                                <td>
                                    <b><span id="ta_faculty_name"></span></b>
                                </td>
                            </tr>--%>
                            <tr>
                                
                                <td>
                                    <button class="btn btn-primary" id="btndownload">
                                        Genrate PDF
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Download Visa</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div id="div_btn" style="text-align: center;">
        </div>
         <input type="hidden" id="hdn_degination" runat="server" clientidmode="Static" />
    </div>
     <div style="display: none;">
        <a href="#" id="Link" download="outline.pdf">Download</a>
    </div>
</asp:Content>

