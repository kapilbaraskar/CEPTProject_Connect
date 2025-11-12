<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="frm_personal_details_old.aspx.cs" Inherits="Admin_frm_personal_details_old" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

         $('#txt_name').text('<%= Session["UserName"] %>');
                         $('#txt_mail').text('<%= Session["email"] %>');

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_personal_details",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {

                    if (data.d[0] != null) {
                        debugger;
                        var p_details = JSON.parse(data.d[0]);

                      //  $('#txt_name').text(p_details[0]["supervisor_name"]);
                        $('#txt_qualification').text(p_details[0]["qualification"]);
                        $('#drp_type').text(p_details[0]["designation"]);
                        $('#drp_department').text(p_details[0]["department"]);
                      //  $('#txt_mail').text(p_details[0]["email"]);
                        $('#txt_contact').text(p_details[0]["contact"]);

                        $('#txt_area').html(p_details[0]["area_of_interest"]);
                        $('#txt_projects').html(p_details[0]["projects"]);
                        $('#txt_Background').html(p_details[0]["Background"]);

                        if (p_details[0]["image_path"] != "") {

                            //                                                        $("#img_photo").attr("src", "https://cpop.cept.ac.in/" + p_details[0]["image_path"]);
                            //                                                        $("#img_photo").attr("alt", "https://cpop.cept.ac.in/" + p_details[0]["image_path"]);

                            //                            $("#img_photo").attr("src", "C://inetpub/wwwroot/CPOP/" + p_details[0]["image_path"]);
                            $("#img_photo").attr("src", "../../UserPersonalPhoto/" + p_details[0]["image_path"]);
                            //  $("#img_photo").attr("alt", "../../" + p_details[0]["image_path"]);

                            $('#lbl_image_name').text(p_details[0]["image_path"]);
                        }

                        // document.getElementById("imageUpload").disabled = false;
                        // bootbox.alert(data.d);

                    }
                    else
                    {
                         $('#txt_name').text('<%= Session["UserName"] %>');
                         $('#txt_mail').text('<%= Session["email"] %>');
                    }


                },
                error: function (msg) { alert(msg.d); }
            });


            $('#btn_edit_profile').on('click', function () {
                 window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/frm_edit_personal_details.aspx") %>";
            });

        });
    </script>
    <style>
        .color_12
        {
            color: rgb(153, 153, 153);
        }
        .wysiwyg_viewer_skins_button_BasicButtonb1-label:hover
        {
            background-color: #CBC622;
            width: 100%;
        }
        .wysiwyg_viewer_skins_area_DefaultAreaSkinc1-bg
        {
            border: 1px solid rgba(153, 153, 153, 0.498039);
            border-image-source: initial;
            border-image-slice: initial;
            border-image-width: initial;
            border-image-outset: initial;
            border-image-repeat: initial;
            position: absolute;
            top: 0px;
            bottom: 0px;
            left: 0px;
            right: 0px;
            background-color: transparent;
            border-radius: 5px;
        }
        #div_what
        {
            width: 275px;
            float: left;
        }
        #div_why
        {
            width: 275px;
            float: left;
            margin-left: 35px;
        }
        #div_how
        {
            width: 275px;
            float: left;
            margin-left: 35px;
        }
        .s16link
        {
            position: absolute;
            top: 0;
            right: 0;
            bottom: 0;
            left: 0;
            background-color: rgba(102, 102, 102, 1);
            transition: border 0.4s ease 0s, background-color 0.4s ease 0s;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6);
            border: solid rgba(153, 153, 153, 1) 0px;
            cursor: pointer !important;
            border-radius: 50%;
        }
        .s16:active[data-state~="mobile"] .s16label, .s16:hover[data-state~="desktop"] .s16label
        {
            color: #9F9B1B;
            transition: color 0.4s ease 0s;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <button style="float: right; margin-right: 30px;" class="btn btn-small" type="button"
        id="btn_edit_profile">
        Edit Profile
    </button>
    <div id="cpfi" width="980" height="500" x="0" y="0" scale="1" angle="0" class="wysiwyg_viewer_skins_page_TransparentPageSkinp2"
        style="visibility: visible; zoom: 1; opacity: 1; position: absolute; top: 100px;
        left: 67px; width: 980px; padding-bottom: 50px;">
        <div class="wysiwyg_viewer_skins_page_TransparentPageSkinp2-bg">
        </div>
        <div class="wysiwyg_viewer_skins_page_TransparentPageSkinp2-inlineContent">
            <div id="hzce7ka6_0" width="949" height="416" x="16" y="80" scale="1" angle="0" state="desktopView"
                class="wysiwyg_viewer_skins_area_DefaultAreaSkinc1" style="visibility: visible;
                left: 16px; top: 80px; min-width: 949px; min-height: 416px; position: absolute;
                margin-bottom: 50px;">
                <div class="wysiwyg_viewer_skins_area_DefaultAreaSkinc1-bg">
                </div>
                <div class="wysiwyg_viewer_skins_area_DefaultAreaSkinc1-inlineContent" style="position: relative;">
                    <div style="float: left; padding-left: 13px; padding-top: 10px;">
                        <div id="hzce7ka6_2" width="189" height="181" x="13" y="10" scale="1" angle="0" state="noTouch"
                            class="wysiwyg_viewer_skins_photo_NoSkinPhotowp2 " style="visibility: visible;
                            min-width: 189px; min-height: 181px;" title="">
                            <a class="wysiwyg_viewer_skins_photo_NoSkinPhotowp2-link" style="cursor: default;">
                                <div id="i09k783m" class="skins_core_ImageNewSkinZoomable" style="visibility: visible;
                                    width: 189px; height: 181px;">
                                    <img id="img_photo" class="skins_core_ImageNewSkinZoomable-image" alt="" style="margin-top: 0px;
                                        margin-left: 0px; width: 189px; height: 181px;">
                                </div>
                            </a>
                        </div>
                        <div id="hzce7ka6_1" width="188" height="202" x="13" y="204" scale="1" angle="0"
                            class="wysiwyg_viewer_skins_WRichTextNewSkintxtNew" style="visibility: visible;
                            width: 188px; min-height: 202px; padding-top: 13px;">
                            <p style="font-size: 15px;" class="font_8">
                                <span style="font-size: 15px;"><span id="txt_name" style="font-weight: bold;"></span>
                                </span>
                            </p>
                            <p style="font-size: 11px;" class="font_8">
                                <span style="font-size: 11px;"><span class="color_12"><span id="txt_qualification"
                                    style="font-weight: bold;"></span></span></span>
                            </p>
                            <p style="font-size: 11px;" class="font_8">
                                &nbsp;</p>
                            <p class="font_8">
                                <font color="#999999"><b id="drp_type"></b></font>
                            </p>
                            <p class="font_8">
                                &nbsp;</p>
                            <p id="txt_area" class="font_8" style="font-size: 13px;">
                            </p>
                        </div>
                    </div>
                    <div id="hzcefnoz" width="325" height="396" x="244" y="10" scale="1" angle="0" class="wysiwyg_viewer_skins_WRichTextNewSkintxtNew"
                        style="visibility: visible; width: 325px; min-height: 396px; float: left; padding-left: 43px;
                        padding-top: 10px;" ng-if="supervisorDetail.Background != ''">
                        <p class="font_8" ng-if="supervisorDetail.Background != null">
                            <b style="font-size: 13px; color: rgb(153, 153, 153);">Background </b>
                        </p>
                        <p class="font_8">
                            &nbsp;</p>
                        <p id="txt_Background" class="font_8">
                        </p>
                        <p class="font_8">
                            &nbsp;</p>
                        <p style="max-width: 99.9000015258789%;" class="font_8">
                            &nbsp;</p>
                    </div>
                    <div id="hzcefur2" width="325" height="377" x="612" y="10" scale="1" angle="0" class="wysiwyg_viewer_skins_WRichTextNewSkintxtNew"
                        style="visibility: visible; width: 325px; min-height: 377px; float: left; padding-left: 43px;
                        padding-top: 10px;">
                        <div ng-if="supervisorDetail.projects != ''">
                            <div ng-if="supervisorDetail.projects != null">
                                <p class="font_8">
                                    <b style="font-size: 13px; color: rgb(153, 153, 153);">Research Projects </b>
                                </p>
                                <p class="font_8">
                                    &nbsp;</p>
                                <p id="txt_projects" class="font_8">
                                </p>
                                <p style="max-width: 99.9000015258789%;" class="font_8">
                                    &nbsp;</p>
                            </div>
                        </div>
                        <p style="max-width: 99.9000015258789%;" class="font_8">
                            <b style="color: rgb(153, 153, 153);">Contact</b></p>
                        <p style="max-width: 99.9000015258789%;" class="font_8">
                            &nbsp;</p>
                        <p style="max-width: 99.9000015258789%;" class="font_8" ng-if="supervisorDetail.email != ''">
                            Email: <span id="txt_mail"></span>
                        </p>
                        <p style="max-width: 99.9000015258789%;" class="font_8" ng-if="supervisorDetail.contact != ''">
                            Mob: <span id="txt_contact"></span>
                        </p>
                        <p style="max-width: 99.9000015258789%;" class="font_8">
                            &nbsp;</p>
                        <%--<p style="max-width: 99.9000015258789%;" class="font_8">Personal Link : <u><a href="{{supervisorDetail.capstone_project}}">{{supervisorDetail.capstone_project}}</a></u></p>--%>
                        <p style="display: none" style="max-width: 99.9000015258789%;" class="font_8" ng-if="supervisorDetail.capstone_project != ''">
                            <a href="{{supervisorDetail.capstone_project}}" target="_blank" style="cursor: pointer;"
                                ng-if="supervisorDetail.capstone_project != null">Click here to See Personal Profile
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
