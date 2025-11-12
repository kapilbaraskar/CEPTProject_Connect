<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="SJR_report.aspx.cs" Inherits="ProjectTraining_SJR_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>

    <script src="../Js/js2/xlsx.core.min.js" type="text/javascript"></script>
    <script src="../Js/js2/Blob.js" type="text/javascript"></script>
    <script src="../Js/js2/FileSaver.js" type="text/javascript"></script>
    <script src="../Js/js2/tableexport.min.js" type="text/javascript"></script>
    <style>
        tfoot {
            display: table-header-group;
        }

        .btn_rad {
            border-radius: 6px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
      <%--   <div style="margin-top: -18px;" class="start_date">
                Semester Start Date: 
                   <input type="text" name='sem_start_date' id="sem_start_date" readonly='true' style="width:72px !important;margin-top: 9px;" />
              &nbsp;
                 <input type="button" id="save_sem_start_date" value="Save" class="btn_rad btn_hide"/>
            </div>--%>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <a href="proposal_accept.aspx"><span class="panel-headingfont">Student Proposal Accept</span></a>
                | <strong><span class="panel-headingfont"> Site Information</span>
                </strong>| <a href="Admin_PSR_FCR_Report.aspx"><span class="panel-headingfont">  PSR & FCR Report </span></a>
                </strong>
            </div>
           
            <%--<div style="padding: 15px;" id="div3">
                <div class="row">
                    <div style="" class="form-group col-md-12">
                        <table id="tbl" class="table" style="width:98%">
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>--%>
            <div id="DataList" style="overflow-x: auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="Site_Information" class="display table table-striped table-bordered table-hover">
                    <thead>
                         
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var myObject = new Object();
        var Obj_instructor = new Object();
        var oTable;
        var asInitVals = new Array();
        $(document).ready(function () {
            debugger;
            
            var user_type = ('<%= Session["User_Type"] %>');

            var str = "";
            var str1 = "";
            window.faculty_name = "";
            //  tbl.innerHTML = '';
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_sjr_all_student",
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {

                    if (result.d != "") {
                        debugger;
                        DisplayData(result.d);
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
        
        });

        $('#save').click(function () {

            var myarrray = new Array();
            $('#example tbody tr').each(function () {
                var obj_save_mapping = new Object();
                if (this.id != "") {
                    obj_save_mapping.user_id = this.id;
                    obj_save_mapping.instructor_code = $(this).find('.select :selected').val();
                    obj_save_mapping.course_code = myObject[1]['course_code'];
                    obj_save_mapping.semester_type = myObject[1]['semester_type'];
                    obj_save_mapping.year_semester = myObject[1]['year_semester'];
                    obj_save_mapping.year_semester = myObject[1]['year_semester'];
                    obj_save_mapping.cancel_flag = 'N';
                    myarrray.push(obj_save_mapping);
                }
            });

            data = JSON.stringify({ "data": JSON.stringify(myarrray) });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/project_mapping_stud_instructor",
                data: data,
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    bootbox.alert(result.d);
                },
                error: function (error) {

                    console.log(error);
                }
            });
        });

        
        function DisplayData(data) {

            debugger;

            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="Site_Information"><thead></thead><tbody> <tfoot id="abc"><tr><th><input type="text" style="width: 5px; display: none" name="search_engine" value=""class="search_init" /></th><th><input type="text" style="width: 35px" name="search_engine" value="" class="search_init" /></th><th><center><input type="text" style="width: 54px;" name="search_Faculty" value="" class="search_init" /></center></th><th><input type="text" style="width: 86px" name="search_semester" value="" class="search_init" /></th><th><input type="text" style="width: 25px" name="search_code" value="" class="search_init" /></th></tr></tfoot> </tbody> </table>');
            }
                       
            oTable = $("#Site_Information").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "sDom": 't',
                //  "sScrollY": '400px',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "oTableTools": {
                    "aButtons": [
                        //"xls"
                    ]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
            { "sTitle": "Sr. No.", "mData": "row", "bSortable": false, },
            { "sTitle": "Code No.", "mData": "user_id", "bSortable": false, },
            //{ "sTitle": "email", "mData": "mail", "bSortable": false, "bVisible": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false, "sClass": 'cls_user_name' },
            { "sTitle": "Project Name", "mData": "project_name", "bSortable": false },
            { "sTitle": "Location", "mData": "location", "bSortable": false },
            { "sTitle": "Project Cost (Rs.)", "mData": "cost_work_pakage", "bSortable": false },
            { "sTitle": "Activities", "mData": "project_activity", "bSortable": false },
            { "sTitle": "Client", "mData": "client_name", "bSortable": false },
            { "sTitle": "Consultant", "mData": "principle_consultant", "bSortable": false },
            { "sTitle": "Contractor", "mData": "contractor", "bSortable": false },
            { "sTitle": "Site Contact Address", "mData": "address_from_communication", "bSortable": false },
            { "sTitle": "Student Contact Address", "mData": "communication_add_stud", "bSortable": false },
            { "sTitle": "Phone/ Fax", "mData": "stud_mobile", "bSortable": false }
            //{ "sTitle": "Mobile(site-in-charge)", "mData": "site_mobile", "bSortable": false },
            //{ "sTitle": "Landline(site-in-charge)", "mData": "landline", "bSortable": false },
            //{ "sTitle": "Communication Address(student)", "mData": "communication_add_stud", "bSortable": false },
            //{ "sTitle": "State", "mData": "state_student", "bSortable": false },
            //{ "sTitle": "city", "mData": "city_student", "bSortable": false },
            //{ "sTitle": "Mobile Number(student)", "mData": "stud_mobile", "bSortable": false },
            //{ "sTitle": "From Working hours", "mData": "from_working_hour", "bSortable": false },
            //{ "sTitle": "To Working hours", "mData": "to_working_hour", "bSortable": false },
            //{ "sTitle": "From Break", "mData": "from_lunch_hour" , "bSortable": false },
            //{ "sTitle": "To Break", "mData": "to_lunch_hour", "bSortable": false },
            //{ "sTitle": "Additional information If any.", "mData": "remark", "bSortable": false },
                ]
            });
            
            $('.cls_user_name').css('text-transform', 'capitalize');

            //$("tfoot input").keyup(function () {
            //    /* Filter on the column (the index) of this element */
            //    oTable.fnFilter(this.value, $("tfoot input").index(this));
            //});



            // /*
            // * Support functions to provide a little bit of 'user friendlyness' to the textboxes in
            // * the footer
            // */
            //$("tfoot input").each(function (i) {
            //    asInitVals[i] = this.value;
            //});

            //$("tfoot input").focus(function () {
            //    if (this.className == "search_init") {
            //        this.className = "";
            //        this.value = "";
            //    }
            //});

            //$("tfoot input").blur(function (i) {
            //    if (this.value == "") {
            //        this.className = "search_init";
            //        this.value = asInitVals[$("tfoot input").index(this)];
            //    }
            //});
            //$.ajax({
            //    type: "POST",
            //    url: "../WebService.asmx/Get_faculty_name_project",
            //    data: '{}',
            //    dataType: 'json',
            //    contentType: "application/json",
            //    async: false,
            //    success: function (result) {

            //        if (result.d != "") {
            //            debugger;
            //            window.faculty_name = JSON.parse(result.d);
            //        }
            //    },
            //    error: function (error) {
            //        console.log(error);
            //    }
            //});
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_instructor_detail",//5 instructor 5055 S 2018
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d != "") {
                        window.faculty_name = JSON.parse(result.d);
                    }
                    else {
                        
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
            var end_year;
            var start_year;
            var batch_year;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_cept_current_sem_data",
                data: "{type:'Project Training'}",
                async: false,
                dataType: "json",
                success: function (data) {
                    debugger;
                    obj = JSON.parse(data.d)

                    end_year = obj[0]['year_code'];
                    start_year = end_year - 1;
                    batch_year = end_year - 4;
                                 
                    
                },
                error: function (result) {
                    debugger;
                    alert(result);
                }
            });
            var str_html = '<tr style="display:none;"><th colspan="4"><b>Site Details of Project Training</b></th></tr>' + 
                           '<tr style="display:none;"><th>Batch</th><th>' + batch_year + '</th><th></th><th colspan="2" align="right"><b>Year: ' + start_year + ' - ' + end_year + '</b></th></tr>' +
                           '<tr style="display:none;"><th colspan="15">'+
                           '<b>Faculty: ';

                             for (var i = 0; i < window.faculty_name.length; i++) {
                                 debugger;
                                 if (i == 0) {
                                     str_html += ' Prof. ' + window.faculty_name[i].instructor_name;
                                 } else {
                                     str_html += ', Prof. ' + window.faculty_name[i].instructor_name;
                                 }
                             }

                             var final_str_html = str_html + '</b></th></tr>' + 
                            '<tr style="display:none;"><th>&nbsp;</th></tr>' + $('#Site_Information thead').html();

                             $('#Site_Information thead').html(final_str_html);

                             var DefaultTable = document.getElementById('Site_Information');
                new TableExport(DefaultTable, {
                    headers: true,
                    footers: true,
                    formats: ['xlsx'],
                    filename: 'id',
                    bootstrap: false,
                    position: 'bottom',
                    ignoreRows: null,
                    ignoreCols: null,
                    ignoreCSS: '.tableexport-ignore',
                    emptyCSS: '.tableexport-empty',
                    trimWhitespace: true
                });

                setDataTableHeaderFooter('Site_Information');

                $('#Site_Information caption').css('text-align', 'left');
                $('#Site_Information caption button').css('position', 'absolute');
                $('#Site_Information caption button').css('margin-top', '-48px');
                $('#Site_Information caption button').css('margin-left', '438px');
            }

    </script>
</asp:Content>

