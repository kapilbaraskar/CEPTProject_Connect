<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Tobedecided_inst_dtl.aspx.cs" Inherits="Admin_Master_Tobedecided_inst_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script type="text/javascript">
         var status_save = false;
         var instructor = '';
         var add_instructor_cnt = 1;
         var instructor = '';
         var bindinst_tobelater_ = '';
        $(document).ready(function () {
            studio_code = $('#hdn_user_id').val();
            bindinst();
            bindinst_tobelater();
            bind_data();
           
            $('#btn_save').on('click', function ()
            {
                saveData();
            });

            $('#btn_inst').on('click', function () {
                
                instructor_data_list = [];
                instr_code_string = '';
                instr_tbd_string = '';
                var inst_code = $('#drpinst').val();
                var inst_name = $('#drpinst').find('option:selected').text();
                if (inst_code == '') {
                    bootbox.alert('Please Checkbox checked then Select instructor Code');
                    return false;
                }
                $('#tbl_dtl tbody tr').each(function (e)
                {
                    var instructor_data = { 'instructor_code': '', 'tbd_id': '' };
                    debugger;
                    if ($(this).find('.check_status').prop('checked') == true)
                    {
                        var id_text = $(this).find('.find_id')[0].id;
                        $('span#' + id_text).text(inst_name);
                        $(this).find('.find_inst_code').text(inst_code);
                        instructor_data.instructor_code = inst_code
                        instructor_data.tbd_id = $(this).find('.find_id')[0].id;
                        instr_code_string += inst_code + ',';
                        instr_tbd_string += $(this).find('.find_id')[0].id + ',';
                       // instructor_data_list.push(instructor_data);
                    }
                    if ($(this).find('.check_status').prop('checked') == false)
                    {
                        instructor_data.instructor_code = $('.find_inst_code#' + $(this).find('.find_id')[0].id).text();
                        instructor_data.tbd_id = $(this).find('.find_id')[0].id;
                        if ($('.find_inst_code#' + $(this).find('.find_id')[0].id).text().substring(0, 4) != 'TBD_')
                        {
                            instr_code_string += $('.find_inst_code#' + $(this).find('.find_id')[0].id).text() + ',';
                            instr_tbd_string += $(this).find('.find_id')[0].id + ',';
                        }
                        
                        //instructor_data_list.push(instructor_data);
                    }
                });
                $('#drpinst').val('');

               
            });

            
        });

         
         var instr_code_string = '';
         var instr_tbd_string = '';
         var instr_tbd_tutor_type = '';
         var instructor_data_list = [];
         function saveData()
         {
             var studio_code = $('#hdn_c').val();
             var sem_code = $('#hdn_s').val();
             var year_code = $('#hdn_y').val();
             var status = true;

             $('#tblinstructor tbody tr').each(function (e)
             {
                 if ($(this).find('.cls_check').is(":checked") == true)
                 {
                     if ($(this).find(".drpinstructor").val().substring(0,4) == "TBD_")
                     {
                         bootbox.alert('Please Select instructor');
                         return false;

                     }
                     if ($(this).find(".cls_drp_tutor").val() == "")
                     {
                         bootbox.alert('Please Select Tutor');
                         return false;

                     }
                     if (status) {
                         instr_code_string += $(this).find(".drpinstructor").val();
                         instr_tbd_string += $(this).find(".cls_check")[0].id;
                         instr_tbd_tutor_type += $(this).find('.cls_drp_tutor').val();
                         status = false;
                     }
                     else
                     {
                         instr_code_string += ',' + $(this).find(".drpinstructor").val();
                         instr_tbd_string += ',' + $(this).find(".cls_check")[0].id;
                         instr_tbd_tutor_type += ',' + $(this).find('.cls_drp_tutor').val();
                     }
                     

                 }    
                 
             });
             if (instr_code_string != "")
             {
                 $.ajax({
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     url: "../../WebService.asmx/update_tobe_later_inst",
                     data: "{ instr_code_string : '" + instr_code_string + "',instr_tbd_string : '" + instr_tbd_string + "',instr_tbd_tutor_type:'" + instr_tbd_tutor_type + "',studio_code : '" + studio_code + "',sem_code : '" + sem_code + "', year_code: '" + year_code + "'}",
                     async: false,
                     datatype: "json",
                     success: function (data) {
                         if (data.d == true) {
                             alert('Data Saved Successfully');
                             bind_data();
                         }
                         else { }
                     },
                     Error: function (data) {
                         // alert(data.d);
                     }
                 });
             }
            
         }

         var lead_tutor_name = '';
         function bind_data() {
             var studio_code = $('#hdn_c').val();
             var sem_code = $('#hdn_s').val();
             var year_code = $('#hdn_y').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_TobeDecided_int_dtl",
                data: "{studio_code :'" + studio_code + "',sem_code :'" + sem_code + "',year_code :'" + year_code + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != null && data.d != '')
                    {
                        $('#tblinstructor tbody tr').remove();
                        var str = '';
                        lead_tutor_name = '';
                        var tutor_full_name = '';
                        var lead_status = true;
                        var inst_data = JSON.parse(data.d);
                        for (var i = 0; i < inst_data.length; i++)
                        {
                            if (inst_data[i]["tutor_type"].trim() == 'T') {
                                if (lead_status) {
                                    lead_tutor_name = inst_data[i]["instructor_name"];
                                    lead_status = false;
                                    tutor_full_name = 'Lead Turor';
                                }
                                else {
                                    lead_tutor_name += ',' + inst_data[i]["instructor_name"];
                                    tutor_full_name = 'Lead Turor';
                                    
                                }
                            }
                            else { tutor_full_name = 'Co-Turor';}

                            if (i == 0)
                            {
                                $('#studio_code').val(inst_data[i]["studio_code"]);
                                $('#studio_title').val(inst_data[i]["studio_title"]);
                                $('#no_of_tutor').val(inst_data[i]["no_of_tutor"]);
                                $('#txt_description').text(inst_data[i]["studio_description"]);
                            }
                            var substring = inst_data[i]["instructor_code"];
                            if (substring.substring(0, 4) == 'TBD_')
                            {
                                $('#co_tutor_note').css('display', 'block');
                                $('#btn_save').css('display', 'block');
                                str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "'><td>" + instructor + "</td>";
                                str += "<td><select  data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;' disabled><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                                str += "<td><input type='checkbox' class='cls_check' id=" + inst_data[i]["instructor_code"]+"></td>";
                                str += "<td></td></tr>";
                            }
                            else
                            {

                                str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td>" + inst_data[i]["instructor_name"] + "</td>";
                                str += "<td>" + tutor_full_name +"</td>";
                                str += "<td></td>";
                                str += "<td></td></tr>";
                            }


                            $('#tblinstructor tbody').append(str);
                            add_instructor_cnt = add_instructor_cnt + 1;
                          
                            var id_text = '#' + (i + 1) + ' ' + 'td';
                            $(id_text).find(".drpinstructor").val(inst_data[i]["instructor_code"].trim());
                            if (inst_data[i]["tutor_type"].trim() == "T") {
                                $(id_text).find(".cls_drp_tutor").val(inst_data[i]["tutor_type"].trim());
                            }
                            else if (inst_data[i]["tutor_type"] == "CT") {
                                $(id_text).find(".cls_drp_tutor").val(inst_data[i]["tutor_type"].trim());
                            }
                            
                        }
                        //$('#tbl_dtl').html(str);
                        
                       $('#lead_tutor_name').val(lead_tutor_name);
                        
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
         function bindinst() {
             $.ajax({
                 type: "POST",
                 contentType: "application/json; charset=utf-8",
                 url: "../../WebService.asmx/Get_faculty_data_with_tbd_user",
                 async: false,
                 data: "{studio_code:'" + $('#hdn_c').val()+"'}",
                 dataType: "json",
                 success: function (data) {
                     if (data.d != "") {
                         var instructor_data = JSON.parse(data.d);
                         instructor = "<select style='width:100%' class='drpinstructor' disabled><option value=''>---Select Instructor---</option>";
                         for (var i = 0; i < instructor_data.length; i++) {
                             instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                         }
                         instructor = instructor + "</select>";

                         //$('#drpinst').empty().append($("<option></option>").val("").html("-- Please Select instructor --"));

                         //for (var i = 0; i < instructor_data.length; i++) {
                         //    $('#drpinst').append($("<option></option>").val(instructor_data[i]["instructor_code"]).html(instructor_data[i]["instructor_name"]));
                         //}
                         //$('#drpinst').chosen();

                     }
                 },
                 error: function (result) {
                     alert(result);
                 }
             });
         }
         function bindinst_tobelater() {
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
                         bindinst_tobelater_ = "<select style='width:100%' class='drpinstructor' disabled><option value=''>---Select Instructor---</option>";
                         for (var i = 0; i < instructor_data.length; i++) {
                             bindinst_tobelater_ = bindinst_tobelater_ + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                         }
                         bindinst_tobelater_ = bindinst_tobelater_ + "</select>";

                     }
                 },
                 error: function (result) {
                     alert(result);
                 }
             });
         }

        

         //$(document).on('change', 'input[type="checkbox"]', function (e)
         //{
         //   
         //
         //    $('.cls_check').prop('checked', false);
         //    
         //    alert(checked);
         //    //alert(e.currentTarget.id);
         //
         //    
         //   // $('#' + e.currentTarget.id).prop('checked', true);
         //    //e.currentTarget.id
         //
         //});

         
         $('#tblinstructor tbody tr td input').live('click', function (e) {

             // var r = confirm("Are you sure you want to remove this?");
             //if (r == true) {
             var thisdata = $(this).closest("tr");
             var row_id = $(this).closest("tr")[0].id;

             if ($(this).is(":checked"))
             {
                 $("#" + row_id + ' ' + 'td .drpinstructor').prop("disabled", false);
                 $("#" + row_id + ' ' + 'td .cls_drp_tutor').prop("disabled", false);
                  
                 
             }
             else
             {
                 $("#" + row_id + ' ' + 'td .drpinstructor').prop("disabled", true);
                 $("#" + row_id + ' ' + 'td .drpinstructor').val($(this).find('.cls_check').context.id);
                 $("#" + row_id + ' ' + 'td .drpinstructor').trigger("liszt:updated");
                 $("#" + row_id + ' ' + 'td .cls_drp_tutor').prop("disabled", true);
                 $("#" + row_id + ' ' + 'td .cls_drp_tutor').val('');
                 $("#" + row_id + ' ' + 'td .cls_drp_tutor').trigger("liszt:updated");
                 

                 
             }
             //}
         });
       
     </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="well" style="background-color: White;">
        
        <div id="main_div" style="margin-top: 15px; margin-bottom: 40px;" class="panel panel-default">

            <div class="panel-heading">
                <strong>To Be Decided</strong>
            </div>
            <div style="padding-top: 15px;padding-left:10px;">
                <table border="0" cellpadding="2" cellspacing="2" style="width: 100%;" align="center">
                    <tr>
                         <td class="pad-top">Studio Code
                        </td>
                        <td>
                            
                            <input type="text" id="studio_code" class="marg-btm"/>
                        </td>


                        <td class="pad-top">Studio Title
                        </td>
                        <td><input type="text" id="studio_title" class="marg-btm"/></td>
                    </tr>

                    <tr>
                        <td class="pad-top">Lead Tutor Name
                        </td>
                        <td><input type="text" id="lead_tutor_name" class="marg-btm"/>
                         
                        </td>
                        <td class="pad-top">No of Tutor 
                        </td>
                        <td>
                            <input type="text" id="no_of_tutor" class="marg-btm"/>
                            
                        </td>

                    </tr>
                    <tr>
                        <td>Studio Description</td>
                        <td colspan="3"><textarea id="txt_description" style="width: 83%; margin-bottom: 0px;" rows="4" cols="10" name="description"></textarea></td>
                    </tr>

                    
                    <tr>
                        <td>

                        </td>
                        <td colspan="3">
                             <div id="dynamic_table" style="display: block;">
                                    <%--<table id="table_bind" class="table table-bordered" style="width: 94%;"></table>--%>
                                    <div class="row-fluid" id="dataList_instructor" style="float: left; width: 50%; display: block;">
                                        <div class="box-content box-no-padding" style="display:none;">
                                            <button class="btn  btn-primary" type="button" id="btn_instructor">
                                                <i class="icon-plus"></i>&nbsp;Add Instructor
                                            </button>
                                        </div>
                                        <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor" style="width: 168% !important">
                                            <thead>
                                                <tr>
                                                    <th style="width: 45%;">Instructor</th>
                                                    <th style="width: 38%;">Tutor
                                    <select style="width: 100%; display: none;" id="cls_drp_tutor">
                                        <option value="">--</option>
                                        <option value="T">Lead Tutor</option>
                                        <option value="CT">Co Tutor</option>
                                    </select>
                                                    </th>
                                                    <th></th>
                                                    <th style="width: 45%;"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                        <div id="co_tutor_note" style="width: 168%; display:none;">It is mandatory for the added instructor to complete the Step-1  i.e personal details through his/her connect login, for your submission to be considered further</div>
                                    </div>

                                </div>
                        </td>
                    </tr>
                </table>
                <br />
                <br />
               <%-- <div class="panel panel-default" id="div_certi_dtl" style="display: none;width: 50%;margin-left: 21%;text-align: center;">
                <div class="panel-heading">
                    <strong>To be Decided </strong>
                </div>
                <div>
                    <table id="tbl_dtl" class="table table-bordered">
                    </table>
                </div>
                   
            </div>--%>
            </div>
            <br />

        </div>
        
        
           <center>
            <input type="button" id="btn_save" value="Submit" style="display:none;" class="btn btn-primary" /></center>
            
        
        
        
    </div>

        <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
        <asp:HiddenField ID="hdn_c" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_s" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_y" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_studio_code" runat="server" ClientIDMode="Static" />
        
    </div>
</asp:Content>

