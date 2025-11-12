


$(document).ready(function () {


    $('#Button1').on('click', function () {
        window.location.href = "/Login.aspx";
       // register();
    });

    $('#btnsave').on('click', function () {

        debugger;
        var password = $('#txtpassword').val();
        if (password == "") {
            bootbox.alert('Please insert Password')
            $('#txtpassword').focus();
            return false;
        }

        var fullname = $('#txtfullname').val();
        if (fullname == "") {
            $('#txtfullname').focus();
            bootbox.alert('Please Insert Full Name')

            return false;
        }

        var gender = $('#drpgender').val();
        if (gender == "0") {
            $('#drpgender').focus();
            bootbox.alert('Please Select Gender')

            return false;
        }

        var birthdate = $('#txtdob').val();
        if (birthdate == "") {
            bootbox.alert('Please Select Birth Date')
            $('#txtdob').focus();
            return false;
        }

        var blood_grp = $('#txtbloodgrp').val();
        if (blood_grp == "0") {
            bootbox.alert('Please insert Blood Group')
            $('#txtbloodgrp').focus();
            return false;
        }



        var country = $('#drpcountry').val();
        if (country == "0") {
            bootbox.alert('Please Select Country')
            $('#drpcountry').focus();
            return false;
        }

        var place_of_birth = $('#txtpob').val();
        if (place_of_birth == "") {
            bootbox.alert('Please Insert place of birth')
            $('#txtpob').focus();
            return false;
        }

        var nationality = $('#txtnationality').val();
        if (nationality == "") {
            bootbox.alert('Please Insert Nationality')
            $('#txtnationality').focus();
            return false;
        }



        ///////////////////////// Contact Details //////////////////



        debugger;

        var local_address = $('#txtadd').val();
        if (local_address == "") {
            bootbox.alert('Please Insert Local Address')
            $('#txtadd').focus();
            return false;
        }

        var per_adress = $('#txtperadd').val();
        if (per_adress == "") {
            bootbox.alert('Please Insert Permanent Address')
            $('#txtperadd').focus();
            return false;
        }


        var mobile = $('#txtmobileno').val();
        if (mobile == "") {
            bootbox.alert('Please Insert Mobile Number')
            $('#txtmobileno').focus();
            return false;
        }


        var email = $('#txtemail').val();
        if (email == "") {
            bootbox.alert('Please Insert Email Address')
            $('#txtemail').focus();
            return false;
        }

        var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
        if (testEmail.test(email)) {

        }
        else {
            bootbox.alert("Please Enter Valid Email");
            $('#txtemail').focus();

            return false;
        }

        var alt_email = $('#txtaltemail').val();

        if (alt_email == '') {
            bootbox.alert('Please Insert Alternet Email')
            $('#txtaltemail').focus();
            return false;
        }


        if (alt_email != '') {
            var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
            if (testEmail.test(alt_email)) {

            }
            else {
                bootbox.alert("Please Enter Valid Alternet Email");
                $('#txtaltemail').focus();

                return false;
            }
        }

        var resident_no = $('#txtresidentno').val();

        if (resident_no == "") {
            bootbox.alert('Please Insert Resident No')
            $('#txtresidentno').focus();
            return false;
        }


        ////////////// Educational Details  ////////////////////////


        var acadamic_prog = $('#txtacadamic').val();
        if (acadamic_prog == "") {
            bootbox.alert('Please Insert Acadamic Program')
            $('#txtacadamic').focus();
            return false;
        }

        var year_of_enr = $('#txtyearofenro').val();
        if (year_of_enr == "") {
            bootbox.alert('Please Insert Year of Enrollment')
            $('#txtyearofenro').focus();
            return false;
        }

        var year_of_passing = $('#txtyop').val();
        if (year_of_passing == "") {
            bootbox.alert('Please Insert Year of Passing')
            $('#txtyop').focus();
            return false;
        }

        var name_of_uni = $('#txtnou').val();
        if (name_of_uni == "") {
            bootbox.alert('Please Insert Name of University')
            $('#txtnou').focus();
            return false;
        }

        var name_of_degree = $('#txtnod').val();
        if (acadamic_prog == "") {
            bootbox.alert('Please Insert Full Name of Degree / Diploma')
            $('#txtnod').focus();
            return false;
        }

        var prof_exp = $('#txtprof_exp').val();
        if (prof_exp == "") {
            bootbox.alert('Please Insert Professional Experiance')
            $('#txtprof_exp').focus();
            return false;
        }

        var add_of_university = $('#txtaddofuni').val();
        if (add_of_university == "") {
            bootbox.alert('Please Insert Address of University')
            $('#txtaddofuni').focus();
            return false;
        }

        var marks = $('#txtmarks').val();
        if (marks == "") {
            bootbox.alert('Please Insert Percentage/Aggregate Marks')
            $('#txtmarks').focus();
            return false;
        }


        var about_here = $('#txthere').val();
        if (about_here == "") {
            bootbox.alert('Please Insert How did you hear about this?')
            $('#txthere').focus();
            return false;
        }



        var data1 = "{'password':'" + password + "','fullname':'" + fullname + "','gender':'" + gender + "','birthdate':'" + birthdate + "','blood_grp':'" + blood_grp + "','country':'" + country + "','place_of_birth':'" + place_of_birth + "','nationality':'" + nationality + "','local_address':'" + local_address + "','per_adress':'" + per_adress + "','mobile':'" + mobile + "','email':'" + email + "','alt_email':'" + alt_email + "','resident_no':'" + resident_no + "','acadamic_prog':'" + acadamic_prog + "','year_of_enr':'" + year_of_enr + "','year_of_passing' :'" + year_of_passing + "' ,'name_of_uni':'" + name_of_uni + "','name_of_degree':'" + name_of_degree + "','prof_exp':'" + prof_exp + "','add_of_university':'" + add_of_university + "','marks':'" + marks + "','about_here':'" + about_here + "',}";

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "WebService_WS.asmx/Registration",
            data: data1,
            dataType: "json",
            success: function (data) {
                // bind_grid();


                if (data.d == "Data Registered Successfully") {
                    bootbox.confirm("Are you sure for register?", function (result1) {

                        if (result1 == true) {
                            $('#txtpassword').val('');
                            $('#txtfullname').val('');
                            $('#drpgender').val('0');
                            $('#txtdob').val('');
                            $('#txtbloodgrp').val('0');
                            $('#drpcountry').val('0');
                            $('#txtpob').val('');
                            $('#txtnationality').val('');
                            $('#txtadd').val('');
                            $('#txtperadd').val('');
                            $('#txtmobileno').val('');
                            $('#txtemail').val('');
                            $('#txtaltemail').val('');
                            $('#txtresidentno').val('');
                            $('#txtacadamic').val('');
                            $('#txtyearofenro').val('');
                            $('#txtyop').val('');
                            $('#txtnou').val('');
                            $('#txtnod').val('');
                            $('#txtprof_exp').val('');
                            $('#txtaddofuni').val('');
                            $('#txtmarks').val('');
                            $('#txthere').val('');

                            register();
                        }
                    });
                }
                else {
                    alert(dta.d);
                }





                return false;

            },
            error: function (data) {
                alert(data.d);
                return false;
            }
        });
        return false;

    });






});

function register() {

    //window.location.href = "<%= Page.ResolveClientUrl("/Login.aspx") %>";
    debugger;
    window.location.href = "Login.aspx";
    return false;
}