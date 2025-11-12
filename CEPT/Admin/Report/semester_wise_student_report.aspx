<%@ Page Title="Semester Wise Student Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="semester_wise_student_report.aspx.cs" Inherits="Admin_Report_semester_wise_student_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Semester Wise Student Report
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">

        <div class="panel panel-default" style="">
            
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                            Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>
                            Year of Allocation
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td>
                            Student Enrollment Year
                        </td>
                        <td>
                            <select class="chosen-select" id="drp_student_enroll_year">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Department
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            Programme
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnretrieve">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="DataList" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Students Detail</strong>
            </div>
            
            <div style="overflow:auto;">
                <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0" border="0" id="example" width="100%">
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <script type="text/javascript">

        var oTable;
        var asInitVals = new Array();

        $(document).ready(function () {

            bindsemdata();
            bindyeardata_for_cross_reg();
            bindyeardata();
            binddepartment();
            bindprogrammedata();

            $('#btnretrieve').on('click', function () {

                var semester = $('#drpsemester').val();
                if (semester == "") {
                    bootbox.alert('Please Select Semester')
                    $('#drpsemester').focus();
                    return false;
                }

                var year_code = $('#drpyear').val();
                if (year_code == "") {
                    bootbox.alert('Please Select Year of Allocation')
                    $('#drpyear').focus();
                    return false;
                }

                var dept_code = $('#drpdepartment').val();

                var student_enroll_year = $('#drp_student_enroll_year').val();

                var prog_code = $('#drpprog').val();


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_semester_wise_student_report",
                    data: "{semester:'" + semester + "',year_code:'" + year_code + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',student_enroll_year:'" + student_enroll_year + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            display_student_data(data.d);
                            setDataTableHeaderFooter('example');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                return false;
            });
        });

        function display_student_data(data) {
            
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <div class="panel-heading"><strong>Students Detail</strong></div><div style="overflow:auto;"><table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table></div>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "iDisplayLength": 60,
                "bSort": false,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //        "sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
				//			    "copy",
				//			    "print",
				//			    {
				//			        "sExtends": "collection",
				//			        "sButtonText": 'Export',
				//			        "aButtons": ["xls", "pdf"]
				//			    }
				//		    ]
                //},

                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Program", "mData": "prog_code", "bSortable": false },
                    { "sTitle": "Program Level", "mData": "prog_level_code", "bSortable": false },
                    { "sTitle": "Year of Enrollement", "mData": "year_desc", "bSortable": false },
                    { "sTitle": "Email", "mData": "mail", "bSortable": false },
                    { "sTitle": "Alternat Email", "mData": "alternet_mail", "bSortable": false },
                    { "sTitle": "Gender", "mData": "gender", "bSortable": false },
                    { "sTitle": "Mobile", "mData": "mobile_no", "bSortable": false },
                    { "sTitle": "DOB", "mData": "dob", "bSortable": false, "mRender": function (data) {
                        if (data != '') {
                            var temp_date = new Date(data);
                            if (temp_date.toString() != "Invalid Date") return temp_date.getDate().toString() + '/' + (temp_date.getMonth() + 1).toString() + '/' + temp_date.getFullYear().toString();
                            else return '';
                        }
                        else return '';
                    }
                    },
                    { "sTitle": "Blood Group", "mData": "blood_group", "bSortable": false }
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


            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            
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
                        var year_data = JSON.parse(data.d);

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

                        $('#drp_student_enroll_year').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drp_student_enroll_year').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drp_student_enroll_year').chosen();
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

        function binddepartment() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                aSync: false,
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

    </script>

</asp:Content>
