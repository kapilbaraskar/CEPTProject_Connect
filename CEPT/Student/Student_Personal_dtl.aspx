<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Student_Personal_dtl.aspx.cs" Inherits="Student_Student_Personal_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <style type="text/css">
        .img-thumbnail {
            display: inline-block;
            max-width: 100%;
            height: auto;
            padding: 4px;
            line-height: 1.42857143;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            -webkit-transition: all .2s ease-in-out;
            transition: all .2s ease-in-out;
        }

        .file-upload input {
            position: absolute;
            top: 0;
            left: 0;
            margin: 0;
            font-size: 10pt;
            opacity: 0;
        }

        .required {
            color: Red;
        }
 
    </style>
    <script type="text/javascript">
        var Student_id;
        $(document).ready(function () {
            document.querySelectorAll('.numeric-input').forEach(function (element) {
                element.addEventListener('input', function (e) {
                    // Replace any non-numeric characters
                    e.target.value = e.target.value.replace(/[^0-9]/g, '');
                });
            });

            document.getElementById('pg-hostel').addEventListener('change', toggleDetails);
            document.getElementById('flat-relative-house').addEventListener('change', toggleDetails);
            window.onload = toggleDetails;

            Student_id = $('#hdn_user_id').val();
            bindstate();
            debugger;
            bind_data();
            $('#btnsubmit').on('click', function () {
                save_data('Y');
            });

            $('#btnsave').on('click', function () {
                save_data('S');
            });
           

           
        });
        function toggleDetails()
        {
            const selectedRadio = document.querySelector('input[name="living_situation"]:checked');
            if (!selectedRadio) {
                return;
            }
            const selectedValue = selectedRadio.value;
            const pgDetails = document.querySelectorAll('#pg-details, #pg-details-2, #pg-details-3, #pg-details-4, #pg-details-5');
            const relativeDetails = document.querySelectorAll('#relative-details, #relative-details-2, #relative-details-3, #relative-details-4');

            if (selectedValue === 'Y') {
                pgDetails.forEach(row => row.classList.remove('hidden'));
                relativeDetails.forEach(row => row.classList.add('hidden'));
            } else {
                pgDetails.forEach(row => row.classList.add('hidden'));
                relativeDetails.forEach(row => row.classList.remove('hidden'));
            }
        }
       
        function bind_data() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_data_in_student_side",
                data: "{Student_id :'" + Student_id + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var student_data = JSON.parse(data.d)

                        


                        $('#txt_stu_code').text(student_data[0]['user_id']);
                        $('#txt_stu_name').text(student_data[0]['full_name']);
                        $('#txt_gender').text(student_data[0]['gender']);
                        $('#mail').text(student_data[0]['mail']);
                        $('#txt_dept_code').text(student_data[0]['dept_name']);
                        $('#txt_pro_code').text(student_data[0]['prog_name']);
                        //$('#txt_pro_level_code').val(student_data[0]['prog_level_name']);
                        $('#txt_pro_level_code').text(student_data[0]['prog_level_name']);
                        $('#dob').text(student_data[0]['date']);
                        $('#txt_blood_group').text(student_data[0]['blood_group']);
                        $('#mobile_number').val(student_data[0]['mobile_no']);
                        $('#emergency_contact_2').val(student_data[0]['emergency_contact_2']);
                        $('#emergency_contact_1').val(student_data[0]['emergency_contact_1']);
                        $('#city').val(student_data[0]['city']);
                        $('#passport_no').val(student_data[0]['passport_no']);
                        $('#name_passport').val(student_data[0]['name_as_passport']);
                        $('#address').val(student_data[0]['address']);
                        $('#rfidcode').val(student_data[0]['RFIDCode']);
                        $('#pincode').val(student_data[0]['applicant_address_pincode']);
                        $('#state').val(student_data[0]['state']).trigger("liszt:updated");;
                        var region = location.origin;
                        $('#img_photo').attr('src', region + '/' + 'UserProfilePhoto/' + student_data[0]['profile_photo']);

                        if (student_data[0]['Type'] == 'Y') {
                            $('#pg-hostel').attr('checked', true);
                            toggleDetails();

                            $('#nameofpg').val(student_data[0]['NameOfAddress']);
                            $('#nameofwarden').val(student_data[0]['WardenName']);
                            $('#wardennumber').val(student_data[0]['WardenNumber']);
                            $('#roomno').val(student_data[0]['RoomNumber']);
                            $('#AddressField1').val(student_data[0]['AddressField1']);
                            $('#AddressField2').val(student_data[0]['AddressField2']);
                            $('#Area').val(student_data[0]['Area']);
                            $('#City_1').val(student_data[0]['cityaddress']);
                            $('#PinCode').val(student_data[0]['PinCode']);
                            $('#HostelNumber').val(student_data[0]['ContactNo']);
                        }
                        else if (student_data[0]['Type'] == 'N') {
                            $('#flat-relative-house').attr('checked', true);
                            toggleDetails();

                            $('#nameofowner').val(student_data[0]['NameOfAddress']);
                            $('#nameofreationship').val(student_data[0]['Relationship']);
                            $('#AddressField_1').val(student_data[0]['AddressField1']);
                            $('#AddressField_2').val(student_data[0]['AddressField2']);
                            $('#Area_2').val(student_data[0]['Area']);
                            $('#City_2').val(student_data[0]['cityaddress']);
                            $('#PinCode_2').val(student_data[0]['PinCode']);
                            $('#OwnerNumber').val(student_data[0]['ContactNo']);
                        }


                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var FileName2 = '';
        function UploadUserProfilePhoto() {
            try {
                var fileToUpload = GetFileNameFromPath($('#imageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                var icode = $('#hdn_icode').val();

                if (CheckUserProfilePhotoExtension(fileToUpload)) {
                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/student_profile_image.ashx',
                                secureuri: false,
                                fileElementId: 'imageUpload',
                                dataType: 'json',
                                data: { name: name, icode: icode },
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#imageUpload').val("");

                                           

                                            FileName2 = data.upfile;
                                            var region = location.origin;
                                            $('#img_photo').attr('src', region + '/' + 'UserPersonalPhoto/' + FileName2);
                                            //$("#img_photo").attr("src", "../../UserPersonalPhoto/" + FileName2 + "?" + (new Date()).getTime());
                                            $('#lbl_image_name').text(FileName2);
                                            alert("Photo Uploaded Successfully");
                                            location.reload();
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
                    alert('Invalid File Type. Please upload .jpeg file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        //Check User Photo Extension
        function CheckUserProfilePhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'jpg':
                    case 'jpeg':
                    case 'JPG':
                    case 'JPEG':
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

        function save_data(type_submit) {

            debugger;
            if (type_submit == 'Y')
            {
                if ($('#emergency_contact_1').val() == "") {
                    alert("Please Enter Emergency Contact No 1");
                    return false;
                }
                if ($('#emergency_contact_2').val() == "") {
                    alert("Please Enter Emergency Contact No 2");
                    return false;
                }
                if ($('#city').val() == "") {
                    alert("Please Enter City Name");
                    return false;
                }
                if ($('#state').val() == "") {
                    alert("Please Select State");
                    return false;
                }
                if ($('#pincode').val() == "") {
                    alert("Please Enter Pin Code");
                    return false;
                }
                if ($('#address').val() == "") {
                    alert("Please Enter Adress");
                    return false;
                }
                if ($('input[name="living_situation"]:checked').val() == '') {
                    alert("Please Select currently living in ?");
                    return false;
                }
                if ($('input[name="living_situation"]:checked').val() == 'Y')
                {

                    if ($('#nameofpg').val() == '') {
                        alert("Please Enter Name of PG or Hostel");
                        return false;
                    }
                    if ($('#nameofwarden').val() == '') {
                        alert("Please Enter Warden Name");
                        return false;
                    }
                    if ($('#wardennumber').val() == '') {
                        alert("Please Enter Warden number");
                        return false;
                    }

                    if ($('#roomno').val() == '') {
                        alert("Please Enter Room number");
                        return false;
                    }


                    if ($('#AddressField1').val() == '') {
                        alert("Please Enter AddressField 1 ");
                        return false;
                    }

                    if ($('#Area').val() == '') {
                        alert("Please Enter Area");
                        return false;
                    }

                    if ($('#City_1').val() == '') {
                        alert("Please Enter City");
                        return false;
                    }
                    if ($('#PinCode').val() == '') {
                        alert("Please Enter Pin Code");
                        return false;
                    }
                    if ($('#HostelNumber').val() == '') {
                        alert("Please Enter HostelNumber");
                        return false;
                    }
                }
                else if ($('input[name="living_situation"]:checked').val() == 'N')
                {

                    if ($('#nameofowner').val() == '') {
                        alert("Please Enter Name of Owner/Relative");
                        return false;
                    }
                    if ($('#nameofreationship').val() == '') {
                        alert("Please Enter Relationship");
                        return false;
                    }
                    if ($('#AddressField_1').val() == '') {
                        alert("Please Enter AddressField 1 ");
                        return false;
                    }

                    if ($('#Area_2').val() == '') {
                        alert("Please Enter Area");
                        return false;
                    }


                    if ($('#City_2').val() == '') {
                        alert("Please Enter City ");
                        return false;
                    }

                    if ($('#PinCode_2').val() == '') {
                        alert("Please Enter Pin Code ");
                        return false;
                    }
                    if ($('#OwnerNumber').val() == '') {
                        alert("Please Enter Owner/Relative Number ");
                        return false;
                    }

                }
                
            }
            var entityMap = { "'": '&#39;', '"': '&#34;', "@": '&#64;', "&": '&#38;', "<": '&#60;', ">": '&#62;', "/": '&#47;' };
            var student_details_save = "";
            student_details_save = {
                "emergency_contact_1": $('#emergency_contact_1').val(),
                "city": $('#city').val(),
                "state": $('#state').val(),
                "pincode": $('#pincode').val(),
                "email_id": $('#mail').text(),
                "address": $("#address").val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                "RFID": $('#rfidcode').val()
            };

            var addressformData = "";
            
            addressformData = {

                "living_situation": $('input[name="living_situation"]:checked').val(),
                "nameofpg": $('#nameofpg').val(),
                "nameofwarden": $('#nameofwarden').val(),
               "wardennumber": $('#wardennumber').val(),
               "roomno": $('#roomno').val(),
                "AddressField1": $('#AddressField1').val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                "AddressField2": $('#AddressField2').val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                "Area": $('#Area').val(),
               "City": $('#City_1').val(),
               "PinCode": $('#PinCode').val(),
               "HostelNumber": $('#HostelNumber').val(),
               "nameofowner": $('#nameofowner').val(),
                "nameofrelationship": $('#nameofreationship').val(),
                "AddressField_1": $('#AddressField_1').val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                "AddressField_2": $('#AddressField_2').val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
               "Area_2": $('#Area_2').val(),
               "City_2": $('#City_2').val(),
               "PinCode_2": $('#PinCode_2').val(),
               "OwnerNumber": $('#OwnerNumber').val()
           };

            var student_details_save_data = [];
            student_details_save_data.push(student_details_save);
            student_details_save_data.push(addressformData);
            var json_submit_data = JSON.stringify(student_details_save_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/update_student_contact_dtl",
                data: "{mobile_no:'" + $('#mobile_number').val() + "',emergency_contact_2:'" + $('#emergency_contact_2').val() + "',passport_no:'" + $('#passport_no').val() + "',name_passport:'" + $('#name_passport').val() + "',details_stu:'" + json_submit_data + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == 'true')
                        {
                            alert("Data Saved Successfully");   
                        }
                        return false;
                        //var student_data = JSON.parse(data.d)
                        //$('#txt_stu_code').text(student_data[0]['user_id']);
                        //$('#txt_stu_name').text(student_data[0]['full_name']);
                        //$('#txt_gender').text(student_data[0]['gender']);
                        //$('#mail').text(student_data[0]['mail']);
                        //$('#txt_dept_code').text(student_data[0]['dept_name']);
                        //$('#txt_pro_code').text(student_data[0]['prog_name']);
                        ////$('#txt_pro_level_code').val(student_data[0]['prog_level_name']);
                        //$('#txt_pro_level_code').text(student_data[0]['prog_level_name']);
                        //$('#dob').text(student_data[0]['date']);
                        //$('#txt_blood_group').text(student_data[0]['blood_group']);
                        //$('#mobile_number').text(student_data[0]['mobile_no']);
                        //$('#emergency_contact_2').text(student_data[0]['emergency_contact_2']);
                        //var region = location.origin;
                        //$('#img_photo').attr('src', region + '/' + 'UserProfilePhoto/' + student_data[0]['profile_photo']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }


        function bindstate()
        {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_state_data",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d);

                        $('#state').empty().append($("<option></option>").val("").html("-- Please Select State --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#state').append($("<option></option>").val(prog_level_data[i]["state_code"]).html(prog_level_data[i]["state_name"]));
                        }

                        //if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                        $('#state').chosen();
                        //}
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


       

        // Add event listeners to the radio buttons
        

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="div_user_group">
        <h3 style="text-align: center;"><u>Personal Details</u></h3>
    </div>

    <div class="well" style="background-color: White;">
        <div style="display: block; font-family: Helvetica Neue,Helvetica,Arial,sans-serif;padding-left: 3px;">
         <h4>Instructions :</h4>
        
        <p>Photograph must be a recent passport style colour picture.</p>
        <p>Make sure that the picture is in colour, taken against a white background.</p>
        <p>Allowed Photo Size – (272 x 272 dimension (pixel) white background)</p>
        <p>Only Allowed JPG Format Image.</p>
            </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Profile Photo</b>
            </div>

            <div style="padding: 10px; overflow: visible; width: 50%;" class="panel-collapse collapse in">

                <img id="img_photo" src="../../UserProfilePhoto/Default_Avtar.png" alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;"
                    class="img-thumbnail" />

                <label id="lbl_img" class="btn btn-primary file-upload " style="vertical-align: bottom;">
                    <span><strong>Upload Photo</strong></span>
                    <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadUserProfilePhoto();" />
                </label>
                <br />
                <label id="lbl_image_name" style="display: none;" ng-model="data.image_name"></label>
                
            </div>

        </div>
        <div id="main_div" style="margin-top: 15px; margin-bottom: 40px;" class="panel panel-default">

            <div class="panel-heading">
                <strong>Student Detail</strong>
            </div>
            <div style="padding-top: 15px;">
                <table border="0" cellpadding="2" cellspacing="2" style="width: 100%;" align="center">

                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Student Code</b>
                        </td>
                        <td>
                            <label id="txt_stu_code"></label>
                            <%--<input type="text" id="txt_stu_code" readonly />--%>
                        </td>

                        <td>
                            <b>Student Name</b>
                        </td>
                        <td>
                            <label id="txt_stu_name"></label>
                            <%--<input type="text" id="txt_stu_name" readonly />--%>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="4" style="padding-top: 6px;"></td>
                    </tr>

                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Gender</b>
                        </td>
                        <td>
                            <label id="txt_gender"></label>
                            <%--<input type="text" id="txt_gender" readonly />--%>
                        </td>

                        <td>
                            <b>EMail Id</b>
                        </td>
                        <td>
                            <label id="mail"></label>
                            <%--<input type="text" id="mail" readonly /> --%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="padding-top: 6px;"></td>
                    </tr>
                    <tr>

                        <td style="padding-left: 15px;">
                            <b>Department Name</b>
                        </td>
                        <td>
                            <label id="txt_dept_code"></label>
                            <%-- <input type="text" id="txt_dept_code" readonly />--%>
                        </td>
                        <td>
                            <b>Program Name</b>
                        </td>
                        <td>
                            <label id="txt_pro_code"></label>
                            <%--<input type="text" id="txt_pro_code" readonly />--%>
                        </td>


                    </tr>
                    <tr>
                        <td colspan="4" style="padding-top: 6px;"></td>
                    </tr>
                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Program Level Name</b>
                        </td>
                        <td>
                            <label id="txt_pro_level_code"></label>
                            <%--<input type="text" id="txt_pro_level_code" readonly/>--%>
                        </td>
                        <td>
                            <b>Date of Birth</b>
                        </td>
                        <td>
                            <label id="dob"></label>
                            <%--<input type="text" id="mail" readonly /> --%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="padding-top: 6px;"></td>
                    </tr>


                     <tr>
                        <td style="padding-left: 15px;">
                            <b>Bloog Group</b>
                        </td>
                        <td>
                            <label id="txt_blood_group"></label>
                            
                        </td>
                         <td>
                            <b>Mobile Number</b>
                        </td>
                        <td>
                            
                            <input type="text" id="mobile_number" pattern="^[0-9]*$" onkeypress="return isNumber(event)" /> 
                        </td>
                       
                    </tr>
                    
                    <tr>
                          <td style="padding-left: 15px;">
                            <b>Emergency Contact Number 1</b>
                        </td>
                        <td>
                            
                            <input type="text" id="emergency_contact_1" pattern="^[0-9]*$" onkeypress="return isNumber(event)" /> 
                        </td>
                        
                          <td >
                            <b>Emergency Contact Number 2</b>
                        </td>
                        <td>
                            
                            <input type="text" id="emergency_contact_2" pattern="^[0-9]*$" onkeypress="return isNumber(event)" /> 
                        </td>
                        
                       

                        
                    </tr>
                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Passport Number</b>
                        </td>
                        <td>
                            
                            <input type="text" id="passport_no" /> 
                        </td>
                        <td>
                            <b>Name (As per Passport)</b>
                        </td>
                        <td>
                            
                            <input type="text" id="name_passport" /> 
                        </td>
                    </tr>
                    <tr>
                          <td style="padding-left: 15px;">
                            <b>Address</b>
                        </td>
                        <td colspan="4">
                            
                            <textarea rows="5" cols="10" id="address" class="ckeditor" style="width: 847px; height: 109px;"></textarea>
                        </td>
                        
                    </tr>
                     <tr>
                          <td style="padding-left: 15px;">
                            <b>City</b>
                        </td>
                        <td>
                            
                            <input type="text" id="city"/> 
                        </td>
                        
                          <td >
                            <b>State</b>
                        </td>
                        <td>
                             <select class="chosen-select" id="state">
                                </select>
                            
                        </td>
                        
                       

                        
                    </tr>

                    <tr>
                        <td style="padding-left: 15px;">
                            <b>Pin Code</b>
                        </td>
                        <td>
                            
                            <input type="text" id="pincode"/> 
                        </td>

                        <td>
                            <b>RFID Code</b>
                        </td>
                        <td>
                            
                            <input type="text" id="rfidcode"/> 
                        </td>
                    </tr>

                     
                    <tr>
    <td style="padding-left: 15px; white-space: nowrap;" colspan="1">
        <span class="living-situation-label" style="color:blue;">Are you currently living in?</span>
    </td>
    <td colspan="3" class="living-situation-options">
    <label class="radio-inline" style="display: inline-block;vertical-align: middle; margin-right: 20px;">
        <input type="radio" style="margin-top: -1px;" name="living_situation" id="pg-hostel"  value="Y"> <span>PG/Hostel</span>
    </label>
    <label class="radio-inline" style="display: inline-block;vertical-align: middle; margin-right: 20px;">
        <input type="radio" style="margin-top: -1px;" name="living_situation" id="flat-relative-house" value="N"> Flat/ Relative House
    </label>
</td>
</tr>

                    <tr id="pg-details" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Name of PG or Hostel </b>
                        </td>
                        <td>
                            
                            <input type="text" id="nameofpg"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>Warden Name </b>
                        </td>
                        <td>
                            
                            <input type="text" id="nameofwarden"/> 
                        </td>
                    </tr>


                    <tr id="pg-details-2" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Warden number </b>
                        </td>
                        <td>
                            
                            <input type="text" id="wardennumber" class="numeric-input"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>Room no </b>
                        </td>
                        <td>
                            
                            <input type="text" id="roomno" class="numeric-input"/> 
                        </td>
                    </tr>


                    <tr id="pg-details-3" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Address Field 1 </b>
                        </td>
                        <td>
                            
                            <input type="text" id="AddressField1"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>Address Field 2 </b>
                        </td>
                        <td>
                            
                            <input type="text" id="AddressField2"/> 
                        </td>
                    </tr>


                    <tr id="pg-details-4" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Area </b>
                        </td>
                        <td>
                            
                            <input type="text" id="Area"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>City</b>
                        </td>
                        <td>
                            
                            <input type="text" id="City_1"/> 
                        </td>
                    </tr>

                      <tr id="pg-details-5" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Pin Code </b>
                        </td>
                        <td>
                            
                            <input type="text" id="PinCode" class="numeric-input"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>PG/Hostel Number</b>
                        </td>
                        <td>
                            
                            <input type="text" id="HostelNumber" class="numeric-input" /> 
                        </td>
                    </tr>




                    <tr id="relative-details" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Name of Owner/Relative </b>
                        </td>
                        <td>
                            
                            <input type="text" id="nameofowner"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>Relationship </b>
                        </td>
                        <td>
                            
                            <input type="text" id="nameofreationship"/> 
                        </td>
                    </tr>


                    <tr id="relative-details-2" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Address Field 1 </b>
                        </td>
                        <td>
                            
                            <input type="text" id="AddressField_1"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>Address Field 2 </b>
                        </td>
                        <td>
                            
                            <input type="text" id="AddressField_2"/> 
                        </td>
                    </tr>

                    <tr id="relative-details-3" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Area </b>
                        </td>
                        <td>
                            
                            <input type="text" id="Area_2"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>City</b>
                        </td>
                        <td>
                            
                            <input type="text" id="City_2"/> 
                        </td>
                    </tr>

                      <tr id="relative-details-4" class="hidden">
                        <td style="padding-left: 15px;">
                            <b>Pin Code </b>
                        </td>
                        <td>
                            
                            <input type="text" id="PinCode_2" class="numeric-input"/> 
                        </td>

                        <td style="padding-left: 15px;">
                            <b>Owner/Relative Number</b>
                        </td>
                        <td>
                            
                            <input type="text" id="OwnerNumber" class="numeric-input" /> 
                        </td>
                    </tr>

                    <tr>
                        
                        
                        <td style="padding-left: 15px;">
                            <button class="btn btn-primary" id="btnsave">Save</button>
                             <button class="btn btn-primary" id="btnsubmit">Submit</button>

                        </td>

                    </tr>
                   
                    <%--   <tr>
                        <td colspan="4" style="padding: 10px; background-color: #eff3f8; border-top: 1px solid #DDD;">
                            <center>
                                <input type="button" id="btn_save" style="line-height: inherit; display: block;" class="btn btn-lg btn-primary" value="Save" />
                            </center>
                        </td>
                    </tr>--%>
                </table>

                

            </div>
            <br />

        </div>

        <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    </div>
    

</asp:Content>

