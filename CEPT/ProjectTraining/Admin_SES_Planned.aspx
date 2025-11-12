<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="Admin_SES_Planned.aspx.cs" Inherits="ProjectTraining_ProjectTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <div><b>Student Engagement Schedule</b>
                     <%-- <input type="button" style="margin-left:10px" class=" pull-right btn_hdn" id="submit" value="Submit" />--%>
                      <input type="button" style="" class="pull-right btn_hdn" id="save"value="save" />
                </div>
            </div>
            <div id="tbt" style="height: 500px;overflow: scroll;">
                <table id="tbl"  class="display table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <td><b>Week</b</td>
                            <td><b>Dates</b></td>
                             <td colspan="3"> <center><b>Planned</b></center></td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <br /><br />
        </div>
      
</div>
        <script type="text/javascript">
            var obj_Get_student_planned = new Object();
            var obj_date = new Object();
            var week_flag = '';
            var user ='';

            if (user == undefined) {
                  user = getQueryStringValue('user');
                    if (user == '') {
                    user = ('<%= Session["UserId"] %>');
                    }
            }

            function getQueryStringValue(key) {
                return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
            }
 

            $(document).ready(function () {
                $('#txt_user_id').val('<%= Session["UserId"] %>');
                $('#txt_name_student').val('<%= Session["UserName"] %>');
                $('#txt_email_stud').val('<%= Session["email"] %>');

                user = getQueryStringValue('user');

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/get_date_for_planned_for_admin",
                    data: '{user_id : "' + user + '"}',
                    dataType: 'json',
                    contentType: "application/json",
                    async: false,
                    success: function (result) {
                        if (result.d != "") {
                            debugger;
                            week_flag = result.d;
                        }
                        else {
                            $('#loading').hide();
                            
                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });

                debugger;
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
                                design_after_one_week();
                        }
                        else {
                            $('#loading').hide();
                            bootbox.alert('No Data Found', function () {
                                window.location.href = "proposal_accept.aspx";
                            });
                          
                        }
                     
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });



                debugger;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/Get_student_planned_for_admin",
                    data: '{user_id : "'+user+'"}',
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    success: function (result) {
                        if (result.d != "") {
                        obj_Get_student_planned = JSON.parse(result.d)
                        var b = 0;

                     

                            for (var i = 0; i < obj_Get_student_planned.length; i++) {
                                var date = new Date(obj_Get_student_planned[i]["date"]);
                                if (document.getElementById(date.toLocaleDateString()) != null) {
                                    var tr = document.getElementById(date.toLocaleDateString()).closest('tr');
                                    $(tr).find('.struct').html(obj_Get_student_planned[i]["structure"]);
                                    $(tr).find('.loc').html(obj_Get_student_planned[i]["location"]);
                                    $(tr).find('.acti').html(obj_Get_student_planned[i]["activity"]);
                                    //  console.log(date.toLocaleDateString());
                                }
                            }
                        //    if (week_flag == "true") { }
                        //else {
                            
                        

                        //for (var i = 0; i < obj_Get_student_planned.length; i++) {
                        //    var date = new Date(obj_Get_student_planned[i]["date"]);
                        //          if (document.getElementById(date.toLocaleDateString()) != null)
                        //                {
                        //                    var tr = document.getElementById(date.toLocaleDateString()).closest('tr');
                        //                    $(tr).find('.struct').val(obj_Get_student_planned[i]["structure"]);
                        //                    $(tr).find('.loc').val(obj_Get_student_planned[i]["location"]);
                        //                    $(tr).find('.acti').val(obj_Get_student_planned[i]["activity"]);
                        //                    //  console.log(date.toLocaleDateString());
                        //                }
                        //             }

                        //      } 

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
                debugger;
                var join_date = obj_date[0]['date_of_join'];

                if (join_date != "") {

                    var now = new Date(join_date);

                    var str = "";
                    str += "<tr>    <td></td>   <td></td>   <td class='text-align'>structure</td>  <td class='text-align'>Location</td>  <td class='text-align'>activity</td>      </tr>";
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

                    //for (var i = 0; i < totaldays; i++) {
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
                            //if (counter == 18) {

                            //} else {
                            //    str += "<tr class='wk'> <td><b>" + 'Wk-' + (counter) + "<b></td>  <td> </td>   <td></td>  <td></td>  <td></td>    </tr> ";
                            //}

                            if (counter <= 18 && i < 118) {
                                str += "<tr class='wk'> <td><b>" + 'Wk-' + (counter) + "<b></td>  <td> </td>   <td></td>  <td></td>  <td></td>    </tr> ";
                            }
                        }
                        else {
                            str += "<tr> <td class='id1' id=" + (now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear() + ">" + monthNames[now.getMonth()] + ' ' + now.getDate() + "</td> "
                               + " <td>" + day + " </td>   <td> <input type='text' class='struct' id=struct" + monthNames[now.getMonth()] + now.getDate() + "/></td> "
                               + " <td> <input type='text' class='loc'  id=loc" + monthNames[now.getMonth()] + now.getDate() + "/>   </td> "
                               + "  <td><input type='text' class='acti' id=acti" + monthNames[now.getMonth()] + now.getDate() + "/>  </td>"
                              // + "<td><input type='text' class='remark' id=remark" + monthNames[now.getMonth()] + now.getDate() + "/> </td>  " +
                               + "</tr>";
                        }
                    }

                } else {


                    bootbox.alert('No Data Found', function () {

                        window.location.href = "site_joining_report(SJR).aspx";

                    });
                }

                $('#tbl').append(str);
            }

            function design_after_one_week() {

                $('.btn_hdn').css('display', 'none');

                <%--var monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];--%>
                     var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];
                     var counter = 1;
                     //var join_date = "Thu Dec 15 2016 17:34:57 GMT+0530 (India Standard Time)";
                     //   var join_date = "1-1-2017";
                     //  var join_date = "02/27/2017";
                     debugger;
                     var join_date = obj_date[0]['date_of_join'];

                     if (join_date != "") {

                         var now = new Date(join_date);

                         var str = "";
                         str += "<tr>    <td></td>   <td></td>   <td class='text-align'>structure</td>  <td class='text-align'>Location</td>  <td class='text-align'>activity</td>      </tr>";
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
                                 if (counter <= 18 && i < 118) {

                                
                                     str += "<tr class='wk'> <td><b>" + 'Wk-' + (counter) + "<b></td>  <td> </td>   <td></td>  <td></td>  <td></td>    </tr> ";
                                 }
                             }
                             else {
                                 str += "<tr> <td class='id1' id=" + (now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear() + ">" + monthNames[now.getMonth()] + ' ' + now.getDate() + "</td> "
                                    + " <td>" + day + " </td>   <td  class='struct' id=struct" + monthNames[now.getMonth()] + now.getDate() + "</td> "
                                    + " <td  class='loc'  id=loc" + monthNames[now.getMonth()] + now.getDate() + "   </td> "
                                    + "  <td  class='acti' id=acti" + monthNames[now.getMonth()] + now.getDate() + "   </td>"
                                    + "</tr>";
                             }
                         }

                     } else {


                         bootbox.alert('No Data Found ', function () {

                             window.location.href = "site_joining_report(SJR).aspx";

                         });
                     }

                     $('#tbl').append(str);
                 }

        </script>
        <style>
            .text-align {
                font-weight: bold;
                text-align: center!important;
            }
        </style>
</asp:Content>
