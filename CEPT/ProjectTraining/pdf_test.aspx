<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="pdf_test.aspx.cs" Inherits="ProjectTraining_ProjectTraining" %>

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
                                    <td class="td1">1.
                                    </td>
                                    <td class="setPadding">Code No.
                                    </td>
                                    <td style="width: 65px;">
                                        <input type="text" id="txt_user_id" disabled="disabled" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">2.
                                    </td>
                                    <td class="setPadding">Name Of Student
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" id="txt_name_student" disabled="disabled" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">3.
                                    </td>
                                    <td class="setPadding">Name of project site
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_project_name" id="txt_project_name" />

                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">project Category
                                    </td>
                                    <td class="setWidth">
                                        <select name="project_name">
                                            <option value="a">select Project category</option>
                                            <option value="a">Metro</option>
                                            <option value="b">residential and commercial building</option>
                                            <option value="c">power project</option>
                                            <option value="d">highway and railway</option>
                                            <option value="d">Other</option>
                                        </select>

                                    </td>
                                </tr>


                                <tr>
                                    <td class="td1">4.
                                    </td>
                                    <td class="setPadding">Objective Of the project
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_project_objective" id="txt_project_objective" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">5.
                                    </td>
                                    <td class="setPadding">Location
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_location" id="txt_location" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">6.
                                    </td>
                                    <td class="setPadding">Owner/client company
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_owner_name" id="txt_owner_name" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">7.
                                    </td>
                                    <td class="setPadding">Principle Consultant/Architect *
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_principle_consultant" id="txt_principle_consultant" />
                                    </td>
                                </tr>
                                <%--  <tr>
                                    <td class="td1">
                                    </td>
                                    <td class="setPadding">
                                        Architect
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_architech" id="txt_architech" />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">Structural Consultant *
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_consultant" id="txt_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">Project Management Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_proj_mgmt_con" id="txt_proj_mgmt_con" />
                                    </td>
                                </tr>
                                <%--  <tr>
                                    <td class="td1">
                                    </td>
                                    <td class="setPadding">
                                        Project Management Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_project_management_consultant" id="txt_project_management_consultant" />
                                    </td>
                                </tr>--%>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">MEP Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_map_consultant" id="txt_map_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">Proof Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_proof_consultant" id="txt_proof_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">Traffic Consultant
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_traffic_consultant" id="txt_traffic_consultant" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">8.
                                    </td>
                                    <td class="setPadding">Contractor
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_contractor" id="txt_contractor" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">Main Subcontractors
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_main_sub_contractor" id="txt_main_sub_contractor" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">9.
                                    </td>
                                    <td class="setPadding">Scope of work
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_scope" id="txt_scope" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">10.
                                    </td>
                                    <td class="setPadding">Cost Of work package(Rs. Cr.)
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_cost" id="txt_cost" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">11.
                                    </td>
                                    <td class="setPadding">Physical aspects of project
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_physical_aspects" id="txt_physical_aspects" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">12.
                                    </td>
                                    <td class="setPadding">Date Of Starting of project
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_project_start_date" id="txt_project_start_date" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">13.
                                    </td>
                                    <td class="setPadding">Date of completion of project(as per contract)
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_date_of_completion" id="txt_date_of_completion" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">14.
                                    </td>
                                    <td class="setPadding">Current status of project
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_current_status_project" id="txt_current_status_project" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">15.
                                    </td>
                                    <td class="setPadding">Date of completion of project(as per current status)
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_date_of_completion_as_per_status" id="txt_date_of_completion_as_per_status" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">16.
                                    </td>
                                    <td class="setPadding">Probable project activities during your training period
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_probable_project_activity" id="txt_probable_project_activity" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">17.
                                    </td>
                                    <td class="setPadding">Did You Consult any of the (6),(7),(8), for your participation ?
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
                                    <td class="setPadding">If yes,state response as gathered by you:
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_state_response" id="txt_state_response" />

                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">19.
                                    </td>
                                    <td class="setPadding">Confirmation Email or Letter
                                    </td>
                                    <td class="setWidth">
                                        <input type="text" name="txt_confirm_email" id="txt_confirm_email" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">20.
                                    </td>
                                    <td class="setPadding">Has Other Student In Past Availed Taining
                                    </td>
                                    <td class="setWidth">
                                        <div class='col-sm-1'>
                                            Yes
                                            <input type="radio" class='radio' id='radio3' name="trained" value="Y" />
                                        </div>
                                        <div class='col-sm-1'>No<input type="radio" class='radio' id='radio4' name="trained" value="N" checked="checked" /></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">
                                        <%-- <input type="button" class="" id="clear" value="clear" />--%>
                                    </td>
                                    <td class="setWidth savebtn">
                                        <input type="button" class=" btn_rad" id="save"
                                            value="save" />
                                        <input type="button" style="margin-left: 20px;" class="btn_rad"
                                            id="submit" value="Submit" />

                                         <input type="button" style="margin-left: 20px;" class="btn_rad" 
                                            id="print_proposal" value="Print" />





                                        <br /><br />
                                      
                                         <label class="btn btn-primary file-upload " style="vertical-align: bottom;"><span><strong>Upload Files</strong></span>
                                        <input type="file" name="file_upload" id="file_upload" onchange="javascript:return UploadProfilePhoto();"style="display: none;"></label>
                                            <span><strong id="upload_result"></strong><span></span>
                                            <a id='download_link' class="fancybox" download="" rel="group" href="">Download</a>

                                    </td>
                                </tr>
                            </tbody>
                        </table>
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
        var data = "";
        var obj;
        var upload_file_name='';
        $(document).ready(function () {

            $('#txt_user_id').val('<%= Session["UserId"] %>');
            $('#txt_name_student').val('<%= Session["UserName"] %>');
            $('#txt_project_start_date,#txt_date_of_completion,#txt_date_of_completion_as_per_status').datepicker({
                dateFormat: "dd/mm/yy"
            });
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_praposal_data",
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    if (result.d != "") {
                        obj = JSON.parse(result.d);
                        var status = obj[0]['is_submit'];
                        if (status == "Y") {
                            //$('#submit').prop('disabled', 'disabled');
                            //$('#save').prop('disabled', 'disabled');
                        }
                        $('#txt_project_name').val(obj[0]['project_site_name']);
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
                        $('#txt_project_start_date').val(obj[0]['project_start_date']);
                        $('#txt_date_of_completion').val(obj[0]['project_complate_date_contract']);
                        $('#txt_current_status_project').val(obj[0]['project_current_status']);
                        $('#txt_date_of_completion_as_per_status').val(obj[0]['project_complate_date_status']);
                        $('#txt_probable_project_activity').val(obj[0]['project_activity']);
                        $('#txt_consult').val(obj[0]['consult_participation']);
                        $('#txt_state_response').val(obj[0]['state_response']);
                        $('#txt_confirm_email').val(obj[0]['conform_email']);

                        if (obj[0]['file_path'] != "") {
                            $('#download_link').prop('href', ("../ProjectTraining/project_proposal_upload/" + obj[0]['file_path']));
                        }
                        else {
                            $('#download_link').css('display','none');
                        }

                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });


            if (document.getElementById('radio_no').checked == true) {
                $('#txt_state_response').prop('disabled', true);
            }


            $('#').validate({
                rules:
                {
                    txt_project_name:
                    {
                        required: true
                    },

                    txt_project_objective:
                    {
                        required: true
                    },

                    txt_location:
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
                    txt_proj_mgmt_con:
                    {
                        required: true
                    },
                    txt_map_consultant:
                    {
                        required: true
                    },

                    txt_map_consultant:
                    {
                        required: true
                    },
                    txt_proof_consultant:
                    {
                        required: true
                    },
                    txt_traffic_consultant:
                    {
                        required: true
                    },
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
                        required: true
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
                    txt_confirm_email:
                    {
                        email: true,
                        required: true
                    }
                },
                messages:
                {
                    txt_project_name:
                    {
                        required: "Please Enter Project Name"
                    },
                    txt_project_objective:
                    {
                        required: "Please Enter Objective Of the project"
                    },
                    txt_location:
                    {
                        required: "Please Enter Location"
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
                    txt_proj_mgmt_con:
                    {
                        required: "Please Enter	Project Management Consultant"
                    },
                    txt_map_consultant:
                    {
                        required: "Please Enter	MEP Consultant"
                    },
                    txt_proof_consultant:
                    {
                        required: "Please Enter	Proof Consultant"
                    },
                    txt_traffic_consultant:
                    {
                        required: "Please Enter	Traffic Consultant"
                    },
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
                    txt_confirm_email: { required: "Please Enter Email " }
                }
            });

            $('#print_proposal').click(function () {

                $('#hdn_download').click();
            });

            $('#save').on('click', function () {
                var result = $('#aspnetForm').valid();
                //                if (result == true) { 

                myObject.userId = $('#txt_user_id').val();
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

                myObject.is_submit = "Y";
                myObject.confirm_email = $('#txt_confirm_email').val();

               
                    myObject.file_path = upload_file_name;
              
                console.log(result);
                console.log(myObject);



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
                        console.log(error);
                    }

                });
                //                }
            });
        });


        $('input:radio').change(
                        function () {
                            if (document.getElementById('radio_no').checked == true) {
                                $('#txt_state_response').prop('disabled', true);
                            }
                            else {
                                $('#txt_state_response').prop('disabled', false);
                            }
                        }
                    );



        function UploadProfilePhoto() {
            upload_file_name = '';
            try {
                debugger;
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

                                    $('#upload_result').text('file upload successfully.');
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

    

    </script>
</asp:Content>
