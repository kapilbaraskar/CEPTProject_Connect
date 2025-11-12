<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="tutor_wise_brief_edit_rights.aspx.cs" Inherits="Admin_Master_tutor_wise_brief_edit_rights" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var oTable;
        var oTable1;
        var oTable2;
        var user_type = '';
        var dept_code_ = '';
        var prog_level = '';
        var studio_level = '';
        var prog_code = '';
        var types = '';
        $(document).ready(function () {
            user_type = $('#hdn_user_type').val();
            bindsemdata();
            bindyeardata_for_cross_reg();
            $('#btnreterive').on('click', function () {
                get_studio_detail();
                return false;
            });
        });
        function bindtypedata() {
            $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            $('#drptype').append($("<option></option>").val("Y").html("Authorized"));
            $('#drptype').chosen();
        }
        $(document).on("click", ".authorize", function (event)
        {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_brief_edit_right",
                    data: "{studio_code:'" + aData["studio_code"] + "',inst_code:'" + aData["user_id"] + "',sem_code:'" + semester + "',year_code:'" + year_code +"'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == true)
                            {
                                message_type = 'Brief Edit Enable Successfully ';
                                bootbox.alert(message_type);
                                get_studio_detail();
                             }
                                
                            }
                        
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        });

        function rowClick_edit(row) {
            var url = "vf_edit_personal_detail.aspx?ic=" + row.id + "&type=tutor";
            window.open(url, "_blank");
        }


     


        

        
       

        function bindsemdata() {


            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();
        }
        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)
                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }
                        $('#drpyear').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
       
       
        
        function bindprogrammedata()
        {
            
            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_Admin_wise_Program_user_dtl",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                $('#drpprog').empty();

                                for (var i = 0; i < user_data.length; i++) {

                                    if (user_data[i]['prog_code'] == "1") {
                                        $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "2") {
                                        $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "3") {
                                        $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                    }
                                }

                            }
                            else {
                                $('#drpprog').val('1');
                                $("#drpprog").attr('disabled', 'disabled');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else {

                $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
                $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

                if ($("#hdnusertype").val() != 'PC' && $("#hdnusertype").val() != 'FA') {
                    $('#drpprog').chosen();
                }
            }
        }


       

      

      


        


        function get_studio_detail() {
            $('#DataList').css('display', 'none');
          
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            
            url_dtl = '../../WebService.asmx/tutor_wise_brief_right';
            
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: url_dtl,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "" && data.d != "[]")
                        {
                          display_studio_proposal_detail(data.d);
                            $('#div_studio_proposal_dtl').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function display_studio_proposal_detail(data) {
            var columns = [
                { "sTitle": "Instructor Code", "mData": "user_id" },
                { "sTitle": "Instructor Name", "mData": "full_name" },
                { "sTitle": "Email", "mData": "mail" },
                { "sTitle": "Nationality", "mData": "country_name" },
                { "sTitle": "Instructor Type", "mData": "inst_designation" },
                { "sTitle": "Title of Studio", "mData": "studio_title" },
                { "sTitle": "Studio Code", "mData": "studio_code" },
                { "sTitle": "No of Tutor", "mData": "no_of_tutor" },
                { "sTitle": "Mode of Teaching", "mData": "teaching_mode" },
                { "sTitle": "Level", "mData": "studio_level" },
                { "sTitle": "Faculty Name", "mData": "dept_name" },
               

                


               
                {
                    "sTitle": "Studio Description", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_description != "") {
                            // return '<center><button type="button" id=' + data.ppt_video + ' onclick="rowClick_download(this)">Download</button></center>';
                            return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description + '';
                        }
                        else return '';
                    }
                },
                

                
                
               
               

                
                {
                    "sTitle": "Edit Brief", "mData": null, "bSortable": false, mRender: function (data) {

                       
                        if (data.brief_edit_status == "" || data.brief_edit_status == "N" )
                            {
                                var row_value = data.user_id + '_' + data.studio_code;
                                return '<center><button type="button" id=' + row_value + ' class="authorize">Edit Brief Enable</button></center>';
                            }
                            
                            else 
                            {
                                //return "<center style='color: green'>Authorized</center>";
                                return "";
                            }
                            
                        
                        
                        
                    }
                },
                



                
               
                
               
            ];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');
        }


      



       

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i><span id="title_name">Tutor Wise Brief Edit Rights</span>
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_studio_proposal_dtl" class="panel panel-default" style="display: none;">

            <div class="panel-heading">
                <strong id="panel_head">Tutor Wise Brief Edit Rights</strong>
            </div>
            <div id="DataList" style="display: none; overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

        

            

        </div>
         
    </div>

</asp:Content>

