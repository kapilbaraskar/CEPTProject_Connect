<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="bonafide_certificate_request_dtl.aspx.cs" Inherits="Admin_Report_bonafide_certificate_request_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>

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

            get_studio_detail();
            bindtypedata();
            $('#btnreterive').on('click', function () {

                get_studio_detail();
                return false;
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
        function rowClick_approve(row, status) {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/approve_bonafide_dtl",
                    data: "{sr_no:'" + row.id + "',status:'" + status + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Approved successfully");
                                get_studio_detail();
                            }
                            else if (data.d == "Reject") {
                                bootbox.alert("Rejected successfully");
                                get_studio_detail();
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

        function get_studio_detail() {
            var type = $('#drptype').val();
            $('#DataList').css('display', 'none');

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_bonafide_student_dtl",
                    data: "{student_code:'',type:'" + type + "',save_status:'N'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != "[]") {
                            display_studio_proposal_detail(data.d);
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
        function display_studio_proposal_detail(data) {
            var columns = [
                { "sTitle": "Sr No", "mData": "sr_no", "sClass": "cls_hide" },
                { "sTitle": "Student Code", "mData": "user_id" },
                { "sTitle": "Student Name", "mData": "user_name" },
                { "sTitle": "Email Id", "mData": "mail" },
                { "sTitle": "Purpose", "mData": "purpose_dec" },
                { "sTitle": "Remarks", "mData": "remarks" },
                {
                    "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.status == "S") {
                            return "<center>Pending</center>";
                            // var rej = 'A';
                            // return '<center><button type="button" id=' + data.sr_no + ' onclick="rowClick_approve(this,\'' + rej + '\')">Approve</button></center>';
                        }
                        else if (data.status == "A") {
                            return "<center>Approved</center>";
                        }
                        else if (data.status == "R") {
                            return "<center>Rejected</center>";
                        }
                        return '';
                    }
                },
                {
                    "sTitle": "Approve", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.status == "S")
                        {
                        var rej = 'A';
                        return '<center><button type="button" id=' + data.sr_no + ' onclick="rowClick_approve(this,\'' + rej + '\')">Approve</button></center>';
                        }
                        else if (data.status == "A") {
                            return "<center>Approved</center>";
                        }
                        else if (data.status == "R") {
                            return "<center>Rejected</center>";
                        }
                        return '';
                    }
                },

                {
                    "sTitle": "Reject", "mData": null, "bSortable": false, mRender: function (data) {
                        var rej = 'R';
                        if (data.status != "A") {
                            return '<center><button type="button" id=' + data.sr_no + ' onclick="rowClick_approve(this,\'' + rej + '\')">Reject</button></center>';
                        }
                        else { return ''; }


                    }
                },
                {
                    "sTitle": "Download Certificate", "mData": null, "bSortable": false, mRender: function (data) {

                        // var rej = 'A';
                        // 
                        if (data.status == "A") {
                            //return "<center>Approved</center>";
                            var id_wise = data.student_code + "_" + data.sr_no;
                            return '<center><button type="button" id=' + id_wise + ' onclick="rowClick_certi_download(this)">Download</button></center>';
                        }

                        return '';
                    }
                },
                //{
                //    "sTitle": "Fees Recipt", "mData": null, "bSortable": false, mRender: function (data) {
                //        if (data.id_proof_path == '') {
                //            return "";
                //        }
                //        else {
                //            //return '<center><button type="button" id=' + data.id_proof_path + ' onclick="rowClick_download(this)">Download</button></center>';
                //            return '<center><a href="#" style="text-decoration:none;" class="fees_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'

                //        }
                //    }
                //},
                {
                    "sTitle": "Document All", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.id_proof_path == '') {
                            return "";
                        }
                        else {
                            //return '<center><button type="button" id=' + data.id_proof_path + ' onclick="rowClick_download(this)">Download</button></center>';
                            return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'

                        }
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
            $("#example tbody tr").each(function (i) {
                $('#example tbody tr')[i].children[0].style.display = 'none';

            });
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
                <i class="icon-desktop"></i><span id="title_name">Bonafide Certificate Request Detail </span>
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
                                <td>Type :
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

        <div id="div_studio_proposal_dtl" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">Bonafide Certificate Request Detail</strong>
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
    <asp:Button ID="btnDownloadvideo" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadvideo_Click" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadcertificate" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadcertificate_Click" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadZipDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadZipDocuments_Click" ClientIDMode="Static" />
    <%--<asp:Button ID="btnfeesrecept" runat="server" Text="Documents" Style="display: none;" OnClick="btnfeesrecept_Click" ClientIDMode="Static" />--%>
    <asp:HiddenField ID="hdn_file_name" runat="server" ClientIDMode="Static" />                           
    <asp:HiddenField ID="hdn_certf_file_name" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_user_type" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_student_id" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_designation_type" runat="server" ClientIDMode="Static" />
    <div id="ifrm_outline" style="display: none;"></div>
</asp:Content>

