<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Student_Clearance_Form.aspx.cs" Inherits="Student_Student_Clearance_Form" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../Scripts/AjaxFileupload.js" type="text/javascript"></script>

    <style type="text/css">
        table {
            margin-top: 10px;
        }

        #tbl_param select {
            width: 100%;
        }

        #tbl_param input[type=text] {
            width: 94%;
        }

        #tbl_param tr th:first-child, #tbl_param tr td:first-child {
            width: 30%;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var department_data = [];
        var sem = "";
        var year = "";

        $(document).ready(function () {
            getParamDetail();
            getClearanceSemYear();
            getSubmittedCheck();
            GetStudentInfo();
            $('#btn_save').on('click', function () {
                saveChanges();
            });

            //if ($("#hdnuserid").val() != "ucadmin") {
            //    $("#div_button").remove();
            //}

        });

        var DocsMandatory = true;
        function GetStudentInfo() {
            debugger;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/check_user_by_user_id",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        
                        var student_data = JSON.parse(data.d);
                        DocsMandatory = parseInt(student_data[0].year_code.substr(5-4)) >= parseInt("2020") && student_data[0].prog_code == "2" ? false : true;
                        if (!DocsMandatory) {
                            $('#tbl_param_extra').css('display', 'none');
                        }
                        else { $('#tbl_param_extra').css('display', 'block');}
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function getParamDetail() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_department_for_student_clearance",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        department_data = JSON.parse(data.d)
                        setTableData();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

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
                data: "{ sem_code: '', year_code: '', student_id: '', dept_type: '', status: '' }",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var submitted_form_data = JSON.parse(data.d)
                        if (submitted_form_data.length > 0) {
                            alert("Student Clearance Form already submitted.");
                            var url = "Clearance_Status.aspx";
                            window.open(url, '_self');
                        } else {

                        }
                    } else {
                        $(".clearance_form").css('display', '');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function setTableData() {
            for (var i = 0; i < department_data.length; i++) {

                var str_html = '';
                

                if (department_data[i]['department_id'] == "D8") {
                    var str_html_D8 = '';

                    str_html_D8 += '<tr id="tr' + department_data[i]['department_id'] + '">';

                    str_html_D8 += '<td><b>' + department_data[i]['department_name'] + '</b></td>';


                    str_html_D8 += '<td>';
                    str_html_D8 += '<input type="text" class="' + department_data[i]['department_id'] + '" placeholder="Bank Name" id="Bank Name" style="width:250px;"/>';
                    str_html_D8 += '<input type="text" class="' + department_data[i]['department_id'] + '" placeholder="Account Holder Name" id="Account Holder Name" style="width:250px;margin-left:25px;"/>';
                    str_html_D8 += '<input type="number" class="' + department_data[i]['department_id'] + '" placeholder="Account No" id="Account No" style="width:250px;margin-left:25px;"/>';
                    str_html_D8 += '<input type="text" class="' + department_data[i]['department_id'] + '" placeholder="IFSC Code" id="IFSC Code" style="width:250px;"/>';
                    str_html_D8 += '<input type="text" class="' + department_data[i]['department_id'] + '" placeholder="Bank Address" id="Bank Address" />';
                    str_html_D8 += 'Upload Cancel Cheque <input id="Upload_Cancel_Cheque" name="Upload_Cancel_Cheque" type="file"  placeholder="Upload Cancel Cheque" onchange="javascript:return UploadCancelCheque();"/>';
                    str_html_D8 += '</td >';
                    str_html_D8 += '</tr>';
                    
                }
                else
                {
                    str_html += '<tr id="tr' + department_data[i]['department_id'] + '">';

                    str_html += '<td><b>' + department_data[i]['department_name'] + '</b></td>';

                    str_html += '<td><input type="text" class="" id="' + department_data[i]['department_id'] + '" /></td>';
                    str_html += '</tr>';
                }

                $('#tbl_param tbody').append(str_html);
            }

            $('#tbl_param tbody').append(str_html_D8);

            var str_html_extra = '';

            str_html_extra += '<tr><td style="width:90%;"><input type="radio" name = "Upload" id="Upload 1" style="margin-bottom: 5px;" value="Receipt Of Deposit"/> I have receipt of deposit. </td><td> <input id="Receipt_Of_Deposit" name="Receipt_Of_Deposit" type="file" placeholder="Receipt Of Deposit" style="width: 186px;" onchange="javascript:return ReceiptOfDeposit();"/></td></tr>';
            str_html_extra += '<tr><td style="text-align:center;" colspan="2"><b>OR</b></td></tr>';
            str_html_extra += '<tr><td><input type="radio" name = "Upload" id="Upload 2" style="margin-bottom: 5px;" value="INDEMNITY BOND"/> In absence of original receipt, students can apply for refund of deposit on INDEMNITY BOND (Rs 100 stamp paper). <a href="https://connect.cept.ac.in/ClearanceDocs/INDEMNITY_BOND.docx" download>Download Format</a></td><td><input id="INDEMNITY_BOND" name ="INDEMNITY_BOND" type="file" placeholder="INDEMNITY BOND" style="width: 186px;" onchange="javascript:return INDEMNITYBOND();"/></td></tr>';

            $('#tbl_param_extra tbody').append(str_html_extra);

        }

        //function saveChanges() {
        //    var student_clearance_form_data = [];
        //    if (department_data.length > 0) {
        //        for (var i = 0; i < department_data.length; i++) {
        //            if (department_data[i]['department_id'] == "D8") {

        //                var value = [];

        //                for (var j = 0; j < $('.' + department_data[i]['department_id'] + '').length; j++) {

        //                    if ($('.' + department_data[i]['department_id'] + '')[j].value == "") {
        //                        alert("Please Enter " + $('.' + department_data[i]['department_id'] + '')[j].id);
        //                        return false;
        //                    }

        //                    var obj_dept_data = { "key": $('.' + department_data[i]['department_id'] + '')[j].id, "value": $('.' + department_data[i]['department_id'] + '')[j].value };

        //                    //if (obj_dept_data.search(/\\/) != -1) { obj_dept_data = obj_dept_data.replace(/\\/g, '\\\\'); }
        //                    //if (obj_dept_data.search("\"") != -1) { obj_dept_data = obj_dept_data.replace(/"/g, '\\\"'); }

        //                    value.push(obj_dept_data);
        //                }

        //                if (GetFileNameFromPath($('#Upload_Cancel_Cheque').val()) == undefined) {
        //                    alert("Please Upload Cancel Cheque.")
        //                    return false;
        //                }

        //                value.push({ "key": "Upload Cancel Cheque", "value": $("#hdnuserid").val() + "_" + sem + "_" + year + "_" + "UploadCancelCheque.pdf" });
        //                if (DocsMandatory) {
        //                    if ($("input[name='Upload']:checked").val() == undefined) {
        //                        alert("Please select the option and Upload the Docs.");
        //                        return false;
        //                    }

        //                    var upload_type = $("input[name='Upload']:checked").val();
        //                    var upload_type_value = upload_type.replace(" ", "");
        //                    upload_type_value = upload_type_value.replace(" ", "");

        //                    var upload_type_value_check = upload_type.replace(" ", "_");
        //                    upload_type_value_check = upload_type_value_check.replace(" ", "_");

        //                    if (GetFileNameFromPath($("#" + upload_type_value_check).val()) == undefined) {
        //                        alert("Please Upload " + upload_type)
        //                        return false;
        //                    }

        //                    value.push({ "key": upload_type, "value": $("#hdnuserid").val() + "_" + sem + "_" + year + "_" + upload_type_value + ".pdf" });
        //                }
        //                value = JSON.stringify(value);

        //                var student_clearance_form = {
        //                    "department_id": department_data[i]['department_id'],
        //                    "department_name": department_data[i]['department_name'],
        //                    "value": value
        //                };
        //            } else {
        //                //if ($('#' + department_data[i]['department_id'] + '').val() == "") {
        //                //    alert("Please Enter into the " + department_data[i]['department_name']);
        //                //    return false;
        //                //}

        //                var student_clearance_form = {
        //                    "department_id": department_data[i]['department_id'],
        //                    "department_name": department_data[i]['department_name'],
        //                    "value": $('#' + department_data[i]['department_id'] + '').val()
        //                };
        //            }
        //            student_clearance_form_data.push(student_clearance_form);
        //        }

        //        var student_clearance_form_registrar = {
        //            "department_id": "R",
        //            "department_name": "Registrar",
        //            "value": ""
        //        };

        //        student_clearance_form_data.push(student_clearance_form_registrar);

        //        var json_submit_data = JSON.stringify(student_clearance_form_data);

        //        if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
        //        if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

        //        console.log(json_submit_data);

        //        $.ajax({
        //            type: "POST",
        //            contentType: "application/json; charset=utf-8",
        //            url: "../../WebService.asmx/submit_student_clearance_form",
        //            data: "{ student_clearance_form_data: '" + json_submit_data + "' }",
        //            dataType: "json",
        //            async: false,
        //            success: function (data) {
        //                if (data.d != "") {
        //                    res = JSON.parse(data.d)
        //                    if (res['status'] == "1") {
        //                        alert(res['message']);
        //                    }
        //                    else if (res['status'] == "0") {
        //                        alert(res['message']);
        //                        var url = "Clearance_Status.aspx";
        //                        window.open(url, '_self');
        //                    }
        //                }
        //            },
        //            error: function (result) {
        //                alert(result);
        //            }
        //        });
        //    }
        //}


        function saveChanges() {
            var student_clearance_form_data = [];
            if (department_data.length > 0) {
                for (var i = 0; i < department_data.length; i++) {
                    if (department_data[i]['department_id'] == "D8") {

                        var value = [];

                        for (var j = 0; j < $('.' + department_data[i]['department_id'] + '').length; j++) {

                            if ($('.' + department_data[i]['department_id'] + '')[j].value == "") {
                                alert("Please Enter " + $('.' + department_data[i]['department_id'] + '')[j].id);
                                return false;
                            }

                            var obj_dept_data = { "key": $('.' + department_data[i]['department_id'] + '')[j].id, "value": $('.' + department_data[i]['department_id'] + '')[j].value };

                            //if (obj_dept_data.search(/\\/) != -1) { obj_dept_data = obj_dept_data.replace(/\\/g, '\\\\'); }
                            //if (obj_dept_data.search("\"") != -1) { obj_dept_data = obj_dept_data.replace(/"/g, '\\\"'); }

                            value.push(obj_dept_data);
                        }

                        if (GetFileNameFromPath($('#Upload_Cancel_Cheque').val()) == undefined) {
                            var filePath = $('#Upload_Cancel_Cheque').val();
                            var fileName = filePath.split('\\').pop();
                            if (fileName == '')
                            {
                                alert("Please Upload Cancel Cheque.")
                                return false;
                            }
                            
                        }

                        value.push({ "key": "Upload Cancel Cheque", "value": $("#hdnuserid").val() + "_" + sem + "_" + year + "_" + "UploadCancelCheque.pdf" });

                        if (DocsMandatory)
                        {
                            if ($("input[name='Upload']:checked").val() == undefined)
                            {
                                alert("Please select the option and Upload the Docs.");
                                return false;
                            }


                            var upload_type = $("input[name='Upload']:checked").val();
                            var upload_type_value = upload_type.replace(" ", "");
                            upload_type_value = upload_type_value.replace(" ", "");

                            var upload_type_value_check = upload_type.replace(" ", "_");
                            upload_type_value_check = upload_type_value_check.replace(" ", "_");

                            if (GetFileNameFromPath($("#" + upload_type_value_check).val()) == undefined) {
                                alert("Please Upload " + upload_type)
                                return false;
                            }

                            value.push({ "key": upload_type, "value": $("#hdnuserid").val() + "_" + sem + "_" + year + "_" + upload_type_value + ".pdf" });
                        }
                        else
                        {
                            if ($("input[name='Upload']:checked").val() != undefined && $("input[name='Upload']:checked").val() != null && $("input[name='Upload']:checked").val() != "")
                            {
                                var upload_type = $("input[name='Upload']:checked").val();
                                var upload_type_value = upload_type.replace(" ", "");
                                upload_type_value = upload_type_value.replace(" ", "");

                                var upload_type_value_check = upload_type.replace(" ", "_");
                                upload_type_value_check = upload_type_value_check.replace(" ", "_");

                                if (GetFileNameFromPath($("#" + upload_type_value_check).val()) != undefined && GetFileNameFromPath($("#" + upload_type_value_check).val()) != null && GetFileNameFromPath($("#" + upload_type_value_check).val()) != "") {
                                    value.push({ "key": upload_type, "value": $("#hdnuserid").val() + "_" + sem + "_" + year + "_" + upload_type_value + ".pdf" });
                                }
                            }
                        }
                        value = JSON.stringify(value);
                        var student_clearance_form = {
                            "department_id": department_data[i]['department_id'],
                            "department_name": department_data[i]['department_name'],
                            "value": value
                        };
                    } else {
                        //if ($('#' + department_data[i]['department_id'] + '').val() == "") {
                        //    alert("Please Enter into the " + department_data[i]['department_name']);
                        //    return false;
                        //}

                        var student_clearance_form = {
                            "department_id": department_data[i]['department_id'],
                            "department_name": department_data[i]['department_name'],
                            "value": $('#' + department_data[i]['department_id'] + '').val()
                        };
                    }
                    student_clearance_form_data.push(student_clearance_form);
                }

                var student_clearance_form_registrar = {
                    "department_id": "R",
                    "department_name": "Registrar",
                    "value": ""
                };

                student_clearance_form_data.push(student_clearance_form_registrar);

                var json_submit_data = JSON.stringify(student_clearance_form_data);

                if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
                if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

                console.log(json_submit_data);

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/submit_student_clearance_form",
                    data: "{ student_clearance_form_data: '" + json_submit_data + "' }",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            res = JSON.parse(data.d)
                            if (res['status'] == "1") {
                                alert(res['message']);
                            }
                            else if (res['status'] == "0") {
                                alert(res['message']);
                                var url = "Clearance_Status.aspx";
                                window.open(url, '_self');
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }


        //Get File Name From Path
        function GetFileNameFromPath(strFilepath) {

            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return strName[0];
            }
        }

        function CheckSkypeDocumentExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'pdf':
                    case 'PDF':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function UploadCancelCheque() {
            try {
                var fileToUpload = GetFileNameFromPath($('#Upload_Cancel_Cheque').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckSkypeDocumentExtension(fileToUpload)) {
                    if (filename != "" && filename != null) {
                        $.ajaxFileUpload({
                            url: '../Handler/UploadDocument.ashx',
                            secureuri: false,
                            data: { 'UploadType': 'UploadCancelCheque', 'UserId': $("#hdnuserid").val() },
                            fileElementId: 'Upload_Cancel_Cheque',
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        alert('Cancel Cheque Uploaded Successfully.');
                                    }
                                }
                            },
                            error: function (data, status, e) {
                                $("#UploadingProgress").fadeOut(200);
                                alert(e);
                            }
                        });
                    }
                }
                else {
                    $('#Upload_Cancel_Cheque').val('');
                    alert('Invalid File Type. Please upload .pdf file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function ReceiptOfDeposit() {
            try {
                var fileToUpload = GetFileNameFromPath($('#Receipt_Of_Deposit').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckSkypeDocumentExtension(fileToUpload)) {
                    if (filename != "" && filename != null) {
                        $.ajaxFileUpload({
                            url: '../Handler/UploadDocument.ashx',
                            secureuri: false,
                            data: { 'UploadType': 'ReceiptOfDeposit', 'UserId': $("#hdnuserid").val() },
                            fileElementId: 'Receipt_Of_Deposit',
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        alert('Receipt of Deposit Uploaded Successfully.');
                                    }
                                }
                            },
                            error: function (data, status, e) {
                                $("#UploadingProgress").fadeOut(200);
                                alert(e);
                            }
                        });
                    }
                }
                else {
                    $('#Receipt_Of_Deposit').val('');
                    alert('Invalid File Type. Please upload .pdf file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function INDEMNITYBOND() {
            try {
                var fileToUpload = GetFileNameFromPath($('#INDEMNITY_BOND').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckSkypeDocumentExtension(fileToUpload)) {
                    if (filename != "" && filename != null) {
                        $.ajaxFileUpload({
                            url: '../Handler/UploadDocument.ashx',
                            secureuri: false,
                            data: { 'UploadType': 'INDEMNITYBOND', 'UserId': $("#hdnuserid").val() },
                            fileElementId: 'INDEMNITY_BOND',
                            dataType: 'json',
                            success: function (data, status) {
                                if (typeof (data.error) != 'undefined') {
                                    if (data.error != '') {
                                        alert(data.error);
                                    }
                                    else {
                                        alert('INDEMNITY BOND Uploaded Successfully.');
                                    }
                                }
                            },
                            error: function (data, status, e) {
                                $("#UploadingProgress").fadeOut(200);
                                alert(e);
                            }
                        });
                    }
                }
                else {
                    $('#INDEMNITY_BOND').val('');
                    alert('Invalid File Type. Please upload .pdf file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        $('input:radio[name=Upload]:checked').change(function () {
            $('#Receipt_Of_Deposit').val('');
            $('#INDEMNITY_BOND').val('');
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="clearance_form" style="display: none;">
        <h3 style="text-align: center;"><u>Send request to get the Clearances from Offices and Departments</u></h3>
        <div id="DataList" style="overflow: auto;">
            <p style="color:blue;"><b>Note:   <span style="color:red;">(Not allowed Special characters -',$,#,*,&,(,),! etc.)</span> </b></p> <p><b>Before submitting the clearance form, please read FAQ which is below the form.</b></p>
            <table id="tbl_param" cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" width="100%">
                <thead>
                    <tr>
                        <th>Department</th>
                        <th>Description (Mention your remarks for a particular department.) </th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <table id="tbl_param_extra" cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" width="100%">
                <tbody>
                </tbody>
            </table>
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
    <div id="div_button" style="text-align: center; margin: 10px 10px 50px 10px; display: none;" class="clearance_form">
        <input type="button" id="btn_save" value="Submit" class="btn btn-primary" />
    </div>
</asp:Content>

