<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="StudentUserManual.aspx.cs" Inherits="Student_StudentUserManual" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    
   <%-- <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>--%>

 <%--   <link href="../../Style/csvstyle.css" rel="stylesheet" />--%>
    <script type="text/javascript">
        var checkebox_id = '';
        var oTable;
        var oTable1;
        $(document).ready(function ()
        {
            GetData();
        });
        function GetData() {
            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/UserManualUserWise",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response)
                {
                    if (response.d !='') {
                        display_data(response.d);
                    }
                    
                    
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });

        }
        function display_data(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            var page = true;

            oTable = $("#example").dataTable({
                "bPaginate": page,
                "bStateSave": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [
                   /* { "sTitle": "Sr No", "mData": "doc_no", "bSortable": false },*/
                    { "sTitle": "Document Tilte", "mData": "Document_title", "bSortable": false },
                    { "sTitle": "Document Name", "mData": "document_name", "bSortable": false },
                    { "sTitle": "Download", "mData": "document_link", "bSortable": false }
                    
                ]
            });


            
            $('#DataList').css('display', 'block');
           
        }
    </script>

    <style>
        .checkbox-inline {
            display: inline-block;
            margin-right: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;User Manual
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
    
        <div id="DataList" class="panel panel-default" style="display:none;margin-bottom:40px;">
            <div class="panel-heading">
                <strong id="panel_head">User Manual Details</strong>
            </div>
            <div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>



       <input type="hidden" id="base64output" />
    </div>
</asp:Content>

