<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="DRP_topic_wise_assign_faculty.aspx.cs" Inherits="Admin_Master_DRP_topic_wise_assign_faculty" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js?t=28062019"></script> 
   <%-- <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>--%>

    <script type="text/javascript">
        var oTable;
        var semester = '';
        var year_code = '';
        var tempData = [];
        var FileNameBrief;
        var data_value = { 'doc_no': '', 'inst_code': '', 'semester': '', 'year': '','doc':'' };
        var doc_path_name;
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            $('#btnreterive').on('click', function () {
                //bind_inst();
                get_drp_topic_data();
                return false;
            });
        });

        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();

        }
        function bindyeardata_for_cross_reg()
        {
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
                        for (var i = 0; i < year_data.length; i++)
                        {
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
        var bind_fac;
        var rem_inst;
        function bind_inst() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_drp_wise_inst_dtl",
                async: false,
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                dataType: "json",
                success: function (data)
                {
                    if (data.d != "") {
                        rem_inst = JSON.parse(data.d)
                        bind_fac = '';
                        $('#cls_int_type').off();  // Remove any previous event handlers
                        $('#cls_int_type').empty();
                        //$('#cls_int_type').empty().append($("<option></option>").val("").html("-- Please Select Instructor --"));
                        //$('#cls_int_type').append('<option value=dfasdf>ass</option>');
                        //$('#cls_int_type').append(rem_inst[0]["options"]);

                        //for (var i = 0; i < rem_inst.length; i++)
                        //{
                        //    if (i == 0)
                        //    {
                        //        bind_fac = '<option value=' + rem_inst[i]["instructor_code"] + '>' + rem_inst[i]["instructor_name"] + '</option>';
                        //
                        //    }
                        //    else {
                        //        bind_fac = bind_fac + '<option value=' + rem_inst[i]["instructor_code"] + '>' + rem_inst[i]["instructor_name"] + '</option>';
                        //
                        //    }
                        //}
                        bind_fac = rem_inst[0]["options"];
                       
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function get_drp_topic_data() {
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
                    url: "../../WebService.asmx/get_drp_topic_dtl",
                    async: false,
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    async:true,
                    success: function (data) {
                        
                        if (data.d != "" && data.d != "[]") {
                            
                            var inst_dtl = JSON.parse(data.d); 
                            drp_wise_inst_list(data.d); 
                            $('#div_course_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            $('#div_course_list').css('display', 'none');

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function drp_wise_inst_list(data) {
            var ss = JSON.parse(data);
            if ($("#example tbody tr").length > 0)
            {
                $("#example tbody tr").each(function (i)
                {
                    $('#cls_int_type').off();  
                    $(this).find('#cls_int_type').empty();    
                });
                

            }
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Doc No ", "mData": "doc_no", "bSortable": false, "sClass":"cls_hide"},
                    { "sTitle": "DRP Code ", "mData": "drp_code", "bSortable": false, "sClass":"cls_hide"},
                    { "sTitle": "Course Code ", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Guide Name ", "mData": "full_name", "bSortable": false },
                    { "sTitle": "DRP Topic ", "mData": "topic", "bSortable": false },
                    {
                        "sTitle": "Document ", "mData": null, "bSortable": false, fnRender: function (data) {
                            if (data.aData["doc_path"] != "") {
                                var path_value = "../../DRPTopicBriefDocs/" + data.aData["doc_path"];
                                return "<a href='" + path_value + "' download>Downlod PDF</a>";
                            }
                            else {
                                return "PDF Not Available";
                            }
                        }
                    },
                    {
                        "sTitle": "Instructor Name", "mData": null, "bSortable": false, fnRender: function (data)
                        {

                            return '<select id="cls_int_type" ><option value="">--Please Select Instructor--</option>' + bind_fac + '</select>';
                            //return '<select id="cls_int_type" ><option value="">--Please Select Instructor--</option></select>';
                            
                        }
                    },
                    {
                        "sTitle": "Document Upload (Only PDF)", "mData": null, "bSortable": false, fnRender: function (data)
                        {
                            
                            return '<input type="file" name=' + data.aData["drp_code"] +' id=' + data.aData["doc_no"] +' onchange="javascript:return UploadDrpBrief(this)"><span id = "lbl_brief_file_name" class=' + data.aData["doc_no"]+' style = "vertical-align: super;" ></span > ';
                           
                            $('#lbl_brief_file_name').val(data.aData["doc_path"]);
                            
                        }
                    }
                ]
            });
            $('#DataList').css('display', 'block');
            
            $("#example tbody tr").each(function (i)
            {
                //$('#cls_int_type').append('<option value=dfasdf>ass</option>');
                $(this).find('#cls_int_type').append(ss[0]['INSTName']);
                $('.cls_hide').css('display', 'none');
                $('#example tbody tr')[i].children[0].style.display = 'none';
                $('#example tbody tr')[i].children[1].style.display = 'none';
            });
           
        }

        function submit_drp_dtl() {
            $("#example tbody tr").each(function (i) {
               
                data_value.doc_no = $(this).children().eq(0).html();
                var drpno = $(this).children().eq(1).html();//$(this).children().eq(7)[0].children[1].text;
                data_value.inst_code = $(this).children().eq(6)[0].children[0].value;
                data_value.semester = semester;
                data_value.year = year_code;
                var value_file = $('.' + drpno).text();
                if (value_file != "" && value_file != "undefined")
                {
                    data_value.doc = value_file;
                }
                if ($(this).children().eq(6)[0].children[0].value != "" || value_file != "")
                {
                    tempData.push(data_value);
                }
                
                data_value = { 'doc_no': '', 'inst_code': '', 'semester': '', 'year': '', 'doc': '' };

            });

            if (tempData.length == 0) {
                bootbox.alert("Instructor not Selected OR PDF not Uploaded.");
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_drp_value",
                    data: "{faculty_drp_Data:'" + JSON.stringify(tempData) + "'}",
                    dataType: "json",
                    success: function (data) {
                        tempData = [];
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == 'Data Saved Successfully') {
                                get_drp_topic_data();
                                bootbox.alert("Data Saved Successfully");

                            }
                            else {
                                bootbox.alert(data.d);
                            }
                        }
                    },
                    error: function (result) {
                        tempData = [];
                        bootbox.alert(result);
                    }
                });

        }


        function GetFileNameFromPathDRPBrief(pre_fix,strFilepath) {

            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return pre_fix +'_'+ strName[0];
            }
        }

        function CheckDrpBriefExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'pdf':
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

        function UploadDrpBrief(e) {

            if ($("#drpsemester").val() == "") {
                $('#drp_brief').val('');
                alert("Please Select Semester");
                return false;
            }
            if ($("#drpyear").val() == "") {
                $('#drp_brief').val('');
                alert("Please Select Year");
                return false;
            }
            
            var pre_fix = e.name;
            var file_name = e.files[0]['name'];
            
            try {
                var fileToUpload = GetFileNameFromPathDRPBrief(pre_fix,file_name);

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckDrpBriefExtension(fileToUpload))
                {

                    var flag = true;

                    if (filename != "" && filename != null) {
                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/Drp_Topic_Brief_Doc.ashx',
                                secureuri: false,
                                data: { 'UploadType': 'drp_brief', 'Course_Code': pre_fix },
                                fileElementId: e.id,
                                dataType: 'json',
                                success: function (data, status)
                                {
                                    if (typeof (data.error) != 'undefined')
                                    {
                                        if (data.error != '')
                                        {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#drp_brief').val("");
                                            $('.' + e.name).html('<b>' + data.upfile + '</b>');
                                            $('.' + e.name).css('display', 'none');
                                            FileNameBrief = data.upfile;
                                            alert('DRP Brief Details Uploaded Successfully.');
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e)
                                {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    $('#drp_brief').val('');
                    alert('Invalid File Type. Please upload .pdf format file.');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>DRP Topic Wise Assign Instructor
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
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
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>DRP Topic </strong>
            </div>
            <div>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div>
                <table style="width: 62%; margin-left: 15%;">
                    <tr>
                        <td align="center">
                            <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_drp_dtl()">Submit</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>


    </div>
</asp:Content>

