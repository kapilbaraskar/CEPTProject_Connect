<%@ Page Title="Reissue Smart Card " Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Student_smart_card_dtl.aspx.cs" Inherits="Student_Student_smart_card_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
        var image_url_exits = "";
        $(document).ready(function () {
            
            Student_id = $('#hdn_user_id').val();
            get_smartcard_dtl();
            get_charges_dtl();
            bind_data();
            $('#submit_pay').css('display', 'block');
           
            $('#submit_pay').on('click', function () {
                if ($("#txt_blood_group").val() == "") {
                    alert("Please Select Blood Group");
                    return false;
                }

                if ($("#txt_address").val() == "") {
                    alert("Please Enter Address");
                    return false;
                }

                if ($("#emergency_contact").val() == "") {
                    alert("Please Enter Emergency Contact No");
                    return false;
                }
                if ($("#dob").val() == "") {
                    alert("Please Enter Date of Birth");
                    return false;
                }
               
                if (image_url_exits == "") {
                    alert("Please Upload Profile Photo");
                    return false;
                }
                //saveData();
                pay_smartcard_fees();
            });


            $('#save_data').on('click', function () {
                if ($("#txt_blood_group").val() == "") {
                    alert("Please Select Blood Group");
                    return false;
                }

                if ($("#txt_address").val() == "") {
                    alert("Please Enter Address");
                    return false;
                }

                if ($("#emergency_contact").val() == "") {
                    alert("Please Enter Emergency Contact No");
                    return false;
                }
                saveData();
                //pay_smartcard_fees();
            });

            $("#dob").datepicker({
                altField: "#dateHidden",
                altFormat: "yy-mm-dd",
                dateFormat: "dd-mm-yy",
                onSelect: function (date) {
                }
            });
        });
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
                        $('#dob').val(student_data[0]['date']);
                        //$('#txt_blood_group').text(student_data[0]['blood_group']);
                        $('#txt_blood_group').val(student_data[0]['blood_group']);

                        $('#txt_address').text(student_data[0]['address']);
                        $('#emergency_contact').val(student_data[0]['emergency_contact_2']);
                        //address, emergency_contact_2
                        var region = location.origin;
                        image_url_exits = student_data[0]['profile_photo'];
                        $('#img_photo').attr('src', region + '/' + 'UserProfilePhoto/' + student_data[0]['profile_photo']);
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

        function pay_smartcard_fees() {
            
                //var stud_selection = $('input[name=rdo_apply_dtl]:checked')[0].value;
                //var cur_room = $('#txt_room_num').val();
                //
                //if (stud_selection == 'R' && cur_room == '') {
                //    bootbox.alert('Please enter your room number');
                //    return false;
                //}

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../WebService.asmx/smartCard_fees_payment",
                   // data: "{student_selection:'" + stud_selection + "',cur_room:'" + cur_room + "'}",
                    data: "",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var result = JSON.parse(data.d);

                            if (result["status"]) {
                                submitFormKotak(result["message"]);
                            }
                            else {
                                alert(result["message"]);
                                return false;
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            
            
        }

        function generateHMAC(param1) {
            document.getElementById("orderAmount").value = param1["amount"];
            document.getElementById("merchantTxnId").value = param1["transaction_id"];
            document.getElementById("currency").value = param1["currency"];
            document.getElementById("returnUrl").value = param1["return_url"];

            if (window.XMLHttpRequest) {
                reqObj = new XMLHttpRequest();
            } else {
                reqObj = new ActiveXObject("Microsoft.XMLHTTP");
            }

            merchantURLPart = param1["merchant_id"];

            if (merchantURLPart.lastIndexOf("/") != -1) {
                vanityURLPart = merchantURLPart.substring(merchantURLPart.lastIndexOf("/") + 1)
            }

            var orderAmount = document.getElementById("orderAmount").value;
            var merchantTxnId = document.getElementById("merchantTxnId").value;
            var currency = document.getElementById("currency").value;

            var param = "merchantId=" + vanityURLPart + "&orderAmount=" + orderAmount + "&merchantTxnId=" + merchantTxnId + "&currency=" + currency;
            reqObj.onreadystatechange = process;

            reqObj.open("POST", param1["hmac_url"] + "?" + param, false);
            reqObj.send(null);
        }

        function process() {
            if (reqObj.readyState == 4) {
                document.getElementById("secSignature").value = reqObj.responseText;
                submitForm();
            }
        }

        function submitForm() {
            document.forms[0].action = merchantURLPart;
            document.forms[0].method = 'POST';
            document.forms[0].submit();
        }
        function submitFormKotak(param1) {
            location.href = 'KotakRequestHandler.aspx';
        }

        function saveData() {
            if ($("#txt_blood_group").val() == "")
            {
                alert("Please Select Blood Group");
                return false;
            }

            if ($("#txt_address").val() == "") {
                alert("Please Enter Address");
                return false;
            }

            if ($("#emergency_contact").val() == "") {
                alert("Please Enter Emergency Contact No");
                return false; 
            }
            if ($("#dob").val() == "") {
                alert("Please Enter Date of Birth");
                return false;
            }
            
            if (image_url_exits == "")
            {
                alert("Please Upload Profile Photo");
                return false;
            }

            var save_data = "";
            save_data =
            {
                "blood_group": $("#txt_blood_group").val(),
                "address": $("#txt_address").val(),
                "emergency_contact_2": $("#emergency_contact").val(),
                "dob": $("#dob").val()

            };
            var smart_card_data = [];
            smart_card_data.push(save_data);
            var json_submit_data = JSON.stringify(smart_card_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/update_smartcard_dtl",
                data: "{ smart_card: '" + json_submit_data + "' }",
                async: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]') {
                        if (data.d == "true") {
                            alert("Data Save successfully");
                            
                        }
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }


        function get_charges_dtl()
        {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_parameter_value",
                data: "{ param_name: 'smartcard_fees_amount' }",
                async: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]')
                    {
                        var data_dtl = JSON.parse(data.d);
                        $('#charges').text(data_dtl[0]['parameter_value']);
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }

        function get_smartcard_dtl() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_smart_card_dtl",
                data: "{ user_id: '" + Student_id+"' }",
                async: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != '' && data.d != '[]') {
                        var details = JSON.parse(data.d);
                        //$('#charges').text(data_dtl[0]['parameter_value']);

                        var str = "<tr><th>Student Code</th><th>Student Name</th><th>Semester</th><th>Year</th><th>Status</th></tr>";
                        for (var i = 0; i < details.length; i++) {
                            str += "<tr><td>" + details[i]['user_id'] + "</td><td>" + details[i]['full_name'] + "</td><td>" + details[i]["semester_type"] + "</td><td>" + details[i]["year_semester"] + "</td><td>" + details[i]["smart_card_status"] + "</td></tr>";
                        }

                        $('#tbl_smartcard_dtl').html(str);
                        $('#div_smartcard_dtl').css('display', 'block');
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="div_user_group">
        <h3 style="text-align: center;"><u>Reissue Smart Card </u></h3>
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
                <strong>Smart Card Detail</strong>
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
                             <input type="text" id="dob" class="marg-btm" placeholder="DD-MM-YYYY" />
                            <%--<label id="dob"></label>--%>
                            
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
                        <%--    <label id="txt_blood_group"></label>--%>
                             <select id="txt_blood_group">
                            <option value="">-- Select Blood Group --</option>
                            <option value="A+">A+ (A Positive)</option>
                            <option value="A-">A- (A Negative)</option>
                            <option value="B+">B+ (B Positive)</option>
                            <option value="B-">B- (B Negative)</option>
                            <option value="O+">O+ (O Positive)</option>
                            <option value="O-">O- (O Negative)</option>
                            <option value="AB+">AB+ (AB Positive)</option>
                            <option value="AB-">AB- (AB Negative)</option>
                        </select>
                            
                        </td>
                         <td><b>Emergency Contact No</b>  </td>
                         <td><input type="text" id="emergency_contact"/></td>
                       
                    </tr>
                    <tr>
                        <td style="padding-left: 15px;"><b>Reissue Smart Card Charges</b></td>
                        <td><label id="charges"></label></td>
                    </tr>
                   <tr>
                        <td style="padding-left: 15px;"><b>Permanent Address</b></td>
                         <td><textarea id="txt_address" style="width: 100%; margin-bottom: 0px;" rows="3" cols="5" name="Address"></textarea></td>
                    </tr>
                    

                    <tr>
                        <td colspan="2">
                             <button class="btn btn-primary" id="save_data" style="margin-left: 88%;" >Save</button>                 
                        </td>
                        <td><button class="btn btn-primary" id="submit_pay">Pay Now</button>
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


        <div class="panel panel-default" id="div_smartcard_dtl" style="display: none;">
                <div class="panel-heading">
                    <strong>Smart Card Status</strong>
                </div>
                <div>
                    <table id="tbl_smartcard_dtl" class="table table-bordered">
                    </table>
                </div>
            </div>


        <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_url_user_id" runat="server" clientidmode="Static" />
        <input type="hidden" id="returnUrl" name="returnUrl" value="" />
    <input type="hidden" id="secSignature" name="secSignature" value="" />
    <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
    <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId" value="" />
    <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount" value="" />
    <input style="display: none" type="text" id="currency" class="text" name="currency" value="INR" />
    </div>
    

</asp:Content>

