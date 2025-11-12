<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Clearance_Status.aspx.cs" Inherits="Student_Clearance_Status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../Scripts/AjaxFileupload.js" type="text/javascript"></script>

    <style type="text/css">
        table {
            margin-top: 10px;
        }

        #tbl_param tr th:first-child, #tbl_param tr td:first-child {
            width: 30%;
        }

        #tbl_param tr th:nth-child(2), #tbl_param tr td:nth-child(2) {
            width: 30%;
        }

        @keyframes blinkingText {
            0% {
                color: #000;
            }

            49% {
                color: #000;
            }

            60% {
                color: transparent;
            }

            99% {
                color: transparent;
            }

            100% {
                color: #000;
            }
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var submitted_form_data;
        var sem = "";
        var year = "";
        var uid = "";

        $(document).ready(function () {
            getClearanceSemYear();
            getSubmittedCheck();
        });

        function getClearanceSemYear() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_current_clearance_form_semester",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var sem_year_data = JSON.parse(data.d)
                        sem = sem_year_data[0]["sem_code"];
                        year = sem_year_data[0]["year_code"];
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function getSubmittedCheck() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_submitted_student_clearance_form",
                data: "{ sem_code: '', year_code: '', student_id: '', dept_type: '', status: ''  }",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var submitted_form_data = JSON.parse(data.d)
                        if (submitted_form_data.length > 0) {
                            setTableData(submitted_form_data);
                            $(".status_of_clearance_form").css('display', '');
                        } else {

                        }
                    } else {
                        alert("Student Clearance Form not submitted yet.");
                        var url = "Student_Clearance_Form.aspx";
                        window.open(url, '_self');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function setTableData(submitted_form_data) {
            var all_approved = true;

            for (var i = 0; i < submitted_form_data.length; i++) {
                if (submitted_form_data[i]['department_id'] != "D8")
                {
                    uid = submitted_form_data[i]['user_id'];

                    var str_html = '';

                    str_html += '<tr id="tr' + submitted_form_data[i]['department_id'] + '">';

                    str_html += '<td><b>' + submitted_form_data[i]['department_name'] + '</b></td>';

                    if (submitted_form_data[i]['status'] == "On Hold") {
                        str_html += '<td><b style="color:blue;">' + submitted_form_data[i]['status'] + '</b><p style="color: red;"><b><u>Remarks:</u></b></p> <span style="color:black;">' + submitted_form_data[i]['remarks'] + '</span></td>';
                        all_approved = false;
                    }
                    else if (submitted_form_data[i]['status'] == "Approved") {
                        str_html += '<td><b style="color:green;">' + submitted_form_data[i]['status'] + '</b></td>';
                    }
                    else {
                        str_html += '<td>' + submitted_form_data[i]['status'] + '</td>';
                        all_approved = false;
                    }

                    str_html += '</tr>';

                    $('#tbl_param tbody').append(str_html);
                }
            }

            if (!all_approved) {
                $(".download_clearance_certificate").remove();
            }
            else
            {
                for (var i = 0; i < submitted_form_data.length; i++)
                {
                    if (submitted_form_data[i]['department_id'] == "R")
                    {
                        var date = new Date(submitted_form_data[i]["created_date"]);
                        date.setDate(date.getDate() + 30);
                        $("#date").text(date.getDate() + "/" + (date.getMonth() + 1) + "/" + date.getFullYear());
                    }
                }
            }
        }


        $(document).on("click", "#DCC", function (event) {
            $('#hdn_user_id').val(uid);
            $('#hdn_sem_code').val(sem);
            $('#hdn_year_code').val(year);
            $('#btn_download').click();
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="status_of_clearance_form" style="display: none;">
        <h3 style="text-align: center;"><u>Status of the Clearances from Offices and Departments</u></h3>
        <div id="DataList" style="overflow: auto;">
            <table id="tbl_param" cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" style="width: 50%; margin-left: auto; margin-right: auto;">
                <thead>
                    <tr>
                        <th>Department</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <br />
            <div>
                <h4 style="width: 100%; text-align: center;">AFTER APPROVAL FROM ALL DEPARTMENT, CERTIFICATE DOWNLOAD WILL BE ENABLED.</h4>
                <h6 style="width: 100%; text-align: center;" class="download_clearance_certificate"><a href="#" id="DCC">Download Clearance Certificate</a></h6>
                <%--https://connect.cept.ac.in/ClearanceDocs/clearancecertificateform.pdf download--%>
                <h5 style="width: 100%; text-align: center;" class="download_clearance_certificate">Note: Your clearance request has been approved. Refund will be processed by  <span id="date"></span>.</h5>
            </div>
        </div>
    </div>
    <div style="border: 1px black solid; padding-left: 20px; padding-right: 20px;">
        <h3>FAQ</h3>
        <p style="text-align: justify"><span style="font-size: 11pt"><span style=""><strong>Clearance will be given by the respective departments after the following conditions are met:-</strong></span></span></p>

        <p style="text-align: justify"><span style="font-size: 11pt"><span style=""><strong>Faculty Admin &nbsp;</strong></span></span></p>

        <ol>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">Students would have completed their academic credit requirements</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif"><span style="color: #222222">Submission of thesis &amp; synopsis&nbsp;both in hard and soft copy (CD or Pen drive).</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif"><span style="color: black">DRP students must have fulfilled the requirements of DRP.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif"><span style="color: #222222">No dues towards fees. </span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif"><span style="color: #222222">No University academic tools like Laptop, Projector etc. &nbsp;due from the students. </span></span></span></span></li>
        </ol>

        <p style="text-align: justify"><span style="font-size: 11pt"><span style=""><strong>Campus Office </strong></span></span></p>

        <ol>
            <li style="text-align: justify"><span style="font-size: 11.0pt"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">Students would have returned the electrical extension board issued by Campus office.&nbsp; In case the extension board is lost, a charge of INR 500 shall be levied from the students.</span></span></span></li>
        </ol>

        <p style="text-align: justify"><strong><span style="font-size: 11.0pt"><span style=""><span style="">IT Office</span></span></span></strong></p>

        <ol>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">Will deactivate WiFi ID of the student</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">The student email id will be deleted after one month of their convocation</span></span></span></span></li>
        </ol>

        <p style="text-align: justify"><span style="font-size: 11pt"><span style=""><strong>SSO (Students Services Office) </strong></span></span></p>

        <ol>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>SSO will deactivate the RFID card during the clearance process. Any balance amount in their ID card will be refunded by the account department as part of the final refund.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>Students would have returned their ID card to SSO by courier on address (CEPT UNIVERSITY, STUDENT SERVICES OFFICE, K.L. CAMPUS, UNIVERSITY ROAD, NAVRANGPURA, AHMEDABAD - 380009)  or through drop box at the North Security Gate.</span></span></span></span></li>
        </ol>

        <p style="text-align: justify"><strong><span style="font-size: 11.0pt"><span style="">Library </span></span></strong></p>

        <ol>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>Library clearance will be given if a student does not have any dues in the library.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>If student has any pending overdue charge or any library books, he/she will be informed by an email and asked to return the books and to pay the overdue charge.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>Student would have returned the books to the library and pay the overdue charges after which library clearance will be given. If student has lostthe library books, then he/she needs to replace the books before getting library clearance.</span></span></span></span></li>
        </ol>
        <p style="text-align: justify"><strong><span style="font-size: 11.0pt"><span style="">Workshops &amp; <span style="background-color: white"><span style="color: #222222">Laboratory</span></span></span></span></strong></p>
        <ol>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>Students would have returned the tools, equipment or instruments to the workshop / Laboratory.</span></span></span></span></li>

            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>In case of missing any tools or damage, students are required to replace the same tool with a new one.</span></span></span></span></li>

            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>In the present scenario; out of state students can either send the tools through courier or advise us to adjust the cost from the caution deposit.</span></span></span></span></li>
        </ol>

        <p style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style=""><strong><span style="color: #222222">Accounts </span></strong></span></span></span></p>

        <ol>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>Cancelled cheque with details of IFSC Code, Account No., Bank and Branch name should be submitted with the Clearance form. Kindly note that Bank account should be in the name of student only.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>Deposit slip / Citrus transaction receipt / Indemnity bond (in the prescribed format) should be submitted with the Clearance form.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span>Write the updated contact number so that the accounts department can message the students whenever the amount is refunded.</span></span></span></span></li>
        </ol>

        <p style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style=""><strong><span style="color: #222222">Hostel </span></strong></span></span></span></p>

        <ol>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">The students would have duly paid the hostel fee for the duration of their stay.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">The students would have no other pending bills related to maintenance work or any other matter that has come to the notice of the authority&nbsp;for which the&nbsp;student has been monetarily held responsible.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">The students (his/her) would have submitted the key of her room to the hostel in-charge at the time of vacating the room.</span></span></span></span></li>
        </ol>


        <p style="text-align: justify"><strong><span style="font-size: 11.0pt"><span style=""><span style="color: #222222">Final Clearance and Refund</span></span></span></strong></p>

        <ol>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">After clearance from each of the above offices, the Registrar will give the final approval.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">Refunds will be processed within 30 days after the approval of the Registrar.</span></span></span></span></li>
            <li style="text-align: justify"><span style="font-size: 11pt"><span style="background-color: white"><span style="font-family: Calibri,sans-serif;"><span style="color: #222222">If any due is pending with any of the above departments, the student&rsquo;s caution deposit will be on hold until such dues are cleared.</span></span></span></span></li>
        </ol>


    </div>
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" />
    <div style="display: none;">
        <asp:Button ID="btn_download" runat="server" ClientIDMode="Static" Text="test" OnClick="Download_CC" />
    </div>
</asp:Content>

