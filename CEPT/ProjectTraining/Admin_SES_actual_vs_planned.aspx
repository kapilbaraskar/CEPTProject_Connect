<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Admin_SES_actual_vs_planned.aspx.cs" Inherits="ProjectTraining_Admin_SES_actual_vs_planned" %>

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
    <div class="well" style="background-color: White; width: 1089px !important; margin-left: -34px;">
      <%--   <div style="margin-top: -18px;" class="start_date">
                Semester Start Date: 
                   <input type="text" name='sem_start_date' id="sem_start_date" readonly='true' style="width:72px !important;margin-top: 9px;" />
              &nbsp;
                 <input type="button" id="save_sem_start_date" value="Save" class="btn_rad btn_hide"/>
            </div>--%>
        <div class="panel panel-default " style="width:1086px !important">
            <div class="panel-heading">
                <a href="proposal_accept.aspx"><span class="panel-headingfont">Student Proposal Accept</span></a>
                | <a href="SJR_report.aspx"><span class="panel-headingfont">  Site Information </span></a> |<strong>SES Planned vs SES Actual</strong>
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
            <div id="DataList">
                <table cellpadding="0" cellspacing="0" border="0" id="SES_Planned_vs_SES_Actual" class="display table table-striped table-bordered table-hover">
                    <thead>
    
                    </thead>
                    <tbody>                    
                    </tbody>
                    <tfoot>
                        
                    </tfoot>
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
            var user = '';

            if (user == undefined) {
                user = getQueryStringValue('user_id');
                if (user == '') {
                    user = ('<%= Session["UserId"] %>');
                }
            }

            function getQueryStringValue(key) {
                return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
            }
            user = getQueryStringValue('user_id');
            var str = "";
            var str1 = "";
            //  tbl.innerHTML = '';
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_student_SES_planned_vs_actual_for_admin",
                data: '{user_id : "' + user + '"}',
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

        function DisplayData(data) {



            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="SES_Planned_vs_SES_Actual"><thead></thead><tbody> <tfoot id="abc"><tr><th><input type="text" style="width: 5px; display: none" name="search_engine" value=""class="search_init" /></th><th><input type="text" style="width: 35px" name="search_engine" value="" class="search_init" /></th><th><center><input type="text" style="width: 54px;" name="search_Faculty" value="" class="search_init" /></center></th><th><input type="text" style="width: 86px" name="search_semester" value="" class="search_init" /></th><th><input type="text" style="width: 25px" name="search_code" value="" class="search_init" /></th></tr></tfoot> </tbody> </table>');
            }


            oTable = $("#SES_Planned_vs_SES_Actual").dataTable({
                "bSort":false,
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
                        //"xls", "pdf"
                    ]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
                { "sTitle": "Date", "mData": "date_of_sub", "bSortable": false },
                //{ "sTitle": "Planned Structure", "mData": "structure", "bSortable": false },
                { "sTitle": "Activity", "mData": "activity", "bSortable": false },
                { "sTitle": "Location", "mData": "location", "bSortable": false },
                { "sTitle": "Date", "mData": "date_of_sub", "bSortable": false },
                //{ "sTitle": "Actual Structure", "mData": "structure_actual", "bSortable": false, "sClass": 'cls_user_name' },
                { "sTitle": "Activity", "mData": "activity_actual", "bSortable": false },
                { "sTitle": "Location", "mData": "location_actual", "bSortable": false }
                //{ "sTitle": "Actual Description", "mData": "Remark", "bSortable": false }
                ]
            });

            $('.cls_user_name').css('text-transform', 'capitalize');
            //$("tfoot input").keyup(function () {
            //    /* Filter on the column (the index) of this element */
            //    oTable.fnFilter(this.value, $("tfoot input").index(this));
            //});



            ///*
            //* Support functions to provide a little bit of 'user friendlyness' to the textboxes in
            //* the footer
            //*/
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
                           '<tr style="display:none;"><th colspan="15">' +
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
           '<tr style="display:none;"><th>&nbsp;</th>' +
           '</tr><tr><th colspan="3" style="text-align:center;">SES Planned</th><th colspan="3" style="text-align:center;">SES Actual</th>' +
           '</tr>' + $('#SES_Planned_vs_SES_Actual thead').html();

            $('#SES_Planned_vs_SES_Actual thead').html(final_str_html);

            var DefaultTable = document.getElementById('SES_Planned_vs_SES_Actual');
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

            setDataTableHeaderFooter('SES_Planned_vs_SES_Actual');

            $('#SES_Planned_vs_SES_Actual caption').css('text-align', 'left');
            $('#SES_Planned_vs_SES_Actual caption button').css('position', 'absolute');
            $('#SES_Planned_vs_SES_Actual caption button').css('margin-top', '-48px');
            $('#SES_Planned_vs_SES_Actual caption button').css('margin-left', '465px');
        }

    </script>
</asp:Content>

