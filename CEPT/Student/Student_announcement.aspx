<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Student_announcement.aspx.cs" Inherits="Student_Student_announcement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        var announcement = "";
        $(document).ready(function ()
        {
            get_announcement_dtl();
        });
        function get_announcement_dtl()
        {
            var user_type = $("#hdnusertype").val();
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_news_announcement_dtl_userwise",
                    //async: false,
                    data: "{user_type:'" + user_type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            var str_html = '';
                            announcement = JSON.parse(data.d);
                            for (var i = 0; i < announcement.length; i++)
                            {
                                str_html += "<p align='justify' style='text-align:justify,font-family: Lato, sans-serif;letter-spacing: 0.05em;'>";
                                str_html += "<img src='../../image/point_left.png' style='width: 25px;height: 22px;position: absolute;'></img>&emsp;";
                                str_html += "<a href='" + location.origin + "\\WSNewsImageUpload\\" + announcement[i]["news_image"] + "' target='_blank' style='font-size: 14px;color: #666;text-justify: inter-character; text-decoration:none;margin-left:17px;font-family: Lato, sans-serif;letter-spacing: 0.05em;'>" + announcement[i]["title"] + "&nbsp;&nbsp;<span style='color:blue;font-family: Lato, sans-serif;letter-spacing: 0.1em;'>" + modify(announcement[i]["date"]) + "</span></a>"
                                str_html += "</p><br/>";
                                //str_html += "<li><a href='" + location.origin + "\\WSNewsImageUpload\\" + announcement[i]["news_image"] + "' target='_blank'>" + announcement[i]["title"] + "</a></li>";
                            }
                            $('#announcement_dtl').append(str_html);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function modify(data) {
            var str = data.replace(/-/g, ' ');
            return str;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; Announcement 
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
  <ul id="announcement_dtl">
  </ul>

    </div>
</asp:Content>

