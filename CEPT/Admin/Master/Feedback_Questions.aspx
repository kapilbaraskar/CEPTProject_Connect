<%@ Page Title="Feedback Questions" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
     CodeFile="Feedback_Questions.aspx.cs" Inherits="Admin_Master_Feedback_Questions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .cls_course_type {
        width:103px;
        }
        .cls_sr_no {
        width:44px;
        }
        .cls_feedback_type {
        width:130px;
        }
        .cls_cancel_flag {
        width:60px;
        }
    </style>

    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            bind_feedback_question_type();

            $('#btnreterive').on('click', function () {
                feedback_questions_data();
                return false;
            });

            $('#btnsave').on('click', function () {
                feedback_questions_save_data();
                return false;
            });

            //return false;
        });

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

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();
        }

        function bind_feedback_question_type()
        {
            $('#drpquestiontype').empty().append($("<option></option>").val("").html("-- Please Select Feedback Question Type --"));
            $('#drpquestiontype').append($("<option></option>").val("FQ").html("Feedback Questions"));
            $('#drpquestiontype').append($("<option></option>").val("FQC").html("Feedback Questions For Chart"));

            $('#drpquestiontype').chosen();
        }

        function feedback_questions_data() {
            $('#DataList').css('display', 'none');

            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

            var feedback_quetion_type = $("#drpquestiontype").val();
            if (feedback_quetion_type == "") {
                bootbox.alert('Please select Feedback Qusetions Type');
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Feedback_questions_data",
                async: false,
                data: "{sem_code : '" + semester + "',year_code : '" + year_code + "',feedback_question_type : '" + feedback_quetion_type + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var dataa = JSON.parse(data["d"]);
                        if (dataa != "") {
                            Display_Assigned_report(data.d);
                        }
                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester');
                        $("#submitBtnDiv").css("display", "none");
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function Display_Assigned_report(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "sDom": 't',
                //"sScrollY": '400px',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "t<'row-fluid'<'span6'i><'span6'p>>",
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"oTableTools":
                //{
                //    "aButtons": [
                //        "copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},
                //"autoWidth" : true, 

                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Course Typology Name", "mData": "course_typology_name", "bSortable": false, "sClass":"cls_course_type" },
                    { "sTitle": "Sr No", "mData": "sr_no", "bSortable": false, "sClass": "cls_sr_no" },
                    { "sTitle": "Feedback Type", "mData": "feedback_type", "bSortable": false, "sClass":"cls_feedback_type" },
                    { "sTitle": "Feedback Questions", "mData": "feedback_instruction", "bSortable": false, "sClass": "cls_feedback_questions" },
                    { "sTitle": "Cancel Flag", "mData": "cancel_flag", "bSortable": false, "sClass": "cls_cancel_flag" },
                ]
            });           
            //var myTable = $('#example').dataTable();

            //var $row = $(this).closest("tr").off("mousedown");
            //var $tds = $row.find("td").not(':first').not(':last');

            //$.each($tds, function (i, el) {
            //    var txt = $(this).text();
            //    $(this).html("").append("<input type='text' value='" + txt + "'>");
            //});

            ////$('#example').on('click', 'tbody tr', function () {
            ////    myTable.row(this).edit();
            ////});
            //$('#example').on('click', 'tbody td:not(:first-child)', function (e) {
            //    editor.inline(this);
            //});

            $("#submitBtnDiv").css("display", "block");
            $('#DataList').css('display', 'block');
            
        }

        function feedback_questions_save_data() {
            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

            var feedback_quetion_type = $("#drpquestiontype").val();
            if (feedback_quetion_type == "") {
                bootbox.alert('Please select Feedback Qusetions Type');
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Save_Feedback_questions_data",
                async: false,
                data: "{sem_code : '" + semester + "',year_code : '" + year_code + "',feedback_question_type : '" + feedback_quetion_type + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        bootbox.alert(data.d);
                        return false;
                    }
                    else {
                        bootbox.alert(data.d);
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Feedback Questions
            </h1>
        </div>
    </div>
        <div  class="panel panel-default"">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Feedback Questions</span></strong>
            </div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div id="div_drpsem" class="form-group col-md-5">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Semester :
                        </div>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </div>
                    </div>
                    <div id="div_drpyear" class="form-group col-md-3"  style="margin-left:-8%">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Year :
                        </div>
                        <div class="col-md-8" style="padding: 0 0 0 0;">
                            <select class="chosen-select col-md-12" id="drpyear">
                            </select>
                        </div>
                    </div>
                 </div>
                <div class="row" style="margin-top:10px">
                    <div id="div_questions" class="form-group col-md-5">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Feedback Question Type :
                        </div>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpquestiontype">
                            </select>
                        </div>
                    </div>
                    <div style="margin-left: 41%;" class="form-group col-md-12">
                        <button class="btn  btn-primary" type="button" id="btnreterive">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>
                <div>
                    <span style="color:red">Note: To save Questions for current semester and year first Retrieve data from which semester and year you want to insert then click Save button.</span>
                </div>
            </div>
         </div>       
        <div id="DataList" class="panel panel-default" style="display:none;margin-bottom:40px;">
            <div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
         
    </div>
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center;display:none">
                    <table style="width: 100%">
                <tr>
                    <%--<td align="right" style="padding-left:75px;">--%>
                        <td style="padding-left:480px;">
                        <button id="btnsave" type="button" style="display: block" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Save
                        </button>
                    </td>
                </tr>
            </table>
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>
</asp:Content>
