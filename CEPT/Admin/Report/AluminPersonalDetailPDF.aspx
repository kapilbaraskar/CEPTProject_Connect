<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AluminPersonalDetailPDF.aspx.cs" Inherits="Admin_Report_AluminPersonalDetailPDF" %>

<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../../DesignCss/chosen.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>
    <script type="text/javascript" src="../../DesignJS/chosen.jquery.min.js"></script>

</head>
      <script type="text/javascript">
          $(document).ready(function () {

              var userid = getParameterByName('userid');
              get_alumni_personal_data(userid);

          });


          function getParameterByName(name, url) {
              if (!url) url = window.location.href;
              name = name.replace(/[\[\]]/g, "\\$&");
              var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                  results = regex.exec(url);
              if (!results) return null;
              if (!results[2]) return '';
              return decodeURIComponent(results[2].replace(/\+/g, " "));
          }


          function get_alumni_personal_data(userid) {
              $.ajax({
                  type: "POST",
                  contentType: "application/json; charset=utf-8",
                  url: "../../WebService.asmx/get_alumni_personal_data_admin_pdf",
                  async: false,
                  data: "{user_id:'" + userid + "'}",
                  dataType: "json",
                  success: function (data) {
                      if (data.d != "") {
                          var response = JSON.parse(data.d);

                          $('#txt_user_name').html(response[0].user_name);
                          $('#txt_first_name').html(response[0].first_name);
                          $('#txt_middle_name').html(response[0].middle_name);
                          $('#txt_last_name').html(response[0].last_name);
                          $('#drpprog').html(response[0].prog_level_name);
                          $('#drpyear').html(response[0].year_desc);
                          $('#txt_roll_no').html(response[0].user_id);
                          $('#txt_occupation').html(response[0].occupation);
                          $('#txt_title').html(response[0].title);
                          $('#txt_organisation').html(response[0].organisation);
                          $('#login_email').html(response[0].mail);
                          $('#hdn_login_email').val(response[0].mail);
                          $('#alternate_email').val(response[0].alternate_mail);

                          $('#txt_home_address').html(response[0].home_address);
                          $('#txt_home_city').html(response[0].home_city);
                          $('#txt_home_country').html(response[0].home_country);
                          if (response[0].home_country == "IN") {
                              $('#drp_home_state').html(response[0].home_state);
                              //$('#drp_home_state_chzn').css('display', '');
                              //$('#txt_home_state').css('display', 'none');
                          }
                          else {
                              $('#txt_home_state').html(response[0].home_state);
                          }

                          $('#txt_work_address').html(response[0].work_address);
                          $('#txt_work_city').html(response[0].work_city);
                          $('#txt_work_country').html(response[0].work_country);
                          if (response[0].work_country == "IN") {
                              $('#drp_work_state').html(response[0].work_state);
                              $('#drp_work_state_chzn').css('display', '');
                              $('#txt_work_state').css('display', 'none');
                          }
                          else {
                              $('#txt_work_state').html(response[0].work_state);
                          }

                          $('#txt_phone_no').html(response[0].phone_no);
                          $('#txt_mobile_no').html(response[0].mobile_no);

                          if (response[0].prog_level_code == 'O')
                              $('#tr_txt_other_prog').css('display', '');

                          //if (response[0].subscribe_newsletter == "Y") $('#chk_subscribe')[0].checked = true;
                          //else $('#chk_subscribe')[0].checked = false;

                          //$('#drpprog').trigger("liszt:updated");
                          //$('#drpyear').trigger("liszt:updated");
                          //$('#txt_home_country').trigger("liszt:updated");
                          //$('#txt_work_country').trigger("liszt:updated");
                          //$('#drp_home_state').trigger("liszt:updated");
                          //$('#drp_work_state').trigger("liszt:updated");
                      }
                  },
                  error: function (result) {
                      alert(result);
                  }
              });
          }


    </script>
<body class="container" style="color: Black; width: 985px;">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Personal Detail
            </h1>
        </div>
        <div>
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Personal Detail</strong>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_personal_detail1" style="width: 100%;">
                        <tr>
                            <td style="width: 20%;">First Name
                            </td>
                            <td style="width: 30%;" id="txt_first_name"></td>
                            <td style="width: 20%;">Middle Name
                            </td>
                            <td style="width: 30%;" id="txt_middle_name"></td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Last Name
                            </td>
                            <td style="width: 30%;" id="txt_last_name"></td>
                            <td style="width: 20%;">Name
                            </td>
                            <td style="width: 30%;" id="txt_user_name"></td>
                        </tr>
                        <tr>
                            <td>Year of Commencement
                            </td>
                            <td id="drpyear"></td>
                            <td>Roll No.
                            </td>
                            <td id="txt_roll_no"></td>

                        </tr>
                        <tr id="tr_txt_other_prog" style="display: none;">
                            <td></td>
                            <td></td>
                            <td></td>
                            <td id="txt_other_prog"></td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Program Title
                            </td>
                            <td style="width: 30%;" id="drpprog"></td>
                            <td>Occupation
                            </td>
                            <td id="txt_occupation"></td>

                        </tr>
                        <tr>
                            <td>Title
                            </td>
                            <td id="txt_title"></td>
                            <td>Company/Organisation
                            </td>
                            <td id="txt_organisation"></td>

                        </tr>
                    </table>
                </div>
            </div>
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Communication Preferences</strong>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_communication_preferences" style="width: 100%;">
                        <tr>
                            <td style="width: 20%;">Email Id
                            </td>
                            <td style="width: 30%;" id="login_email"></td>
                            <td style="width: 20%;">Alternate Email Id
                            </td>
                            <td style="width: 30%;" id="alternate_email"></td>
                        </tr>
                        <tr>
                            <td style="padding: 15px 0 15px 0;" colspan="4">
                                <div style="border: 1px solid #ddd;">
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>Home Address
                            </td>
                            <td colspan="3" id="txt_home_address" style="width: 86%"></td>
                        </tr>
                        <tr>
                            <td>Home City
                            </td>
                            <td id="txt_home_city"></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Home Country
                            </td>
                            <td id="txt_home_country"></td>
                            <td>Home State
                            </td>
                            <td id="txt_home_state"></td>
                        </tr>
                        <tr>
                            <td style="padding: 15px 0 15px 0;" colspan="4">
                                <div style="border: 1px solid #ddd;">
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>Work Address
                            </td>
                            <td colspan="3" id="txt_work_address"></td>
                        </tr>
                        <tr>
                            <td>Work City
                            </td>
                            <td id="txt_work_city"></td>
                            <td></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Work Country
                            </td>
                            <td id="txt_work_country"></td>
                            <td>Work State
                            </td>
                            <td id="txt_work_state"></td>
                        </tr>
                        <tr>
                            <td style="padding: 15px 0 15px 0;" colspan="4">
                                <div style="border: 1px solid #ddd;">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>Phone No
                            </td>
                            <td id="txt_phone_no"></td>
                            <td>Mobile No
                            </td>
                            <td id="txt_mobile_no"></td>
                        </tr>
                        <tr>
                            <td style="padding-top: 10px; display: none;" colspan="4">
                                <input type="checkbox" id="chk_subscribe" />&nbsp;&nbsp;I would like to subscribe
                                to the newsletter
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="panel panel-default " style="display: none;">
                <div class="panel-heading">
                    <strong>Invite your friends</strong>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_invite_friend" style="width: 100%;">
                        <tr>
                            <td style="width: 20%;">Enter Email ID
                            </td>
                            <td style="width: 30%;">

                                <input type="text" class="txt_invite_friend" />
                            </td>
                            <td style="width: 20%;">
                                <button id="btn_add_more" type="button" class="btn btn-lg btn-primary" style="margin-left: -60px;"
                                    onclick="add_more_email()">
                                    Add More</button>
                                <button id="btn_send_email" type="button" class="btn btn-lg btn-primary" style="margin-left: 10px;"
                                    onclick="return send_alumni_invite_friend_mail()">
                                    Send</button>
                            </td>
                            <td style="width: 30%;"></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="margin-top: 30px; display: none;">
                <button id="btn_save" type="button" class="btn btn-lg btn-primary" style="margin-left: -60px;">
                    Submit</button>
            </div>
        </div>
    </div>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_login_email" />
  

</body>
</html>
