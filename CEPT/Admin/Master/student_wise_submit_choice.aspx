<%@ Page Title="Student Wise Sunmitted L3 Choice Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="student_wise_submit_choice.aspx.cs" Inherits="Admin_Master_student_wise_submit_choice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js?t=16122021" type="text/javascript"></script><%--01012021--%>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        var asInitVals = new Array();

        $(document).ready(function () {

            if ($('#hdnuserid').val() == 'admin.asc@cept.ac.in')
            {
                $('#adminsection').css('display', '');
            }
            bindsemdata();
            bindyeardata_for_cross_reg();
            bindtypedata();
            binddepartment();
            bindprogrammedata();

            bindproglevel();
            bind_program_level_code();
            $('#drpdepartment').on('change', function () {
                bind_program_level_code();
            });
            $('#drpprog').on('change', function () {
                bind_program_level_code();
            });



            $('#btnreterive').on('click', function () {
                if ($('#drpyear').val() == "") {
                    bootbox.alert('please select year.');
                    return false;
                }
                cur_sem = $('#drpsem').val()
                cur_year = $('#drpyear').val();
                prog_code = $('#drpprog').val();
                prog_level_code = $('#drpproglevel').val();
                dept_code = $('#drpdepartment').val();

                get_student_wise_dtl();
                return false;
            });


            $('#btnsaveuser').on('click', function () {

                if ($('#hdnuserid').val() == 'admin.asc@cept.ac.in')
                {
                if ($('#drpsemester').val() == "") {
                    bootbox.alert('Please select Semester.');
                    return false;
                }
                if ($('#drpyear').val() == "") {
                    bootbox.alert('Please select year.');
                    return false;
                }
                if ($('#drpcat').val() == "") {
                    bootbox.alert('Please select Type.');
                    return false;
                }
                if ($('#userid').val() == "") {
                    bootbox.alert('Please Enter Student Code.');
                    return false;
                }
                var studio_level = "";
                if ($('#drpcat').val() == '23') {
                    studio_level = 'L2';
                }
                else if ($('#drpcat').val() == '29') {
                    studio_level = 'L3';
                }
                else if ($('#drpcat').val() == '26') {
                    studio_level = 'L2';
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/without_Check_eligibility_L2",
                    async: false,
                    data: "{studio_level:'" + studio_level + "',sub_cat_id:'" + $('#drpcat').val() + "',sem_code:'" + $('#drpsemester').val() + "',year_code:'" + $('#drpyear').val() + "',student_code:'" + $('#userid').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == 'false') {
                                alert("Not Eligible for this Semester (Please Read Instructions)")
                                return false;
                            }
                            else if (data.d == 'true') {
                                alert("L3 Choice Preference Data Saved Successfully");
                                get_user_detail();
                                return false;
                            }
                            else {
                                alert(data.d);
                                return false;
                            }
                        }
                        else {
                            alert(data.d);
                            return false;
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
                }
            });

        });

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            $('#drpsemester').chosen();
        }

        function bindtypedata() {
            $('#drpcat').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drpcat').append($("<option></option>").val("23").html("Studio"));
            $('#drpcat').append($("<option></option>").val("29").html("DRP"));
            $('#drpcat').append($("<option></option>").val("26").html("Internship"));
            $('#drpcat').chosen();
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

        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        function get_student_wise_dtl() {
            $('#DataList').css('display', 'none');

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

            var sub_cat_id = $('#drpcat').val();
            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();
            var prog_level_code = $('#drpproglevel').val();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Data_choice_preference_dtl",
                //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',sub_cat_id:'" + sub_cat_id + "',dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {

                        display_Choice_detail(data.d);

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

        function set_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Student Code", "mData": "user_id" });
            columns.push({ "sTitle": "Student Name", "mData": "full_name" });
            columns.push({ "sTitle": "Appliced For", "mData": "appliedfor" });
            columns.push({ "sTitle": "L3 Choice", "mData": "Choice" });
            columns.push({
                "sTitle": "Status", "mData": "status", "mRender": function (data) {
                    if (data == 'Y') {
                        return 'Submitted';
                    }
                    else { return 'Pending';}
                    
                    
                }
            });
            columns.push({
                "sTitle": "Submitted Date", "mData": "created_date_by", "mRender": function (data) {
               
                    return data;
                }
            });

            columns.push({
                "sTitle": "Enable", "mData": "editstatus", "mRender": function (data)
                {
                    if ($('#hdnusertype').val() == 'A1' || $('#hdnusertype').val() == 'A')
                    {
                        if (data == '') {
                            return '<button type="button" class="btn btn-primary btn-small enable">Enable</button>';
                        }
                        else {
                            return 'Only one Time Edit L3 Choice Details ';
                        }
                    }
                    //nitinbhai 14032024 Anydesk 
                    else if ($('#hdnusertype').val() == 'FA')
                    {

                        if (data == '') {
                            return '';
                        }
                        else {
                            return 'One Time Lifeline Used ';
                        }
                    }
                    //END
                    else { return '';}
                    
                    
                }
            });

            return columns;
        }

        function display_Choice_detail(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

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
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
				//        "print",
            	//        {
            	//            "sExtends": "collection",
            	//            "sButtonText": 'Export',
            	//            "aButtons": ["xls"]
            	//        }
			    //    ]
                //},

                "aaData": JSON.parse(data),

                "aoColumns": columns

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
            //$('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }


        $(document).on("click", ".enable", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var student_id = aData["user_id"];
            var instructor_name = aData["full_name"];
            var sub_cat_id = aData["Choice"];
            if (sub_cat_id == 'Studio') {
                sub_cat_id = ' 23';
            } else if (sub_cat_id == 'DRP') {
                sub_cat_id = ' 29';
            }
            else { sub_cat_id = ' 26';}

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
           
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_L3_details",
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',student_id:'" + student_id + "',sub_cat_id:'" + sub_cat_id + "'}",
                    async: false,
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            
                            alert("Data Update Successfully");
                            get_student_wise_dtl();
                            //var json_dtl = JSON.parse(data.d);
                            return false;
                           

                        }
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });





            return false;
        });

        function bind_program_level_code() {
            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();

            if (dept_code == '' && prog_code == '') {

                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_programme_level_dept_wise",
                data: "{dept_code : '" + dept_code + "',prog_code:'" + prog_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Program level Code course --"));

                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(year_data[i]["prog_level_code"]).html(year_data[i]["prog_level_desc"]));
                        }

                        $('#drpproglevel').chosen();
                        $('#drpproglevel').trigger("liszt:updated");
                    }
                    else {
                        $('#drpproglevel')
                            .find('option')
                            .remove()
                            .end()
                            .append('<option value="">No Program level found</option>')
                            .val('');
                        $('#drpproglevel').chosen();

                        $('#drpproglevel').val('').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function bindproglevel() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data_rights_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d)

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }
                        $('#drpproglevel').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Student Wise Sunmitted L3 Choice Details
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>
                                    Year  :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    Type  :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpcat">
                                    </select>
                                </td>
                                </tr>
                                <tr>
                                <td>
                               Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
                            </td>
                                 <td>
                               Program :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog" />
                            </td>
                                    <td>
                                    Program Level :
                                </td>
                                    <td>
                                        <select class="chosen-select" id="drpproglevel"
                                    </td>
                                    </tr>
                            <tr>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>

                            <tr id="adminsection" style="display:none;">
                                <td>Student Code</td>
                                <td><input type="text" id="userid" /></td>

                                <td><button class="btn btn-primary" id="btnsaveuser">
                                        Save
                                    </button></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>L3 Choice Detail</strong>
            </div>
            <div><%--class="panel-body"--%>      
                <div id="DataList" style="display: none;overflow:auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
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

