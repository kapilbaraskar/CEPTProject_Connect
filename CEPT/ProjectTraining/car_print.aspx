<%@ Page Language="C#" AutoEventWireup="true" CodeFile="car_print.aspx.cs" Inherits="ProjectTraining_car_print" %>
<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script src="../DesignJS/jquery.min.js" type="text/javascript"></script>
</head>
    <body>
        <div style="top: 20px; height: 96px; left: 1px;" title="" id="i22byht1">
        <a style="width: 297px; height: 96px; cursor: pointer;float:right;" href="../Master/Home.aspx" id="i22byht1link">
            <div id="i22byht1img" style="width: 297px; height: 96px; position: relative;">
            <img alt="" style="width: 297px; height: 96px; object-fit: cover;" src="../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage"></div>
        </a>
    </div>

    <form id="form1" runat="server">

        <div class="well" style="background-color: White;    margin-left: 68px;">
           <span style="font-size:x-large"><center>Project Training | Faculty Of Technology | <span id="sem_type"></span> <span id="year" ></span> 
           
                                           </center></span> 
            <div class="panel panel-default ">
                <div class="panel-heading"><br />
                   <span  style="margin-left:52px;">Current Activity Report</span> 
                </div>
                <div style="padding: 15px;" id="div3">
                    <div class="row">
                        <div style="" class="form-group col-md-12">
                            <table id="tbl_print" width="100%" border="1" style="">
                                <tbody>
                                    <tr>
                                        <td class="td1">1.
                                        </td>
                                        <td class="setPadding">Code No.
                                        </td>
                                        <td style="width: 65px;">
                                            <span id="txt_user_id"></span>
                                        </td>
                                    </tr>
                                     
                                    <tr class="past_train">
                                        <td class="td1">.</td>
                                        <td class="setPadding">Student Activity
                                        </td>
                                        <td class="setWidth">
                                            <span id="stud_acti"></span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
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
            var upload_file_name;
            $(document).ready(function () {

                debugger;
                var obj = new Object();
                obj.UserName = getQueryStringValue('UserName');
                obj.sem_code = getQueryStringValue('sem_code');
                obj.year_code = getQueryStringValue('year_code');
                obj.user_id = getQueryStringValue('UserId');
                obj.name = getQueryStringValue('name');
                function getQueryStringValue(key) {
                    return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
                }


                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/get_project_catagory",
                    data: '{}',
                    dataType: 'json',
                    contentType: "application/json",
                    async: false,
                    success: function (result) {
                        if (result.d != "") {
                            debugger;
                            Obj_project_catagory = JSON.parse(result.d);
                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });






                data = JSON.stringify(obj);
                $.ajax({
                    type: "POST",
                    //url: "../WebService.asmx/Get_praposal_data_pdf",
                    url: "../WebService.asmx/Get_praposal_data_for_pdf",
                    data: data,
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (result) {
                        debugger;
                        if (result.d != "") {
                            obj = JSON.parse(result.d);
                            console.log(obj);
                            $('#txt_name_student').text(obj[0]['user_name']);
                            $('#txt_user_id').text(obj[0]['user_id']);
                            $('#txt_project_name').text(obj[0]['project_site_name']);
                            $('#project_name').text(obj[0]['name'] + " /" + obj[0]['project_category_other']);
                            $('#txt_project_objective').text(obj[0]['project_objective']);
                            $('#txt_location').text(obj[0]['location']);
                            $('#txt_owner_name').text(obj[0]['client_name']);
                            $('#txt_principle_consultant').text(obj[0]['principle_consultant']);
                            $('#txt_consultant').text(obj[0]['structural_consultant']);
                            $('#txt_proj_mgmt_con').text(obj[0]['project_managment_consultant']);
                            $('#txt_map_consultant').text(obj[0]['mep_consultant']);
                            $('#txt_proof_consultant').text(obj[0]['proof_consultant']);
                            $('#txt_traffic_consultant').text(obj[0]['traffic_consultant']);
                            $('#txt_contractor').text(obj[0]['contractor']);
                            $('#txt_main_sub_contractor').text(obj[0]['main_subcontractor']);
                            $('#txt_scope').text(obj[0]['scope_work']);
                            $('#txt_cost').text(obj[0]['cost_work_pakage']);
                            $('#txt_physical_aspects').text(obj[0]['physical_aspect_project']);
                            $('#txt_project_start_date').text(obj[0]['project_start_date1']);
                            $('#txt_date_of_completion').text(obj[0]['project_complate_date_contract1']);
                            $('#txt_current_status_project').text(obj[0]['project_current_status']);
                            $('#txt_date_of_completion_as_per_status').text(obj[0]['project_complate_date_status1']);
                            $('#txt_probable_project_activity').text(obj[0]['project_activity']);
                            $('#txt_consult').text(obj[0]['consult_participation']);
                            $('#txt_state_response').text(obj[0]['state_response']);
                            $('#txt_confirm_email').text(obj[0]['conform_email']);
                            $('#train_under').text(obj[0]['project_training_under']);


                            if (obj[0]['train_stud_name'] != "") {
                                $('#radio1').text("Yes");

                                $('#stud_name').text(obj[0]['train_stud_name']);
                                $('#stud_acti').text(obj[0]['train_stud_activity']);
                            }
                            else {
                                $('.past_train').css('display', 'none');
                                $('#radio1').text("No");
                            }

                            if (obj[0]['state_response'] != "") {
                                $('#radio').text("Yes");

                            } else {
                                $('#radio').text("No");
                            }


                            if (obj[0]['semester_type'] == "M") {
                                $('#sem_type').text("Monsoon");
                            }
                            else if (obj[0]['semester_type'] == "S") {
                                $('#sem_type').text("Spring");
                            }
                            $('#year').text(obj[0]['year_semester']);



                            if (obj[0]['file_path'] != "") {
                                $('#download_link').prop('href', ("../ProjectTraining/project_proposal_upload/" + obj[0]['file_path']));
                            }
                            else {
                                $('#download_link').css('display', 'none');
                            }

                        }
                    },
                    error: function (error) {

                        console.log(error);
                    }
                });



            });










        </script>

    </form>
</body>

    <style>
        
        #tbl_print tr td {
            
        
             border-right: 1px;
              border-bottom: 1px;
               border-color:black;
        }
          #tbl_print {
             
                    border-spacing: 0;
                   border-color:black;
                   border-left: 1px;
                   border-top: 1px;
        }
         

         

    </style>
</html>
