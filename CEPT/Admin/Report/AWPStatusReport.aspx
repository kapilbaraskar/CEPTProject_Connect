<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="AWPStatusReport.aspx.cs" Inherits="Admin_Report_AWPStatusReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <%--<script src="../../Js/admin_report.js?t=03012022" type="text/javascript"></script>--%>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var oTable;
        $(document).ready(function ()
        {
            $('#btnreterive').on('click', function ()
            {
                total_Apply_user_dtl();
                return false;
            });

            $(document).on('click', '.take-action-btn', function () {


                var usercode = $(this).data('usercode');
                var plancode = $(this).data('plantype');
                var Pathname = window.location.origin + '/AWPPDF/' + usercode + '_' + $('#drpyear').val() + '_' + plancode + '.pdf';



                const pdfUrl = window.location.origin + '/AWPPDF/' + usercode + '_' + $('#drpyear').val() + '_' + plancode + '.pdf';
                const link = document.createElement('a');
                link.href = pdfUrl;
                link.download = plancode + '.pdf';
                link.style.display = 'none';
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link); 
                return false;


            });

            return false;  
        });
        
        function total_Apply_user_dtl() {
            $('#DataList').css('display', 'none');
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/AWPGetSubmittedData",
                data: "{year:'" + $('#drpyear').val() + "' , plan_type : ''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_aws_submitted_data(data.d);
                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Year');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function display_aws_submitted_data(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "User Code", "mData": "superviser_code", "bSortable": false, "bVisible": false },
                    { "sTitle": "Name", "mData": "supervisor_name", "bSortable": false },
                    { "sTitle": "Email", "mData": "email", "bSortable": false },
                    { "sTitle": "Designation", "mData": "designation", "bSortable": false, "bVisible": false  },
                    { "sTitle": "DepartMent", "mData": "department", "bSortable": false, "bVisible": false  },
                    { "sTitle": "Faculty Status", "mData": "faculty_status", "bSortable": false, "bVisible": false  },
                    { "sTitle": "Dean Status", "mData": "dean_status", "bSortable": false, "bVisible": false  },
                    { "sTitle": "Hr Status", "mData": "hr_status", "bSortable": false, "bVisible": false  },
                    {"sTitle": "Both Proposed (june to dec and Jan to june)", "mData": null, "bSortable": false, mRender: function (data){                    
                    if (data.Proposed_jun_dec_faculty_status_PLA001 == 'Y' && data.Proposed_jan_jun_faculty_status_PLA002 == 'Y')
                    {
                        return '<button class="btn btn-primary btn-sm take-action-btn" data-usercode="' + data.superviser_code + '"data-plantype="Proposed_Planned">Download</button>';
                    }
                        else { return ''; }
                    }
                    },

                    {
                        "sTitle": "Proposed-june to dec and Actual June to dec", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Proposed_jun_dec_faculty_status_ACT001 == 'Y')
                            {
                                return '<button class="btn btn-primary btn-sm take-action-btn" data-usercode="' + data.superviser_code + '"data-plantype="Actual_June_to_Dec">Download</button>';
                            }
                            else { return ''; }
                        }
                    },
                    {
                        "sTitle": "Proposed-Jan to june and Actual- Jan to June", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Proposed_jan_jun_faculty_status_ACT002 == 'Y')
                            {
                                return '<button class="btn btn-primary btn-sm take-action-btn" data-usercode="' + data.superviser_code + '"data-plantype="Actual_Jan_to_June">Download</button>';
                            }
                            else { return ''; }
                        }
                    },
                    {
                        "sTitle": "Both Actual (June to dec and Jan to june)", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Proposed_jun_dec_faculty_status_ACT001 == 'Y' && data.Proposed_jan_jun_faculty_status_ACT002 == 'Y')
                            {
                                return '<button class="btn btn-primary btn-sm take-action-btn" data-usercode="' + data.superviser_code + '"data-plantype="Actual_both">Download</button>';
                            }
                            else { return ''; }
                        }
                    },

                    {
                        "sTitle": "All in One", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Proposed_jun_dec_faculty_status_ACT001 == 'Y' && data.Proposed_jan_jun_faculty_status_ACT002 == 'Y'
                                && data.Proposed_jun_dec_faculty_status_PLA001 == 'Y' && data.Proposed_jan_jun_faculty_status_PLA002 == 'Y')
                            {
                                return '<button class="btn btn-primary btn-sm take-action-btn" data-usercode="' + data.superviser_code + '"data-plantype="all">Download</button>';
                            }
                            else { return ''; }
                        }
                    }

                    //{
                    //"sTitle": "PDF Download","mData": null, "bSortable": false,
                    //"render": function (data, type, row) {
                    //    if (row.faculty_status === 'Submitted') {
                    //        return '<button class="btn btn-primary btn-sm take-action-btn" data-usercode="' + row.superviser_code + '"data-plantype="' + row.superviser_code + '">Download</button>';
                    //    } else {
                    //        return '';
                    //    }
                    //}
                    //    }
                    
                ]

               
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

       
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> AWP Submission Report
            </h1>
        </div>
       </div>
        <div>
            <div class="panel panel-default">
                <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                    <option value="2025-2026">2025-2026</option>
                                    <%--<option value="2026-2027">2026-2027</option>
                                    <option value="2027-2028">2027-2028</option>
                                    <option value="2028-2029">2028-2029</option>--%>
                                </select>
                            </td>
                            <td style="display:none;">
                                Plan :
                            </td>
                            <td style="display:none;">
                                <select class="chosen-select" id="drpplan">
                                    <option value="Proposed_Planned">Full Year Proposed/Planned</option>
                                    <option value="Actual_June_to_Dec">Actual June to Dec</option>
                                    <option value="Actual_Jan_to_June">Actual Jan to June</option>
                                    <option value="Actual_both">Actual June to Dec and Jan to June </option>
                                   
                                    <%--<option value="ACT001">ACTUAL June to Dec</option>
                                    <option value="ACT002">ACTUAL Jan to June</option>--%>
                                    
                                </select>
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="DataList" style="display: none;overflow:auto;" class="panel panel-default">
                <div class="panel-heading">
                <strong id="panel_head">AWP Submission Details</strong>
            </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            
        </div>

</asp:Content>

