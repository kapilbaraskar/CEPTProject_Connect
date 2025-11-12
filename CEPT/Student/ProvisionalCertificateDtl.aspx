<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="ProvisionalCertificateDtl.aspx.cs" Inherits="Student_ProvisionalCertificateDtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>
    
    <script type="text/javascript">
        var oTable;
        var oTable3;
        var sumcreditdata = '';
        $(document).ready(function ()
        {
            GetCurrentSemCredit();
            GetApplyForProvisionalCertificateDel();
            get_credits_dtl();
            
            
            $('#btnapply').click(function (event)
            {
                var HS_data = 'N';
                var JP_data = 'N';
                var declare_data = 'N';
                var hsCheckbox = document.getElementById("HS");
                var jpCheckbox = document.getElementById("JP");
                var declareCheckbox = document.getElementById("S_declare");
                var statuscheckded = false;
                if (hsCheckbox.checked) {
                    HS_data = 'HS';
                    statuscheckded = true;
                }
                if (jpCheckbox.checked) {
                    JP_data = 'JP';
                    statuscheckded = true
                }

                if (!statuscheckded) {
                    alert("At least one checkbox is checked.");
                    return false;
                }
                if ($('#address_Text').val() == "") {
                    alert("Please share about the institute of higher studies and/or the name of the organization for the job/placement");
                    return false;
                }

                if (declareCheckbox.checked) {
                    declare_data = 'Y';
                }
                else {
                    alert("Please Checked Checkbox (Declaration)");
                    return false;

                }


                event.preventDefault();
                Swal.fire({
                    title: "Are you sure?",
                    text: "You won't be Apply For Provisional Certificate !",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "Yes !"
                }).then((result) => {
                    if (result.isConfirmed)
                    {
                    ApplyForProvisionalCertificate();
                    }
                });
            });
            
            
        });
        
        function get_credits_dtl() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_students_completed_credits_sgpa_cgpa_report_data",
                    data: "{enrollment_year : '',dept_code:'',prog_code:''}",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "")
                        {
                            display_student_Credit(data.d);
                            if (sumcreditdata != '')
                            {
                                var userid = $('#hdnuserid').val();
                                var currentsem = JSON.parse(sumcreditdata);
                                var data = JSON.parse(data.d);
                                var resultdata = alasql('SELECT user_id, SUM(CAST(credits_completed AS INT)) AS total_credits_completed FROM ? WHERE  semester_type <> "' + currentsem[0].sem_code + '"  OR year_semester <> "' + currentsem[0].year_code +'" GROUP BY user_id', [data]);
                                if (resultdata != '')
                                {
                                    var sumcredits = (parseInt(currentsem[0].total_credits_all_semesters) + parseInt( resultdata[0].total_credits_completed));

                                    if (currentsem[0].prog_code == '1')
                                    {
                                        if (parseInt(sumcredits) >= 180)
                                        {
                                            $('#btnapply').css('display', '');
                                        }
                                        else
                                        {
                                            $('#btnapply').css('display', 'none');
                                            $('#eligible').css('display', 'block');
                                        }
                                        
                                    }
                                    else if (currentsem[0].prog_code == '2')
                                    {
                                        if (parseInt(sumcredits) >= 80) {
                                            $('#btnapply').css('display', '');
                                        }
                                        else
                                        {
                                            $('#btnapply').css('display', 'none');
                                            $('#eligible').css('display', 'block');
                                        }

                                    }
                                }
                            }
                        }
                    },
                    error: function (result) {
                        $('#btnapply').css('display', 'none');
                        return false;
                       // alert(result);
                    }
                });

        }

        function GetCurrentSemCredit() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetCurrentSemCreditAllocatedUser",
                    data: "{}",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "")
                        {
                            sumcreditdata = data.d;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }

        function ApplyForProvisionalCertificate() {
            var HS_data = 'N';
            var JP_data = 'N';
            var declare_data = 'N';
            var hsCheckbox = document.getElementById("HS");
            var jpCheckbox = document.getElementById("JP");
            var declareCheckbox = document.getElementById("S_declare");
            var statuscheckded = false;
            if (hsCheckbox.checked) {
                HS_data = 'HS';
                statuscheckded = true;
            }
            if (jpCheckbox.checked)
            {
                JP_data = 'JP';
                statuscheckded = true
            }

            if (!statuscheckded) {
                alert("At least one checkbox is checked.");
                return false;
            }
            if ($('#address_Text').val() == "")
            {
                alert("Please share about the institute of higher studies and/or the name of the organization for the job/placement");
                return false;
            }

            if (declareCheckbox.checked) {
                declare_data = 'Y';
            }
            else {
                alert("Please Checked Checkbox (Declaration)");
                return false;

            }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/ApplyForProvisionalCertificate",
                    data: "{ declaration_1:'" + HS_data + "', declaration_2: '" + JP_data + "', submit_status: '" + declare_data + "', Remark: '" + $('#address_Text').val() + "'}",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "") {
                            get_credits_dtl();
                            GetApplyForProvisionalCertificateDel();
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }

        function GetApplyForProvisionalCertificateDel() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetApplyForProvisionalCertificateDel",
                    data: "{ dept_code:'', prog_code: ''}",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "") {
                            //get_credits_dtl();
                            var status_data = JSON.parse(data.d);
                            if (status_data[0]['declaration_1'].trim() == 'HS') {
                                $('#HS').prop('checked', true);
                            }
                            else { $('#HS').prop('checked', false); }


                            if (status_data[0]['declaration_2'].trim() == 'JP') {
                                $('#JP').prop('checked', true);
                            }
                            else { $('#JP').prop('checked', false); }

                            if (status_data[0]['submit_status'].trim() == 'Y') {
                                $('#S_declare').prop('checked', true);
                            }
                            else { $('#S_declare').prop('checked', false); }
                            
                            display_student_status(data.d);
                            $('#changetext').text('You have already applied for a Provisional Certificate request. Please Check Status');
                            $('#eligible').css('display', '');
                            $('#btnapply').css('display', 'none');
                            $('#btnapply').hide();
                        } 
                        else {
                            //$('#btnapply').css('display', '');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }


        function set_table_columns(row) {

            var columns = [];

            columns.push({
                "sTitle": "Semester", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.semester_type != '') return data.semester_type ;
                    else return '';
                }
            });
            columns.push({
                "sTitle": "Semester Year", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.year_semester != '') return data.year_semester;
                    else return '';
                }
            });
            columns.push({
                "sTitle": "Total Credits Registered", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.semester_wise_total_credit != '') {
                        return data.semester_wise_total_credit;
                    }
                    else {
                        return '';
                    }
                }
            });
            columns.push({ "sTitle": "Credits Completed", "mData": "credits_completed" });
            columns.push({
                "sTitle": "Semester GPA", "mData": "sem_grade_point_ratio_actual", "mRender": function (data) {// (Actual)
                    if (data != '')
                        return round_num(round_num(data, 2), 1);//parseFloat(data).toFixed(2);
                    else return '';
                }
            });
            return columns;
        }
        function round_num(num, precision) {
            return (+(Math.round(+(num + 'e' + precision)) + 'e' + -precision)).toFixed(precision);
        }

        function display_student_Credit(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

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
                "oLanguage":
                {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": columns,
                "footerCallback": function (row, data, start, end, display) {
                    var api = this.api();

                   

                    // Calculate the total for the "Credits Completed" column (index 3)
                    var totalCreditsCompleted = api
                        .column(3, { page: 'current' })
                        .data()
                        .reduce(function (a, b) {
                            return parseFloat(a) + parseFloat(b);
                        }, 0);

                    // Update footer
                    $(api.column(3).footer()).html(totalCreditsCompleted.toFixed(2));
                }
            });
            $('#DataList').css('display', 'block');
        }
        function display_student_status(data) {
            if (oTable3 != null) {
                oTable3.fnDestroy();
                $("#provisiinalcertificatedtl").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_reg_pro" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable3 = $("#example_reg_pro").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                //  "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    
                    { "sTitle": "Student Code", "mData": "Student_id", "bSortable": false },
                    { "sTitle": "Faculty Admin Status", "mData": "FAStatustxt", "bSortable": false },
                    { "sTitle": "Admin Status", "mData": "AdminStatustxt", "bSortable": false },
                    { "sTitle": "Account Status", "mData": "AccountStatustxt", "bSortable": false },
                    { "sTitle": "Examination Status", "mData": "ExaminationStatustxt", "bSortable": false },
                    { "sTitle": "Faculty Admin Remark", "mData": "Student_FA_Remark", "bSortable": false },
                    { "sTitle": "Account Remark", "mData": "Student_AC_Remark", "bSortable": false },
                    { "sTitle": "Admin Remark", "mData": "Student_UGPG_Remark", "bSortable": false },
                    { "sTitle": "Examination Remark", "mData": "Student_Exam_Remark", "bSortable": false }
                   

                ]
            });

            $('#provisiinalcertificatedtl').css('display', 'block');
            $('#eligible').css('display', 'none');



        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="well" style="background-color: White;">
        <br />

        <h4>Declaration :</h4>
        <span><b>I need the Provisional Certificate for</span><br />
        <input type="checkbox" id="HS" value="HS"> Higher Studies<br>
        <input type="checkbox" id="JP" value="JP"> Jobs/Placements<br />
        
        <br />
        Please share about the institute of higher studies and/or the name of the organization for the job/placement :<br><br /></b>
        <textarea rows="5" cols="10" id="address_Text" class="ckeditor" style="width: 1015px; height: 109px;" spellcheck="true"></textarea><br />

        1. <b>I acknowledge that the Provisional Certificate is issued upon completion of all academic requirements</b><br>
        2. <b>I also commit to fulfilling all compliance requirements arising out of academic and financial audits, after the issuance of the provisional certificate</b><br>
        3. <b>I understand that my application will not be processed until I have completed all credits and settled any outstanding fees</b><br><br />
        <input type="checkbox" id="S_declare"> <b style="color:blue;">I hereby declare that all the instructions and information provided in the application form are complete and accurate to the best of my knowledge and based on records</b><br>

        <br />
        <br />


    <div id="div_course_list" class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Student Credit Details</strong>
            </div>
            <div>     
                <div id="DataList" style="display: none;overflow:auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th>Total : </th>
                                <th>
                                </th>
                                <th style="text-align: left"></th>
                                <th style="text-align: left"></th>
                                <th style="text-align: left"></th>
                                
                            </tr>
                        </tfoot>
                    </table>
                </div>
                
            </div>
        </div>
    
    
        <div>
            <div id="provisiinalcertificatedtl" style="display:none; overflow: auto;" class="panel panel-default">
                        <div class="panel-heading">
                            <strong id="panel_head_reg_man">Apply Provisional Certificate Status</strong>
                        </div>
                        <table cellpadding="0" cellspacing="0" border="0" id="example_reg_pro" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                      
                  </div>

             <div id="eligible" style="display:none; padding:10px;">
                        <p><b><span style="Color:blue;font-size: 21px;" id="changetext">You Are Not Eligible For A Provisional Certificate Request...</span></b></p>
                    </div>       
        </div>


        <div style="text-align:center;">
            <button class="btn btn-primary" id="btnapply" style="display:none;">Apply Provisional Certificate</button>
        </div>
    </div>
</asp:Content>

