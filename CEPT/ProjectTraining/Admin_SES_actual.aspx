<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="Admin_SES_actual.aspx.cs" Inherits="ProjectTraining_ProjectTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <div>
                    <b>Student Engagement Schedule</b>
                    <span>
                </div>

            </div>

            <div id="tbt" style="height: 487px; overflow: scroll;">
                <table id="tbl" class="display table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <td><b>Week</b></td>
                            <td><b>Dates</b></td>

                            <td colspan="3">
                                <center><b>Actual</b></center>
                            </td>
                            <td>
                                <center><b>Discription</b></center>
                            </td>
                            <td>
                                <center><b>Upload</b></center>
                            </td>
                            <td>
                                <center><b>Time Sheet</b></center>
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>

                </table>
            </div>
            <br />
            <br />

        </div>
        <div class="col-sm-12">

           <%-- <div class="col-xs-3 ">Date: </div>
            <div class="col-xs-3">Signature Of Student: </div>
            <div class="col-xs-3">--%>
            </div>
            <br />
        </div>
    </div>
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black;">
      <%--  <div id="div_buttons" class="container" style="display: block;">
            <div class="span11" style="margin-top: 10px">
                <table align="center" border="0" cellpadding="3" cellspacing="5">
                    <tr>
                        <%--  <table align="center" border="0" cellpadding="3" cellspacing="5">--%>
                      <%--  <td>
                            <button type="button" id="btn_plan" class="pull-right btn btn-lg btn-primary" data-toggle="modal" data-target="#planned">SES Planned</button>
                        </td>--%>
                        <td>
                            <%--<input type="button" style="margin-right: 10px" class=" pull-right" id="submit" value="Submit"/>--%>
                            <%--<input type="button" style="margin-right: 10px;" class="pull-right btn btn-lg btn-primary" id="save" value="save" />--%>
                        </td>

                    </tr>
                </table>
            </div>
        </div>--%>
    </div>

    <!-- Modal -->
    <div class="modal fade modal1" id="myModal" role="dialog" style="display: none;margin-left: -47% !important;width: 95% !important;">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Time Sheet</h4>
                </div>
                <div class="modal-body">
                    <div>
                        <center><u><b>TIME SHEET</b></u></center>
                    </div>
                    <div style="padding: 15px;" id="div3">
                        <div class="row">
                            <br />
                            <div style="" class="form-group col-md-12">
                                <div class="form-group col-sm-6 ">
                                    <p>Name of Student : <span id="stud_name"></span></p>
                                </div>
                                <div class="form-group col-sm-5">
                                    <p>code no : <span id="stud_code"></span></p>
                                </div>
                            </div>

                            <div style="" class="form-group col-md-12">
                                <div class="form-group col-sm-6 ">
                                    <p>Project Name :<span id="proj_code"></span> </p>
                                </div>
                                <div class="form-group col-sm-5">
                                    <p>Location :<span id="stud_loca"></span> </p>
                                </div>
                            </div>

                            <div style="" class="form-group col-md-12">
                                 
                            </div>

                            <div style="" class="form-group col-md-12">
                                <div class="form-group col-sm-6 ">
                                    <p>Date:<span id="dailysheet_time"></span> </p>
                                     <p>Time:<span id="daily_time"></span> </p>
                                </div>
                                <div class="form-group col-sm-5">
                                    <p><span id="Span2"></span></p>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <table id="tb_Time_sheet" class="display table table-striped table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <td>No</td>
                                        <td colspan="1">Activities</td>
                                    </tr>
                                </thead>
                            </table>

                        </div>
                    
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>
    </div>




    <!-- Modal -->
    <div class="modal fade planned1" id="planned" role="dialog" style="margin-left: -47%!important; width: 95%!important; display: none">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Student Engagement Schedule Planned</h4>
                </div>
                <div class="modal-body">
                    <div class="well" style="background-color: White;">
                        <div class="panel panel-default ">
                            <div class="panel-heading">
                                <div><b>Student Engagement Schedule</b></div>
                            </div>
                            <div id="Div1" style="height: 500px; overflow: scroll;">
                                <table id="tbl1" class="display table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <td><b>Week</b></td>
                                            <td><b>Dates</b></td>
                                            <td colspan="3">
                                                <center><b>Planned</b></center>
                                            </td>
                                            <td>
                                                <center><b>Remarks</b></center>
                                            </td>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>

                                </table>
                            </div>
                            <br />
                            <br />

                        </div>
                        <div class="col-sm-12">
                            <div class="col-sm-4 ">Date: </div>
                            <div class="col-sm-4">Signature Of Student: </div>
                            <div class="col-sm-4"></div>
                        </div>
                    </div>
                </div>

                <div class="copyright" style="box-shadow: 5px 0 6px 1px black;"></div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>

        </div>

    </div>
    <script type="text/javascript">

        $('#txt_user_id').val('<%= Session["UserId"] %>');
        $('#txt_name_student').val('<%= Session["UserName"] %>');
        $('#txt_email_stud').val('<%= Session["email"] %>');
        $('#stud_name').text('<%= Session["UserName"] %>');
        var join_date;
        var str = '';
        var str1 = '';
        var activity = new Object();
        var obj_Get_student_planned = new Object();
        var obj_Get_student_actual = new Object();
        var current_date;
        var dailysheet = new Object();
        var address_from_communication = '';
        var project_name = '';
        var user_id = ''
        var tmp_date = '';
        var selected_date = '';
        
        var user = '';

        if (user == undefined) {
            user = getQueryStringValue('user');
            if (user == '') {
                $(".file-upload").css('display', 'none');
                user = ('<%= Session["UserId"] %>');
                    }
                }

        function isNumberKey(evt) {
            debugger;
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
        }

        function getQueryStringValue(key) {
            return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }

        $(document).ready(function () {

            user = getQueryStringValue('user_id');
            user_name = getQueryStringValue('user_name');
            $('#stud_name').text(user_name);

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_currunt_date",
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d != "") {
                        current_date = result.d;
                        debugger;
                    }
                    else {
                        alert('a');
                    }

                },
                error: function (error) {
                    console.log(error);
                }
            });




            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_sjr_report_date_for_admin",
                data: '{user_id : "' + user + '"}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {

                    if (result.d != "") {
                        obj_date = JSON.parse(result.d);
                        join_date = obj_date[0]['date_of_join'];
                        address_from_communication = obj_date[0]['address_from_communication'];
                        project_name = obj_date[0]['project_name'];
                        user_id = obj_date[0]['user_id'];
                        design();
                    }
                    else {
                        bootbox.alert('Please Fill Site Join Report', function () {
                            //window.location.href = "site_joining_report(SJR).aspx";
                        });


                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });


            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_project_activity",
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    if (result.d != "") {
                        activity = JSON.parse(result.d);
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });



            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_student_planned_for_admin",
                data: '{user_id : "' + user + '"}',
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {

                    if (result.d != "") {
                        obj_Get_student_planned = JSON.parse(result.d)
                        
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_student_actual_for_admin",
                data: '{user_id : "' + user + '"}',
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    if (result.d != "") {
                        obj_Get_student_actual = JSON.parse(result.d)

                        for (var i = 0; i < obj_Get_student_actual.length; i++) {
                            var date = new Date(obj_Get_student_actual[i]["date"]);
                            if (document.getElementById(date.toLocaleDateString()) != null) {

                                var now;
                                var ddd;
                                var t1;
                                var t;

                                if (current_date != "false") {

                                    now = new Date(obj_Get_student_actual[i]['date']);
                                    ddd = new Date(current_date);
                                    t1 = ddd.toLocaleDateString();
                                    t = now.toLocaleDateString();
                                }
                                var tr = document.getElementById(date.toLocaleDateString()).closest('tr');
                                    $(tr).find('.struct').html(obj_Get_student_actual[i]["structure_actual"]);
                                    $(tr).find('.loc').html(obj_Get_student_actual[i]["location_actual"]);
                                    $(tr).find('.acti').html(obj_Get_student_actual[i]["activity_actual"]);
                                    $(tr).find('.remark').html(obj_Get_student_actual[i]["Remark"]);
                                    if (obj_Get_student_actual[i]["file_path"] != "") {
                                        $(tr).find('.download_link').prop('href', ("../ProjectTraining/actual_upload/" + obj_Get_student_actual[i]["file_path"]));
                                        $(tr).find('.download_link').text('Download');
                                        $(tr).find('.hdn_link').text(obj_Get_student_actual[i]["file_path"]);
                                    }
                                    else {
                                        $(tr).find('.download_link').html("");
                                    }

                                //cooment 6 end

                              
                            }
                        }
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });


        });

        function design() {
                <%--var monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];--%>
            var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var counter = 1;
            //var join_date = "Thu Dec 15 2016 17:34:57 GMT+0530 (India Standard Time)";
            // var join_date = "1-1-2017";.
            var join_date = obj_date[0]['date_of_join'];
            var now = new Date(join_date);
            if (join_date != "") {


                str = "";
                str += "<tr>    <td></td>   <td></td>   <td style='width:20%' class='text-align'>Structure</td>  <td style='width:20%'  class='text-align'>Location</td>  <td style='width:20%' class='text-align'>Activity</td> <td style='width:20%'></td> <td></td> <td></td>  </tr>";
                var totaldays = 112;
                switch (now.getDay()) {
                    case 0:
                        totaldays = parseInt(totaldays + 7);
                        break;
                    case 1:
                        totaldays = parseInt(totaldays + 7);
                        break;
                    case 2:
                        totaldays = parseInt(totaldays + 6);
                        break;
                    case 3:
                        totaldays = parseInt(totaldays + 5);
                        break;
                    case 4:
                        totaldays = parseInt(totaldays + 4);
                        break;
                    case 5:
                        totaldays = parseInt(totaldays + 3);
                        break;
                    case 6:
                        totaldays = parseInt(totaldays + 2);
                }

                // str += "<tr>    <td><b>Wk-" + counter + "<b></td>   <td></td>   <td></td>  <td></td>  <td></td> <td></td><td></td> <td> </td>     </tr>";


                if (now.getDay() == 0) {
                    counter = 0;
                }
                else {
                    //   str += "<tr>    <td><b>Wk-" + counter + "<b></td>   <td></td>   <td></td>  <td></td>  <td></td>   </tr>";
                }

                for (var i = 0; i < 119; i++) {
                    var now = new Date(join_date);
                    now.setDate(now.getDate() + i)
                    switch (now.getDay()) {
                        case 0:
                            day = "Sun";
                            break;
                        case 1:
                            day = "Mon";
                            break;
                        case 2:
                            day = "Tue";
                            break;
                        case 3:
                            day = "Wed";
                            break;
                        case 4:
                            day = "Thu";
                            break;
                        case 5:
                            day = "Fri";
                            break;
                        case 6:
                            day = "Sat";
                    }
                    if (day == "Sun") {
                        counter = counter + 1;
                        if (counter == 18) {

                        } else {
                            //  str += "<tr> <td><b>" + 'Wk-' + (counter) + "<b></td>  <td> </td>   <td></td>  <td></td>  <td></td> <td></td> <td></td>  <td></td> </tr> ";
                        }


                    }
                    else {
                        debugger;
                        var ddd = new Date(current_date);
                        var t1 = ddd.toLocaleDateString();
                        tmp_date = t1;
                        var t = now.toLocaleDateString();
                       
                            str += "<tr> <td class='id1' id=" + (now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear() + ">" + monthNames[now.getMonth()] + ' ' + now.getDate() + "</td> "
                            + "<td>" + day + " </td>   <td class='struct' id=struct" + monthNames[now.getMonth()] + now.getDate() + "</td> "
                            + "<td class='loc'  id=loc" + monthNames[now.getMonth()] + now.getDate() + "</td> "
                            + "<td class='acti' id=acti" + monthNames[now.getMonth()] + now.getDate() + " </td>"
                            + "<td class='remark' id=remark" + monthNames[now.getMonth()] + now.getDate() + "</td>"
                            + "<td>"
                            + "<span id='upload_span' ><strong class='upload_result'></strong><span></span>"
                            + "<a id='download_link" + monthNames[now.getMonth()] + now.getDate() + "' class='fancybox radio_hide download_link' download='' rel='group' href=''></a><span class='hdn_link' style='display:none'></span></td>"
                            + "<td>  <button type='button'  class='time_sheet bt btn btn-sm' data-toggle='modal' data-target='#myModal'>Time Sheet</button></td> "
                            + "</tr>";
                    }
                }


                $('#tbl').append(str);
            } else {
                $('#loading').hide();
                bootbox.alert('No Data Found !!', function () {
                });
            }
        }

        var dailysheet;
        $(document).on('click', ".time_sheet", function () {
            dailysheet = "";
            $('.save_submit').css('display', 'block');
            var time;
            selected_date = this.parentNode.parentNode.children[0].id;

            var date = JSON.stringify({ "date": selected_date });
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_DailySheet_for_admin",
                data: '{user_id : "' + user_id + '",date : "' + selected_date + '"}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d != "") {
                        dailysheet = JSON.parse(result.d);
                        time = dailysheet[0].created_date.slice(11, 50);
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });

            var b = this;
            var d = new Date(b.parentNode.parentNode.children[0].id);
            var a = new Date(d)
             

            $('#dailysheet_time').text(a.getDate() + "/" + parseInt(d.getMonth() + 1) + "/" + d.getFullYear());
            $('#daily_time').text("");
            $('#daily_time').text(time);
            $('#proj_code').text(project_name);
            $('#stud_loca').text(address_from_communication);
            $('#tb_Time_sheet').html('');
            $('#stud_code').text(user_id);
            str1 = '';

            str1 += ' <thead><tr><td >No</td> <td>Activities</td><td>No. of Hours</td> <td colspan="2" style="text-align:center;">labour</td> <td>Qty Exe.</td> <td >UOM</td></tr></thead>';

            str1 += "<tr> <td></td> <td> </td> <td> </td> <td >Skill</td>  <td >Unskill</td> <td></td> <td ></td>      </tr> ";
            debugger;
            if (dailysheet == "") {

                for (var i = 0; i < activity.length; i++) {
                    str1 += "<tr>  <td class='seq' id='" + activity[i]['seq_no'] + "' class='td_width'>" + activity[i]['seq_no'] + " </td> <td>" + activity[i]['name'] + "</td>"
                        + "<td ><input class='hour' onkeypress='return isNumberKey(event)'  style='width:65px;'type='text' id=hour" + activity[i]['seq_no'] + " ></td>"
                        + "<td ><input  class='skill'  onkeypress='return isNumberKey(event)'   style='width:85px;' type='text' id=skill" + activity[i]['seq_no'] + " ></td>"
                        + "<td ><input  class='unskill' onkeypress='return isNumberKey(event)'  style='width:85px;' type='text' id=unskill" + activity[i]['seq_no'] + "  ></td>"
                        + "<td ><input class='qty'   onkeypress='return isNumberKey(event)'  style='width:85px;' type='text' id=qty" + activity[i]['seq_no'] + " ></td>"
                         + "<td >  <select  class='uom' style='width: 115px;' id=uom" + activity[i]['seq_no'] + " name='project_name'>"
                                           + "<option value='' >Select</option>"
                                           + " <option value='sq'>SQ MTS</option>"
                                           + " <option value='cb'>CM MTS</option>"
                                           + " <option value='rm'>RM MTS</option>"
                                           + " <option value='kgs'>KGS</option>"
                                           + " <option value='tons'>TONS</option>"
                                           + " <option value='num'>Number</option>"
                                           + " <option value='none'>None</option>"
                                           + "</select></td>"
                        + "</tr> ";
                }
            }
            else {
               
                for (var i = 0; i < activity.length; i++) {
                    str1 += "<tr id=" + activity[i]['code'] + ">  <td class='seq' id='" + activity[i]['seq_no'] + "' class='td_width'>" + activity[i]['seq_no'] + " </td> <td>" + activity[i]['name'] + "</td>"
                        + "<td ><input class='hour' onkeypress='return isNumberKey(event)' style='width:65px;'type='text' id=hour" + activity[i]['seq_no'] + " value=" + dailysheet[i]['hours'] + " ></td>"
                        + "<td ><input  class='skill' onkeypress='return isNumberKey(event)'   style='width:85px;' type='text' id=skill" + activity[i]['seq_no'] + " value=" + dailysheet[i]['skill'] + " ></td>"
                        + "<td ><input  class='unskill' onkeypress='return isNumberKey(event)'  style='width:85px;' type='text' id=unskill" + activity[i]['seq_no'] + " value=" + dailysheet[i]['Unskill'] + " ></td>"
                        + "<td ><input class='qty' onkeypress='return isNumberKey(event)'    style='width:85px;' type='text' id=qty" + activity[i]['seq_no'] + " value=" + dailysheet[i]['qty'] + " ></td>"
                         + "<td >  <select  class='uom' style='width: 115px;'  id=uom" + activity[i]['seq_no'] + " name='project_name'>"
                                           + "<option value='' >Select</option>"
                                           + " <option value='sq'>SQ MTS</option>"
                                           + " <option value='cb'>CM MTS</option>"
                                           + " <option value='rm'>RM MTS</option>"
                                           + " <option value='kgs'>KGS</option>"
                                           + " <option value='tons'>TONS</option>"
                                           + " <option value='num'>Number</option>"
                                           + " <option value='none'>None</option>"
                                           + "</select></td>"
                        + "</tr> ";
                     
                    
                }
            }

            $('#tb_Time_sheet').append(str1);

            //comment no=7 start  
            // only display btn when current date in on
            //if (tmp_date == b.parentNode.parentNode.children[0].id) {
            //    $('.save_submit').css('display', 'block');
            //}
            //else {
              
            //    $('.save_submit').css('display', 'none');
            //}
            //comment no=7 end orignal


            //comment 8 strat  
            //display all day save btn
                $('.save_submit').css('display', 'block');
            //comment 8 end         


            var no = 0;
            $('#tb_Time_sheet tbody tr').each(function () {

                var id = this.id;
                var t = id - 1;
                if (id != "") {
                    this.getElementsByClassName('uom')[0].value = dailysheet[t]['uom'];
                }
            });

        });

        $('#btn_plan').click(function () {

                <%--var monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];--%>
                var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];
                var counter = 1;
                //var join_date = "Thu Dec 15 2016 17:34:57 GMT+0530 (India Standard Time)";
                //   var join_date = "1-1-2017";
                var now = new Date(join_date);

                var str2 = "";
                tbl1.innerHTML = '';

                str2 += "<tr>    <td></td>   <td></td>   <td class='text-align'>structure</td>  <td class='text-align'>Location</td>  <td class='text-align'>activity</td>   </tr>";
                var totaldays = 112;
                switch (now.getDay()) {
                    case 0:
                        totaldays = parseInt(totaldays + 7);
                        break;
                    case 1:
                        totaldays = parseInt(totaldays + 7);
                        break;
                    case 2:
                        totaldays = parseInt(totaldays + 6);
                        break;
                    case 3:
                        totaldays = parseInt(totaldays + 5);
                        break;
                    case 4:
                        totaldays = parseInt(totaldays + 4);
                        break;
                    case 5:
                        totaldays = parseInt(totaldays + 3);
                        break;
                    case 6:
                        totaldays = parseInt(totaldays + 2);
                }

                if (now.getDay() == 0) {
                    counter = 0;
                }
                else {
                    str += "<tr>    <td><b>Wk-" + counter + "<b></td>   <td></td>   <td></td>  <td></td>  <td></td>   </tr>";
                }

                for (var i = 0; i < 119; i++) {
                    var now = new Date(join_date);
                    now.setDate(now.getDate() + i)

                    switch (now.getDay()) {
                        case 0:
                            //day = "Sunday";

                            day = "Sun";
                            break;
                        case 1:
                            day = "Mon";
                            break;
                        case 2:
                            day = "Tue";
                            break;
                        case 3:
                            day = "Wed";
                            break;
                        case 4:
                            day = "Thu";
                            break;
                        case 5:
                            day = "Fri";
                            break;
                        case 6:
                            day = "Sat";
                    }


                    if (day == "Sun") {
                        counter = counter + 1;
                        if (counter == 18) {

                        } else {
                            //str2 += "<tr> <td><b>" + 'Wk-' + (counter) + "<b></td>  <td> </td>   <td></td>  <td></td>  <td></td>    </tr> ";
                        }
                    }
                    else {
                        str2 += "<tr> <td id=" + (now.getMonth() + 1) + now.getDate() + now.getFullYear() + ">" + monthNames[now.getMonth()] + ' ' + now.getDate() + "</td> "
                           + " <td>" + day + " </td>   <td class='struct_dp'  type='text' id=struct" + monthNames[now.getMonth()] + now.getDate() + "</td> "
                           + " <td  class='loc_dp' id=loc" + monthNames[now.getMonth()] + now.getDate() + "   </td> "
                           + "  <td  class='acti_dp' id=acti" + monthNames[now.getMonth()] + now.getDate() + " " + "  </td>"
                          + "</tr>";
                    }
                }

                $('#tbl1').append(str2);

                for (var i = 0; i < obj_Get_student_planned.length; i++) {
                    var tmp = new Date(obj_Get_student_planned[i]["date"]);
                    var date = (tmp.getMonth() + 1) + "" + tmp.getDate() + "" + tmp.getFullYear();
                    if (document.getElementById(date) != null) {
                        var tr = document.getElementById(date).closest('#tbl1 tr');
                        $(tr).find('.struct_dp').html(obj_Get_student_planned[i]["structure"]);
                        $(tr).find('.loc_dp').html(obj_Get_student_planned[i]["location"]);
                        $(tr).find('.acti_dp').html(obj_Get_student_planned[i]["activity"]);
                        console.log(date);
                    }
                }
            });

            $('#save').click(function () {
                debugger;
                var myarrray = new Array();
                $("#tbl tbody tr").each(function () {
                    var obj = new Object();
                    if ($(this).find('.id1').prop('id') == undefined) {
                    }
                    else {
                        var now = new Date(this.children[0].id);
                        var ddd = new Date(current_date);
                        var t1 = ddd.toLocaleDateString();
                        var t = now.toLocaleDateString();
                        //comment no 3
                        //this code will be save only those days data which are open current days
                        //if (t == t1) {
                        //    obj.date = $(this).find('.id1').prop('id');
                        //    obj.structure = $(this).find('.struct').val();
                        //    obj.location = $(this).find('.loc').val();
                        //    obj.activity = $(this).find('.acti').val();
                        //    obj.remark = $(this).find('.remark').val();
                        //    obj.file_path = $(this).find('.upload_result').html();
                        //    debugger;
                        //    myarrray.push(obj);
                        //}
                        //comment no 3 ends



                        //comment no 4 start
                        //this code will be remove the validation to save only current days data and strore all days data
                             obj.date = $(this).find('.id1').prop('id');
                            obj.structure = $(this).find('.struct').val();
                            obj.location = $(this).find('.loc').val();
                            obj.activity = $(this).find('.acti').val();
                            obj.remark = $(this).find('.remark').val();
                            if ($(this).find('.upload_result').html() == "") {
                                obj.file_path = $(this).find('.hdn_link').html();
                            }
                            else {
                                obj.file_path = $(this).find('.upload_result').html();
                            }

                            debugger;
                            myarrray.push(obj);
                            
                        //comment no 4 end 



                        }
                    
                });


                data = JSON.stringify({ "data": JSON.stringify(myarrray) });
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/project_actual",
                    data: data,
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (result) {
                        bootbox.alert(result.d, function () {
                          //  window.location.reload();
                        });
                    },
                    error: function (error) {
                        console.log(error);
                    }

                });
            });


     

            var current_event = "";
            function UploadProfilePhoto(event) {
                debugger;
                upload_file_name = '';

                current_event = event.id;
                try {
                    debugger;
                    var fileToUpload = GetFileNameFromPath(event.value);

                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));
                    var selected_date = $(event).closest('tr').children()[0].id;
                    if (CheckUserPhotoExtension(fileToUpload)) {

                        var flag = true;

                        if (filename != "" && filename != null) {

                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../Handler/actual.ashx?selected_date=' + selected_date,
                                    secureuri: false,
                                    fileElementId: event.id,
                                    dataType: 'json',
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                            }
                                            else {
                                                //  $(event.id).val("");

                                                //FileName = data.upfile;
                                                //upload_file_name = FileName;

                                                $('#' + current_event).closest('tr').find('.upload_result').text(data.upfile);

                                            }
                                        }
                                        $("#UploadingProgress").fadeOut(200);
                                        current_event = '';
                                        //$('#upload_result').text('file upload successfully.');
                                        $('#save').click();
                                        
                                    },
                                    error: function (data, status, e) {
                                        $("#UploadingProgress").fadeOut(200);
                                        current_event = '';
                                        alert(e);
                                    }
                                });
                            }
                        }
                    }
                    else {
                        alert('Invalid File Type. Please upload .jpeg file');
                    }
                    return false;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                }
            }

            function GetFileNameFromPath(strFilepath) {

                var objRE = new RegExp(/([^\/\\]+)$/);
                var strName = objRE.exec(strFilepath);

                if (strName == null) {
                    return null;
                }
                else {
                    return strName[0];
                }
            }

            function CheckUserPhotoExtension(file) {
                try {
                    var flag = true;
                    var extension = file.substr((file.lastIndexOf('.') + 1));

                    switch (extension) {
                        case 'jpg':
                        case 'jpeg':
                        case 'JPG':
                        case 'JPEG':
                        case 'png':
                        case 'PNG':
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


    </script>
    <style>
        .struct{
            text-align: justify;
        }


        .time_sheet {
        width:110px!important;
        }

        .copyright {
            font-size: 12px;
            background: rgba(129,193,229,0.8);
            position: fixed;
            bottom: 0px;
            z-index: 11;
            margin-top: 10px;
            ht p;

        {
            right a;

        {
            margin: 0 color: #72c02c;
        }


        ight a:hover {
            -ebkit-transi - moz-tr n in-out;
            t ease-in-ou;
            nsition: all 0.4s .span8;

        {
            g-top: 15px t . p padding-top:;
        }



        t important; .bt {
            -block;
            ht: 40;
            .25;
            text-align: ce white-sp ce: nowrap;
            t le;
            : pointer;
            ant;
            l rtant;
            r-colo: #0275d8!impor .modal1;

        {
            margin-left: -47%!important;
            width: 95%!important;
        }

        .td_width {
            width: 51px!important;
        }
    </style>
</asp:Content>
