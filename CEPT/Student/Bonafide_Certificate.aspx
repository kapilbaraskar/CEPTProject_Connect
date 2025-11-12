<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Bonafide_Certificate.aspx.cs" Inherits="Student_Bonafide_Certificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <style>
        body {
            overflow-x: hidden;
        }
    </style>
    <script>
        $(document).ready(function () {
            var action;
            var sem_code = "";
            var year_code = "";
            var oTable = "";
            var FileName = "";
            var count_row = 0;
            var department_code = '';
            bindpurpose();
            bindprogrammedata();
            binddepartment();
            get_fees_status();
            get_student_dtl();
            get_bonafide_dtl();
            $('#student_code').val($("#hdn_stud_code").val());
            $('#btnsave').on('click', function () {
                //action = 'S';
                action = 'N';
                $('#savesubmit').click();
            });
            $('#btnsubmit').on('click', function () {
               // action = 'A';
                action = 'S';
                $('#savesubmit').click();
            });
            $('#savesubmit').on('click', function () {
                var flag = true;
                // if (action == "A") {
                if ($("#student_code").val() == "") {
                    flag = false;
                    bootbox.alert("Please Enter Student Code");
                    return false;
                }
                if ($("#student_name").val() == "") {
                    flag = false;
                    bootbox.alert("Please Enter Student Name");
                    return false;
                }
                if ($("#gender_type").val() == "") {
                    flag = false;
                    bootbox.alert("Please Enter Gender");
                    return false;
                }

                if ($("#drpdepartment").val() == "") {
                    flag = false;
                    bootbox.alert("Please Select Faculty Name");
                    return false;
                }
                if ($("#drpprog").val() == "") {
                    flag = false;
                    bootbox.alert("Please Select Program Name");
                    return false;
                }

                if ($("#Purpose").val() == "")
                {
                    flag = false;
                    bootbox.alert("Please Select Purpose for seeking Bonafide Certificate");
                    return false;
                }

                if ($("#Purpose").val() == "IP" || $("#Purpose").val() == "PC")
                {
                    if ($("#remarks").val() == "")
                    {
                        flag = false;
                        bootbox.alert("Specific details that you need mentioned in the Bonafide Certificate");
                        return false;
                    }
                }

                if ($('#Purpose').val() == 'O')
                {
                    if ($('#purpose_res').val() == "")
                    {
                        flag = false;
                        bootbox.alert("Please Select Purpose");
                        return false;
                    }

                }
                if ($('#hdn_file_name').val() == "") {
                    flag = false;
                    bootbox.alert("Please Upload Id Proof");
                    return false;
                }
                if ($('#hdn_fees_file_name').val() == "") {
                    flag = false;
                    bootbox.alert("Please Upload Existing Semester Fees Slip");
                    return false;
                }
                //if ($("#remarks").val() == "") {
                //    flag = false;
                //    bootbox.alert("Specific details that you need mentioned in the Bonafide Certificate");
                //    return false;
                //}

                if ($("#remarks").val().length > 150) {
                    flag = false;
                    bootbox.alert("Maximum 150 chars allow for Specific details that you need mentioned in the Bonafide Certificate.");
                    return false;
                }
                if (flag) {
                    var bonafide_data = { 'student_code': '', 'purpose': '', 'remark': '', 'id_proof_pat': '', 'fees_slip_path': '', 'other_remarks': '', 'message': '', 'sr_no': '', 'action': '' };

                    bonafide_data.student_code = $("#student_code").val();
                    bonafide_data.purpose = $('#Purpose').val();
                    if ($("#remarks").val() == "") {
                        bonafide_data.remark = "";
                    }
                    else { bonafide_data.remark = $("#remarks").val();}
                    
                    bonafide_data.id_proof_pat = $('#hdn_file_name').val();
                    bonafide_data.fees_slip_path = $('#hdn_fees_file_name').val();
                    if ($('#purpose_res').val() != "") {
                        bonafide_data.other_remarks = $('#purpose_res').val();
                    }
                    else
                    {
                        bonafide_data.other_remarks = '';
                    }
                    if ($('#hdn_sr_no').val() != '')
                    {
                        bonafide_data.sr_no = $('#hdn_sr_no').val();
                    }

                    bonafide_data.action = action;
                    if (bonafide_data.remark.search(/\\/) != -1) { bonafide_data.remark = bonafide_data.remark.replace(/\\/g, '\\\\'); }
                    if (bonafide_data.remark.search("\"") != -1) { bonafide_data.remark = bonafide_data.remark.replace(/"/g, '\\\"'); }

                    bonafide_data = JSON.stringify(bonafide_data);

                    if (bonafide_data.search("'") != -1) {
                        bonafide_data = bonafide_data.replace(/\'/g, '\\\'');
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../WebService.asmx/save_bonafide_data",
                        data: "{bonafide_dtl:'" + bonafide_data + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var response = JSON.parse(data.d);
                                if (response["message"] == "Insert  Successfully") {
                                    alert("Data Save Successfully");
                                    
                                    var region = location.origin;
                                    if (action == 'S')
                                    {
                                        window.location.href = region + "/Student/Bonafide_Certificate.aspx";
                                    }
                                    else if (action == 'N') {
                                        window.location.reload();
                                    }
                                    
                                    return false;
                                }
                                else if (response["message"] == "Student_id_card not found") {
                                    alert("Problem In Data (Student ID Card Not Available on Portal)");
                                    window.location.reload();
                                    return false;
                                }
                                else {
                                    bootbox.alert("Problem In Data");
                                    return false;
                                }

                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }
            });

            function binddepartment() {
                $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));

                $('#drpdepartment').append($("<option></option>").val("1").html("Architecture"));
                $('#drpdepartment').append($("<option></option>").val("2").html("Design"));
                $('#drpdepartment').append($("<option></option>").val("3").html("Management"));
                $('#drpdepartment').append($("<option></option>").val("4").html("Planning"));
                $('#drpdepartment').append($("<option></option>").val("5").html("Technology"));
                $('#drpdepartment').append($("<option></option>").val("6").html("Centre of Excellence in Urban Transport"));
                $('#drpdepartment').append($("<option></option>").val("7").html("Summer Winter"));
                $('#drpdepartment').append($("<option></option>").val("8").html("Ahmedabad University"));
                $('#drpdepartment').append($("<option></option>").val("9").html("CEPT Foundation Program"));
                $('#drpdepartment').append($("<option></option>").val("10").html("Doctoral Programs"));
                $('#drpdepartment').append($("<option></option>").val("91").html("CEPT Short Term Program"));

                $('#drpdepartment').chosen();
            }
            //function binddepartment() {
            //    $.ajax({
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/Get_department_data",
            //        data: "{}",
            //        dataType: "json",
            //        aSync: false,
            //        success: function (data) {
            //            if (data.d != "") {
            //                var sem_data = JSON.parse(data.d)

            //                //$('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
            //                //for (var i = 0; i < sem_data.length; i++)
            //                //{
            //                //    $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
            //                //}
            //                //$('#drpdepartment').chosen();

            //                return false;
            //            }
            //        },
            //        error: function (result) {
            //            alert(result);
            //        }
            //    });
            //}

            function bindpurpose() {
                
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_purpose_data",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var purpose_data = JSON.parse(data.d)

                            $('#Purpose').empty().append($("<option></option>").val("").html("-- Please Select Purpose --"));
                            for (var i = 0; i < purpose_data.length; i++) {
                                $('#Purpose').append($("<option></option>").val(purpose_data[i]["purpose_code"]).html(purpose_data[i]["purpose_dec"]));
                            }
                            $('#Purpose').chosen();

                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });


                //$('#Purpose').empty().append($("<option></option>").val("").html("-- Please Select Purpose --"));

                //$('#Purpose').append($("<option></option>").val("Visa").html("Visa"));
                //$('#Purpose').append($("<option></option>").val("Change City").html("Change City"));


                //$('#Purpose').chosen();
            }

            function get_student_dtl() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_student_dtl",
                    async: false,
                    data: "{student_code : '" + $("#hdn_stud_code").val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            var student_data = JSON.parse(data.d)
                            $('#student_name').val(student_data[0]["user_name"]);
                            if (student_data[0]["gender"] == "F") {
                                $('#gender_type').val("Female");
                            }
                            else if (student_data[0]["gender"] == "M") {
                                $('#gender_type').val("Male");
                            }
                            else if (student_data[0]["gender"] == "T") {
                                $('#gender_type').val("Transgender");
                            }
                            $('#email_id').val(student_data[0]["mail"]);
                            $('#mobile_number').val(student_data[0]["mobile_no"]);

                            $('#drpprog').val(student_data[0]["prog_code"]);
                            $('#drpprog').trigger("liszt:updated");

                            $("#drpdepartment").val(student_data[0]["dept_code"]);
                            $("#drpdepartment").trigger("liszt:updated");
                        }
                        else {

                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            if (data_row_count.length == "1") {
                $('#datalist_saved').css('height', '62px');
            }
            if (data_row_count.length == "2") {
                $('#datalist_saved').css('height', '105px');
            }
            if (data_row_count.length > 0) {
                for (var i = 0; i < data_row_count.length; i++)
                { 
                    $("#btnsave").css("display", "none");
                    $("#btnsubmit").css("display", "none");

                    if (data_row_count[i]["status"] == "N" && $('#hdn_sr_no').val() != '') {
                        $("#btnsave").css("display", "inline-block");
                        $("#btnsubmit").css("display", "inline-block");
                        break;
                    }

                    if (data_row_count[i]["status"] == "N")
                    {
                        $("#btnsave").css("display", "none");
                        $("#btnsubmit").css("display", "none");
                        break;
                    }
                    if (data_row_count[i]["status"] == "A" || $('#status').val() == 'R')
                    {
                        $("#btnsave").css("display", "inline-block");
                        $("#btnsubmit").css("display", "inline-block");
                        break;
                    }

                    
                }
            }


            $('#Purpose').on('change', function () {

                if ($('#Purpose').val() == 'O') {
                    $('#purpose_text').css('display', 'block');
                    //alert("The text has been changed.");
                }
                else
                {
                    $('#purpose_text').css('display', 'none');
                }
            });

        });
        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programe --"));

            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function UploadProfilePhoto() {

            try {
                //var d = new Date();
                var fileToUpload = GetFileNameFromPath($('#idUpload').val());
                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/student_upload_id_proof.ashx',
                                secureuri: false,
                                fileElementId: 'idUpload',
                                data: { 'ICODE': $("#hdn_stud_code").val(), 'FNAME': $("#student_name").val(), 'LNAME': $("#student_name").val() },
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#idUpload').val("");
                                            $('#lbl_id_proof_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload
                                            $('#hdn_file_name').val(data.upfile);
                                            //FileName = data.upfile;
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    alert('Invalid File Type. Please upload jpeg / png / pdf / doc file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }

        }

        function Uploadfeesslip() {
            try {
                //var d = new Date();
                var fileToUpload = GetFileNameFromPath($('#fessUpload').val());
                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/student_upload_id_proof.ashx',
                                secureuri: false,
                                fileElementId: 'fessUpload',
                                data: { 'ICODE': $("#hdn_stud_code").val(), 'FNAME': $("#student_name").val(), 'LNAME': 'feesslip' },
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#fessUpload').val("");
                                            $('#lbl_fees_slip_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload
                                            $('#hdn_fees_file_name').val(data.upfile);
                                            //FileName = data.upfile;
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    alert('Invalid File Type. Please upload jpeg / png / pdf / doc file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }

        }
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
        function CheckUserPhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'jpg':
                    case 'jpeg':
                    case 'JPG':
                    case 'JPEG':
                    case 'png':
                    case 'PNG':
                    case 'pdf':
                    case 'PDF':
                        //case 'doc':
                        //case 'DOC':
                        //case 'docx':
                        //case 'DOCX':
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

        var data_row_count = "";
        function get_bonafide_dtl() {
            var type = '';
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_bonafide_student_dtl",
                async: false,
                data: "{student_code : '" + $("#hdn_stud_code").val() + "',type:'" + type + "',save_status:''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        data_row_count = JSON.parse(data.d);
                        Display_saved_Data(data.d);
                        if ($('#hdn_sr_no').val() != '')
                        {
                            for (var i = 0; i < data_row_count.length; i++)
                            {
                                if (data_row_count[i]['sr_no'] == $('#hdn_sr_no').val())
                                {
                                    if (data_row_count[i]['status'] == 'N')
                                    {
                                        $('#Purpose').val(data_row_count[i]['purpose_value']);
                                        $('#Purpose').change();
                                        $('#Purpose').trigger("liszt:updated");
                                        $('#remarks').val(data_row_count[i]['remarks']);
                                        $('#hdn_file_name').val(data_row_count[0]['fees_slip_path']);
                                        $('#lbl_fees_slip_file_name').text(data_row_count[0]['fees_slip_path']);
                                        $('#hdn_fees_file_name').val(data_row_count[0]['id_proof_path']);
                                        $('#lbl_id_proof_file_name').text(data_row_count[0]['id_proof_path']);
                                    }
                                    

                                }
                            }
                        }


                    }
                    else {
                        return false;
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function Display_saved_Data(data) {

            var oTable;

            $('#datalist_saved').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#datalist_saved").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_saved" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable = $("#datatable_saved").dataTable({

                "bPaginate": false,
                "bStateSave": true,
                "bSort": false,
                "sDom": 't',
                "sScrollY": '111px',

                "aaData": JSON.parse(data),

                "aoColumns": [

                    { "sTitle": "Student Code", "mData": "student_code", "bSortable": false },
                    { "sTitle": "Purpose", "mData": "purpose_dec", "bSortable": false },
                    { "sTitle": "Remark", "mData": "remarks", "bSortable": false },
                    {
                        "sTitle": "Approve Status", "mData": null, "bSortable": false, "fnRender": function (datad) {
                            if (datad.aData["status"] == "S") {
                                return 'Pending';
                            }
                            else if (datad.aData["status"] == "A") {
                                // return '<center><button type="button" id=' + datad.student_code + ' onclick="rowClick_download(this)">Download</button></center>';
                                return 'Approved';
                            }
                            else if (datad.aData["status"] == "R")
                            {
                                return 'Rejected';
                            }

                            return "";

                        }
                    },

                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, "fnRender": function (datad) {
                             if (datad.aData["status"] == "N") {
                                 return '<center><button type="button" id=' + datad.student_code + ' onclick="rowClick_edit(' + datad.aData["sr_no"] +')">Edit</button></center>';
                                
                            }
                            else {
                                 return "";
                            }

                            

                        }
                    }
                    //{
                    //    "sTitle": "Download", "mData": null, "bSortable": false, "fnRender": function (datas) {
                           
                    //        if (datas.aData["status"] == "A") {
                    //            return '<center><button type="button" id=' + datas.aData["sr_no"] + ' onclick="rowClick_download(this)">Download</button></center>';
                    //        }

                    //        return "";

                    //    }
                    //}

                ]
            });

            $('#datalist_saved').css('display', 'block');

        }
        function get_fees_status() {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_fees_status",
                data: {},
                contentType: "application/json",
                async: false,
                datatype: "json",
                success: function (data) {

                    if (data.d != "") {
                        fees_status = JSON.parse(data.d);
                        if (fees_status[0]["no_of_installment"] > 0) {
                            for (var i = 1; i <= fees_status[0]["no_of_installment"]; i++) {
                                if (fees_status[0]["is_installment" + i + "_paid"] == "Y") {
                                    $("#btnsave").css("display", "inline-block");
                                    $("#btnsubmit").css("display", "inline-block");
                                    break;

                                }
                                else {
                                    $("#btnsave").css("display", "none");
                                    $("#btnsubmit").css("display", "none");
                                    $("#fess_status").css("display", "block");
                                }
                            }

                        }
                    }
                    else {

                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });

            return false;
        }

        function rowClick_download(row) {
            
            var file_name = $("#hdn_stud_code").val() + "_" + row.id;
            $('#hdn_file_name').val(file_name);
            $("#btnDownloadvideo").click();

        }
        function rowClick_edit(row)
        {
            var region = location.origin;
            //window.location.href = region + "/Student/Bonafide_Certificate.aspx?c=" + row;
            window.open(region + "/Student/Bonafide_Certificate.aspx?c=" + row, '_blank');
            //var file_name = $("#hdn_stud_code").val() + "_" + row.id;

        }

       

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <main class="my-form">
        <div class="cotainer">
            <div class="row-fluid">
                <div class="page-header position-relative">
                    <h1>Student BonaFide CertiFicate Request Form (NON-ACADEMIC)
                    </h1>
                </div>
            </div>

            <div style="margin-top: 5px; display: none; width: 100%" class="row-fluid" id="datalist_saved">
                <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0" border="0" id="datatable_saved" width="100%">
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div id="fess_status" style="display: none; font-weight: bold; color: red;">
                <h5>Current Semester Fees Pending. Please Pay Fees. Then Submit the Request Form.</h5>
            </div>
            <div class="row justify-content-center" style="padding-top: 25px;">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group row">
                                    <label for="full_name" id="title_form" class="col-md-4 col-form-label text-md-right" style="font-weight: 900; font-size: 20px; padding-bottom: 15px;">REQUEST FORM </label>
                                    <div class="col-md-6">
                                        <p id="status"></p>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="stu_code" class="col-md-4 col-form-label text-md-right">Student Code</label>
                                    <div class="col-md-6">
                                        <input type="text" id="student_code" class="form-control" name="Student Code" disabled="disabled">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="full_name" class="col-md-4 col-form-label text-md-right">Student Name</label>
                                    <div class="col-md-6">
                                        <input type="text" id="student_name" class="form-control" name="Student Name" disabled="disabled">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="full_name" class="col-md-4 col-form-label text-md-right">Gender</label>
                                    <div class="col-md-6">
                                        <input type="text" id="gender_type" class="form-control" name="Gender" disabled="disabled">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="user_id" class="col-md-4 col-form-label text-md-right">Email Id</label>
                                    <div class="col-md-6">
                                        <input type="text" id="email_id" class="form-control" name="EmailId" disabled="disabled">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="mobile" class="col-md-4 col-form-label text-md-right">Mobile Number</label>
                                    <div class="col-md-6">
                                        <input type="text" id="mobile_number" class="form-control" name="MobileNumber" disabled="disabled">
                                    </div>
                                </div>
                                <div class="form-group row" style="">
                                    <label for="faculty_name" class="col-md-4 col-form-label text-md-right">Faculty Name</label>
                                    <div class="col-md-6">
                                        <select class="chosen-select" id="drpdepartment" disabled="disabled">
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row" style="margin-top: 5px;">
                                    <label for="phone_number" class="col-md-4 col-form-label text-md-right"></label>
                                </div>
                                <div id="div_thesis" style="display: block;">
                                    <div class="form-group row">
                                        <label for="phone_number" class="col-md-4 col-form-label text-md-right">Program Name</label>
                                        <div class="col-md-6">
                                            <select class="chosen-select" id="drpprog" disabled="disabled">
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row" style="margin-top: 5px;">
                                        <label for="phone_number" class="col-md-4 col-form-label text-md-right"></label>
                                    </div>
                                    <div class="form-group row">
                                        <label for="purpose" class="col-md-4 col-form-label text-md-right">Purpose for seeking Bonafide Certificate <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <select id="Purpose" class="form-control" name="purpose">
                                                <%--<option value="">-- Please Select Purpose --</option>--%>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row" id="purpose_text" style="display:none;">
                                        <label for="purpose_res" class="col-md-4 col-form-label text-md-right">Purpose <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                             <input type="text" id="purpose_res" class="form-control" name="Purpose">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="fees_slip" class="col-md-4 col-form-label text-md-right">Upload your Fee Receipt Copy of Existing Semester <span style="color:blue;">(Max 2 MB)</span><span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <div style="padding: 10px; overflow: visible;" id="div_upload_fees_slip" class="panel-collapse collapse in">
                                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                    <span><strong>Upload Fees Slip</strong></span>
                                                    <input type="file" name="fessUpload" id="fessUpload" onchange="javascript:return Uploadfeesslip();" style="display: none;">
                                                </label>
                                                <span id="lbl_fees_slip_file_name" style="vertical-align: super;"></span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="form-group row">
                                        <label for="permanent_address" class="col-md-4 col-form-label text-md-right">Upload your ID Proof<span style="color:blue;"> (Max 2 MB)</span><span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <div style="padding: 10px; overflow: visible;" id="div_upload_cv" class="panel-collapse collapse in">
                                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                    <span><strong>Upload ID Proof</strong></span>
                                                    <input type="file" name="idUpload" id="idUpload" onchange="javascript:return UploadProfilePhoto();" style="display: none;">
                                                </label> 
                                                <span id="lbl_id_proof_file_name" style="vertical-align: super;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row" style="margin-top: 10px;">
                                        <label for="phone_number" class="col-md-4 col-form-label text-md-right">Specific details that you need mentioned in the Bonafide Certificate (max 150 chars)</label>
                                        <div class="col-md-6">
                                            <input type="text" id="remarks" class="form-control" name="Thesis Topic" style="width: 600px; height: 50px;">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4" id="div_save_submit">
                                        <button class="btn  btn-primary" type="button" id="btnsave" style="display:inline-block;">
                                            Save
                                        </button>
                                        <button class="btn  btn-primary" type="button" id="btnsubmit" style="display: inline-block;">
                                            Submit   
                                        </button>
                                        <button class="btn  btn-primary" type="button" id="savesubmit" style="display: none;">
                                            Save Submit   
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <input type="hidden" id="hdn_stud_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_file_name" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_fees_file_name" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sr_no" runat="server" clientidmode="Static" />
    <asp:Button ID="btnDownloadvideo" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadvideo_Click" ClientIDMode="Static" />
</asp:Content>

