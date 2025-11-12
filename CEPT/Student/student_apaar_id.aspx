<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="student_apaar_id.aspx.cs" Inherits="Student_student_apaar_id" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript">
        {
            $(document).ready(function () {
                GetApaarIdData();
                $('#txt_apaarid,#txt_nameasperaadhar').on('keypress', function (e)
                {
                    if (e.which === 13) { 
                        e.preventDefault(); 
                        return false;
                    }
                });

                
            });

            function savedata() {
                if ($('#txt_apaarid').val() == "") {
                    bootbox.alert("Please Enter Apaarid");
                    return false;
                }
                if ($('#txt_nameasperaadhar').val() == "") {
                    bootbox.alert("Please Enter Name");
                    return false;
                }
                if ($('#txt_apaarid').val().length > 12) {
                    bootbox.alert("ApparId allows a maximum of 12 digits");
                    return false;
                }
                else if ($('#txt_apaarid').val().length < 12) {
                    bootbox.alert("ApparId allows a maximum of 12 digits");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/SaveStudentApaarId",
                    async: false,
                    data: "{apaar_id:'" + $('#txt_apaarid').val() + "',name :'" + $('#txt_nameasperaadhar').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == 'true') {
                                $('#btnsubmit').css('display', 'none');
                                alert("Apaar Id Submit Successfully");
                                $('#messagetxt').css('display', 'block');
                            }
                            else {
                                alert("Apaar Id Not Submit Successfully");
                            }

                            return false;

                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }



            $('#btnsubmit1').on('click', function () {
                debugger
                if ($('#txt_apaarid').val() == "") {
                    bootbox.alert("Please Enter Apaarid");
                    return false;
                }
                if ($('#txt_nameasperaadhar').val() == "") {
                    bootbox.alert("Please Enter Name");
                    return false;
                }
                if ($('#txt_apaarid').val().length > 12)
                {
                    bootbox.alert("ApparId allows a maximum of 12 digits");
                    return false;
                }
                else if ($('#txt_apaarid').val().length < 12)
                {
                    bootbox.alert("ApparId allows a maximum of 12 digits");
                    return false;
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/SaveStudentApaarId",
                    async: false,
                    data: "{apaar_id:'" + $('#txt_apaarid').val() + "',name :'" + $('#txt_nameasperaadhar').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == 'true') {
                                $('#btnsubmit').css('display', 'none');
                                alert("Apaar Id Submit Successfully");
                                $('#messagetxt').css('display', 'block');
                            }
                            else {
                                alert("Apaar Id Not Submit Successfully");
                            }

                            return false;

                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            });
            function GetApaarIdData()
            {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetStudentApaarId",
                    async: false,
                    data: "",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "")
                        {
                            var datasave = JSON.parse(data.d);
                            if (datasave[0].Status == 'Y')
                            {
                                $('#txt_apaarid').val(datasave[0].apaar_id);
                                $('#txt_nameasperaadhar').val(datasave[0].student_name);
                                $('#btnsubmit').css('display', 'none');
                                $('#messagetxt').css('display', '');
                            }
                            else if (datasave[0].UniversityIDStatus == 'N')
                            {
                                $('#btnsubmit').css('display', 'none');
                                $('#messagetxt').css('display', '');
                                $('#messagetxt').text('You are not eligible to apply for an Apaar ID');
                            }
                            else
                            {
                                $('#btnsubmit').css('display', '');
                                $('#messagetxt').css('display', 'none');
                            }
                            return false;

                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            function limitLength(input) {
                if (input.value.length > 12)
                {
                    input.value = input.value.slice(0, 12);
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <main class="my-form">
        <div class="cotainer">
            <div class="row-fluid">
                <div class="page-header position-relative">
                    <h1>Student Apaar Id </h1>
                </div>
            </div>
            <div style="display: block; font-family: Helvetica Neue,Helvetica,Arial,sans-serif;">
                
                <h4>Note :</h4>
        
        <p>Step 1: Login to DigiLocker. Student with DigiLocker Account can create APAAR ID. or Go to <a href="https://www.abc.gov.in/" target="_blank">abc.gov.in</a> for login to student account.</p>
       
        <p>Step 2: Search for Education. Education category shows Academic Bank of Credits service.</p>
       
        <p>Step 3: Create APAAR ID. Select your University and click on Generate APAAR ID.</p>
		
        <!--<p style="color:red;">If you have any questions, please contact Student Services Office (SSO) Email: studentservices@cept.ac.in</p>-->
       
            </div>

            <div class="row justify-content-center" style="padding-top: 25px;">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                 
                               

                                <div id="div_thesis" style="display: block;">
                                    <div class="form-group row">
                                        <label for="fees_slip" class="col-md-4 col-form-label text-md-right">Student Apaar id <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <input type="number" id="txt_apaarid" class="marg-btm" placeholder="Apaar id" maxlength="12" oninput="limitLength(this)">
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label for="fees_slip" class="col-md-4 col-form-label text-md-right">Name (As Per Aadhar) <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <input type="text" id="txt_nameasperaadhar" class="marg-btm" placeholder="Name">
                                        </div>
                                    </div>

                                    <div class="form-group row" style="display:block;padding-bottom: 14px;">
                                    <div class="col-md-6">
                                     <button class="btn btn-primary" id="btnsubmit" style="display:none;" onclick="savedata()" >Submit</button>
                                        <span style="color:blue; font-size:15px; display:none;" id="messagetxt">Apaar id already submitted</span>
                                    </div>
                                </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
             
        </div>
        </main>
</asp:Content>

