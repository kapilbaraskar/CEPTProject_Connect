<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageAlumini.master" AutoEventWireup="true" CodeFile="AlumniSearchJob.aspx.cs" Inherits="Alumni_AlumniSearchJob" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
   
     <script src="../DesignJS/ckeditor2/ckeditor.js" type="text/javascript"></script>
   
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1><i class="icon-desktop"></i>&nbsp;View Job</h1>
        </div>

        <div class="panel panel-default ">

                <div class="row">
                    <div class="col-md-2" style="font-size: 20px; margin-top: 10px; margin-left: 200px;">
                        <input type="text" placeholder="Keyword" id="txt_keyword" />
                    </div>
                    <div class="col-md-2" style="font-size: 20px; margin-top: 10px; margin-left: 20px;">
                        <input type="text" placeholder="State/city" id="txt_city" />
                    </div>
                    <div class="col-md-2" style="font-size: 20px; margin-top: 10px;margin-left: 20px;">
                        <button type="button" class="btn btn-primary" id="btn_search" style="margin-bottom: 20px;">Search</button>
                    </div>
                </div>
                <div style="margin-left: 150px;" id="search_job" >
                </div>
         
        </div>

        <div>
            <div class="panel panel-default " style="display:none;">
                <%--<div class="panel-heading">
                    <strong>View Job</strong>
                </div>--%>
                <div class="container" style="margin-left: 20px;">
                    <div class="row">
                        <div class="col-md-12" style="margin-left: 140px; font-size: 20px; margin-top: 10px;">
                            <b><span class="txt_job_title"></span></b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-1" style="margin-left: 11px;">
                            <image src="/image/AlumniJob.jpg" style="width: 100px;"></image>
                        </div>
                        <div class="col-md-3" style="margin-top: 15px;">
                            <span id="org_name"></span>
                            <br />

                            <span id="state_city"></span>
                            <br />
                            <span>Due Date:</span>
                            <span id="dur_date"></span>
                            <br />

                            <span>Website:</span>
                            <span id="website"></span>

                        </div>
                    </div>
                    <div class="row" style="padding-left: 20px;">
                        <div class="col-md-10">
                            <hr style="width: 85%;" />
                            <b><span class="txt_job_title"></span></b>
                            <div id="desc_dis">
                            </div>
                        </div>
                    </div>
                    <div class="row" style="padding-left: 20px;">
                        <div class="col-md-10">
                            <hr style="width: 85%;" />

                            <div id="profile_desc">
                            </div>
                        </div>
                    </div>

                    <div class="row" style="padding-left: 20px;">
                        <div class="col-md-10">
                            <hr style="width: 85%;" />

                            <div id="requirement">
                            </div>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>
   
     <input type="hidden" runat="server" clientidmode="Static" id="hdn_login_email" />
    <input type="hidden" id="hdn_doc_no" />
  
     <script type="text/javascript">

         $(document).ready(function () {
             debugger;
             var doc_no = getParameterByName('doc_no');
             if (doc_no != null) {
                 //  get_alumni_data(doc_no);
             }
             serach_data();
             $('#btn_search').on('click', function () {
                 serach_data();
             });
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

         function get_alumni_data(no) {
             //debugger;
             //$.ajax({
             //    type: "POST",
             //    contentType: "application/json; charset=utf-8",
             //    url: "../../WebService.asmx/get_alumni_job_data",
             //    async: false,
             //    data: '{doc_no:"' + no + '"}',
             //    dataType: "json",
             //    success: function (data) {
             //        if (data.d != "") {
             //            var response = JSON.parse(data.d);

             //            display_data(response);
             //        }
             //    },
             //    error: function (result) {
             //        alert(result);
             //    }
             //});
             window.location.href = "AlumniViewJob.aspx?doc_no=" + no;
         }
         function display_data(data) {

             $('.txt_job_title').html(data[0].job_title);
             $('#dur_date').html(data[0].test);
             // $('#txt_city').val(data[0].city);
             $('#state_city').html(data[0].state + "," + data[0].city);
             //$('#txt_state').val(data[0].state);
             $('#txt_pro_area').val(data[0].professional_area);
             $('#txt_experience').val(data[0].experience);
             $('#salar').html(data[0].salary);
             $('#org_name').html(data[0].organization);
             $('#desc_dis').html(data[0].description);
             $('#website').html('<a href=' + data[0].organization_website + '>' + data[0].organization_website + '</a>')
             $('#hdn_doc_no').val(data[0].Doc_no);
             $('#profile_desc').html(data[0].profile_description);
             $('#requirement').html(data[0].requirements);
         }

         function serach_data() {

             var obj_data = {};
             obj_data.keyword = $('#txt_keyword').val();
             obj_data.city = $('#txt_city').val();

             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../WebService.asmx/Get_search_data",
                 async: false,
                 data: "{str_req_data:'" + JSON.stringify(obj_data) + "'}",
                 dataType: "json",
                 success: function (data) {
                     if (data.d != "") {
                         var response = JSON.parse(data.d);
                         var str = "";
                         if (response['status'] == 'true') {

                             for (var i = 0; i < response["message"].length; i++) {

                                 str += '<div class="row"> ';
                                 str += ' <div class="col-lg-1" style="cursor: pointer;"> ';
                                 str += ' <a  onclick=get_alumni_data(' + response["message"][i]["Doc_no"] + ')><image src="../image/' + response["message"][i]["image_path"] + '" style="width: 100px;"></image></a> ';
                                 str += '</div> ';
                                 str += ' <div class="col-lg-2"> ';
                                 str += '   <b><span>' + response["message"][i]["job_title"] + '</span> </b>';
                                 str += ' <br /> ';
                                 str += '  <span>' + response["message"][i]["organization"] + '</span> ';
                                 str += ' </div> ';
                                 str += ' <div class="col-lg-2"> ';
                                 str += '  <span>' + response["message"][i]["state"] + ',' + response["message"][i]["city"] + '</span><br /> ';
                                 str += '  <span>' + response["message"][i]["due_date"] + '</span> ';
                                 str += ' </div> ';
                                 str += '</div> ';
                                 str += ' <hr style="width: 85%;" />';

                             }
                             $('#search_job').html(str);
                         }
                         else if (response['status'] == 'False') {
                             bootbox.alert(response['message']);
                         }
                     }
                 },
                 error: function (result) {
                     alert(result);
                 }
             });

         }


    </script>

</asp:Content>

