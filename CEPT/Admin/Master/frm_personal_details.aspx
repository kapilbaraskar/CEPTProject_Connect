<%@ Page Title="Profile" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="frm_personal_details.aspx.cs" Inherits="Admin_frm_personal_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">

        var str = "<tr><td class='degree'></td> ";
        str += "<td class='Institution'></td> ";
        str += "<td class='Field'></td> ";
        str += "<td class='year_of_completion'></td></tr> ";
        //        str += "<td class='description'></td></tr> ";

        var oTable;

        //   $(window).load(function(){
        //   alert('hi');
        //   });
        $(document).ready(function () {

            $('h2').css('font-size', '25px');

            var code = getParameterByName('code');

            if (code == '')
            {
                if ( '<%= Session["UserId"] %>' != '178') {
                    $('#li_other_profile').css('display', 'none');
                }
                getinstructor();
                $('.txt_name').text('<%= Session["UserName"] %>');
                $('#txt_mail').text('<%= Session["email"] %>');
            }
            else
            {
                if (code != '<%= Session["UserId"] %>') {
                    $('#btn_edit_profile').css('display', 'none');
                    $('#li_other_profile').css('display', 'none');
                }
            }

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_personal_details",
                data: "{instructor_code :'" + code + "'}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {

                    if (data.d[0] != null) {
                        var p_details = JSON.parse(data.d[0]);

                        $('#txt_qualification').text(p_details[0]["qualification"]);
                        $('.drp_type').text(p_details[0]["designation"]);
                        $('#drp_department').text(p_details[0]["department"]);

                        $('#txt_contact').text(p_details[0]["contact"]);
                        $('#txt_capstone_project').text(p_details[0]["capstone_project"]);
                        $('#spn_office_collection').text(p_details[0]["office_location"]);
                        $('#spn_institutional_roles').text(p_details[0]["public_service"]);

                        $('#txt_education_description').html(p_details[0]["education_description"]);

                        $('#txt_area').html('');

                        if (p_details[0]["area_of_interest"] != '') {

                            var a = p_details[0]["area_of_interest"].split('~');

                            var str_aoe = '<ul>';
                            for (var i = 0; i < a.length; i++) {

                                str_aoe += "<li>" + a[i] + "</li>";

                            }
                            str_aoe += "</ul>";

                            $('#txt_area').html(str_aoe);
                        }


                        $('#txt_projects').html(p_details[0]["projects"]);
                        // $('#txt_Background').html(p_details[0]["Background"]);

                        $('#txt_articles_papers').html(p_details[0]["research_articles_papers"]);
                        $('#txt_presented_papers_and_invited_lectures').html(p_details[0]["presented_papers_and_invited_lectures"]);
                        $('#txt_prof_honors').html(p_details[0]["professional_honors"]);
                        $('#txt_prof_affiliations').html('');

                        if (p_details[0]["professional_affiliations"] != '') {

                            var a = p_details[0]["professional_affiliations"].split('~');

                            var str_pa = '<ul>';
                            for (var i = 0; i < a.length; i++) {

                                str_pa += "<li>" + a[i] + "</li>";

                            }
                            str_pa += "</ul>";

                            $('#txt_prof_affiliations').html(str_pa);
                        }


                        if (p_details[0]["cv_path"] != '') {
                            document.getElementById('cv_path').href = "../../UploadFacultyProfileCV/" + p_details[0]["cv_path"];
                            document.getElementById('cv_path').innerText = "Download detailed CV";
                        }

                        if (code != '') {
                            $('.txt_name').text(p_details[0]["supervisor_name"]);
                            $('#txt_mail').text(p_details[0]["email"]);
                        }

                        document.getElementById('capstone_project').href = p_details[0]["capstone_project"];
                        document.getElementById('capstone_project').innerText = p_details[0]["capstone_project"];

                        if (p_details[0]["image_path"] != "") {

                            $("#img_photo").attr("src", "../../UserPersonalPhoto/" + p_details[0]["image_path"]);
                         //   $("#img_photo").attr("src", '<%= Page.ResolveClientUrl("~/UserPersonalPhoto/") %>'+p_details[0]["image_path"]);
                        }
                        else if (p_details[0]["profile_photo"] != "") {
                            $("#img_photo").attr("src", "../../UserPersonalPhoto/" + p_details[0]["profile_photo"]);
                        }

                    }
                    else {
                         //$('.txt_name').text('<%= Session["UserName"] %>');
                         //$('#txt_mail').text('<%= Session["email"] %>');
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

                    if (data.d[2] != null) {

                        var CT_details = JSON.parse(data.d[2]);
                        $("#tblcoursetaught tbody").html('');
                        $("#tblcoursetaughtother tbody").html('');

                        if (CT_details.length <= 5) {
                            $('#show_more_dd_tblcoursetaught').css('display', 'none');
                            $('#dd_tblcoursetaught').css('height', '100%');
                        }



                        //                        for (var i = 0; i < CT_details.length; i++) 
                        //                        {
                        //                            if (CT_details[i]["section"] == 'A') 
                        //                            {
                        //                                $('#tblcoursetaught tbody').append(str_course_taught);
                        //                            }
                        //                            else if (CT_details[i]["section"] == 'O')
                        //                            {
                        //                                $('#tblcoursetaughtother tbody').append(str_course_taught);
                        //                            }
                        //                        }

                        //                        $("#tblcoursetaught tbody tr").each(function (j) {

                        //                            var count = 1;
                        //                            for (var i = 0; i < CT_details.length; i++) {
                        //                                if (j == i) 
                        //                                {
                        //                                    if (CT_details[i]["section"] == 'A') 
                        //                                    {
                        //                                        $(this).find(".sr_no").text( (count + 1));
                        //                                        $(this).find(".course_taught").text(CT_details[i]["course_name"]);
                        //                                        $(this).find(".semester_year").text(CT_details[i]["semester_year"]);

                        //                                        count++;
                        //                                    }
                        //                                }
                        //                            }

                        //                        });

                        //                        $("#tblcoursetaughtother tbody tr").each(function (j) {
                        //                         var count = 1;
                        //                            for (var i = 0; i < CT_details.length; i++) {
                        //                                if (j == i) {
                        //                                    if (CT_details[i]["section"] == 'O') 
                        //                                    {
                        //                                        
                        //                                        $(this).find(".sr_no").text( (count + 1));
                        //                                        $(this).find(".course_taught").text(CT_details[i]["course_name"]);
                        //                                        $(this).find(".semester_year").text(CT_details[i]["semester_year"]);

                        //                                        count++;
                        //                                    }
                        //                                }
                        //                            }

                        //                        });

                        var count_area = 1;
                        var count_other = 1;

                        for (var i = 0; i < CT_details.length; i++) {

                            if (CT_details[i]["section"] == 'A') {
                                var str_course_taught_area = "<tr><td class='sr_no'>" + count_area + "</td> ";
                                str_course_taught_area += "<td class='course_taught'>" + CT_details[i]["course_name"] + "</td> ";
                                str_course_taught_area += "<td class='semester_year'>" + CT_details[i]["semester_year"] + "</td></tr> ";

                                $('#tblcoursetaught tbody').append(str_course_taught_area);

                                count_area = (count_area + 1);
                            }
                            else if (CT_details[i]["section"] == 'O') {
                                var str_course_taught_other = "<tr><td class='sr_no' >" + count_other + "</td> ";
                                str_course_taught_other += "<td class='course_taught'>" + CT_details[i]["course_name"] + "</td> ";
                                str_course_taught_other += "<td class='semester_year'>" + CT_details[i]["semester_year"] + "</td></tr> "

                                $('#tblcoursetaughtother tbody').append(str_course_taught_other);

                                count_other = (count_other + 1);
                            }
                            else {
                                var str_course_taught_area = "<tr><td class='sr_no'>" + count_area + "</td> ";
                                str_course_taught_area += "<td class='course_taught'>" + CT_details[i]["course_name"] + "</td> ";
                                str_course_taught_area += "<td class='semester_year'>" + CT_details[i]["semester_year"] + "</td> </tr>";

                                $('#tblcoursetaught tbody').append(str_course_taught_area);

                                count_area = (count_area + 1);
                                // count_area++;
                            }
                        }

                        if ($("#tblcoursetaught tbody tr").length <= 5) {
                            $('#show_more_dd_tblcoursetaught').css('display', 'none');
                            $('#dd_tblcoursetaught').css('height', '100%');
                            $('#dd_tblcoursetaught').css('min-height', '0');
                        }


                        if ($("#tblcoursetaughtother tbody tr").length <= 5) {

                            if ($("#tblcoursetaughtother tbody tr").length == 0) {
                                $('#dl_other_course_taught').css('display', 'none');
                            }
                            $('#show_more_dd_tblcoursetaughtother').css('display', 'none');
                            $('#dd_tblcoursetaughtother').css('height', '100%');
                            $('#dd_tblcoursetaughtother').css('min-height', '0');
                        }
                    }

                    if (data.d[0] == null) {
                        $("#img_photo").attr("src", "../../UserPersonalPhoto/" + 'profile_' + '<%= Session["UserId"] %>'+'.jpg');
                    }
                },
                error: function (msg) { alert(msg.d); }
            });


            $('#btn_edit_profile').on('click', function () {
                debugger;
                if ($('#hdn_user_type').val() == 'instructor')
                {
                    window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/frm_edit_personal_details.aspx") %>";
                }
                else { window.location.href = "<%= Page.ResolveClientUrl("~/Admin/Master/vf_edit_personal_detail.aspx?ic="+hdn_user_id.Value+"") %>";}
                
               // 
            });

            $('#btn_print_profile').on('click', function () {

                //  window.open('print_personal_profile.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                //return false;
            });


        });

        function getinstructor() {

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_all_other_Instructor_for_profile_view",
                data: "{}",
                contentType: "application/json",
                datatype: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        display_instructor_data(data.d);
                    }
                },
                Error: function (data) {

                    alert(data.d);
                }

            });

        }

        function display_instructor_data(data) {


            if (oTable != null) {
                oTable.fnDestroy();

                $("#datalist_instructor").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_instructor"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#datatable_instructor").dataTable({

                "bPaginate": false,
                "bStateSave": false,
                "iDisplayLength": 60,
                "bSort": false,
                "sDom": 't',
                //    "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": ""
                },
                //        "sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [

                    ]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "Instructor Name", "mData": "user_name", "bSortable": false },

                    {
                        "sTitle": "<center>View</center>",
                        "mData": null,
                        "bSortable": false,
                        fnRender: function (data) {

                            return '<center><a style="cursor:pointer" href="frm_personal_details.aspx?code=' + data.aData.user_id + '" target="_blank" class="course_outlin_oTable1" >View</a></center>';
                        }

                    }

                ]


            });

            $('#datalist_instructor').css("display", "block");

            var flag = "N";

            $("#datatable_instructor tbody tr").each(function (i) {

                var aPos = oTable.fnGetPosition(this);
                var a = oTable.fnGetData(aPos);


                if (a["other_user_id"] == a["user_id"]) {

                    $(this).find(".chk_instructor").prop('checked', true);

                    flag = "Y";
                }

            });

            if (flag == "Y") {
                $(".chk_full_parent").prop('checked', true);
            }

        }
        function tree_menu_click(this_node) {

            var parent_class = this_node.parentElement.classList;
            var status;

            if (this_node.parentElement.classList.contains('easytree-exp-c')) status = false;
            else if (this_node.parentElement.classList.contains('easytree-exp-e')) status = true;

            if (status) {
                this_node.parentElement.classList.remove('easytree-exp-e');
                this_node.parentElement.classList.add('easytree-exp-c');
                this_node.parentElement.nextElementSibling.style.display = 'none';
            }
            else {
                this_node.parentElement.classList.remove('easytree-exp-c');
                this_node.parentElement.classList.add('easytree-exp-e');
                this_node.parentElement.nextElementSibling.style.display = 'block';
            }
        }
        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

        function show_more_click(cur_id) {
            $('#' + cur_id).css('height', '100%');
            $('#show_more_' + cur_id).css('display', 'none');
            $('#show_less_' + cur_id).css('display', 'block');
        }

        function show_less_click(cur_id) {
            $('#' + cur_id).css('height', '70px');
            $('#show_less_' + cur_id).css('display', 'none');
            $('#show_more_' + cur_id).css('display', 'block');
        }

    </script>
    <link href="../../DesignCss/ui.easytree.css" rel="stylesheet" type="text/css" />
    <style>
        .table thead:first-child tr {
            color: #333;
            font-weight: bold;
            background-image: none;
            background-color: White;
        }

            .table thead:first-child tr th {
                border: 0;
            }

        body {
            margin: 0;
            font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 14px;
            line-height: 20px;
            color: #333;
            background-color: #fff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../../DesignCss/reset-personal_profile.css" rel="stylesheet" type="text/css" />
    <link href="../../DesignCss/personal_profile.min.css" rel="stylesheet" type="text/css" />
    <div id="main" role="main" style="font-family: 'Helvetica Neue',Helvetica,Arial,sans-serif">
        <div id="content-columns" class="row-fluid">
            <div id="portal-column-content" class="cell width-3:4 position-1:4" style="margin-top: 7px;">
                <div id="viewlet-above-content">
                </div>
                <div class="">
                    <dl class="portalMessage info" id="kssPortalMessage" style="display: none">
                        <dt>Info</dt>
                        <dd></dd>
                    </dl>
                    <div id="content">
                        <div>
                            <div>
                                <div class="row-fluid">
                                    <div class="span6">
                                        <h1 class="documentFirstHeading visualNoPrint">
                                            <span class="txt_name"></span>
                                        </h1>
                                    </div>
                                    <div class="span6">
                                        <%-- <div style="float: right;" class="btn-group">
                                            <%--<button type="button" id="btn_edit_profile" class="btn">
                                                Edit Profile</button>  <i class="glyphicon glyphicon-pencil"></i> | <i class="icon-print bigger-160"></i></div>--%>
                                        <div style="float: right;">
                                            <a id="btn_edit_profile" title="Edit"><i class="icon-edit icon-2x text-blue" style="cursor: pointer; width: 33px;"></i></a>| <a id="btn_print_profile" title="Print"><i class="icon-print icon-2x text-blue"
                                                style="cursor: pointer;"></i></a>
                                        </div>
                                    </div>
                                </div>
                                <b>
                                    <br>
                                    <span class="drp_type"></span>
                                    <br>
                                    <%--  <a href="/academics/departments/">Biology</a>--%></b><p>
                                        <b><span id="spn_institutional_roles"></b></span>
                                        <br>
                                        Phone : <span id="txt_contact"></span>
                                        <br>
                                        Office Location : <span id="spn_office_collection"></span>
                                        <br>
                                        <%-- <a href="mailto:EAlter@york.cuny.edu">EAlter@york.cuny.edu</a>--%><span id="txt_mail"></span><br>
                                        <a target="_blank" id="capstone_project" href=""></a>
                                        <br />
                                        <a target="_blank" id="cv_path" download href=""></a>
                                        <%--Public Service : <span id="spn_public_service"></span>--%>
                                    </p>
                                <table style="display: none;" class="table">
                                    <tbody>
                                        <tr>
                                            <th>Office Hours
                                            </th>
                                            <th>&nbsp;
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>Tuesday&nbsp;
                                            </td>
                                            <td>12-1pm&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Thursday&nbsp;
                                            </td>
                                            <td>12-1pm&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;
                                            </td>
                                            <td>&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;
                                            </td>
                                            <td>&nbsp;
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <dl>
                                    <dt>
                                        <h2 style="margin-bottom: 2px;">Education</h2>
                                    </dt>
                                    <dd>
                                        <table id="tbleducation" class="table">
                                            <thead>
                                                <tr>
                                                    <th>Degree
                                                    </th>
                                                    <th>Institution
                                                    </th>
                                                    <th>Field
                                                    </th>
                                                    <th>Year of Completion
                                                    </th>
                                                    <%-- <th>
                                                    Brief description of education work
                                                </th>--%>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </dd>
                                </dl>
                                <div>
                                    <dt>
                                        <h2 style="margin-bottom: 2px;">Bio</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_education_description">
                                        </p>
                                    </dd>
                                </div>
                                <dl>
                                    <dt>
                                        <h2>Areas of Expertise</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_area">
                                        </p>
                                        <%--<p id="txt_area" style="height:70px;min-height:70px;overflow:hidden;"></p>--%>
                                        <%--<span id="show_more_txt_area" style="font-size:14px;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_more_click('txt_area')">Show More</span>
                                        <span id="show_less_txt_area" style="font-size:14px;display:none;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_less_click('txt_area')">Show Less</span>--%>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>
                                        <h2 style="margin-bottom: 2px;">Courses Taught in the Areas of Expertise</h2>
                                    </dt>
                                    <dd>
                                        <div id="dd_tblcoursetaught" style="height: 70px; min-height: 220px; overflow: hidden;">
                                            <table id="tblcoursetaught" class="table">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 75px;">Sr No.
                                                        </th>
                                                        <th style="width: 559px;">Course Name
                                                        </th>
                                                        <th style="width: 105px;">Semester
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                        <span id="show_more_dd_tblcoursetaught" style="font-size: 14px; cursor: pointer; text-decoration: underline; color: Blue;"
                                            onclick="show_more_click('dd_tblcoursetaught')">Show More</span> <span id="show_less_dd_tblcoursetaught" style="font-size: 14px; display: none; cursor: pointer; text-decoration: underline; color: Blue;"
                                                onclick="show_less_click('dd_tblcoursetaught')">Show Less</span>
                                    </dd>
                                </dl>
                                <dl id="dl_other_course_taught">
                                    <dt>
                                        <h2 style="margin-bottom: 2px;">Other Courses Taught</h2>
                                    </dt>
                                    <dd>
                                        <div id="dd_tblcoursetaughtother" style="height: 70px; min-height: 220px; overflow: hidden;">
                                            <table id="tblcoursetaughtother" class="table">
                                                <thead>
                                                    <tr>
                                                        <th style="width: 75px;">Sr No.
                                                        </th>
                                                        <th style="width: 559px;">Course Name
                                                        </th>
                                                        <th style="width: 105px;">Semester
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                        <span id="show_more_dd_tblcoursetaughtother" style="font-size: 14px; cursor: pointer; text-decoration: underline; color: Blue;"
                                            onclick="show_more_click('dd_tblcoursetaughtother')">Show More</span> <span id="show_less_dd_tblcoursetaughtother" style="font-size: 14px; display: none; cursor: pointer; text-decoration: underline; color: Blue;"
                                                onclick="show_less_click('dd_tblcoursetaughtother')">Show Less</span>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>
                                        <%--<h2>Research/Design Projects (completed/ongoing)</h2>--%>
                                        <h2>Recent Research/ Design Projects in Areas of Expertise</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_projects">
                                        </p>
                                        <%--<p id="txt_projects" style="height:70px;min-height:70px;overflow:hidden;"></p>
                                        <span id="show_more_txt_projects" style="font-size:14px;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_more_click('txt_projects')">Show More</span>
                                        <span id="show_less_txt_projects" style="font-size:14px;display:none;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_less_click('txt_projects')">Show Less</span>--%>
                                    </dd>
                                </dl>
                                <dl style="display: none;">
                                    <dt>
                                        <h2>Background</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_Background">
                                        </p>
                                    </dd>
                                </dl>
                                <dl style="clear: both;">
                                    <dt>
                                        <h2>Recent Presented Papers and Invited Lectures in Areas of Expertise
                                        </h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_presented_papers_and_invited_lectures">
                                        </p>
                                        <%--<p id="txt_presented_papers_and_invited_lectures" style="height:70px;min-height:70px;overflow:hidden;"></p>--%>
                                        <%--<span id="show_more_txt_presented_papers_and_invited_lectures" style="font-size:14px;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_more_click('txt_presented_papers_and_invited_lectures')">Show More</span>
                                        <span id="show_less_txt_presented_papers_and_invited_lectures" style="font-size:14px;display:none;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_less_click('txt_presented_papers_and_invited_lectures')">Show Less</span>--%>
                                    </dd>
                                </dl>
                                <dl style="clear: both;">
                                    <dt>
                                        <%--<h2>Research Articles, Presented Papers, Invited Lectures, etc.</h2>--%>
                                        <h2>Research Articles and Book Chapters in Areas of Expertise</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_articles_papers">
                                        </p>
                                        <%--<p id="txt_articles_papers" style="height:70px;min-height:70px;overflow:hidden;"></p>--%>
                                        <%--<span id="show_more_txt_articles_papers" style="font-size:14px;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_more_click('txt_articles_papers')">Show More</span>
                                        <span id="show_less_txt_articles_papers" style="font-size:14px;display:none;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_less_click('txt_articles_papers')">Show Less</span>--%>
                                    </dd>
                                </dl>
                                <dl style="clear: both;">
                                    <dt>
                                        <h2>Professional Honors, Prizes, Fellowships</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_prof_honors">
                                        </p>
                                        <%--<p id="txt_prof_honors" style="height:70px;min-height:70px;overflow:hidden;"></p>--%>
                                        <%--<span id="show_more_txt_prof_honors" style="font-size:14px;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_more_click('txt_prof_honors')">Show More</span>
                                        <span id="show_less_txt_prof_honors" style="font-size:14px;display:none;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_less_click('txt_prof_honors')">Show Less</span>--%>
                                    </dd>
                                </dl>
                                <dl style="clear: both;">
                                    <dt>
                                        <h2>Professional Affiliations / Public Service</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_prof_affiliations">
                                        </p>
                                        <%--<p id="txt_prof_affiliations" style="height:70px;min-height:70px;overflow:hidden;"></p>--%>
                                        <%--<span id="show_more_txt_prof_affiliations" style="font-size:14px;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_more_click('txt_prof_affiliations')">Show More</span>
                                        <span id="show_less_txt_prof_affiliations" style="font-size:14px;display:none;cursor:pointer;text-decoration: underline;color:Blue;" onclick="show_less_click('txt_prof_affiliations')">Show Less</span>--%>
                                    </dd>
                                </dl>
                                <%--<dl>
                                    <dt>
                                        <h2>
                                            Areas of Expertise</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_area">
                                        </p>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>
                                        <h2>
                                            Research/Design Projects (completed/ongoing)</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_projects">
                                        </p>
                                    </dd>
                                </dl>
                                <dl style="display: none;">
                                    <dt>
                                        <h2>
                                            Background</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_Background">
                                        </p>
                                    </dd>
                                </dl>
                                <dl style="float: left;">
                                    <dt>
                                        <h2>
                                            Research Articles, Presented Papers, Invited Lectures, etc.(Please use APA 6th edition
                                            format only)</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_articles_papers">
                                        </p>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>
                                        <h2>
                                            Professional Honors, Prizes , Fellowships</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_prof_honors">
                                        </p>
                                    </dd>
                                </dl>
                                <dl>
                                    <dt>
                                        <h2>
                                            Professional Affiliations</h2>
                                    </dt>
                                    <dd>
                                        <p id="txt_prof_affiliations">
                                        </p>
                                    </dd>
                                </dl>--%>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="viewlet-below-content">
                </div>
            </div>
            <div id="portal-column-one" class="cell width-1:4 position-0">
                <div class="portletWrapper" id="portletwrapper-706c6f6e652e6c656674636f6c756d6e0a636f6e74656e745f747970650a466163756c74790a666163756c74792d7069782d706f72746c6574"
                    data-portlethash="706c6f6e652e6c656674636f6c756d6e0a636f6e74656e745f747970650a466163756c74790a666163756c74792d7069782d706f72746c6574">
                    <div class="newsImageContainer">
                        <img id="img_photo" class="image-left" alt="" width="266px" height="400px" pagespeed_url_hash="222325817"
                            onload="pagespeed.CriticalImages.checkImageForCriticality(this);"><div style="clear: both">
                                &nbsp;
                        </div>
                        <p class="discreet">
                            <span class="txt_name"></span>
                            <br>
                            <span class="drp_type"></span>
                            <br>
                            <%--Biology--%>
                            <li id="li_other_profile" style="margin-top: 10px;"><span id="_st_node_3433_2" class="easytree-node  easytree-ico-cf easytree-exp-c easytree-active">
                                <span class="easytree-expander" onclick="return tree_menu_click(this);"></span><span
                                    class="easytree-title" onclick="return tree_menu_click(this);" style="margin-left: 0px; padding-left: 0px; font-size: 14px;">Other Profile</span> </span>
                                <ul class="" style="display: none; white-space: normal;">
                                    <div style="margin-top: 5px; display: none; width: 100%; height: 632px; overflow: hidden;"
                                        class="row-fluid" id="datalist_instructor">
                                        <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                                            border="0" id="datatable_instructor" width="100%">
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </ul>
                            </li>
                        </p>
                    </div>
                </div>
                <div class="portletWrapper" id="portletwrapper-706c6f6e652e6c656674636f6c756d6e0a636f6e74656e745f747970650a466163756c74790a70625f616374696f6e5f706f72746c6574"
                    data-portlethash="706c6f6e652e6c656674636f6c756d6e0a636f6e74656e745f747970650a466163756c74790a70625f616374696f6e5f706f72746c6574">
                    <div>
                        &nbsp; &nbsp;
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="hdn_profile_photo_url" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_page_per" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_user_type" runat="server" clientidmode="Static" />
</asp:Content>
