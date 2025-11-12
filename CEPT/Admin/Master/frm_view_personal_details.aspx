<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="frm_view_personal_details.aspx.cs" Inherits="Admin_Master_frm_view_personal_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">

     var str = "<tr><td class='degree'></td> ";
        str += "<td class='Institution'></td> ";
        str += "<td class='Field'></td> ";
        str += "<td class='year_of_completion'></td></tr> ";
//        str += "<td class='description'></td></tr> ";
      
      var oTable ;

        $(document).ready(function () {


        var code = getParameterByName('code');

         getinstructor();

         $('.txt_name').text('<%= Session["UserName"] %>');
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

                        $('#txt_qualification').text(p_details[0]["qualification"]);
                        $('.drp_type').text(p_details[0]["designation"]);
                        $('#drp_department').text(p_details[0]["department"]);
                      
                        $('#txt_contact').text(p_details[0]["contact"]);
                        $('#txt_capstone_project').text(p_details[0]["capstone_project"]);
                        $('#spn_office_collection').text(p_details[0]["office_location"]);

                        $('#txt_education_description').html(p_details[0]["education_description"]);
                        $('#txt_area').html(p_details[0]["area_of_interest"]);
                        $('#txt_projects').html(p_details[0]["projects"]);
                       // $('#txt_Background').html(p_details[0]["Background"]);

                        $('#txt_articles_papers').html(p_details[0]["research_articles_papers"]);
                        $('#txt_prof_honors').html(p_details[0]["professional_honors"]);
                        $('#txt_prof_affiliations').html(p_details[0]["professional_affiliations"]);

                        document.getElementById('capstone_project').href = p_details[0]["capstone_project"];
                        document.getElementById('capstone_project').innerText = p_details[0]["capstone_project"];

                        if (p_details[0]["image_path"] != "") {

                            $("#img_photo").attr("src", "../../UserPersonalPhoto/" + p_details[0]["image_path"]);
                         //   $("#img_photo").attr("src", '<%= Page.ResolveClientUrl("~/UserPersonalPhoto/") %>'+p_details[0]["image_path"]);
                        }

                    }
                    else
                    {
                         $('.txt_name').text('<%= Session["UserName"] %>');
                         $('#txt_mail').text('<%= Session["email"] %>');
                    }

                     if (data.d[1] != null) {

                        var E_details = JSON.parse(data.d[1]);
                        $("#tbleducation tbody").html('');

                        for (var i = 0; i < E_details.length; i++) {

                            $('#tbleducation tbody').append(str);
                        }

                        $("#tbleducation tbody tr").each(function (j) {

                            for (var i = 0; i < E_details.length; i++) {
                                if (j == i) {
                                    $(this).find(".degree").text(E_details[i]["degree"]);
                                    $(this).find(".Institution").text(E_details[i]["institution"]);
                                    $(this).find(".Field").text(E_details[i]["field"]);
                                    $(this).find(".year_of_completion").text(E_details[i]["year_of_completion"]);
                                    $(this).find(".description").text(E_details[i]["description"]);
                                }
                            }

                        });
                    }
                },
                error: function (msg) { alert(msg.d); }
            });


            $('#btn_edit_profile').on('click', function () {
                 window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/frm_edit_personal_details.aspx") %>";
            });

        });
        
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
</asp:Content>

