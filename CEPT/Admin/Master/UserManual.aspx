<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="UserManual.aspx.cs" Inherits="Admin_Master_UserManual" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<script src="../../Scripts/AjaxFileupload.js"></script>--%>

     <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
     <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var checkebox_id = '';
        var oTable;
        var oTable1;
        $(document).ready(function ()
        {
            if ($("#hdnusertype").val() == 'A1')
            {
                $("#filterpanel").css('display', 'block');
            }
            else { $("#hdnusertype").css('display', 'none');}
            document.getElementById('pdfFile').addEventListener('change', function (event)
            {
                var file = event.target.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function (e)
                    {
                        var base64String = e.target.result;
                        document.getElementById('base64output').value = base64String;
                    };
                    reader.readAsDataURL(file);
                }
            });

            $("#uploadBtn").click(function () {

                if ($('input[type="checkbox"]:checked').length == 0)
                {
                    alert("Please Select CheckBox.");
                    return false;
                }
                var fileInput = document.getElementById('pdfFile');
                var file = fileInput.files[0];

                if (!file) {
                    alert("Please select a PDF file.");
                    return false;
                }

                if (file.type !== "application/pdf") {
                    alert("Only PDF files are allowed.");
                    return false;
                }


                var fileBytes = $('#base64output').val();
                var base64String = fileBytes.split(',')[1];
                var sendurl = base64String;
                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/FileUpload",
                        data: "{fileBytes:'" + sendurl + "' ,fileName:'" + file.name + "',doc_title:'" + $('#title').val() + "',usertype:'" + checkebox_id+"'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response)
                        {
                            var status = JSON.parse(response.d)
                            if (status.success == true) {
                                alert(status.message);
                            }
                            else { alert(status.message);}
                            
                        },
                        error: function (xhr, status, error) {
                            alert("Error: " + error);
                        }
                    });
                

                
                
            });


            $('input[type="checkbox"]').change(function () {
                checkebox_id = '';
                $('input[type="checkbox"]:checked').each(function ()
                {
                    checkebox_id += $(this).attr('id') + ',';
                });
                checkebox_id = checkebox_id.slice(0, -1);
            });
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
                    var status = response.d;
                    if (status != "") {
                        display_data(response.d);
                    }
                    
                    
                },
                error: function (xhr, status, error) {
                    alert("Error: " + error);
                }
            });

        }

        //jQuery.extend({
        //    handleError: function (s, xhr, status, e) {
        //        // If a local callback was specified, fire it
        //        if (s.error)
        //            s.error(xhr, status, e);
        //        // If we have some XML response text (e.g. from an AJAX call) then log it in the console
        //        else if (xhr.responseText)
        //            console.log(xhr.responseText);
        //    }
        //});

        //function GetFileNameFromPath(strFilepath) {

        //    var objRE = new RegExp(/([^\/\\]+)$/);
        //    var strName = objRE.exec(strFilepath);

        //    if (strName == null) {
        //        return null;
        //    }
        //    else {
        //        return strName[0];
        //    }
        //}

        //function CheckMarksDocumentExtension(file) {
        //    try {
        //        var flag = true;
        //        var extension = file.substr((file.lastIndexOf('.') + 1));

        //        switch (extension) {
        //            case 'pdf':
        //            case 'PDF':
        //                flag = true;
        //                break;
        //            default:
        //                flag = false;
        //        }

        //        return flag;
        //    }
        //    catch (e) {
        //        alert("Exception : " + e.message);
        //    }
        //}

        //function UploadData() {
        //    try {
        //        var fileToUpload = GetFileNameFromPath($('#update_document').val());

        //        if (CheckMarksDocumentExtension(fileToUpload)) {
        //            $("#UploadingProgress").fadeIn(200);
        //            $.ajaxFileUpload({
        //                url: '../../Handler/UserManualDocument.ashx',
        //                secureuri: false,
        //                fileElementId: 'update_document',
        //                dataType: 'json',
        //                success: function (data, status) {
        //                    //if (typeof (data.error) != 'undefined' && typeof (data.error) != '')
        //                    if (data.error != 'undefined' && data.error != '') {
        //                        if (data.error != '') {
        //                            alert(data.error);
        //                        }
        //                        else {

        //                            // alert("");

        //                        }
        //                    }
        //                    $("#UploadingProgress").fadeOut(200);
        //                    // alert('File upload Successfully' + data.upfile);
        //                    $('#update_document').val(data.upfile);
        //                },
        //                error: function (data, status, e) {
        //                    $("#UploadingProgress").fadeOut(200);
        //                    alert(data.responseText);
        //                    //window.location.reload();
        //                    $('#update_document').val('');
        //                }
        //            });
        //            //}
        //        }
        //        else {
        //            alert('Invalid File Type. Please upload .xls file');
        //        }
        //        return false;
        //    }
        //    catch (e) {
        //        alert("Exception : " + e.message);
        //    }
        //}

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
                    { "sTitle": "User Type", "mData": "USERType", "bSortable": false },
                    /*{ "sTitle": "Sr No", "mData": "doc_no", "bSortable": false },*/
                    { "sTitle": "Document Tilte", "mData": "Document_title", "bSortable": false },
                    { "sTitle": "Document Name", "mData": "document_name", "bSortable": false },
                    { "sTitle": "Download", "mData": "document_link", "bSortable": false },
                    { "sTitle": "Status", "mData": "Status_data", "bSortable": false },
                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                            if ($('#hdnusertype').val() == 'A1')
                            {
                                //if (data.cancel_flag == 'Y')
                                //{
                                //    return '<center><button type="button" id="' + data.doc_no + '" onclick="rowClick(this,N)">Active</button></center>';
                                //}
                                //else
                                //{
                                //    return '<center><button type="button" id="' + data.doc_no + '" onclick="rowClick(this,Y)">InActive</button></center>';
                                //}
                                var actionStatus = (data.cancel_flag == 'Y') ? 'Active' : 'In-Active';
                                var flag = (data.cancel_flag == 'Y') ? 'N' : 'Y';
                                return `<div style="text-align: center;">
                                        <button type="button" id="${data.doc_no}" onclick="rowClick(this, '${flag}')">${actionStatus}</button>
                                                </div>`;
                                
                            }
                            else { return ''; }
                            


                        }
                    },
                    
                ]
            }).rowGrouping();


            
            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function rowClick(row, status)
        {
            var rowId = row.id;
            var data_text = '';
            if (status == 'N') {
                data_text = 'Are you sure you want to Active this data?';
            }
            else { data_text = 'Are you sure you want to In-Active this data?';}
            Swal.fire({
                title: data_text,
                text: "",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Yes"
            }).then((result) => {
                if (result.isConfirmed) {
                    //var thisdata = $(this).closest("tr");
                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/DeleteFile",
                        data: "{sr_no:'" + rowId + "', statusflag:'" + status+"'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (response) {
                            var status = JSON.parse(response.d)
                            
                            if (status.success == true) {
                                GetData();
                                Swal.fire({
                                    title: "Update!",
                                    text: "Your Data has been updated.",
                                    icon: "success"
                                });

                            }
                            //else { alert(status.message); }

                        },
                        error: function (xhr, status, error) {
                            alert("Error: " + error);
                        }
                    });
                   
                }
            });


            
        }
    </script>

    <style>
        .checkbox-inline {
            display: inline-block;
            margin-right: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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

