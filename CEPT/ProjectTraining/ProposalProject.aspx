<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="ProposalProject.aspx.cs" Inherits="ProjectTraining_ProjectTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Project Proposal</span></strong>
            </div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div style="" class="form-group col-md-12">
                        <table width="100%">
                            <tbody>
                                <tr>
                                    <span style="color: red">All Asterisk (*) fields Are Compulsory</span>
                                    <td class="td1">1.
                                    </td>
                                    <td class="setPadding">Code No.
                                    </td>
                                    <td style="width: 65px;">
                                        <input class="col-xs-10" type="text" id="txt_user_id" disabled="disabled" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">2.
                                    </td>
                                    <td class="setPadding">Name Of Student
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" id="txt_name_student" disabled="disabled" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">3.
                                    </td>
                                    <td class="setPadding">Name of project site<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_project_name" id="txt_project_name" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">3.a</td>
                                    <td class="setPadding">project Category<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth select1"></td>
                                </tr>

                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding"></td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_project_other_catagory" id="txt_project_other_catagory" style="display: none" />
                                    </td>
                                </tr>


                                <tr>
                                    <td class="td1">4.
                                    </td>
                                    <td class="setPadding">Objective Of the project<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_project_objective" id="txt_project_objective" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">5.
                                    </td>
                                    <td class="setPadding">Location(Google Map)
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_location" id="txt_location" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">6.
                                    </td>
                                    <td class="setPadding">Owner/client company<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_owner_name" id="txt_owner_name" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">7.
                                    </td>
                                    <td class="setPadding">Principal Consultant/Architect <span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_principle_consultant" id="txt_principle_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">7.a</td>
                                    <td class="setPadding">Structural Consultant <span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_consultant" id="txt_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">7.b</td>
                                    <td class="setPadding">Project Management Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_proj_mgmt_con" id="txt_proj_mgmt_con" />
                                    </td>
                                </tr>

                                <tr>
                                    <td class="td1">7.c</td>
                                    <td class="setPadding">MEP Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_map_consultant" id="txt_map_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">7.d</td>
                                    <td class="setPadding">Proof Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_proof_consultant" id="txt_proof_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">7.e</td>
                                    <td class="setPadding">Traffic Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_traffic_consultant" id="txt_traffic_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">8.
                                    </td>
                                    <td class="setPadding">Contractor<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_contractor" id="txt_contractor" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">8.a</td>
                                    <td class="setPadding">Sub Subcontractors<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_main_sub_contractor" id="txt_main_sub_contractor" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">9.
                                    </td>
                                    <td class="setPadding">Scope of work<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_scope" id="txt_scope" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">10.
                                    </td>
                                    <td class="setPadding">Cost Of work package(Rs. Cr.)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_cost" id="txt_cost" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">11.
                                    </td>
                                    <td class="setPadding">Physical aspects of project<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_physical_aspects" id="txt_physical_aspects" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">12.
                                    </td>
                                    <td class="setPadding">Date Of Starting of project<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_project_start_date" id="txt_project_start_date" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">13.
                                    </td>
                                    <td class="setPadding">Date of completion of project(as per contract)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_date_of_completion" id="txt_date_of_completion" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">14.
                                    </td>
                                    <td class="setPadding">Current status of project<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_current_status_project" id="txt_current_status_project" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">15.
                                    </td>
                                    <td class="setPadding">Date of completion of project(as per current status)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_date_of_completion_as_per_status" id="txt_date_of_completion_as_per_status" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">16.
                                    </td>
                                    <td class="setPadding">Probable project activities during your training period<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_probable_project_activity" id="txt_probable_project_activity" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">17.
                                    </td>
                                    <td class="setPadding">Did You Consult any of the (6),(7),(8), for your participation ?<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <%--  <input type="text" name="txt_consult" id="txt_consult" />--%>
                                        <div class='col-sm-1'>
                                            Yes
                                            <input type="radio" class='radio' id='radio_yes' name="state" value="Y" />
                                        </div>
                                        <div class='col-sm-1'>No<input type="radio" class='radio' id='radio_no' name="state" value="N" checked="checked" /></div>



                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">18.
                                    </td>
                                    <td class="setPadding">If yes,state response as gathered by you:<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input class="col-xs-10" type="text" name="txt_state_response" id="txt_state_response" />

                                    </td>
                                </tr>



                                <tr>
                                    <td class="td1">19</td>
                                    <td class="setPadding">Confirmation Email or Letter</td>
                                    <td class="setWidth">
                                        <div class='col-sm-1'>email<input type="radio" class='' id='radio_email' name="Confirmation" value="email" /></div>
                                        <div class='col-sm-1'>Letter<input type="radio" class='' id='radio_letter' name="Confirmation" value="Letter" checked="checked" /></div>

                                        <label class="btn btn-primary file-upload btn_hide  " style="vertical-align: bottom; width: 100px">
                                            <span><strong>Upload Files</strong></span>

                                            <div class="col-xs-2">
                                                <input type="file" name="file_upload" id="file_upload" onchange="javascript:return UploadProfilePhoto();" style="display: none;" />
                                            </div>
                                        </label>
                                        <%--<span style="color:red">Please only upload the confirmation letter,<br/><span style="margin-left: 45%;">which you have received from the client/contractor.</span><span style="    margin-left: 45%;"> This upload is not compulsory.</span></span>
                                           <span id="upload_span"><strong id="upload_result"></strong></span> --%>

                                        <span style="color: red">
                                            <div>
                                                <div class="col-xs-5"></div>
                                                <div class="col-xs-4">
                                                    Please only upload the confirmation letter,which you have received from the client/contractor.This upload is not compulsory.
                                                </div>
                                                <div class="col-xs-4"><a id='download_link' class="fancybox radio_hide" download="" rel="group" href="">Download</a> </div>
                                            </div>
                                        </span>

                                    </td>
                                </tr>

                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding"></td>
                                    <td class="setWidth"></td>
                                </tr>

                                <tr>
                                    <td class="td1">20</td>
                                    <td class="setPadding">Project Training Taken To Be Under<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth ">
                                        <select class="col-xs-10" name="project_training_under" id="txt_project_training_under">
                                            <option value="">Select</option>
                                            <option value="Client">Client</option>
                                            <option value="Consultant">Consultant</option>
                                            <option value="contractors">Contractors</option>

                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">21.
                                    </td>
                                    <td class="setPadding">Has Other Student In Past Availed Taining<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <div class='col-sm-1'>
                                            Yes<input type="radio" class='radio' id='radio_train' name="trained" value="Y" />
                                        </div>
                                        <div class='col-sm-1'>No<input type="radio" class='radio' id='radio_train_1' name="trained" value="N" checked="checked" /></div>
                                    </td>
                                </tr>


                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding"></td>
                                    <td class="setWidth">
                                        <div class='col-xs-12 training'>
                                            <input type="text" class="col-xs-10" placeholder="Name Of Student" disabled="disabled" id="train_stud_name" />
                                            <input type="text" class="col-xs-10" placeholder="activity" disabled="disabled" id="train_stud_activity" />
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding"></td>
                                    <td class="setWidth savebtn">
                                        <div class="save_submit">
                                            <div class="col-xs-1">
                                                <input type="button" class=" btn_rad btn_hide " id="save" value="save" />
                                            </div>
                                            <input type="button" style="display: none" class=" btn_rad btn_hide " id="save_upload" value="save" />
                                        </div>
                                        <div class="col-xs-1">
                                            <input type="button" style="margin-left: 20px;" class="btn_rad btn_hide" id="submit" value="Submit" />
                                        </div>

                                        <div class="col-xs-1">
                                            <input type="button" style="margin-left: 20px;" class="btn_rad" id="print_proposal" value="Print" />
                                        </div>
                                        <br />
                                        <br />

                                    </td>
                                    <td class="accept_reject">
                                        <br />
                                        <div class="col-xs-1 accept">
                                            <input type="button" id="accept" value="Accept" />
                                        </div>
                                        <div class="col-xs-1 reject">
                                            <input type="button" id="reject" value="Reject" />
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="display: none;">
        <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="print_proposal" />
    </div>
    </div>
    <style>
        .setPadding {
            width: 25px;
        }

        .setWidth {
            width: 65px;
        }

        .td1 {
            width: 3%;
        }

        .btn_rad {
            border-radius: 6px;
        }
    </style>
    <script type="text/javascript">
        var myObject = new Object();
        var Obj_project_catagory = new Object();
        var data = "";
        var obj;
        var upload_file_name;
        var str1 = '';


        //ready start
        $(document).ready(function () {

            var user = getQueryStringValue('user_id');

            function getQueryStringValue(key) {
                return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
            }

            if (user == "") {
                $('#txt_user_id').val('<%= Session["UserId"] %>');
                $('#txt_name_student').val('<%= Session["UserName"] %>');
                $('.accept_reject').css('display', 'none');
            }
            else {
                $('.savebtn').css('display', 'none');
            }



            $('#txt_project_start_date,#txt_date_of_completion,#txt_date_of_completion_as_per_status').datepicker({
                dateFormat: "dd/mm/yy"
            });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_project_catagory",
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d != "") {
                        Obj_project_catagory = JSON.parse(result.d);
                        str1 += "<select class='select col-xs-10' name='project_Category' id='project_Category'  ><option value=''>Select</option>"
                        for (var i = 0; i < Obj_project_catagory.length; i++) {
                            str1 += "<option value='" + Obj_project_catagory[i]['code'] + "'>" + Obj_project_catagory[i]['name'] + "</option>";
                        }
                        str1 += "</select>"
                    }
                    $('.select1').append(str1);
                },
                error: function (error) {
                    ////console.log(error);
                }

            });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_praposal_data",
                data: '{user_id : "' + user + '"}',
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    debugger;
                    if (result.d != "") {
                        obj = JSON.parse(result.d);
                        ////console.log(obj);
                        var status = obj[0]['is_submit'];

                        if (status == "Y") {
                            $('input[type="text"], input[type="checkbox"], select').prop("disabled", true);
                            $('.btn_hide').css('display', 'none');
                            $('.save_submit').html(" ");
                        }
                        var temp = obj[0]['project_Category'];
                        if (temp == 9) {
                            $('#txt_project_other_catagory').css('display', 'block');
                            $('#txt_project_other_catagory').val(obj[0]['project_category_other']);
                        }

                        $('#txt_user_id').val(obj[0]['user_id']);
                        $('#txt_name_student').val(obj[0]['user_name']);


                        $('#txt_project_name').val(obj[0]['project_site_name']);

                        $('#project_Category option[value=' + temp + ']').attr('selected', true);

                        $('#txt_project_objective').val(obj[0]['project_objective']);
                        $('#txt_location').val(obj[0]['location']);
                        $('#txt_owner_name').val(obj[0]['client_name']);
                        $('#txt_principle_consultant').val(obj[0]['principle_consultant']);
                        $('#txt_consultant').val(obj[0]['structural_consultant']);
                        $('#txt_proj_mgmt_con').val(obj[0]['project_managment_consultant']);
                        $('#txt_map_consultant').val(obj[0]['mep_consultant']);
                        $('#txt_proof_consultant').val(obj[0]['proof_consultant']);
                        $('#txt_traffic_consultant').val(obj[0]['traffic_consultant']);
                        $('#txt_contractor').val(obj[0]['contractor']);
                        $('#txt_main_sub_contractor').val(obj[0]['main_subcontractor']);
                        $('#txt_scope').val(obj[0]['scope_work']);
                        $('#txt_cost').val(obj[0]['cost_work_pakage']);
                        $('#txt_physical_aspects').val(obj[0]['physical_aspect_project']);
                        $('#txt_project_start_date').val(obj[0]['project_start_date1']);
                        $('#txt_date_of_completion').val(obj[0]['project_complate_date_contract1']);
                        $('#txt_current_status_project').val(obj[0]['project_current_status']);
                        $('#txt_date_of_completion_as_per_status').val(obj[0]['project_complate_date_status1']);
                        $('#txt_probable_project_activity').val(obj[0]['project_activity']);
                        $('#txt_consult').val(obj[0]['consult_participation']);

                        if (obj[0]['train_stud_name'] != "" && obj[0]['train_stud_activity'] != "") {
                            $('#train_stud_name').val(obj[0]['train_stud_name']);
                            $('#train_stud_activity').val(obj[0]['train_stud_activity']);
                            $('#radio_train').attr("checked", "checked");
                        }
                        else {
                            $('#train_stud_name').prop("disabled", true);
                            $('#train_stud_activity').prop("disabled", true);
                            $('#radio_train_1').attr("checked", "checked");
                        }


                        if ((obj[0]['state_response'] != "")) {
                            $('#txt_state_response').val(obj[0]['state_response']);
                            $("#radio_yes").prop("checked", true);
                        }
                        else {
                            $("#radio_no").prop("checked", true);
                            $('#txt_state_response').prop('disabled', true);
                        }

                        //$('#txt_confirm_email').val("");

                        if (obj[0]['conform_email'] == "Letter") {
                            $("#radio_letter").attr('checked', 'checked');
                        }
                        else {
                            $("#radio_email").attr('checked', 'checked');
                        }


                        $('#txt_project_training_under').val(obj[0]['project_training_under']);

                        if (obj[0]['file_path'] != "") {
                            $('#download_link').prop('href', ("../ProjectTraining/project_proposal_upload/" + obj[0]['file_path']));
                            $("#radio3").prop("checked", true);
                            $('#download_link').css('display', 'block');
                            $('#upload_span').css('display', 'block');
                            upload_file_name = obj[0]['file_path'];
                        }
                        else {
                            $('#download_link').css('display', 'none');
                            $("#radio3").prop("checked", false);
                            upload_file_name = '';
                        }
                    }
                    else {
                        $('#txt_state_response').prop('disabled', true);
                        $('#download_link').css('display', 'none');
                        $('#upload_span').css('display', 'none');
                        $("#radio3").prop("checked", false);
                        $('.radio_hide ').css('display', 'none');
                        upload_file_name = '';
                    }
                },
                error: function (error) {
                    //////console.log(error);
                }
            });




            $.validator.addMethod("dateFormat", function (value, element) {

                return value.match(/^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/);
            }, "Please enter a date in the format dd/mm/yyyy.");


            $('#aspnetForm').validate({
                rules:
                {
                    project_Category:
                    {
                        required: true
                    },
                    txt_project_name:
                    {
                        required: true
                    },

                    txt_project_objective:
                    {
                        required: true
                    },


                    txt_owner_name:
                    {
                        required: true
                    },

                    txt_principle_consultant:
                    {
                        required: true
                    },
                    txt_consultant:
                    {
                        required: true
                    },
                    //txt_proj_mgmt_con:
                    //{
                    //    required: true
                    //},
                    //txt_map_consultant:
                    //{
                    //    required: true
                    //},

                    //txt_map_consultant:
                    //{
                    //    required: true
                    //},
                    //txt_proof_consultant:
                    //{
                    //    required: true
                    //},
                    //txt_traffic_consultant:
                    //{
                    //    required: true
                    //},
                    txt_contractor:
                    {
                        required: true
                    },
                    txt_main_sub_contractor:
                    {
                        required: true
                    },
                    txt_scope:
                    {
                        required: true
                    },
                    txt_cost:
                    {
                        required: true,
                        digits: true
                    },

                    txt_physical_aspects:
                    {
                        required: true
                    },

                    txt_project_start_date:
                    {
                        required: true
                    },
                    txt_project_start_date:
                    {
                        required: true
                    }
                    ,
                    txt_date_of_completion:
                    {
                        required: true

                    },
                    txt_current_status_project:
                    {
                        required: true
                    },
                    txt_date_of_completion_as_per_status:
                    {
                        required: true
                    },
                    txt_probable_project_activity:
                    {
                        required: true
                    },
                    txt_consult:
                    {
                        required: true
                    }
                    ,
                    txt_state_response:
                    {
                        required: true
                    }
                       ,

                    project_training_under:
                    {

                        required: true
                    }

                },
                messages:
                {

                    project_training_under:
                            {
                                required: "Please Select Project Training Taken To Be Under"
                            },
                    project_Category:
                           {
                               required: "Please Select Project Category"
                           },
                    txt_project_name:
                  {
                      required: "Please Enter Project Name"
                  },
                    txt_project_objective:
                    {
                        required: "Please Enter Objective Of the project"
                    },

                    txt_owner_name:
                    {
                        required: "Please Enter Owner/client company"
                    },
                    txt_principle_consultant:
                    {
                        required: "Please Enter Principle Consultant"
                    },
                    txt_consultant:
                    {
                        required: "Please Enter Structural Consultant"
                    },
                    //txt_proj_mgmt_con:
                    //{
                    //    required: "Please Enter	Project Management Consultant"
                    //},
                    //txt_map_consultant:
                    //{
                    //    required: "Please Enter	MEP Consultant"
                    //},
                    //txt_proof_consultant:
                    //{
                    //    required: "Please Enter	Proof Consultant"
                    //},
                    //txt_traffic_consultant:
                    //{
                    //    required: "Please Enter	Traffic Consultant"
                    //},
                    txt_contractor:
                    {
                        required: "Please Enter	Consultant"
                    },

                    txt_main_sub_contractor:
                    {
                        required: "Please Enter	Main Subcontractors"
                    },
                    txt_scope:
                    {
                        required: "Please Enter Scope of work"
                    },
                    txt_cost:
                    {
                        required: "Please Enter Cost Of work package"
                    },
                    txt_physical_aspects:
                    {
                        required: "Please Enter Physical aspects of project"
                    },
                    txt_project_start_date:
                    {
                        required: "Please Enter Date Of Starting of project"
                    },
                    txt_date_of_completion:
                    {
                        required: "Please Enter Date of completion of project"
                    },
                    txt_current_status_project: { required: "Please Enter Current status of project" },
                    txt_date_of_completion_as_per_status: { required: "Please Enter Date of completion" },
                    txt_probable_project_activity: { required: "Please Enter project activities" },
                    txt_consult: { required: "Please Consult " },
                    txt_state_response: { required: "Please Enter Response " },

                }
            });

            $('#print_proposal').click(function () {

                $('#hdn_download').click();
            });

            $('#save').on('click', function () {
                var result = $('#aspnetForm').valid();
                if (result == true) {
                    myObject.userId = $('#txt_user_id').val();
                    myObject.project_category_other = "";
                    if ($('#project_Category').val() == '9') {
                        if ($('#txt_project_other_catagory').val() != "") {
                            myObject.project_category_other = $('#txt_project_other_catagory').val();
                        }
                    }
                    myObject.project_category = $('#project_Category :selected').val();
                    myObject.stud_name = $('#txt_name_student').val();
                    myObject.project_site_name = $('#txt_project_name').val();
                    myObject.project_objective = $('#txt_project_objective').val();
                    myObject.locatiion = $('#txt_location').val();
                    myObject.company_name = $('#txt_owner_name').val();
                    myObject.principle_consultant = $('#txt_principle_consultant').val();
                    myObject.consultant = $('#txt_consultant').val();
                    myObject.proj_mgmt_consultant = $('#txt_proj_mgmt_con').val();
                    myObject.map_consultant = $('#txt_map_consultant').val();
                    myObject.proof_consultant = $('#txt_proof_consultant').val();
                    myObject.traffic_consultant = $('#txt_traffic_consultant').val();
                    myObject.contractor = $('#txt_contractor').val();
                    myObject.sub_contractor = $('#txt_main_sub_contractor').val();
                    myObject.scope = $('#txt_scope').val();
                    myObject.cost = $('#txt_cost').val();
                    myObject.physical_aspects = $('#txt_physical_aspects').val();
                    myObject.project_start_date = $('#txt_project_start_date').val();
                    myObject.project_completion_date = $('#txt_date_of_completion').val();
                    myObject.project_current_status = $('#txt_current_status_project').val();
                    myObject.project_completion_date_asPerStatus = $('#txt_date_of_completion_as_per_status').val();
                    myObject.project_activity = $('#txt_probable_project_activity').val();
                    myObject.consult_participation = $('input:radio[name=state]:checked').val();
                    myObject.state_response = $('#txt_state_response').val();
                    myObject.train_stud_name = $('#train_stud_name').val();
                    myObject.train_stud_activity = $('#train_stud_activity').val();


                    myObject.is_submit = "N";

                    var temp = $('#radio_email').is(':checked');
                    if (temp == true) {
                        myObject.confirm_email = $('#radio_email').val();
                    }
                    else {
                        myObject.confirm_email = $('#radio_letter').val();
                    }

                    // myObject.confirm_email = $('#txt_confirm_email').val();

                    myObject.project_training_under = $('#txt_project_training_under :selected').val();


                    if (upload_file_name != undefined) {
                        myObject.file_path = upload_file_name;
                    }
                    else {
                        myObject.file_path = "";
                    }

                    //////console.log(upload_file_name);

                    data = JSON.stringify({ "data": myObject });

                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/project_praposal",
                        data: data,
                        dataType: 'json',
                        contentType: "application/json",
                        success: function (result) {
                            bootbox.alert(result.d);
                        },
                        error: function (error) {
                            //////console.log(error);
                        }

                    });
                }
            });


        });



        $('#submit').on('click', function () {
            var result = $('#aspnetForm').valid();
            if (result == true) {


                myObject.project_category_other = "";

                if ($('#project_Category').val() == '9') {
                    if ($('#txt_project_other_catagory').val() != "") {
                        myObject.project_category_other = $('#txt_project_other_catagory').val();
                    }
                }

                myObject.userId = $('#txt_user_id').val();
                myObject.project_category = $('#project_Category :selected').val();
                myObject.stud_name = $('#txt_name_student').val();
                myObject.project_site_name = $('#txt_project_name').val();
                myObject.project_objective = $('#txt_project_objective').val();
                myObject.locatiion = $('#txt_location').val();
                myObject.company_name = $('#txt_owner_name').val();
                myObject.principle_consultant = $('#txt_principle_consultant').val();
                myObject.consultant = $('#txt_consultant').val();
                myObject.proj_mgmt_consultant = $('#txt_proj_mgmt_con').val();
                myObject.map_consultant = $('#txt_map_consultant').val();
                myObject.proof_consultant = $('#txt_proof_consultant').val();
                myObject.traffic_consultant = $('#txt_traffic_consultant').val();
                myObject.contractor = $('#txt_contractor').val();
                myObject.sub_contractor = $('#txt_main_sub_contractor').val();
                myObject.scope = $('#txt_scope').val();
                myObject.cost = $('#txt_cost').val();
                myObject.physical_aspects = $('#txt_physical_aspects').val();
                myObject.project_start_date = $('#txt_project_start_date').val();
                myObject.project_completion_date = $('#txt_date_of_completion').val();
                myObject.project_current_status = $('#txt_current_status_project').val();
                myObject.project_completion_date_asPerStatus = $('#txt_date_of_completion_as_per_status').val();
                myObject.project_activity = $('#txt_probable_project_activity').val();
                myObject.consult_participation = $('input:radio[name=state]:checked').val();
                myObject.state_response = $('#txt_state_response').val();
                myObject.train_stud_name = $('#train_stud_name').val();
                myObject.train_stud_activity = $('#train_stud_activity').val();
                myObject.is_submit = "Y";
                myObject.project_training_under = $('#txt_project_training_under :selected').val();

                var temp = $('#radio_email').is(':checked');
                if (temp == true) {
                    myObject.confirm_email = $('#radio_email').val();
                }
                else {
                    myObject.confirm_email = $('#radio_letter').val();
                }



                if (upload_file_name != undefined) {
                    myObject.file_path = upload_file_name;
                }
                else {
                    myObject.file_path = "";
                }
                data = JSON.stringify({ "data": myObject });
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/project_praposal",
                    data: data,
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (result) {

                        bootbox.alert(result.d, function () {
                            window.location.reload();
                        });
                    },
                    error: function (error) {
                        //////console.log(error);
                    }
                });
            }
        });


        $('#save_upload').on('click', function () {

            myObject.userId = $('#txt_user_id').val();
            myObject.project_category_other = "";
            if ($('#project_Category').val() == '9') {
                if ($('#txt_project_other_catagory').val() != "") {
                    myObject.project_category_other = $('#txt_project_other_catagory').val();
                }
            }
            myObject.project_category = $('#project_Category :selected').val();
            myObject.stud_name = $('#txt_name_student').val();
            myObject.project_site_name = $('#txt_project_name').val();
            myObject.project_objective = $('#txt_project_objective').val();
            myObject.locatiion = $('#txt_location').val();
            myObject.company_name = $('#txt_owner_name').val();
            myObject.principle_consultant = $('#txt_principle_consultant').val();
            myObject.consultant = $('#txt_consultant').val();
            myObject.proj_mgmt_consultant = $('#txt_proj_mgmt_con').val();
            myObject.map_consultant = $('#txt_map_consultant').val();
            myObject.proof_consultant = $('#txt_proof_consultant').val();
            myObject.traffic_consultant = $('#txt_traffic_consultant').val();
            myObject.contractor = $('#txt_contractor').val();
            myObject.sub_contractor = $('#txt_main_sub_contractor').val();
            myObject.scope = $('#txt_scope').val();
            myObject.cost = $('#txt_cost').val();
            myObject.physical_aspects = $('#txt_physical_aspects').val();
            myObject.project_start_date = $('#txt_project_start_date').val();
            myObject.project_completion_date = $('#txt_date_of_completion').val();
            myObject.project_current_status = $('#txt_current_status_project').val();
            myObject.project_completion_date_asPerStatus = $('#txt_date_of_completion_as_per_status').val();
            myObject.project_activity = $('#txt_probable_project_activity').val();
            myObject.consult_participation = $('input:radio[name=state]:checked').val();
            myObject.state_response = $('#txt_state_response').val();
            myObject.train_stud_name = $('#train_stud_name').val();
            myObject.train_stud_activity = $('#train_stud_activity').val();


            myObject.is_submit = "N";

            var temp = $('#radio_email').is(':checked');
            if (temp == true) {
                myObject.confirm_email = $('#radio_email').val();
            }
            else {
                myObject.confirm_email = $('#radio_letter').val();
            }

            // myObject.confirm_email = $('#txt_confirm_email').val();

            myObject.project_training_under = $('#txt_project_training_under :selected').val();


            if (upload_file_name != undefined) {
                myObject.file_path = upload_file_name;
            }
            else {
                myObject.file_path = "";
            }

            //////console.log(upload_file_name);

            data = JSON.stringify({ "data": myObject });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/project_praposal",
                data: data,
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    bootbox.alert(result.d);
                },
                error: function (error) {
                    //////console.log(error);
                }

            });

        });

        $('input:radio').change(
                        function () {
                            if (document.getElementById('radio_no').checked == true) {
                                $('#txt_state_response').prop('disabled', true);
                                $('#txt_state_response').val("");
                            }
                            else {
                                $('#txt_state_response').prop('disabled', false);
                            }
                        }
                    );



        $('input:radio').change(

                        function () {

                            if (document.getElementById('radio_train').checked == false) {
                                $('#train_stud_name').prop("disabled", true);
                                $('#train_stud_activity').prop("disabled", true);
                                $('#train_stud_name').val('');
                                $('#train_stud_activity').val('');
                            }
                            else {
                                $('#train_stud_name').prop("disabled", false);
                                $('#train_stud_activity').prop("disabled", false);
                            }
                        }
                    );



        $(document).on('change', '#project_Category', function () {

            var other_clm = $('#project_Category').val();

            if (other_clm == 9) {
                $('#txt_project_other_catagory').css('display', 'block');
            }
            else {
                $('#txt_project_other_catagory').css('display', 'none');
            }

        });


        function UploadProfilePhoto() {
            upload_file_name = '';
            try {

                var fileToUpload = GetFileNameFromPath($('#file_upload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../Handler/proposal.ashx',
                                secureuri: false,
                                fileElementId: 'file_upload',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#file_upload').val("");

                                            FileName = data.upfile;
                                            upload_file_name = FileName;
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                    $('#save_upload').click();
                                    $('#upload_result').text('file uploaded successfully.');
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
                    alert('Invalid File Type. Please upload pdf,png or jpeg file');
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

        $('#accept').click(function () {
            if (obj[0]['is_approved'] != "Y") {

                var userid = $('#txt_user_id').val();
                var flag = "A";
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/accept_reject_proposal",
                    data: '{user_id : "' + userid + '",flag : "' + flag + '"}',
                    dataType: 'json',
                    contentType: "application/json",
                    async: false,
                    success: function (result) {
                        if (result.d != "") {
                            bootbox.alert(result.d, function () {
                                window.location.href = "proposal_accept.aspx";
                            });
                        }
                    },
                    error: function (error) {
                        //////console.log(error);
                    }

                });

            }
            else {
                bootbox.alert("You can not Accept. Proposal is already Accepted")

            }

        });
        $('#reject').click(function () {
            if (obj[0]['is_approved'] != "Y") {

                var userid = $('#txt_user_id').val();
                var flag = "R";
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/accept_reject_proposal",
                    data: '{user_id : "' + userid + '",flag : "' + flag + '"}',
                    dataType: 'json',
                    contentType: "application/json",
                    async: false,
                    success: function (result) {
                        if (result.d != "") {
                            bootbox.alert(result.d, function () {
                                window.location.href = "proposal_accept.aspx";
                            });
                        }
                    },
                    error: function (error) {
                        ////console.log(error);
                    }

                });

            }
            else {
                bootbox.alert("You can not Reject. Proposal is already Accepted")

            }
        });
    </script>
</asp:Content>
