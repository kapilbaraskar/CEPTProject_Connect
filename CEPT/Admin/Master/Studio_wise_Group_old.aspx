<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Studio_wise_Group_old.aspx.cs" Inherits="Admin_Master_Studio_wise_Group" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div id="div_wel" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Dashboard</span></strong></div>
            <div style="padding-top: 10px; padding-left: 10px;">
                <div class="row">
                    <div id="wel_msg" class="form-group col-md-12" align="center">
                        <h1>
                            Welcome</h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Retrieve Course Data</span></strong></div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Semester :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpsem">
                            <option value="M">Monsoon</option>
                            <option value="S">Spring</option>
                        </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Year :
                    </div>
                    <div id="div_cur_sem_course" class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpyear">
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <button class="btn btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Program :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpprog">
                        </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Program Level :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpproglevel">
                        </select>
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px; display: none;">
                        Department
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px; display: none;">
                        <select class="chosen-select" id="drpdepartment" />
                    </div>
                    <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static" />
                </div>
                <div class="row">
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Course :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpcourse">
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Retrieve Course Data</span></strong></div>
            <div class="form-group col-md-1" style="padding-top: 8px;">
                Select Group :
            </div>
            <div class="form-group col-md-3" style="padding-top: 6px;">
                <select class="chosen-select" id="drpgroup">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                </select>
            </div>
        </div>
    </div>
    <div id="studiocourse" class="tab-pane">
        <%-- in active">--%>
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
    <script>
        var oTable1;
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindprogrammedata();
            bindproglevel();
            binddepartment();
            get_fauser_detail();

            var cur_sem;
            var cur_year;
            var prog_code;
            var prog_level_code;

            $('#btnRetrieve').on('click', function () {



            });

            $('#drpsem,#drpyear,#drpprog,#drpproglevel').on('change', function () {

                cur_sem = $('#drpsem').val();
                if (cur_sem == "") {
                    bootbox.alert('Please select semester');
                    $('#drpsem').focus();
                    return false;
                }

                cur_year = $('#drpyear').val();
                if (cur_year == "") {
                    bootbox.alert('Please select Year');
                    $('#drpyear').focus();
                    return false;
                }

                dept_code = $('#drpdepartment').val();
                if (dept_code == "") {
                    bootbox.alert('Please select Department');
                    $('#drpdepartment').focus();
                    return false;
                }

                prog_code = $('#drpprog').val();
                prog_level_code = $('#drpproglevel').val();


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_studio_course_data_for_group_entry",
                    async: false,
                    data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        //   display_data(data.d);

                        if (data.d != "") {


                            var course_data = JSON.parse(data.d)

                            $('#drpcourse').empty();
                            for (var i = 0; i < course_data.length; i++) {


                                $('#drpcourse').append($("<option></option>").val(course_data[i]["course_code"]).html(course_data[i]["course_code"]));
                            }

                            $('#drpcourse').chosen();
                            $("#drpcourse").trigger("liszt:updated");
                        }
                        else {

                            $('#drpcourse')
                .find('option')
                .remove()
                .end()
                .append('<option value="">No data found</option>')
                .val('');
                            $('#drpcourse').chosen();

                            $('#drpcourse').val('').trigger("liszt:updated");
                        }


                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

        });

        $(document).on("click", ".cls_group_title", function (event) {

            debugger;

            var row = $(this).closest("tr").get(0);
            var aData = oTable1.fnGetData(row);



        });

        function display_data(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                    //"copy",
				"print",
            	{
            	    "sExtends": "collection",
            	    "sButtonText": 'Export',
            	    "aButtons": ["xls"]
            	}
			]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
            { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
             { "sTitle": "Select Group",
                 "bSortable": false,
                 "mData": null,
                 fnRender: function (oObj) {
                     var listItems = '<select class="cls_group_selection">';
                     listItems += "<option value='0'>Select</option>";
                     listItems += "<option value='1'>1</option>";
                     listItems += "<option value='2'>2</option>";
                     listItems += "<option value='3'>3</option>";
                     listItems += "<option value='4'>4</option>";
                     listItems += "<option value='5'>5</option>";
                     listItems += "<option value='6'>6</option>";
                     listItems += "<option value='7'>7</option>";
                     listItems += "<option value='8'>8</option>";
                     listItems += "<option value='9'>9</option>";
                     listItems += "<option value='10'>10</option>";
                     listItems += '</select>';

                     return listItems;
                 }
             },
              { "sTitle": "Add Title",
                  "bSortable": false,
                  "mData": null,



                  "mRender": function () {

                      debugger;
                      //                //alert(course_code);
                      return '<center><a style="cursor:pointer" class="cls_group_title" >Add</a></center>';



                  }
              }


        ]
            });

            $('#DataList').css('display', 'block');
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

        function bindprogrammedata() {
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
            else if ($('#hdn_utype').val() == 'PC') {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_programme_coordinator_dtl",
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
                            //$('#drpprog').val(user_data[0]['prog_code']);
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

                if ($("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
                    $('#drpprog').chosen();
                }
            }
        }

        function bindproglevel() {

            //    $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            //    $('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
            //    $('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data_rights_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d)

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }

                        // if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                        $('#drpproglevel').chosen();
                        //  }

                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        }


        function binddepartment() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",

                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {

                    if (data.d != "") {

                        var sem_data = JSON.parse(data.d)

                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                        for (var i = 0; i < sem_data.length; i++) {
                            $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                        }
                        $('#drpdepartment').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function get_fauser_detail() {
            if ($('#hdnusertype').val() == 'FA') {

                //     $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_department_wise_user_dtl",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);
                            $('#drpdepartment').val(user_data[0]['dept_code']);

                            //$('#drpprog').val(user_data[0]['prog_code']);
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }
    </script>
</asp:Content>
