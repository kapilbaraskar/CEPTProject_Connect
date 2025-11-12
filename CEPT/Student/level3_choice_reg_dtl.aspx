<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="level3_choice_reg_dtl.aspx.cs" Inherits="Student_level3_choice_reg_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function ()
        {
            bind_dropdown();
            Get_semester_data();
            get_user_detail();
            $('#btnsubmit').on('click', function () {
                var studio_level = '';
                var select_one = $('#drstudio_type').val();
                if (select_one == '') {
                    bootbox.alert("Please Select Option");
                    return false;
                }
                if ($('#drstudio_type').val() == '23') {
                    studio_level = 'L2';
                }
                else if ($('#drstudio_type').val() == '29') {
                    studio_level = 'L3';
                }
                else if ($('#drstudio_type').val() == '26') {
                    studio_level = 'L2';
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Check_eligibility_L2",
                    async: false,
                    data: "{studio_level:'" + studio_level + "',sub_cat_id:'" + $('#drstudio_type').val() +"'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            if (data.d == 'false')
                            {
                                alert("Not Eligible for this Semester (Please Read Instructions)")
                                return false;
                            }
                            else if (data.d == 'true')
                            {
                                alert("L3 Choice Preference Data Saved Successfully");
                                get_user_detail();
                                return false;
                            }
                            else
                            {
                                alert(data.d);
                                return false;
                            }
                        }
                        else
                        {
                            alert(data.d);
                            return false;
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

        });

        function Get_semester_data() {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_cept_current_sem_data",
                    data: "{type:'L3_Choice_Reg'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            var sem_data = JSON.parse(data.d);
                            $('#sem_year').text(sem_data[0]["sem_desc"] + ' ' + sem_data[0]["year_code"]);
                            $('#sem_year_code').text(sem_data[0]["sem_desc"] + ' ' + sem_data[0]["year_code"]);
                        }
                        else
                        {
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }


        function get_user_detail() {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_Data_choice_preference",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            var origin = window.location.origin;
                            var details = JSON.parse(data.d);
                            var statustext = '';

                            for (var i = 0; i < details.length; i++)
                            {        
                                    if (i == 0) {
                                        var str = "<tr><th>Student Code</th><th>Student Name</th><th>Applied For</th><th>L3 Choice</th><th>Status</th><th>Submitted Date</th></tr>";
                                    }

                                str += "<tr><td>" + details[i]["user_id"] + "</td><td>" + details[i]["full_name"] + "</td><td>" + details[i]["appliedfor"] + "</td><td>" + details[i]["Choice"] + "</td>";
                                str += "<td>Submitted</td>";
                                str += "<td>" + details[i]["created_date"] + "</td></tr>";
                                
                            }
                            $('#tbl_certi_dtl').html(str);

                            $('#div_certi_dtl').css('display', 'block');

                            if (details[0]['status'] == 'N' && details[0]['edit_status'] == 'N')
                            {
                                $('#btnsubmit').css('display', 'block');
                            }
                            else if (details[0]['status'] == 'Y') {
                                $('#btnsubmit').css('display', 'none');
                            }
                            




                        }
                        else {
                            //bootbox.alert('No data Found');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function bind_dropdown() {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Bind_dropdown_l3_choive",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            var details = JSON.parse(data.d);
                            $('#drstudio_type').empty().append($("<option></option>").val("").html("-- Please Select --"));
                            $('#drstudio_type').append($("<option></option>").val("23").html("Studio"));

                            for (var i = 0; i < details.length; i++)
                            {
                                if (details.length == '1')
                                {
                                    if (details[i]['sub_cat_id'] == '26') {
                                        $('#drstudio_type').append($("<option></option>").val('29').html('DRP'));
                                    }
                                    else if (details[i]['sub_cat_id'] == '29')
                                    {
                                        $('#drstudio_type').append($("<option></option>").val('26').html('Internship'));
                                    }
                                  
                                }
                                
                            }

                            $('#drstudio_type').chosen();
                        }
                        else
                        {
                            $('#drstudio_type').empty().append($("<option></option>").val("").html("-- Please Select --"));
                            $('#drstudio_type').append($("<option></option>").val("23").html("Studio"));
                            $('#drstudio_type').append($("<option></option>").val('29').html('DRP'));
                            $('#drstudio_type').append($("<option></option>").val('26').html('Internship'));
                            $('#drstudio_type').chosen();
                            //bootbox.alert('No data Found');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; L3 Choice Preference For <span id="sem_year"></span>
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <p><b> Question 1 : </b> What will be your L3 choice of selection for registration in the <span id="sem_year_code"></span> ?</p>
        <label><b>Select One :</b>   
        <select class="chosen-select" id="drstudio_type" >
            <%--<option value="">Please Select</option>
            <option value="23">Studio</option>
            <option value="29">DRP</option>
            <option value="26">Internship</option>--%>
        </select></label>  
        <div style="margin-left:45%;"> <button class="btn btn-primary" id="btnsubmit">Submit</button> </div>
                                        

        <div class="panel panel-default" id="div_certi_dtl" style="display: none;">
                <div class="panel-heading">
                    <strong>L3 Choice Preference Details</strong>
                </div>
                <div>
                    <table id="tbl_certi_dtl" class="table table-bordered">
                    </table>
                </div>
            </div>

    </div>
</asp:Content>

