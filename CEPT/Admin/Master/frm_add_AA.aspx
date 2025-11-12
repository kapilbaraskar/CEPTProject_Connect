<%@ Page Title="Course wise AA" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="frm_add_AA.aspx.cs" Inherits="Admin_Master_frm_add_AA" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">

        var instructor = '';
        var instructor1 = '';
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            //  bindyeardata();
            bindsemdata();
            binddepartment();
            bindinstructor();
            bindinstructor_TA();
            $('#drpsemester,#drpyear,#drpdepartment').on('change', function () {

                $('#DataList').css('display', 'none');

            });

            $('#btn_instructor').on('click', function () {
               
                var str = "<tr><td>" + instructor + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td><td><input type='button' value='Save' class ='but_click_aa'/></td></td></tr>";
                $('#tblinstructor tbody').append(str);

                // $('.drpinstructor').chosen();
                // $('.chzn-drop').css({ "width": "140px" });
                return false;
            });

            $('#btn_instructor_TA').on('click', function () {
           
                var str = "<tr><td>" + instructor + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td><input type='button' value='Save' class ='but_click'/></td></tr>";
                $('#tblinstructor_TA tbody').append(str);

                // $('.drpinstructor').chosen();
                // $('.chzn-drop').css({ "width": "140px" });
                return false;
            });

            $('#btn_add').on('click', function () {
                
                //    alert($('#spn_course_code').text());

                var instructor_data_list = [];



                $("#tblinstructor tbody tr").each(function (j) {
                    var instructor_data = { 'instructor_code': '' };

                    instructor_data.instructor_code = $(this).find(".drpinstructor").val();

                    instructor_data_list.push(instructor_data);
                });

                if (instructor_data_list.length == 0) {
                    bootbox.alert("Please Add AA ");

                    return false;
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_course_wise_AA",

                    data: "{ 'course_AA_data': '" + JSON.stringify(instructor_data_list) + "', 'sem_code': '" + $('#drpsemester').val() + "', 'year_code':'" + $('#drpyear').val() + "' , 'course_code':'" + $('#spn_course_code').text() + "' }",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            if (data.d == "Data Saved Successfully") {
                                $('#btnreterive').click();
                                $('#popup_add_aa').modal('hide');
                            }

                            bootbox.alert(data.d);

                        }
                        else {
                            bootbox.alert(data.d);
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                return false;

            });


            $('#btn_save_TA').on('click', function () {

                
                //    alert($('#spn_course_code').text());

                var instructor_data_list = [];



                $("#tblinstructor_TA tbody tr").each(function (j) {

                    var instructor_data = { 'instructor_code': '' };

                    instructor_data.instructor_code = $(this).find(".drpinstructor").val();

                    instructor_data_list.push(instructor_data);
                });

                if (instructor_data_list.length == 0) {
                    bootbox.alert("Please Add AA ");

                    return false;
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_course_wise_TA",

                    data: "{ 'course_TA_data': '" + JSON.stringify(instructor_data_list) + "', 'sem_code': '" + $('#drpsemester').val() + "', 'year_code':'" + $('#drpyear').val() + "' , 'course_code':'" + $('#spn_course_code_TA').text() + "' }",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            if (data.d == "Data Saved Successfully") {
                                $('#btnreterive').click();
                                $('#popup_add_TA').modal('hide');
                            }

                            bootbox.alert(data.d);

                        }
                        else {
                            bootbox.alert(data.d);
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                return false;

            });
            $('#btn_delete_aa').on('click', function () {
                
                //    alert($('#spn_course_code').text());

                var instructor_data_list = [];



                $("#tblinstructor tbody tr").each(function (j) {
                    var instructor_data = { 'instructor_code': '' };

                    instructor_data.instructor_code = $(this).find(".drpinstructor").val();

                    instructor_data_list.push(instructor_data);
                });

                if (instructor_data_list.length == 0) {
                    bootbox.alert("No entry found for delete.");

                    return false;
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/delete_course_wise_AA",

                    data: "{ 'sem_code': '" + $('#drpsemester').val() + "', 'year_code':'" + $('#drpyear').val() + "' , 'course_code':'" + $('#spn_course_code').text() + "' }",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            if (data.d == "Data delete successfully.") {
                                $('#btnreterive').click();
                                $('#popup_add_aa').modal('hide');
                            }

                            bootbox.alert(data.d);

                        }
                        else {
                            bootbox.alert(data.d);
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                return false;

            });

            $('#btn_delete_TA').on('click', function () {
                
                //    alert($('#spn_course_code').text());

                var instructor_data_list = [];



                $("#tblinstructor_TA tbody tr").each(function (j) {
                    var instructor_data = { 'instructor_code': '' };

                    instructor_data.instructor_code = $(this).find(".drpinstructor").val();

                    instructor_data_list.push(instructor_data);
                });

                if (instructor_data_list.length == 0) {
                    bootbox.alert("No entry found for delete.");

                    return false;
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/delete_course_wise_TA",// change only web service

                    data: "{ 'sem_code': '" + $('#drpsemester').val() + "', 'year_code':'" + $('#drpyear').val() + "' , 'course_code':'" + $('#spn_course_code_TA').text() + "' }",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            if (data.d == "Data delete successfully.") {
                                $('#btnreterive').click();
                                $('#popup_add_TA').modal('hide');
                            }

                            bootbox.alert(data.d);

                        }
                        else {
                            bootbox.alert(data.d);
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                return false;

            });

            $('#btnreterive').on('click', function () {

                var sem_code = $('#drpsemester').val();

                if (sem_code == '') {
                    bootbox.alert('Please select semester');
                    return false;
                }

                var year_code = $('#drpyear').val();

                if (year_code == '') {
                    bootbox.alert('Please select year');
                    return false;
                }

                var dept_code = $('#drpdepartment').val();

                if (dept_code == '') {
                    bootbox.alert('Please select department');
                    return false;
                }

                $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_course_data_department_wise",

        data: "{sem_code:'" + sem_code + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {



                display_course_data(data.d);
            }
            else {
                bootbox.alert('There is No data Found For Selected Semester or Year');
            }

        },
        error: function (result) {
            alert(result);
        }
    });

            });

            $('#btn_assign').on('click', function () {

                return false;

            });

            return false;

        });


        function bindinstructor() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_faculty_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {




                    if (data.d != "") {


                        var instructor_data = JSON.parse(data.d)


                        instructor = "<select style='width:85%' class='drpinstructor'>";


                        for (var i = 0; i < instructor_data.length; i++) {

                            instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";

                        }

                        instructor = instructor + "</select>";


                    }

                },
                error: function (result) {
                    alert(result);
                }
            });

        }

        function bindinstructor_TA() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_faculty_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {




                    if (data.d != "") {


                        var instructor_data = JSON.parse(data.d)


                        instructor1 = "<select style='width:85%' class='drpinstructor_TA'>";


                        for (var i = 0; i < instructor_data.length; i++) {

                            instructor1 = instructor1 + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";

                        }

                        instructor1 = instructor1 + "</select>";


                    }

                },
                error: function (result) {
                    alert(result);
                }
            });

        }

        function display_course_data(data) {


            if (oTable != null) {
                oTable.fnDestroy();


                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //    "bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //        "sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //							"copy",
				//			"print",
            	//						{
            	//						    "sExtends": "collection",
            	//						    "sButtonText": 'Export',
            	//						    "aButtons": ["xls"]

            	//						}
                //    ]
                //},

                "aaData": JSON.parse(data),
                "aoColumns": [
                                 { "sTitle": "Course Code", "mData": "course_code", "bSortable": false, "bVisible": true },
                                 { "sTitle": "Course Name", "mData": "course_name", "bSortable": false, "bVisible": true },
                                  { "sTitle": "AA Name", "mData": "instructor", "bSortable": false, "bVisible": true },
           {
               "sTitle": "<center>Add AA</center>",
               "mData": null,
               "bSortable": false,
               "sDefaultContent": '<center>   <button class="btn btn-primary btn-small" type="button" id="btn_add_aa">Add AA</button></center>'
           },

                { "sTitle": "TA Name", "mData": "instructor_TA", "bSortable": false, "bVisible": true },
                        {
                            "sTitle": "<center>Add TA</center>",
                            "mData": null,
                            "bSortable": false,
                            "sDefaultContent": '<center>   <button class="btn btn-primary btn-small" style="display:none;" type="button" id="btn_add_TA">Add TA</button></center>'
                        }
                                ]

            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';


        }

        $('#btn_add_aa').live('click', function (e) {

            

            $('#tblinstructor tbody').html('');



            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);


            $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_single_course_saved_data",

        data: "{sem_code:'" + $('#drpsemester').val() + "' , year_code : '" + $('#drpyear').val() + "',course_code: '" + aData.course_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {


                var course_instructor_data = JSON.parse(data.d)

                for (var i = 0; i < course_instructor_data.length; i++) {


                    var str = "<tr><td>" + instructor + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td></td></tr>";


                    $('#tblinstructor tbody').append(str);

                }


                $("#tblinstructor tbody tr").each(function (j) {

               
                    for (var i = 0; i < course_instructor_data.length; i++) {

                        if (j == i) {
                            $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);

                            //    $(this).find(".drpinstructor").chosen();
                            // $(this).find(".drpinstructor").trigger("liszt:updated");
                        }
                    }



                });



            }
            else {


            }


        },
        error: function (result) {
            alert(result);
        }
    });


            $('#spn_course_code').text(aData.course_code);

            $('#popup_add_aa').modal('show');

        });

        $('#tblinstructor tbody tr td i.icon-trash').live('click', function (e) {

            var r = confirm("Are you sure you want to remove this?");
            if (r == true) {

                var datalist = [];
                var flag = 'Y';
                var ob = {};
                var thisdata = $(this).closest("tr");
                var inst_code = thisdata.find(".drpinstructor").val();
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/course_wise_Delete_TA_AA",
                        data: "{'inst_code':'" + inst_code + "','sem_code':'" + $('#drpsemester').val() + "' , 'year_code' : '" + $('#drpyear').val() + "','course_code': '" + $('#spn_course_code').text() + "','inst_type':'AA'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == "Data Delete Successfully")
                            {
                                //$(this).closest("tr").remove();
                                thisdata.remove();
                                $('#btnreterive').click();
                                //$('#popup_add_aa').modal('hide');
                                //$(this).closest("tr").remove();
                              

                            }
                            bootbox.alert(data.d);
                            return false;
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                var totalsum = 0;

                
            }
            
        });


        //TA
        $('#tblinstructor_TA tbody tr td i.icon-trash').live('click', function (e) {

            var r = confirm("Are you sure you want to remove this?");
            if (r == true) {

                var datalist = [];
                var flag = 'Y';
                var ob = {};
                var thisdata = $(this).closest("tr");
                var inst_code = thisdata.find(".drpinstructor").val();

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/course_wise_Delete_TA_AA",
                        data: "{'inst_code':'" + inst_code + "','sem_code':'" + $('#drpsemester').val() + "' , 'year_code' : '" + $('#drpyear').val() + "','course_code': '" + $('#spn_course_code_TA').text() + "','inst_type':'TA'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d == "Data Delete Successfully") {
                                thisdata.remove();
                                $('#btnreterive').click();
                                //$('#popup_add_TA').modal('hide');
                               
                            }
                            bootbox.alert(data.d);
                            return false;
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

              




                //$(this).closest("tr").remove();
                //var totalsum = 0;
                

            }
        });


        $('#btn_add_TA').live('click', function (e) {

          

            $('#tblinstructor_TA tbody').html('');



            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var studio_status = false;

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Studio_teaching_interest_dtl",
                    data: "{studio_code: '" + aData.course_code + "',sem_code:'" + $('#drpsemester').val() + "' , year_code : '" + $('#drpyear').val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "")
                        {
                            bootbox.alert("For Studio : Please Select TA From TA Application Page <a href='department_wise_ta_approved.aspx'>click</a>");
                             studio_status = true;

                            return false;

                        }

                    },
                    error: function (result) {
                        //alert(result);
                    }
                });
            
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_single_course_saved_data_TA",

                        data: "{sem_code:'" + $('#drpsemester').val() + "' , year_code : '" + $('#drpyear').val() + "',course_code: '" + aData.course_code + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {


                                var course_instructor_data = JSON.parse(data.d)

                                for (var i = 0; i < course_instructor_data.length; i++) {


                                    var str = "<tr><td>" + instructor + "</td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";


                                    $('#tblinstructor_TA tbody').append(str);

                                }


                                $("#tblinstructor_TA tbody tr").each(function (j) {


                                    for (var i = 0; i < course_instructor_data.length; i++) {

                                        if (j == i) {
                                            $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);

                                            //    $(this).find(".drpinstructor").chosen();
                                            // $(this).find(".drpinstructor").trigger("liszt:updated");
                                        }
                                    }



                                });



                            }
                            else {


                            }


                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            
  

            if (studio_status == false) {
                $('#spn_course_code_TA').text(aData.course_code);

                $('#popup_add_TA').modal('show');
            }
            

        });

        $('#tblinstructor_TA tbody tr td input.but_click').live('click', function (e) {
            
            cur_tr = $(this).closest('tr');
            var inst_code = cur_tr.find(".drpinstructor").val();
            if (inst_code == '') {
                bootbox.alert('Please Select Instructor')
                return false;
            }
            var sem_code = '';
            var year_code = '';
            if ($('#drpsemester').val() != '') {
                sem_code = $('#drpsemester').val();
            }
            if ($('#drpyear').val() != '') {
                year_code = $('#drpyear').val();
            }

            var instructor_data_list = [];
           var instructor_data = { 'instructor_code': '' };

            instructor_data.instructor_code = inst_code;

           instructor_data_list.push(instructor_data);
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    //url: "../../WebService.asmx/save_course_wise_TA",
                    url: "../../WebService.asmx/course_wise_TA_save",

                    data: "{ 'course_TA_data': '" + JSON.stringify(instructor_data_list) + "', 'sem_code': '" + $('#drpsemester').val() + "', 'year_code':'" + $('#drpyear').val() + "' , 'course_code':'" + $('#spn_course_code_TA').text() + "',inst_type:'TA' }",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            if (data.d == "Data Saved Successfully") {
                                cur_tr.find('.but_click').css('display', 'none');
                                $('#btnreterive').click();
                                //$('#popup_add_TA').modal('hide');
                            }

                            bootbox.alert(data.d);

                        }
                        else {
                            bootbox.alert(data.d);
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            return false;


        });


        $('#tblinstructor tbody tr td input.but_click_aa').live('click', function (e) {

            cur_tr = $(this).closest('tr');
            var inst_code = cur_tr.find(".drpinstructor").val();
            if (inst_code == '') {
                bootbox.alert('Please Select Instructor')
                return false;
            }
            var sem_code = '';
            var year_code = '';
            if ($('#drpsemester').val() != '') {
                sem_code = $('#drpsemester').val();
            }
            if ($('#drpyear').val() != '') {
                year_code = $('#drpyear').val();
            }

            var instructor_data_list = [];
            var instructor_data = { 'instructor_code': '' };

            instructor_data.instructor_code = inst_code;

            instructor_data_list.push(instructor_data);
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    //url: "../../WebService.asmx/save_course_wise_TA",
                    url: "../../WebService.asmx/course_wise_TA_save",

                    data: "{ 'course_TA_data': '" + JSON.stringify(instructor_data_list) + "', 'sem_code': '" + $('#drpsemester').val() + "', 'year_code':'" + $('#drpyear').val() + "' , 'course_code':'" + $('#spn_course_code').text() + "',inst_type:'AA' }",

                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            if (data.d == "Data Saved Successfully") {
                                cur_tr.find('.but_click_aa').css('display', 'none');
                                $('#btnreterive').click();
                                //$('#popup_add_aa').modal('hide');
                            }

                            bootbox.alert(data.d);

                        }
                        else {
                            bootbox.alert(data.d);
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            return false;


        });

        //$('.close_add').on('click', function () {
        //    $('#popup_add_TA').modal('hide');
        //});
       

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="modal hide fade" id="popup_add_aa" style="margin-left: -240px; width: 30%; overflow: auto;">
       
            <div class="modal-header">
                <b>Add AA for Course Code : <span id="spn_course_code"></span></b> <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <div class="row-fluid" id="dataList_instructor" style="display: block;">
                    <div class="box-content box-no-padding">
                        <button class="btn  btn-primary" type="button" id="btn_instructor">
                            <i class="icon-plus"></i>&nbsp;Add AA
                        </button>
                    </div>
                    <div style="text-align: center;">
                        <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor">
                            <thead>
                                <tr>
                                    <th>
                                        Instructor
                                    </th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <br />
                </div>
            </div>
            <div class="modal-footer">
                <center>
                    <a href="#" id="btn_add" class="btn btn-primary" style="display:none;">Save AA</a>
                      <a href="#" id="btn_delete_aa" class="btn btn-primary" style="display:none;">Delete all AA</a>
                </center>

            </div>
       
    </div>

     <div class="modal hide fade" id="popup_add_TA" style="margin-left: -240px; width: 30%; overflow: auto;">
       
            <div class="modal-header">
                <b>Add TA for Course Code : <span id="spn_course_code_TA"></span></b> <button type="button" class="close" data-dismiss="modal">×</button>
            </div>
            <div class="modal-body">
                <div class="row-fluid" id="dataList_instructor_TA" style="display: block;">
                    <div class="box-content box-no-padding">
                        <button class="btn  btn-primary" type="button" id="btn_instructor_TA">
                            <i class="icon-plus"></i>&nbsp;Add TA
                        </button>
                    </div>
                    <div style="text-align: center;">
                        <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor_TA">
                            <thead>
                                <tr>
                                    <th>
                                        Instructor
                                    </th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <br />
                </div>
            </div>
            <div class="modal-footer">
                <center>
                    <a href="#" id="btn_save_TA" class="btn btn-primary" style="display:none;">Save TA</a>
                      <a href="#" id="btn_delete_TA" class="btn btn-primary" style="display:none;">Delete all TA</a>
                </center>

            </div>
       
    </div>
  
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Add Course wise AA
            </h1>
        </div>
        <div>
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
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="button" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="DataList" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
