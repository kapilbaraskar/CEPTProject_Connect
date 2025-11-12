<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="proposal_accept.aspx.cs" Inherits="ProjectTraining_proposal_accept" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <style>
        tfoot
        {
            display: table-header-group;
        }
         .btn_rad {
            border-radius: 6px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;    width: 1089px !important;margin-left: -34px;">
      <%--   <div style="margin-top: -18px;" class="start_date">
                Semester Start Date: 
                   <input type="text" name='sem_start_date' id="sem_start_date" readonly='true' style="width:72px !important;margin-top: 9px;" />
              &nbsp;
                 <input type="button" id="save_sem_start_date" value="Save" class="btn_rad btn_hide"/>
            </div>--%>
        <div class="panel panel-default " style="width:1086px !important">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Student Proposal Accept</span>
                </strong>| <a href="SJR_report.aspx"><span class="panel-headingfont">  Site Information </span></a>
                </strong>| <a href="Admin_PSR_FCR_Report.aspx"><span class="panel-headingfont">  PSR & FCR Report </span></a>
            </div>
           
            <%--<div style="padding: 15px;" id="div3">
                <div class="row">
                    <div style="" class="form-group col-md-12">
                        <table id="tbl" class="table" style="width:98%">
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>--%>
            <div id="DataList">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                    <tfoot>
                        <tr>
                            <th>
                                <%--  Search <i class="icon-on-right icon-arrow-right"></i>--%>
                                <input type="text" style="width: 50px; display: block" name="search_engine" value=""
                                    class="search_init" />
                            </th>
                            <th>
                                <input type="text" style="width: 150px" name="search_sem" value="" class="search_init" />
                            </th>

                            <th>
                                <center>
                                    <input id="txt_code" type="text" style="width: 38px;" name="search_Faculty" value=""
                                        class="search_init" /></center>
                            </th>
                            <th>
                                <input type="text" style="width: 38px" name="search_semester" value="" class="search_init" />
                            </th>

                            <th>
                                <input type="text" style="width: 38px" name="search_code" value="" class="search_init" />
                            </th>

                            <th>
                                <input type="text" style="width: 38px" name="search_planned" value="" class="search_init" />
                            </th>

                            <th>
                                <input type="text" style="width: 38px" name="search_actual" value="" class="search_init" />
                            </th>

                            <th>
                                <input type="text" style="width: 38px" name="planned_vs_actual" value="" class="search_init" />
                            </th>
                             
                            <th>
                                <input type="text" style="width: 38px" name="search_weekly_timesheet" value="" class="search_init" />
                            </th>

                            <th>
                            <input type="text" style="width: 38px" name="search_car_timesheet" value="" class="search_init" />
                            </th>
                            
                            <th>
                            <input type="text" style="width: 38px" name="search_psr" value="" class="search_init" />
                            </th>

                             <th>
                            <input type="text" style="width: 38px" name="search_final" value="" class="search_init" />
                            </th>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var myObject = new Object();
        var Obj_instructor = new Object();
        var oTable;
        var asInitVals = new Array();
        var user_type;
        $(document).ready(function () {
            debugger;
            user_type = ('<%= Session["User_Type"] %>');
            if (user_type == "I2") {
               $('.start_date').css("display","block");
            } else {
               $('.start_date').remove();
            }
            
            $('#sem_start_date').datepicker({
                dateFormat: "mm/dd/yy"
            });
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_cept_current_sem_data",
                data: "{type:'Project Training'}",
                dataType: "json",
                success: function (data) {
                    debugger;
                    obj = JSON.parse(data.d)
                    
                    $('#sem_start_date').val(obj[0]['start_date']);
                },
                error: function (result) {
                    debugger;
                    alert(result);
                }
            });
            
            
            var str = "";
            var str1 = "";
            //  tbl.innerHTML = '';
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_praposal_data_for_accept",
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    
                    if (result.d != "") {
                        debugger;
                        DisplayData(result.d);
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });
        });
    
        $(Document).on('click', '#save_sem_start_date', function () {
            debugger;
            var update_obj = new Object();
            var date = $('#sem_start_date').val();
            update_obj.date = date;
            var user = ('<%= Session["UserId"] %>');
            update_obj.user_id = user;

            data = JSON.stringify({ "data": update_obj });
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/project_sem_start_date",
                data: data,
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    bootbox.alert(result.d, function () {
                        //window.location.reload();
                    });
                },
                error: function (error) {
                    console.log(error);
                }

            });


        });
        $('#save').click(function () {

            var myarrray = new Array();
            $('#example tbody tr').each(function () {
                var obj_save_mapping = new Object();
                if (this.id != "") {
                    obj_save_mapping.user_id = this.id;
                    obj_save_mapping.instructor_code = $(this).find('.select :selected').val();
                    obj_save_mapping.course_code = myObject[1]['course_code'];
                    obj_save_mapping.semester_type = myObject[1]['semester_type'];
                    obj_save_mapping.year_semester = myObject[1]['year_semester'];
                    obj_save_mapping.year_semester = myObject[1]['year_semester'];
                    obj_save_mapping.cancel_flag = 'N';
                    myarrray.push(obj_save_mapping);
                }
            });

            data = JSON.stringify({ "data": JSON.stringify(myarrray) });

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/project_mapping_stud_instructor",
                data: data,
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    bootbox.alert(result.d);
                },
                error: function (error) {
                    
                    console.log(error);
                }
            });
        });


        function DisplayData(data) {

            debugger

            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> <tfoot id="abc"><tr><th><input type="text" style="width: 5px; display: none" name="search_engine" value=""class="search_init" /></th><th><input type="text" style="width: 35px" name="search_engine" value="" class="search_init" /></th><th><center><input type="text" style="width: 54px;" name="search_Faculty" value="" class="search_init" /></center></th><th><input type="text" style="width: 86px" name="search_semester" value="" class="search_init" /></th><th><input type="text" style="width: 25px" name="search_code" value="" class="search_init" /></th></tr></tfoot> </tbody> </table>');
            }


            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bStateSave": false,
                "sDom": 't',
                //  "sScrollY": '400px',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "oTableTools": {
                    "aButtons": [
                        "xls", "pdf"
						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
            { "sTitle": "Code", "mData": "user_id", "bSortable": false, },
            //{ "sTitle": "email", "mData": "mail", "bSortable": false, "bVisible": false },
            { "sTitle": "Name", "mData": "user_name", "bSortable": false, "sClass": 'cls_user_name' },
            { "sTitle": "Proposal Status", "mData": "PT_submit", "bSortable": false },
            {"sTitle": "Approve Status", "mData": "is_approved", "bSortable": false, "fnRender": function (data, type, full) {

                if (user_type != "FA")
                {
                    if (data.aData.PT_submit == 'Yes' && data.aData.is_approved != 'Accepted' && data.aData.is_approved != 'Rejected') {
                        return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/ProposalProject.aspx?user_id=") %>' + data.aData.user_id + '">Accept/Reject</a>'
                    }
                    else if (data.aData.is_approved != 'NA') {
                        if (data.aData.is_approved == "Rejected" && data.aData.PT_submit != 'Yes') {
                            return data.aData.is_approved + " and not submitted";
                        }
                        else {
                            return data.aData.is_approved + ' - ' + '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/ProposalProject.aspx?user_id=") %>' + data.aData.user_id + '">Check</a>';
                        }
                    }
                    else {
                        return data.aData.is_approved;
                    }
                }
                else
                {
                     return data.aData.is_approved;
                }
             }
         },
             {
                 "sTitle": "SJR Status", "mData": "SJR_submit", "bSortable": false, "fnRender": function (data, type, full) {
                      if (data.aData.SJR_submit == 'Yes') {
                         return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/site_joining_report(SJR).aspx?user=") %>' + data.aData.user_id + '&user_name=' + data.aData.user_name + '&user_id=' + data.aData.user_id + ' ">Check</a>'
                     }
                     else
                     {
                         return data.aData.SJR_submit;
                     }
                 }
             },
             {
                 "sTitle": "SES Planned", "mData": 'user_id_for_planned', "bSortable": false, "fnRender": function (data, type, full) {

                     if (data.aData.user_id_for_planned == data.aData.user_id) {
                         return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/Admin_SES_Planned.aspx?user=") %>' + data.aData.user_id + '">Check</a>'
                     }
                     else {
                         return data.aData.user_id_for_planned;
                     }
                 }

             }, {
                 "sTitle": "SES Actual", "mData": 'user_id_for_actual', "bSortable": false, "fnRender": function (data, type, full) {

                     if (data.aData.user_id_for_actual == data.aData.user_id) {
                         return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/Admin_SES_actual.aspx?user_id=") %>' + data.aData.user_id + '&user_name=' + data.aData.user_name + '">Check</a>'
                     }
                     else {
                         return data.aData.user_id_for_actual;
                     }
                 }
             },
             {
                 "sTitle": "SES Planned VS Actual", "mData": 'user_id_for_actual_vs_planned', "bSortable": false, "fnRender": function (data, type, full) {

                     if (data.aData.user_id_for_actual_vs_planned == data.aData.user_id) {
                         return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/Admin_SES_actual_vs_planned.aspx?user_id=") %>' + data.aData.user_id + '&user_name=' + data.aData.user_name + '">Check</a>'
                     }
                     else {
                         return data.aData.user_id_for_actual_vs_planned;
                     }
                 }
             }
             , {
                 "sTitle": "Weekly TimeSheet", "mData": 'user_id_for_weekly_timesheet', "bSortable": false, "fnRender": function (data, type, full) {

                     if (data.aData.user_id_for_weekly_timesheet == data.aData.user_id) {
                         return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/week_report_menu.aspx?user_id=") %>' + data.aData.user_id +'">Check</a>'
                     }
                     else {
                         return data.aData.user_id_for_weekly_timesheet;
                     }
                 }
             }

              , {
                  "sTitle": "car", "mData": 'user_id_for_car', "bSortable": false, "fnRender": function (data, type, full) {

                      if (data.aData.user_id_for_car == data.aData.user_id) {
                          return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/car.aspx?user_id=") %>' + data.aData.user_id + '&user_name=' + data.aData.user_name + '">Check</a>'
                    }
                    else {
                          return data.aData.user_id_for_car;
                     }
                 }
              }
              , {
                  "sTitle": "PSR", "mData": 'pro_psr', "bSortable": false, "fnRender": function (data, type, full) {

                      if (data.aData.pro_psr == data.aData.user_id) {
                          return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/preliminary_site_report.aspx?user_id=") %>' + data.aData.user_id + '&user_name=' + data.aData.user_name + '">Check</a>'
                      }
                      else {
                          return data.aData.pro_psr;
                      }
                  }
              }
               , {
                   "sTitle": "Final Report", "mData": 'pro_final_report', "bSortable": false, "fnRender": function (data, type, full) {

                       if (data.aData.pro_final_report == data.aData.user_id) {
                           return '<a target="_blank" href="<%= Page.ResolveClientUrl("~/ProjectTraining/Final_report_upload.aspx?user_id=") %>' + data.aData.user_id + '&user_name=' + data.aData.user_name + '">Check</a>'
                      }
                      else {
                           return data.aData.pro_final_report;
                      }
                  }
               }
           ]
            });

     $('.cls_user_name').css('text-transform','capitalize');
            $("tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("tfoot input").index(this));
            });



            /*
            * Support functions to provide a little bit of 'user friendlyness' to the textboxes in
            * the footer
            */
            $("tfoot input").each(function (i) {
                asInitVals[i] = this.value;
            });

            $("tfoot input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("tfoot input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("tfoot input").index(this)];
                }
            });
        }

    </script>
</asp:Content>
