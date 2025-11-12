<%@ Page Title="Thesis Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="student_thesis_dtl.aspx.cs" Inherits="Admin_Master_thesis_apporve" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script src="../../Js/admin_report.js?t=28082019" type="text/javascript"></script>


    <script type="text/javascript">
        var stud_id = '';
        var status = '';
        var oTable;
        var oTable1;
        var tbl_user_id = '';
        var prog_code;
        var prog_leve;
        var dept_code;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            //binddepartment();
            //bindprogrammedata();
            binddepartment();
            bindprogname();
            //bindproglevel();
           
            $('#btnreterive').on('click', function () {
                $("#div_tab").css('display', 'block');
                var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#thesispending'>Pending for Approval</a></li>" +
                    
                    "<li><a data-toggle='tab' href='#thesisapprove'>My Thesis/DRP Details&nbsp; </a></li></ul>";

                $("#div_myTab").html(strHtml);
                $("#thesispending").addClass("in active");
                
                get_thesis_data();
                get_thesis_data_approve();
                
                return false;

            });
            return false;
        });


        function get_thesis_data() {
            $('#DataList').css('display', 'none');

            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please Select Semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please Select Year');
                $('#drpyear').focus();
                return false;
            }

            prog_code = $('#drpprog').val();
            //if (prog_code == "")
            //{
            //    bootbox.alert('Please Select Program');
            //    $('#drpprog').focus();
            //    return false;
            //}
           //prog_leve = $('#drpproglevel').val();
            dept_code = $('#drpprogname').val();
            //if (prog_code == "") {
            //    bootbox.alert('Please Select Faculty Name');
            //    $('#drpprogname').focus();
            //    return false;
            //}

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_drp_details_user_wise",
                    async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "', dept_code:'" + dept_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {

                            if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'PC' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'A1' || $("#hdn_utype").val() == 'A' || $("#hdn_utype").val() == 'FA') {

                                display_thisis_detal(data.d);
                                
                            }

                            $('#div_course_list').css('display', 'block');
                        }
                        else
                        {
                            bootbox.alert('No data Found For Pending for Approval.');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function get_thesis_data_approve() {
            $('#DataList1').css('display', 'none');
            
            semester = $('#drpsemester').val();
            if (semester == "") {
                //bootbox.alert('Please Select Semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                //bootbox.alert('Please Select Year');
                $('#drpyear').focus();
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_thesis_detl",
                    async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',prog_code:'" + prog_code + "', dept_code:'" + dept_code + "',user_type:'',user_id:''}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {

                            display_thisis_detal_approve(data.d);

                            $('#div_course_list').css('display', 'block');
                        }
                        else
                        {
                            bootbox.alert('No data Found For My DRP Details');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function display_thisis_detal(data) {
            
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
                "iDisplayLength": 30,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },


                "aaData": JSON.parse(data),

                "aoColumns": columns

            });
            
            if ($("#hdn_utype").val() == 'A1' || $("#hdn_utype").val() == 'A') {
                $("table thead tr th:nth-child(2)").css("width", "10%");
                $("table thead tr th:nth-child(1)").css("width", "90%");
            }
            else
            {
                $("table thead tr th:nth-child(1)").css("width", "70%");
            }

            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            //$('.dt-button.buttons-csv.buttons-html5').css("display","none");
            $('#DataList').css('display', 'block');
        }

        function display_thisis_detal_approve(data) {

            var columns = set_table_columns_approve(JSON.parse(data)[0]);

            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_approve" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example_approve").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 30,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },


                "aaData": JSON.parse(data),

                "aoColumns": columns

            }); 
            // $("table thead tr th:nth-child(1)").css("width","70%");
             //$('.dt-button.buttons-csv.buttons-html5')[1].innerText = 'Excel';
            $('#DataList1').css('display', 'block');
        }

        function set_table_columns(row) {
            var columns = [];
            columns.push({
                "sTitle": "Description", "mData": null, "mRender": function (data) {
                    var formtype = data['form_type'];
                    var str = "";
                    str += "<div><div>";

                    if (formtype == '25') {
                        str += "<div><b>Thesis</b><div>";
                    }
                    if (formtype == '29') {
                        str += "<div><b>DRP</b><div>";
                        str += "<div style='width:45%; text-align:justify;float: left;padding-right: 50px;'><b>" + data['user_id'] + " : " + data['f_name'] + "</b></div>";
                    }

                    str += "<div style='width:45%; text-align:justify;float: left;padding-right: 50px;'><b>" + data['student_code'] + " : " + data['user_name'] + "</b></br><div style='float: left;'><b>" + data['course_code'] + " : " + data['course_name'] + "</b><p hidden>" + data['user_id'] + "</p> </div></div>";
                    str += "<div style='width:45%;float: left;'><b>Instructor Name : </b> " + data['instructor_name'] + "</div></br>"
                    // str += "<div style='width:20%;float: left;'><b>" + data['course_code'] +" : " + data['course_name'] + "</b> </div>"
                    str += "<div style='width:45%;float: left;'><b>Topic Title : </b> " + data['topic'] + "</div></br></br></br>"
                    str += "<div style='width:45%; text-align:justify;float: left;padding-right: 50px;'><b>Abstract : </b>" + data['thesis_abstract'] + "</div>";
                    str += "<div style='width:45%;float:left;'><b>Reference : </b> " + data['thesis_references'] + "</div><br/><br>";
                    str += "</div>";
                    str += "</div>";
                    str += "</div></div>";
                    return str;
                }
            });
            
            if ($("#hdn_utype").val() != 'A1' && $("#hdn_utype").val() != 'A')
            {
            columns.push({
                "sTitle": "Action", "mData": null, "sClass": "cls_action", "mRender": function (data)
                {
                    var user_id = data['instructor_code'];
                    if ($("#hdn_user_id").val() == user_id)
                    {
                        return '<button type="button" onclick="rowClick_Accept(this,oTable)">Accept</button><button type="button" onclick="rowClick_Reject(this,oTable)" style="margin-left:10px;">Reject</button><button type="button" onclick="rowClick_Review(this,oTable)" style="margin-left:32px;margin-top:20px;">Review</button>';
                    }
                    else {
                        return '<button type="button" onclick="rowClick_Accept(this,oTable)">Accept</button><button type="button" onclick="rowClick_Reject(this,oTable)" style="margin-left:10px;">Reject</button>';
                    }
                }
            });
            }

            columns.push({ "sTitle": "Status", "sClass": "cls_status", "mData": "status" });
            

            return columns;
        }

        function set_table_columns_approve(row) {
            var columns = [];
            columns.push({
                "sTitle": "Description", "mData": null, "mRender": function (data) {
                    var formtype = data['form_type'];
                    var str = "";
                    str += "<div><div>";

                    if (formtype == '25') {
                        str += "<div><b>Thesis</b><div>";
                    }
                    if (formtype == '29') {
                        str += "<div><b>DRP</b><div>";
                        str += "<div style='width:45%; text-align:justify;float: left;padding-right: 50px;'><b>" + data['user_id'] + " : " + data['f_name'] + "</b></div>";
                    }

                    str += "<div style='width:45%; text-align:justify;float: left;padding-right: 50px;'><b>" + data['student_code'] + " : " + data['user_name'] + "</b></br><div style='float: left;'><b>" + data['course_code'] + " : " + data['course_name'] + "</b><p hidden>" + data['user_id'] + "</p> </div></div>";
                    str += "<div style='width:45%;float: left;'><b>Instructor Name : </b> " + data['instructor_name'] + "</div></br>"
                    // str += "<div style='width:20%;float: left;'><b>" + data['course_code'] +" : " + data['course_name'] + "</b> </div>"
                    str += "<div style='width:45%;float: left;'><b>Topic Title : </b> " + data['topic'] + "</div></br></br></br>"
                    str += "<div style='width:45%; text-align:justify;float: left;padding-right: 50px;'><b>Abstract : </b>" + data['thesis_abstract'] + "</div>";
                    str += "<div style='width:45%;float:left;'><b>Reference : </b> " + data['thesis_references'] + "</div><br/><br>";
                    str += "</div>";
                    str += "</div>";
                    str += "</div></div>";
                    return str;
                }
            });

            columns.push({ "sTitle": "Status", "mData": "status" });

            return columns;
        }

        //---- Action Active and Reject------// 
        function rowClick_Accept(row, objtable) {
            stud_id = objtable.fnGetData($(row).closest('tr')[0])['student_code'];
            tbl_user_id = objtable.fnGetData($(row).closest('tr')[0])['user_id'];
            status = 'A';
            thesis_accept_reject_data(status);
        }

        function rowClick_Reject(row, objtable) {
            stud_id = objtable.fnGetData($(row).closest('tr')[0])['student_code'];
            tbl_user_id = objtable.fnGetData($(row).closest('tr')[0])['user_id'];
            status = 'R';
            thesis_accept_reject_data(status);
        }

        function rowClick_Review(row, objtable) {
            stud_id = objtable.fnGetData($(row).closest('tr')[0])['student_code'];
            tbl_user_id = objtable.fnGetData($(row).closest('tr')[0])['user_id'];
            status = 'Review';
            thesis_accept_reject_data(status);
        }
        ///---- Thesis Accept Reject ------////

        function thesis_accept_reject_data(status) {
            //$('#DataList').css('display', 'none');

            if (stud_id == "") {
                bootbox.alert('Please Insert Student Code');
                return false;
            }
            if (status == "" && status == undefined) {
                bootbox.alert('Please Status Code');
                return false;
            }
            if (tbl_user_id == "") {
                bootbox.alert('Please Insert user_id');
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_thesis_data",
                    //async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',stud_id:'" + stud_id + "',status:'" + status + "',user_id:'" + tbl_user_id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "true")
                        {
                            if (status == 'A') {
                                bootbox.alert("Student Thesis/DRP Accepted Successfully");
                            }
                            else if (status == 'R') {
                                bootbox.alert("Student Thesis/DRP Rejected Successfully");
                            }
                            else
                            { bootbox.alert("Student Thesis/DRP Review Successfully");}

                            get_thesis_data();
                            get_thesis_data_approve();
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }


        ///-----Department Wise Details-------///
        function binddepartment()
        {
            if ($('#hdn_utype').val() == 'FAA' || $('#hdn_utype').val() == 'PCC')
            {
                $('.cls_dept_prog').css('display', 'none');
                var url_user_wise;
                if ($('#hdn_utype').val() == 'FA') {
                    url_user_wise = "../../WebService.asmx/get_Admin_wise_Program_user_dtl";
                }
                if ($('#hdn_utype').val() == 'PC') {
                    url_user_wise = "../../WebService.asmx/get_programme_coordinator_dtl";
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_user_wise,
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);
                            $('#drpprog').empty();
                            for (var i = 0; i < user_data.length; i++) {

                                if (user_data[i]['prog_code'] == "1") {
                                    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                }
                                else if (user_data[i]['prog_code'] == "2") {
                                    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                }
                                else if (user_data[i]['prog_code'] == "3") {
                                    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                }
                            }
                        }
                        else {
                            $('#drpprog').val('1');
                            $("#drpprog").attr('disabled', 'disabled');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            }
            else {
                $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
                $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
            }
        }

        function bindprogname() {
            var url_user_wise;
            if ($('#hdn_utype').val() == 'FAA') {
                url_user_wise = "../../WebService.asmx/get_faculty_name_department_wise";
            }
            else if ($('#hdn_utype').val() == 'PCC') {
                url_user_wise = "../../WebService.asmx/get_pc_name_department_wise";
            }
            else {
                url_user_wise = "../../WebService.asmx/Get_department_data";
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: url_user_wise,
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_name_data = JSON.parse(data.d)

                        $('#drpprogname').empty().append($("<option></option>").val("").html("-- Please Select Faculty --"));

                        for (var i = 0; i < prog_name_data.length; i++)
                        {
                            $('#drpprogname').append($("<option></option>").val(prog_name_data[i]["dept_code"]).html(prog_name_data[i]["dept_name"]));
                        }
                        if (prog_name_data.length == 1)
                        {
                            $('#drpprogname').val(prog_name_data[0]["dept_code"]);
                        }
                        
                        //$('#drpprogname').chosen();
                        //}
                    }
                    else {
                        $('#drpprogname').empty().append($("<option></option>").val("").html("-- Please Select Prog Name --"));
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

    </script>
    <style>
        .cls_status {
            width:54px !important;
        }
        .cls_action {
            width:125px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Thesis/DRP Approval
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
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>

                            <tr>
                                <td>Program :
                                </td>
                                <td>
                                    <select class ="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>Faculty :
                                </td>
                                <td>
                                    <select class ="chosen-select" id="drpprogname">
                                    </select>
                                </td>
                                <td style="display:none">Program Level :
                                </td>
                                <td style="display:none">
                                    <select class ="chosen-select" id="drpproglevel">
                                    </select>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Thesis/DRP Details</strong>
            </div>
            <div id="div_myTab">
                <%--<ul class="nav nav-tabs" id="myTab">
                <li class="active"><a data-toggle="tab" href="#pendingthesis">Thesis Pending for Approval&nbsp;</a>
                </li>
                <li><a data-toggle="tab" href="#thesisinfo">Thesis Approve/Reject &nbsp; </a></li>
                </ul>--%>
            </div>
            <div>

                <div class="tab-content">
                    <div id="thesispending" class="tab-pane">
                        <div id="DataList" style="display: none; overflow: auto">
                            <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                                width="100%">
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="thesisapprove" class="tab-pane">
                        <div id="DataList1" style="display: none; overflow: auto">
                            <table cellpadding="0" cellspacing="0" border="0" id="example_approve" class="display table table-striped table-bordered table-hover"
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
        </div>
    </div>

    <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_user_id" runat="server" ClientIDMode="Static" />

</asp:Content>

