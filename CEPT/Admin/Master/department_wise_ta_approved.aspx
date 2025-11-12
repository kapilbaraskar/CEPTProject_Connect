<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="department_wise_ta_approved.aspx.cs" Inherits="Admin_Master_department_wise_ta_approved" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/admin_report.js?t=03042023" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            //binddepartment(); 
            bindprogrammedata();
            bindproglevel();
            bindTAType();
            if ($('#hdn_user_type').val() == 'A1' || $('#hdn_user_type').val() == 'FA') {
                $('#studio_code').css('display', '');
                $('#studio_name').css('display', '');
            }
            else {
                $('#studio_code').css('display', 'none');
                $('#studio_name').css('display', 'none');}
           // bindstudio();
            $('#btnreterive').on('click', function () {
                var semester = $('#drpsemester').val();
                if (semester == "")
                {
                    bootbox.alert('Please select semester')
                    $('#drpsemester').focus();
                    return false;
                }

                var year_code = $('#drpyear').val();
                if (year_code == "")
                {
                    bootbox.alert('Please select year')
                    $('#drpyear').focus();
                    return false;
                }
                $('#hdn_sem_code').val(semester);
                $('#hdn_year_code').val(year_code);
                var drp_code = $('#drpdepartment').val();
                if (drp_code == "") {
                    bootbox.alert('Please select Department')
                    $('#drpdepartment').focus();
                    return false;
                }
                if ($('#hdn_user_type').val() == 'A1' || $('#hdn_user_type').val() == 'FA')
                {
                var studio_code = $('#drpstudio_code').val();
                    if (studio_code == "") {
                        bootbox.alert("Please Select Studio Code");
                        return false;
                    }
                }
                bindstudio();
                get_TA_details();
                return false;
            });

            $('#drpsemester,#drpyear,#drpdepartment,#drptype').on('change', function () {
                
                var end = this.value;
                var semester = $('#drpsemester').val();
                if (semester == "") {
                    //bootbox.alert('Please select semester')
                    $('#drpsemester').focus();
                    return false;
                }

                var year_code = $('#drpyear').val();
                if (year_code == "") {
                    //bootbox.alert('Please select year')
                    $('#drpyear').focus();
                    return false;
                }
                if ($('#hdn_user_type').val() == 'A1' || $('#hdn_user_type').val() == 'FA') {
                    if (this.id != 'drpdepartment' && this.id != 'drptype') {
                        binddept();
                    }
                }
                else
                {
                    if (this.id == 'drpdepartment' || this.id == 'drptype') {
                        
                    }
                    else { binddept();}
                }
                
                if ($('#hdn_user_type').val() == 'A1' || $('#hdn_user_type').val() == 'FA')
                {
                    var drpdepartment = $('#drpdepartment').val();
                    //if (drpdepartment == "") {
                    //    //bootbox.alert('Please select year')
                    //    $('#drpdepartment').focus();
                    //    return false;
                    //}
                    console.log(this.id);
                    if (this.id == 'drpsemester') {
                        bindstudiocodeugpg();
                    }
                    if (this.id == 'drpyear') {
                        bindstudiocodeugpg();
                    }
                    if (this.id == 'drpdepartment') {
                        bindstudiocodeugpg();
                    }
                    if (this.id == 'drptype') {
                        bindstudiocodeugpg();
                    }
                    
                }
                
                
                
            });

          
            return false;
        });

       
        function binddept() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_user_wise_department",
                async: false,
                data: "{ sem_code:'" + $('#drpsemester').val() + "', year_code: '" + $('#drpyear').val() + "', action: 'true'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var dept_data = JSON.parse(data.d);
                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select DepartMent --"));

                        for (var i = 0; i < dept_data.length; i++)
                        {
                            $('#drpdepartment').append($("<option></option>").val(dept_data[i]["dept_code"]).html(dept_data[i]["dept_name"]));
                        }
                        $('#drpdepartment').chosen();
                        $('#drpdepartment').val('').trigger("liszt:updated");

                    } else {
                        $('#drpdepartment').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                        $('#drpdepartment').chosen();
                        $('#drpdepartment').val('').trigger("liszt:updated");
                    }
                       
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindstudiocodeugpg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_ugpg_studio_code",
                async: false,
                data: "{ sem_code:'" + $('#drpsemester').val() + "', year_code: '" + $('#drpyear').val() + "', dept_code: '" + $('#drpdepartment').val() + "', type: '" + $('#drptype').val() +"'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var dept_data = JSON.parse(data.d);
                        $('#drpstudio_code').empty().append($("<option></option>").val("").html("-- Please Select Studio --"));

                        for (var i = 0; i < dept_data.length; i++) {
                            $('#drpstudio_code').append($("<option></option>").val(dept_data[i]["studio_code"]).html(dept_data[i]["studio_code"] + ' - ' + dept_data[i]["studio_title"] ));

                        }
                        $('#drpstudio_code').chosen();
                        $('#drpstudio_code').val('').trigger("liszt:updated");

                    } else {
                        $('#drpstudio_code').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                        $('#drpstudio_code').chosen();
                        $('#drpstudio_code').val('').trigger("liszt:updated");
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        var bind_studio_code = '';
        function bindstudio()
        {
            var type = $('#drptype').val();
            var dept_code = $('#drpdepartment').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_user_wise_studio_code",
                async: false,
                data: "{ sem_code:'" + $('#drpsemester').val() + "', year_code: '" + $('#drpyear').val() + "', action: '" + type + "', dept_code: '" + dept_code +"'}",
                dataType: "json",
                success: function (data)
                {
                    if (data.d != "") {
                        var dept_data = JSON.parse(data.d);
                        bind_studio_code = JSON.parse(data.d);
                    }
                    else { bind_studio_code = '';}
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        $(document).on("click", ".pdf_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);


            //var instructor_code = aData["user_id"];
            var instructor_code = aData['user_id']
            var cv_file_name = aData["cv_file_name"];
            var portfolio_file_name = aData["portfolio_file_name"];
            if (instructor_code == '') {
                if (cv_file_name != '') {
                    var myArr = cv_file_name.split("_");
                    instructor_code = myArr[0];
                }
                if (portfolio_file_name != '') {
                    var myArr = cv_file_name.split("_");
                    instructor_code = myArr[0];

                }
            }



            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            var dep_name = "";

            if (semester == 'S') {
                semester = 'Spring';
            }
            else {
                semester = 'Monsoon';
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Download_Document_new_ta",
                data: "{'instructor_code':'" + instructor_code + "','cv_file_name':'" + cv_file_name + "','portfolio_file_name':'" + portfolio_file_name + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "1") {
                            $("#btnDownloadExcelDocuments").click();
                            return false;
                        }
                        else {
                            bootbox.alert('Document Not Found');
                        }
                        return true;
                    }
                    else {
                        bootbox.alert('Document Not Found');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        });


        function get_TA_details() {
            //$('#div_faculty_list').css('display', 'none');
            //$('#DataList').css('display', 'none');
            var user_type = $('#hdn_user_type').val();
            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select year')
                $('#drpyear').focus();
                return false;
            }

           var dept_code = $('#drpdepartment').val();
            if (dept_code == "") {
                bootbox.alert('Please select Department');
                $('#drpdepartment').focus();
                return false;
            }
            var type = $('#drptype').val();
            if (type == "") {
                bootbox.alert('Please select Type');
                $('#drpdepartment').focus();
                return false;
            }
            var studio_code = $('#drpstudio_code').val();


            //prog_code = $('#drpprog').val();
            //if (user_type != "A1") {
            //    if (prog_code == "") {
            //        bootbox.alert('Please select Programme');
            //        $('#drpprog').focus();
            //        return false;
            //    }
            //}


            //prog_level_code = $("#drpproglevel").val();  ///Returned By Ananth 26/04/2019

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_apply_ta_dtl_department_wise",
                data: "{semester: '" + semester + "',year: '" + year_code + "',studio_code:'" + studio_code + "' ,dept_code: '" + dept_code + "',type: '" + type + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null) {
                        if (data.d != "")
                        {
                            Display_TA_data(data.d);
                            //setDataTableHeaderFooter('example');
                        }
                        else {
                            $('#DataList').html('');
                            bootbox.alert('There is No data Found for selected semester and year');
                            return false;
                        }
                    }
                    else {
                        $('#DataList').html('');
                        bootbox.alert('There is No data Found for selected semester and year');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


        function Display_TA_data(data) {
            
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bStateSave": false,
                "iDisplayLength": 60,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [
                    /*{ "sTitle": "User id", "mData": "user_id", "bSortable": false },*/
                    { "sTitle": "Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Mail ", "mData": "mail", "bSortable": false },
                    { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Selected in Studio Code", "mData": "studio_code", "bSortable": false },
                    { "sTitle": "Selected in Studio Title", "mData": "studio_title", "bSortable": false },
                    //{ "sTitle": "Total Experiance", "mData": "total_experiance", "bSortable": false },
                    //{ "sTitle": "Rate Band", "mData": "rate_band", "bSortable": false },
                    {
                        "sTitle": "Document (CV,Portfolio,Reference Letter)", "mData": null, "sClass": "cls_action", mRender: function (data) {

                            return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'

                        }
                    },


                    {
                        "sTitle": "Select Studio", "mData": null, "bSortable": false, mRender: function (data) {
                           
                            var append_drodown = '';
                            if (data.faculty_selected == 'N' && data.apply_type == '23')
                            {
                                append_drodown = "";
                                for (var p = 0; p < bind_studio_code.length; p++)
                                {
                                    if (p == 0)
                                    {
                                        //bindstudio();
                                        append_drodown = '<select class="drpinstructor" id="selectstudio">';
                                        append_drodown += '<option value="">Please Select Studio</option>';
                                        append_drodown += '<option value=' + bind_studio_code[p]['studio_code'] + '>' + bind_studio_code[p]['studio_code'] + '_' + bind_studio_code[p]['studio_title'] + '</option>';
                                    }
                                    else {
                                        append_drodown += '<option value=' + bind_studio_code[p]['studio_code'] + '>' + bind_studio_code[p]['studio_code'] + '_' + bind_studio_code[p]['studio_title'] + '</option>';
                                    }
                                }
                                append_drodown += '</select>';
                            }
                            else if (data.faculty_selected == 'N' && data.apply_type == '24')
                            {
                                append_drodown = "";
                                for (var p = 0; p < bind_studio_code.length; p++) {
                                    if (p == 0) {
                                        //bindstudio();
                                        append_drodown = '<select class="drpinstructor" id="selectstudio">';
                                        append_drodown += '<option value="">Please Select Course</option>';
                                        append_drodown += '<option value=' + bind_studio_code[p]['course_code'] + '>' + bind_studio_code[p]['course_name'] + '</option>';
                                    }
                                    else {
                                        append_drodown += '<option value=' + bind_studio_code[p]['course_code'] + '>' + bind_studio_code[p]['course_name'] + '</option>';
                                    }
                                }
                                append_drodown += '</select>';
                            }
                            else if (data.faculty_selected == 'Y' && data.apply_type == '24' && $('#hdn_user_type').val() != 'FA' && $('#hdn_user_type').val() != 'A1') {
                                append_drodown = "";
                                for (var p = 0; p < bind_studio_code.length; p++) {
                                    if (p == 0) {
                                        //bindstudio();
                                        append_drodown = '<select class="drpinstructor" id="selectstudio">';
                                        append_drodown += '<option value="">Please Select Course</option>';
                                        append_drodown += '<option value=' + bind_studio_code[p]['course_code'] + '>' + bind_studio_code[p]['course_name'] + '</option>';
                                    }
                                    else {
                                        append_drodown += '<option value=' + bind_studio_code[p]['course_code'] + '>' + bind_studio_code[p]['course_name'] + '</option>';
                                    }
                                }
                                append_drodown += '</select>';
                                return '<span style = color:green;>Selected By ' + data.faculty_selected_name + '</br></br>' + append_drodown + '</span>';
                            }

                            else if (data.faculty_selected == 'Y')
                            {
                                if ($('#hdn_user_type').val() != 'FA' && $('#hdn_user_type').val() != 'A1' && $('#drptype').val() == '24')
                                {
                                    return '<span style = color:green;>Selected By ' + data.faculty_selected_name + '</br></br>' + append_drodown + '</span>';
                                }
                                else
                                {
                                    return '<span style = color:green;>Selected By ' + data.faculty_selected_name + '</br></br>' + append_drodown + '</span>';
                                    //append_drodown += '<span style = color:green;>Selected By ' + data.faculty_selected_name + '</span>';
                                }
                                
                            }
                           
                           
                            return  append_drodown;
                          

                        }
                    },

                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data)
                        {
                            var row_value = data.user_id + '_' + data.studio_code;
                            if (data.faculty_selected == 'N')
                            {
                                
                                return '<center><button type="button" class="authorize" id=' + row_value + '>Select</button></center>';
                            }
                            else if (data.faculty_selected == 'Y' && $('#drptype').val() == '24')
                            {
                                if ($('#hdn_user_type').val() != 'FA' && $('#hdn_user_type').val() != 'A1' && $('#drptype').val() == '24')
                                {
                                    return '<center><button type="button" class="authorize_repet" id=' + row_value + '>Select</button></center>';
                                }
                                else { return '<center><button type="button" class="authorize_repet" id=' + row_value + '>Select</button></center>'; }

                            }
                            else if (data.faculty_selected == 'Y')
                            {
                                return '';
                            }

                        }
                    },
                    {
                        "sTitle": "Personal Details", "mData": null, "bSortable": false, mRender: function (data) {

                            var row_value = data.user_id;
                            if (($('#hdn_user_type').val() == 'FA' || $('#hdn_user_type').val() == 'A1') && data.studio_code == '') {
                                return '<center><button type="button" id=' + row_value + ' onclick="rowClick_edit(this)" class="per_edit">Edit</button></center>';
                            }
                            else { return '';}
                            

                        }
                    },

                    {
                        "sTitle": "View Personal Details", "mData": null, "bSortable": false, mRender: function (data) {

                            var row_value = data.user_id;
                            //if (($('#hdn_user_type').val() == 'FA' || $('#hdn_user_type').val() == 'A1') && data.studio_code == '') {
                                return '<center><button type="button" id=' + row_value + ' onclick="rowClick_view(this)" class="per_edit">View</button></center>';
                           // }
                          //  else { return ''; }


                        }
                    },
                    {
                        "sTitle": "", "mData": null, "bSortable": false, "mRender": function (data)
                        {
                            var row_value = data.user_id;
                            return '<center><button type="button" id=' + row_value + ' onclick="rowClick(this)">Download</button></center>';
                        }
                    },
                    {
                        "sTitle": "Delete TA", "mData": null, "bSortable": false, "mRender": function (data) {
                            var row_value = data.user_id;
                            if (($('#hdn_user_type').val() == 'A1' || $('#hdnuserid').val() == 'admin.asc@cept.ac.in') && data.faculty_selected == 'Y')
                            {
                                return '<center><button type="button" id=' + row_value + ' class="delete_ta">Delete TA</button></center>';
                            }
                            return '';

                            
                        }
                    }

                   
                ]
            });
           // bindstudio();
            $('#div_faculty_list').css('display', 'block');
            $('#DataList').css('display', 'block');
            //$('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            
           // $('#selectstudio').append(bind_studio_code);
        }


        $(document).on("click", ".authorize", function (event) {
            
            //var row = $(this).closest("tr").get(0);

            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            
            
            var row = $(this).closest("tr");
            var studio_code = row.find(".drpinstructor").val();
            if (studio_code == "" && $('#hdn_user_type').val() != 'A1' && $('#hdn_user_type').val() != 'FA')
            {
                bootbox.alert("Please Select Studio Code");
                return false;
            }
            else if ($('#hdn_user_type').val() == 'A1' || $('#hdn_user_type').val() == 'FA')
            {
                studio_code = $('#drpstudio_code').val();
                if (studio_code == "") {
                    bootbox.alert("Please Select Studio Code");
                    return false;
                }
            }
            var type = $('#drptype').val();
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["user_id"];
            var doc_no = aData["new_doc_no"];
            var prog_code = aData["progcode"];
            var prog_level_code = aData["proglevelcode"];
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/accept_ta_req",
                    data: "{doc_no:'" + doc_no + "',studio_code:'" + studio_code + "',semester_type:'" + semester + "',year_semester:'" + year_code + "',instructor_code:'" + instructor_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',type:'"+type+"'}",
           
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            if (data.d == "HR Not Approved RateBand") {
                                bootbox.alert(' HR Not Approved RateBand. Please Contact HR. ');
                                return false;
                            }
                            else if (data.d == "true") {
                                
                                bootbox.alert('TA Request Accept Successfully ');
                                get_TA_details();
                            }
                        }
                        else
                        {
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


        $(document).on("click", ".authorize_repet", function (event) {

            //var row = $(this).closest("tr").get(0);

            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();


            var row = $(this).closest("tr");
            var studio_code = row.find(".drpinstructor").val();
            if (studio_code == "" && $('#hdn_user_type').val() != 'A1' && $('#hdn_user_type').val() != 'FA') {
                bootbox.alert("Please Select Studio Code");
                return false;
            }
            else if ($('#hdn_user_type').val() == 'A1' || $('#hdn_user_type').val() == 'FA') {
                studio_code = $('#drpstudio_code').val();
                if (studio_code == "") {
                    bootbox.alert("Please Select Studio Code");
                    return false;
                }
            }
            var type = $('#drptype').val();
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["user_id"];
            var doc_no = aData["new_doc_no"];
            var prog_code = aData["progcode"];
            var prog_level_code = aData["proglevelcode"];
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/accept_ta_req",
                    data: "{doc_no:'" + doc_no + "',studio_code:'" + studio_code + "',semester_type:'" + semester + "',year_semester:'" + year_code + "',instructor_code:'" + instructor_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',type:'" + type + "'}",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {

                            if (data.d == "HR Not Approved RateBand") {
                                bootbox.alert(' HR Not Approved RateBand. Please Contact HR. ');
                                return false;
                            }
                            else if (data.d == "true") {

                                bootbox.alert('TA Request Accept Successfully ');
                                get_TA_details();
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


        $(document).on("click", ".delete_ta", function (event) {

            //var row = $(this).closest("tr").get(0);

            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();


            var row = $(this).closest("tr");
            
            var type = $('#drptype').val();
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["user_id"];
            var studio_code = aData["studio_code"];
            var doc_no = aData["new_doc_no"];
            var prog_code = aData["progcode"];
            var prog_level_code = aData["proglevelcode"];
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/delete_ta_req_inst",
                    data: "{doc_no:'" + doc_no + "',studio_code:'" + studio_code + "',semester_type:'" + semester + "',year_semester:'" + year_code + "',instructor_code:'" + instructor_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "',type:'" + type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true")
                            {
                                bootbox.alert('TA Remove Successfully ');
                            }
                        }
                        else
                        {
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
            //vf_edit_personal_detail.aspx?ic=30
            var url = "vf_edit_personal_detail.aspx?ic=" + row.id ;
            window.open(url, "_blank");
        }
        function rowClick_view(row) {
            //vf_edit_personal_detail.aspx?ic=30
            var url = "Userdetails.aspx?ic=" + row.id + "&is=" + $('#drpsemester').val() + "" + "&iy=" + $('#drpyear').val()+"";
            window.open(url, "_blank");
        }
        function rowClick(row) {
            
            $('#hdn_user_id').val(row.id);

            $('#hdn_download').click();
        }
    </script>
    <style>
        #DataList .span6 
        {
            width:513px;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;TA Details
            </h1>
        </div>
        <div>
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Filter Criteria</strong>
                </div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                             <td>
                                Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                            
                        </tr>
                        <tr>
                            <td>
                                Type
                            </td>
                            <td>
                                <select class="chosen-select" id="drptype">
                                </select>
                            </td>
                            <td id="studio_name">
                                Course / Studio Name 
                            </td>
                            <td id="studio_code">
                                <select class="chosen-select" id="drpstudio_code">
                                </select>
                            </td>
                            <%--<td>
                                Program Level
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel">
                                </select>
                            </td>--%>
                            
                           <%-- <td>
                                Type 
                            </td>
                            <td>
                                <select class="chosen-select" id="drptype">
                                    <option value="">--select Type--</option>
                                    <option value="N">Pending</option>
                                    <option value="Y">Approved</option>
                                </select>
                            </td>--%>
                          
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="div_faculty_list" class="panel panel-default" style="display: none;">
                <div class="panel-heading">
                    <strong>TA Details</strong>
                </div>
                <div>
                    <div id="DataList" style="display: none; overflow:auto;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
     <asp:HiddenField ID="hdn_user_type" runat="server" ClientIDMode="Static" />
     <asp:HiddenField ID="hdn_sem_code" runat="server" ClientIDMode="Static" />
     <asp:HiddenField ID="hdn_year_code" runat="server" ClientIDMode="Static" />
     <asp:HiddenField ID="hdn_user_id" runat="server" ClientIDMode="Static" />
     <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadExcelDocuments_Click" /> 
    <asp:Button ID="hdn_download" runat="server"  Style="display: none;" ClientIDMode="Static" OnClick="hdn_download_Click" />
</asp:Content>

