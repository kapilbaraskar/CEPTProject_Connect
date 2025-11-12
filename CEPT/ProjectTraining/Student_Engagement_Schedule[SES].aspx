<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="Student_Engagement_Schedule[SES]_actual.aspx.cs" Inherits="ProjectTraining_ProjectTraining" %>

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
        <%-- <div class="col-sm-12">
                <div class="col-sm-4 "> Date: </div>
                 <div class="col-sm-4">Signature Of Student: </div>
                 <div class="col-sm-4">  </div>
            </div>--%>
</div>
        <script type="text/javascript">
            var obj_Get_student_planned = new Object();
            var obj_date = new Object();
            var week_flag = '';


            function redirect(str) {
                $('#loading').hide();
                bootbox.alert('Site Join Report not submitted yet', function () {
                    window.location.href = "site_joining_report(SJR).aspx";
                });
            }


            $(document).ready(function () {
                $('#txt_user_id').val('<%= Session["UserId"] %>');
                $('#txt_name_student').val('<%= Session["UserName"] %>');
                $('#txt_email_stud').val('<%= Session["email"] %>');


             
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/get_date_for_planned",
                    data: '{}',
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
                            bootbox.alert('Please Fill Site Join Report', function () {
                                window.location.href = "site_joining_report(SJR).aspx";
                            });
                        }
                    },
                    error: function (error) {
                      
                    }
                });

              
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/get_sjr_report_date",
                    data: '{}',
                    dataType: 'json',
                    contentType: "application/json",
                    async: false,
                    success: function (result) {
                        if (result.d != "") {
                            obj_date = JSON.parse(result.d);

                            if (week_flag == "true") {
                                design_after_one_week();
                            }
                            else {
                                design();
                            }
                        }
                        else {
                            $('#loading').hide();
                            bootbox.alert('Please Fill Site Join Report', function () {
                            window.location.href = "site_joining_report(SJR).aspx";
                            });
                          
                        }
                     
                    },
                    error: function (error) {
                      
                    }
                });



               
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/Get_student_planned",
                    data: '{}',
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    success: function (result) {
                        if (result.d != "") {
                        obj_Get_student_planned = JSON.parse(result.d)
                        var b = 0;
                       
                        if (week_flag == "true") {

                            for (var i = 0; i < obj_Get_student_planned.length; i++) {
                                var date = new Date(obj_Get_student_planned[i]["date"]);
                                if (document.getElementById(date.toLocaleDateString()) != null) {
                                    var tr = document.getElementById(date.toLocaleDateString()).closest('tr');
                                    $(tr).find('.struct').html(obj_Get_student_planned[i]["structure"]);
                                    $(tr).find('.loc').html(obj_Get_student_planned[i]["location"]);
                                    $(tr).find('.acti').html(obj_Get_student_planned[i]["activity"]);
                                
                                }
                            }
                        }
                        else {
                            
                        

                        for (var i = 0; i < obj_Get_student_planned.length; i++) {
                            var date = new Date(obj_Get_student_planned[i]["date"]);
                            
                            if (document.getElementById(convert_date(date)) != null)//24/1/17
                               
                                //  if (document.getElementById(date) != null)//24/1/17
                                        {
                                        var tr = document.getElementById(convert_date(date)).parentElement;
                                        //   var tr = document.getElementById(date).closest('tr');
                                            $(tr).find('.struct').val(obj_Get_student_planned[i]["structure"]);
                                            $(tr).find('.loc').val(obj_Get_student_planned[i]["location"]);
                                            $(tr).find('.acti').val(obj_Get_student_planned[i]["activity"]);
                                          

                                        }
                                     }

                               }

                        }
                    },
                    error: function (error) {
                        ////console.log(error);
                    }
                });
            });

        


            function design() {

                <%--var monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];--%>
                var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];
                var counter = 1;
                //var join_date = "Thu Dec 15 2016 17:34:57 GMT+0530 (India Standard Time)";
                //   var join_date = "1-1-2017";
                //  var join_date = "02/27/2017";
               
                var join_date = obj_date[0]['date_of_join'];

                if (join_date != "") {

                    var now = new Date(join_date);

                    var str = "";
                    str += "<tr>    <td></td>   <td></td>   <td class='text-align'>Structure</td>  <td class='text-align'>Location</td>  <td class='text-align'>Activity</td>      </tr>";
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
                        debugger;
                        //if (counter == 1) { } else { uncomment for skip 1 week
                            str += "<tr>    <td><b>Wk-" + counter + "<b></td>   <td></td>   <td></td>  <td></td>  <td></td>   </tr>";
                        //} uncomment for skip 1 week
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
                        else
                            //if (i > 6) uncomment for skip 1 week
                        {
                            str += "<tr> <td class='id1' id=" + (now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear() + ">" + monthNames[now.getMonth()] + ' ' + now.getDate() + "</td> "
                               + " <td>" + day + " </td>   <td> <input type='text' class='struct' id=struct" + monthNames[now.getMonth()] + now.getDate() + "/></td> "
                               + " <td> <input type='text' class='loc'  id=loc" + monthNames[now.getMonth()] + now.getDate() + "/>   </td> "
                               + "  <td><input type='text' class='acti' id=acti" + monthNames[now.getMonth()] + now.getDate() + "/>  </td>"
                              // + "<td><input type='text' class='remark' id=remark" + monthNames[now.getMonth()] + now.getDate() + "/> </td>  " +
                               + "</tr>";
                        }
                    }

                } else {


                    bootbox.alert('Please Fill Site Join Report', function () {

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
                             debugger;
                             //if (counter == 1) { } else { uncomment for skip 1 week
                                 str += "<tr>    <td><b>Wk-" + counter + "<b></td>   <td></td>   <td></td>  <td></td>  <td></td>   </tr>";
                             //} uncomment for skip 1 week
                         }

                         for (var i = 0; i < totaldays; i++) {
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
                                     str += "<tr class='wk'> <td><b>" + 'Wk-' + (counter) + "<b></td>  <td> </td>   <td></td>  <td></td>  <td></td>    </tr> ";
                                 }
                             }
                             else
                                 //if (i > 6) uncomment for skip 1 week
                                 {
                                 str += "<tr> <td class='id1' id=" + (now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear() + ">" + monthNames[now.getMonth()] + ' ' + now.getDate() + "</td> "
                                    + " <td>" + day + " </td>   <td  class='struct' id=struct" + monthNames[now.getMonth()] + now.getDate() + "</td> "
                                    + " <td  class='loc'  id=loc" + monthNames[now.getMonth()] + now.getDate() + "   </td> "
                                    + "  <td  class='acti' id=acti" + monthNames[now.getMonth()] + now.getDate() + "   </td>"
                                    + "</tr>";
                             }
                         }

                     } else {


                         bootbox.alert('Please Fill Site Join Report', function () {

                             window.location.href = "site_joining_report(SJR).aspx";

                         });
                     }

                     $('#tbl').append(str);
                 }


            $('#save').click(function () {
                var myarrray = new Array();
                $("#tbl tbody tr").each(function () {
                    var obj = new Object();
                    if ($(this).find('.id1').prop('id') == undefined) {
                    }
                    else {
                        obj.date = $(this).find('.id1').prop('id');
                        obj.structure = $(this).find('.struct').val();
                        obj.location = $(this).find('.loc').val();
                        obj.activity = $(this).find('.acti').val();
                        // obj.remark = $(this).find('.remark').val();
                        myarrray.push(obj);
                    }
                });

              
                data = JSON.stringify({ "data": JSON.stringify(myarrray) });

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/project_planned",
                    data: data,
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (result) {
                        bootbox.alert(result.d);

                    },
                    error: function (error) {
                    }

                });
            });


            function convert_date(tmp) {
                var dates = new Date(tmp);
                var day = dates.getDate();
                var month = dates.getMonth() + 1;
                var year = dates.getFullYear();
                return month + "/" + day + "/" + year;
            }


        </script>
        <style>
            .text-align {
                font-weight: bold;
                text-align: center!important;
            }
        </style>
</asp:Content>
