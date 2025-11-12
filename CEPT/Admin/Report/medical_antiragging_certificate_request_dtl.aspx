<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="medical_antiragging_certificate_request_dtl.aspx.cs" Inherits="Admin_Report_medical_antiragging_certificate_request_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script src="../../Js/admin_report.js?t=31052021" type="text/javascript"></script>

    <script type="text/javascript">
       // const { type } = require("jquery");
       // const { type } = require("jquery");

        var semester = '';
        var year_code = '';
        var oTable;
        var oTable1;
        var oTable2;
        var user_type = '';
        var dept_code_ = '';
        var prog_level = '';
        var studio_level = '';

        $(document).ready(function () {
            user_type = $('#hdn_user_type').val();

            //get_submit_certificate_detail();
            bindtypedata();
            bindyeardata();
            bindtypecertdata();
            binddepartment();
            bindprogrammedata();
            $('#btnreterive').on('click', function ()
            {
                 if($('#certitype').val() == "")
                 {
                     bootbox.alert("Please Select Certificate"); return false;
                 }
            if($('#drptype').val() == "")
            {
                bootbox.alert("Please Select Type"); return false;
            }
                //if($('#drptype').val() == "")
                //{bootbox.alert("Please Select Type"); return false;}
                get_submit_certificate_detail();
                return false;
            });


            $('#btndownload_pdf').on('click', function () {
                var FileName = '';
                var obj_selected_course = $('.cls_chk_user_select:checked');
                if (obj_selected_course.length > 0) {

                    for (var i = 0; i < obj_selected_course.length; i++) {

                        if (i== 0) {
                            FileName = obj_selected_course[i].id;
                        }
                        else {
                            FileName = FileName + ',' + obj_selected_course[i].id;
                        }

                    }
                }
                else {
                    bootbox.alert('Please select CheckBox');
                    return false;
                }
                if (obj_selected_course.length > 0) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/CombinePDF_Medical_Antiragging",
                        // data: "{'year_code':'" + year_code + "','sem_code':'" + semester + "','course_type':'" + course_type + "','course_code':'" + course_code + "','dept_code':'" + department + "','selected_instructor':'" + instructor_code + "'}",
                        data: "{'FileName':'" + FileName + "','type':'" + $('#certitype').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "2") {
                                    bootbox.alert("No Data Found");
                                    return false;
                                }
                                else {
                                    var origin = window.location.origin;
                                    if ($('#certitype').val() == "M") {
                                        window.open(origin + '/' + 'MedicalCertificate' + '/' + 'MedicalCertificate.zip'); return false;
                                    }
                                    else { window.open(origin + '/' + 'Antiragging' + '/' + 'Antiragging.zip'); return false; }

                                    //bootbox.alert("PDF Download Sucessfully");
                                }

                                return false;

                            }
                            else {
                                bootbox.alert('No data found for selected criteria');
                                return false;
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                    return false;
                }


            });
        });
        function rowClick_download(row) {
            $('#hdn_file_name').val(row.id);
            $("#btnDownloadvideo").click();

        }

        function rowClick_certi_download(row) {
            $('#hdn_certf_file_name').val(row.id);
            $("#btnDownloadcertificate").click();

        }
            function rowClick_view(row,file_name)
            {
               var origin   = window.location.origin;
                var type='';
               if($('#certitype').val() == "M"){window.open(origin + '\\' + 'MedicalCertificate' + '\\' + file_name,"_blank");}
               else{window.open(origin + '\\' + 'Antiragging' + '\\' + file_name,"_blank");}               
                
            }
        function rowClick_approve(row, status,mail,reverse) 
           {
               
            var remark = $('#'+row.id).val();
            var type='';
               if($('#certitype').val() == "M"){type ="M"}else{type="A"} 
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/approve_certificate",
                    data: "{sr_no:'" + row.id + "',status:'" + status + "',remarks:'" + remark + "',type:'" + type + "',EmailId:'" + mail + "',reverse:'" + reverse +"'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Approved Successfully");
                                get_submit_certificate_detail();
                            }
                            else if (data.d == "Reject") {
                                bootbox.alert("Rejected Successfully");
                                get_submit_certificate_detail();
                            }
                            else if (data.d == "Save") {
                                bootbox.alert("All Changes Reverse Successfully");
                                get_submit_certificate_detail();
                            }
                            else {
                                bootbox.alert('Problem in Data');
                            }
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

        }

        function get_submit_certificate_detail() {
            var type = $('#drptype').val();
            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();
            var year_code = $('#drpyear').val();
            $('#DataList').css('display', 'none');
               var url_dtl='';
                 if($('#certitype').val() == "M")
                    {
                    url_dtl  ="../../WebService.asmx/get_medical_antiragging_dtl";
                    }
                    else
                    {
                    url_dtl  ="../../WebService.asmx/get_antiragging_dtl";
                    }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_dtl,
                    data: "{student_code:'',type:'" + type + "',prog_code:'" + prog_code + "',dept_code:'" + dept_code + "',year_code:'" + year_code +"'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != "[]") { 
                            display_certificate_detail(data.d);
                            $('#div_studio_proposal_dtl').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function display_certificate_detail(data) {
            var columns = [
                { "sTitle": "Sr No", "mData": "doc_no", "sClass": "cls_hide" },
                {
                    "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, mRender: function (data) {

                        return '<input type="checkbox" id="' + data.file_path +'" class="cls_chk_user_select"  onchange="user_select_change(this)" />';

                    }
                },
                { "sTitle": "Student Code", "mData": "user_id" },
                { "sTitle": "Student Name", "mData": "user_name" },
                { "sTitle": "Email Id", "mData": "mail" }, //

                {
                    "sTitle": "Year", "mData": null, "bSortable": false, mRender: function (data) {

                        if (data.year_code != '') {
                            return "<center>" + data.year_code + "</center>";
                        }
                        else {
                            return "";
                        }
                        


                    }
                },
                //{ "sTitle": "Remarks", "mData": "remark" },
                {
                    "sTitle": "Remarks", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.remark != "") {
                            return "<center><input type='text' class='cls_text_message' id='"+data.doc_no+"' value ='"+data.remark+"' /></center>";
                            // var rej = 'A';
                            // return '<center><button type="button" id=' + data.sr_no + ' onclick="rowClick_approve(this,\'' + rej + '\')">Approve</button></center>';
                        }
                        else  {
                            return "<center><input type='text' class='cls_text_message' id='"+data.doc_no+"' /></center>";
                        }
                        
                        return '';
                    }
                },
                {
                    "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.is_submit == "S") {
                            return "<center>Pending</center>";
                            // var rej = 'A';
                            // return '<center><button type="button" id=' + data.sr_no + ' onclick="rowClick_approve(this,\'' + rej + '\')">Approve</button></center>';
                        }
                        else if (data.is_submit == "A") {
                            return "<center>Approved</center>";
                        }
                        else if (data.is_submit == "R") {
                            return "<center>Rejected</center>";
                        }
                        return '';
                    }
                },
                {
                    "sTitle": "Approve", "mData": null, "bSortable": false, mRender: function (data) {
                        //if (data.status == "S")
                        //{
                        var reverse = ''
                        var rej = 'A';
                        var mail = data.mail;
                        return '<center><button type="button" id=' + data.doc_no + ' onclick="rowClick_approve(this,\'' + rej + '\',\'' + mail + '\',\'' + reverse + '\')">Approve</button></center>';
                        
                        return '';
                    }
                },

                {
                    "sTitle": "Reject", "mData": null, "bSortable": false, mRender: function (data)
                    {
                        if ($('#drptype').val() == "A") {
                            return "";
                        }
                        var reverse = ''
                        var rej = 'R';
                        var mail = data.mail;
                        return '<center><button type="button" id=' + data.doc_no + ' onclick="rowClick_approve(this,\'' + rej + '\',\'' + mail + '\',\'' + reverse + '\')">Reject</button></center>';


                    }
                },

               
                {
                    "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                        if ($('#drptype').val() == "A") {
                            return "";
                        }
                        else if (data.status == "E") {
                            return "";
                        }
                        var reverse ='E'
                           var rej = 'S';
                           var mail = data.mail;
                        return '<center><button type="button" id=' + data.doc_no + ' onclick="rowClick_approve(this,\'' + rej + '\',\'' + mail + '\',\'' + reverse + '\')">Reverse Changes</button></center>';


                    }
                } ,
                {
                    "sTitle": "View", "mData": null, "bSortable": false, mRender: function (data) {
                        
                        return '<center><button type="button" id=' + data.doc_no + ' onclick="rowClick_view(this,\'' + data.file_path + '\')">View</button></center>';


                    }
                }
                

            ];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');
            $('#example thead tr')[0].children[0].style.display = 'none';
            $("#example tbody tr").each(function (i) 
            {
                $('#example tbody tr')[i].children[0].style.display = 'none';

            });
            if($('#drptype').val() == "R" || $('#drptype').val() == "A" )
            {
            $('#example thead tr')[0].children[7].style.display = 'none';
            $('#example thead tr')[0].children[8].style.display = 'none';
            $("#example tbody tr").each(function (i) 
            {
                $('#example tbody tr')[i].children[7].style.display = 'none';
                $('#example tbody tr')[i].children[8].style.display = 'none';

            });
            }
            if($('#drptype').val() == "S" )
            {
            $('#example thead tr')[0].children[9].style.display = 'none';
            
            $("#example tbody tr").each(function (i) 
            {
                $('#example tbody tr')[i].children[9].style.display = 'none';
            

            });
            }
        }

        $(document).on("click", ".pdf_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);

            var sr_no = aData["sr_no"];
            var student_code = aData["student_code"];


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Download_Bonafide_Document",
                data: "{'student_code':'" + student_code + "','sr_no':'" + sr_no + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "1") {
                            $("#btnDownloadZipDocuments").click();
                            return false;
                        }
                        else {
                            bootbox.alert('Document Not Found');
                        }
                        return true;
                    }
                    else {
                        bootbox.alert('Document Not Found');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        });

        function bindtypedata() {

            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("A").html("Approved"));
            $('#drptype').append($("<option></option>").val("R").html("Rejected"));
            $('#drptype').append($("<option></option>").val("S").html("Pending"));

            $('#drptype').chosen();

        }
        function bindyeardata() {

            $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
            $('#drpyear').append($("<option></option>").val("2022").html("2022"));
            $('#drpyear').append($("<option></option>").val("2023").html("2023"));
            $('#drpyear').append($("<option></option>").val("2024").html("2024"));
            $('#drpyear').append($("<option></option>").val("2025").html("2025"));
            $('#drpyear').append($("<option></option>").val("2026").html("2026"));
            $('#drpyear').append($("<option></option>").val("2027").html("2027"));
            $('#drpyear').append($("<option></option>").val("2028").html("2028"));
            $('#drpyear').append($("<option></option>").val("2029").html("2029"));
            $('#drpyear').chosen();

        }  
function bindtypecertdata() {

            $('#certitype').empty().append($("<option></option>").val("").html("-- Please Select Certificate --"));
            $('#certitype').append($("<option></option>").val("M").html("Medical Fitness Certificate"));
            $('#certitype').append($("<option></option>").val("A").html("Anti Ragging Certificate"));
            

            $('#certitype').chosen();

        }

        function select_all_change() {
            if ($('#chk_select_all')[0].checked) {
                $('.cls_chk_user_select').attr('checked', 'checked');
            }
            else {
                $('.cls_chk_user_select').removeAttr('checked');
            }
        }

        function user_select_change(cur_ele) {

            if (cur_ele.checked) {
                if ($('.cls_chk_user_select').length == $('.cls_chk_user_select:checked').length)
                    $('#chk_select_all')[0].checked = true;
            }
            else {
                $('#chk_select_all')[0].checked = false;
            }
        }


       



        //$(document).on("click", ".fees_download", function (event) {

        //    var row = $(this).closest("tr").get(0);
        //    var aData = oTable.fnGetData(row);
        //    var sr_no = aData["sr_no"];
        //    var student_code = aData["student_code"];
        //    $('#hdn_student_id').val(student_code);
        //   // $('#btnfeesrecept').click();

        //    return false;
        //});

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i><span id="title_name">Medical And Antiragging Certificate Submit Details </span>
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
                                <td>Certificate :
                                </td>
                                <td>
                                    <select class="chosen-select" id="certitype">
                                    </select>
                                </td>
                                <td>Type :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drptype">
                                    </select>
                                </td>
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Department :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                <td>Program :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog" />
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btndownload_pdf">
                                        Download All PDF
                                    </button>
                                </td>
                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_studio_proposal_dtl" class="panel panel-default" style="display: none; overflow:auto;">

            <div class="panel-heading">
                <strong id="panel_head">Medical And Antiragging Certificate Request Details</strong>
            </div>
            <div id="DataList" style="display: none;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>


        </div>

    </div>
    <%--<asp:Button ID="btnDownloadvideo" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadvideo_Click" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadcertificate" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadcertificate_Click" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadZipDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadZipDocuments_Click" ClientIDMode="Static" />--%>

    <asp:HiddenField ID="hdn_file_name" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_certf_file_name" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_user_type" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_student_id" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_designation_type" runat="server" ClientIDMode="Static" />
    <div id="ifrm_outline" style="display: none;"></div>
</asp:Content>

