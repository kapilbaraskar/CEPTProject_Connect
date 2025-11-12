<%@ Page Title="Approve Manually Payslip" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_upload_manually_payslip_report.aspx.cs"
    Inherits="Admin_Report_frm_upload_manually_payslip_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js_WS/StudentFees.js" type="text/javascript"></script>
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {

            $('#popup_reject_remark').modal(
            {
                backdrop: 'static',
                keyboard: false
            });

            $('#popup_reject_remark').modal('hide');

            $('#btn_retrieve_payslip_data').on('click', function () {

                retrieve_data();

                return false;

            });

            $('#btn_reject_remark_close').on('click', function () {

                var RejectIndex = $('#hfRejectBtnIndex').val();

                $('#btnReject_' + RejectIndex).prop('checked', false);

                $('#popup_reject_remark').modal('hide');

            });

            $('#btn_reject_remark').on('click', function () {

                var RejectIndex = $('#hfRejectBtnIndex').val();


                var data = {};

                data["user_id"] = RejectIndex;
                data["is_admin_approved"] = "R";
                data["remark"] = $('#txtRejectRemark').val();
                data["mail"] = $('#hfmail').val();

                $.ajax({
                    type: "POST",
                    url: "../../WebService_WS.asmx/accept_reject_payslip",
                    data: "{ 'aceept_reject_data': '" + JSON.stringify(data) + "' }",
                    contentType: "application/json",
                    datatype: "json",
                    success: function (data) {

                        var result = JSON.parse(data.d);

                        if (result["status"]) {

                            retrieve_data();
                            bootbox.alert("Manually Payslip Application Rejected.");
                            $('#popup_reject_remark').modal('hide');
                        }
                        else {
                            $('#btnReject_' + RejectIndex).prop('checked', false);
                            bootbox.alert(result["message"]);
                            $('#popup_reject_remark').modal('hide');
                            return false;
                        }
                    }
                });
            });

        });

        $(document).on("change", ".radio_reject", function (event) {

            var row = $(this).closest("tr").get(0);
            var aPos = oTable.fnGetPosition(row);
            var aData = oTable.fnGetData(aPos);

            $('#txtRejectRemark').val(aData.remarks);
            $('#hfRejectBtnIndex').val(aData.user_id);
            $('#hfmail').val(aData.mail);

            $('#popup_reject_remark').modal('show');
        });

        $(document).on("change", ".radio_accept", function (event) {

            var row = $(this).closest("tr").get(0);

            var aPos = oTable.fnGetPosition(row);

            var aData = oTable.fnGetData(aPos);

            if (confirm("Are you sure to accept this payslip?")) {

                var data = {};

                data["user_id"] = aData.user_id;
                data["is_admin_approved"] = "A";
                data["dept_code"] = aData.dept_code;
                data["year_code"] = aData.year_code;
                data["remark"] = "Your Payslip is approved by cept";
                data["mail"] = aData.mail;

                $.ajax({
                    type: "POST",
                    url: "../../WebService_WS.asmx/accept_reject_payslip",
                    data: "{ 'aceept_reject_data': '" + JSON.stringify(data) + "' }",
                    contentType: "application/json",
                    datatype: "json",
                    success: function (data) {
                        debugger;
                        if (data.d != "") {


                            var result = JSON.parse(data.d);

                            if (result["status"]) {

                                bootbox.alert("Manually Payslip Application Accept");
                                retrieve_data();
                            }
                            else {
                                $('#btnAccept_' + aData.user_id).prop('checked', false);
                                bootbox.alert(result["message"]);
                                return false;
                            }

                        }
                    }
                });

            }
            else {

                $('#btnAccept_' + aData.user_id).prop('checked', false);

            }

        });


        function DisplayData(data) {


            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,

                "sDom": 't',
                "bSortable": false,
                //"sScrollY": "400px",

                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oTableTools": {
                    "aButtons": [
                    //							"copy",
                    //							"print",
                    //							{
                    //							    "sExtends": "collection",
                    //							    "sButtonText": 'Export',
                    //							    "aButtons": ["csv", "xls", "pdf"]
                    //							}
						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
          { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
          { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
          { "sTitle": "Mode of payment", "mData": "mode_of_payment", "bSortable": false },
          { "sTitle": "Branch Name", "mData": "branch", "bSortable": false },
          { "sTitle": "Bank Name", "mData": "bank_name", "bSortable": false },
          { "sTitle": "DD No.", "mData": "dd_no", "bSortable": false },
          { "sTitle": "DD date", "mData": "date_of_dd", "bSortable": false },
          { "sTitle": "Amount", "mData": "amount", "bSortable": false },
          { "sTitle": "check",
              "mData": null,
              "bSortable": false,
              fnRender: function (oObj) {


                  //         return '<a class="fancybox" rel="group" href="../course_image/' + oObj.aData.image_name + '"><img src="../course_image/' + oObj.aData.image_name + '" height="60px" width="75px" alt="No Image"></img></a>';
                  //                  return '<a class="fancybox" target="_blank" rel="group" href="../../UploadPaySlipSWS/' + oObj.aData.uploadpayslippath + '" download>check Payslip</a>';
                  return '<a class="fancybox" target="_blank" rel="group" href="../../UploadPaySlipSWS/' + oObj.aData.uploadpayslippath + '">check Payslip</a>';
                  //         return '<a class="fancybox" rel="group" href="../course_image/' + oObj.aData.image_name + '"><img src="../course_image/pdf.jpg" height="60px" width="75px" alt="No Image"></img></a>';

              }
          },
         { "sTitle": "Accept",
             "mData": null,
             "bSortable": false,
             fnRender: function (oObj) {

                 debugger;
                 if (oObj.aData.is_admin_approved == "A") {
                     return ' <input type="radio"  id="btnAccept_' + oObj.aData.user_id + '" class="radio_accept"  name= "radio' + oObj.aData.user_id + '" checked  />';
                 }
                 else if (oObj.aData.is_admin_approved == "R") {
                     return ' <input type="radio"  id="btnAccept_' + oObj.aData.user_id + '" disabled class="radio_accept" name= "radio' + oObj.aData.user_id + '" />';
                 }
                 else {

                     return ' <input type="radio"  id="btnAccept_' + oObj.aData.user_id + '" class="radio_accept" name= "radio' + oObj.aData.user_id + '" />';
                 }

             }
         },
         { "sTitle": "Reject",
             "mData": null,
             "bSortable": false,
             fnRender: function (oObj) {

                 debugger;
                 if (oObj.aData.is_admin_approved == "R") {
                     return ' <input type="radio" id="btnReject_' + oObj.aData.user_id + '" class="radio_reject" name= "radio' + oObj.aData.user_id + '" checked value="R" />';
                 }
                 else if (oObj.aData.is_admin_approved == "A") {
                     return ' <input type="radio" id="btnReject_' + oObj.aData.user_id + '" disabled name= "radio' + oObj.aData.user_id + '"  value="R" />';
                 }
                 else {
                     return ' <input type="radio" id="btnReject_' + oObj.aData.user_id + '" class="radio_reject" name= "radio' + oObj.aData.user_id + '"  value="R" />';
                 }


             }
         }

            ]


            });

        }

        function retrieve_data() {

            if ($('#drpdepartment').val() == '') {

                bootbox.alert('Please select department');

                return false;
            }

            $.ajax({
                type: "POST",
                url: "../../WebService_WS.asmx/get_upload_manually_payslip_dtl",
                data: "{ 'dept_code': '" + $('#drpdepartment').val() + "','year_of_allocation' : '" + $('#drpyear').val() + "','prog_code' : '" + $('#drpprog').val() + "' }",
                contentType: "application/json",
                datatype: "json",
                success: function (data) {

                    if (data.d != "") {

                        DisplayData(data.d);

                        $('#DataList').css('display', 'block');
                    }
                    else {

                        bootbox.alert("There is no data found");

                        $('#DataList').css('display', 'none');
                    }
                }
            });

        }

        function approve_reject(e) {

            debugger;
        }
  
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="modal hide fade" id="popup_reject_remark" style="margin-left: -240px;
        width: 30%; overflow: auto;">
        <div class="modal-header">
            <b>Reject Remark</b>
        </div>
        <div class="modal-body">
            <textarea style="width: 96%;" class="form-control" rows="5" cols="150" id="txtRejectRemark"
                maxlength="10000"></textarea>
            <asp:HiddenField ID="hfRejectBtnIndex" runat="server" ClientIDMode="Static" />
            <asp:HiddenField ID="hfmail" runat="server" ClientIDMode="Static" />
        </div>
        <div class="modal-footer">
            <center>
                <a href="#" id="btn_reject_remark_close" class="btn btn-primary">Close</a> <a href="#"
                    id="btn_reject_remark" class="btn btn-primary">Submit</a>
            </center>
        </div>
    </div>
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-rupee"></i>Approve Manually payslip
            </h1>
        </div>
        <div class="space">
        </div>
        <div>
            <table border="0" cellpadding="5" cellspacing="5">
                <tr>
                    <td>
                        Current semester for fees :
                    </td>
                    <td>
                        <label style="color: Red;" id="lbl_current_sem" runat="server">
                        </label>
                    </td>
                </tr>
            </table>
            <div>
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                            Department
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            <td>
                                Year of enrollment
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <td>
                                Programme
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btn_retrieve_payslip_data">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
            </div>
        </div>
        <div style="margin-top: 25px; display: none; width: 100%" class="row-fluid" id="DataList">
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                border="0" id="example" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>
