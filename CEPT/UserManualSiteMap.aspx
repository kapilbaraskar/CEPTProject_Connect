<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="UserManualSiteMap.aspx.cs" Inherits="UserManualSiteMap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
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
                    var status = JSON.parse(response.d);
                    display_data(response.d);
                    
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
                    { "sTitle": "Sr No", "mData": "doc_no", "bSortable": false },
                    { "sTitle": "Document Tilte", "mData": "Document_title", "bSortable": false },
                    { "sTitle": "Document Name", "mData": "document_name", "bSortable": false },
                    { "sTitle": "Download", "mData": "document_link", "bSortable": false }
                    
                ]
            });


            
            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
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
        <div class="panel panel-default" id="filterpanel" style="display:none;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div style="margin-left: 10px; margin-top: 10px; margin-bottom: 10px;">

                <label class="checkbox-inline">
                    <input type="checkbox" name="option1" value="S" id="S">
                    Student
   
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="option2" value="A1" id="A1">
                    Admin
   
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="option3" value="FA" id="FA">
                    Faculty Admin
   
                </label>
                <label class="checkbox-inline">
                    <input type="checkbox" name="option3" value="PC" id="PC">
                    Progam Codinator
   
                </label>
            </div>

             <div class="panel-body for_ue" style="margin-top: 10px; border: 1px solid #ddd; height: 40px;">
           

                 
                 <div style="float: left; width: 15%;">
                <label for="text1" class="control-label">
                    Document Title :
                </label>
            </div>
                 <div style="float: left;width: 25%;">
                <div class="col-md-8" style="padding: 0 0 0 0;">
                   <input type="text"  id="title"/> 
                </div>
            </div>

            <div style="float: left; width: 38%;">

                <div class="col-md-8" style="padding: 0 0 0 0;">
                    <input type="file" id="pdfFile" accept="application/pdf" />
                    
                </div>
            </div>
            <div style="float: left; width: 15%;">
                <label for="text1" class="control-label">
            <button class="btn  btn-primary" type="button" id="uploadBtn">Save</button>
                </label>
            </div>
        </div>

         
        </div>
    
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

