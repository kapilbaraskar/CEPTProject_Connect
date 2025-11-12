<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="map.aspx.cs" Inherits="ProjectTraining_ProjectTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
   <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Student and Instructor Mapping</span></strong>
            </div>
            <div style="padding: 15px;" id="div3">

                 <div class="row">
                    <div style="" class="form-group col-md-12">
                      
                     <%--   <div class="col-sm-1"><label>Course</label></div>--%>
                        <div class="col-sm-6">
                     <%--       <select>
                          <option>Select</option>
                        </select>--%>

                            
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div style="" class="form-group col-md-12">
                        <table id="tbl" class="table" style="width:98%">
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="row">
                    
                    <div style="" class="form-group col-md-12">
                    <input class="btn btn-primary" type="button" id="save" value="save" style="margin-left: 44%;margin-top: 19px;margin-bottom: -55px;height: 40px;" />
                          <%--<input cls="btn btn-primary" type="button" id="save" value="save" />--%>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
    <style>
    
    </style>
    <script type="text/javascript">
        var myObject = new Object();
        var Obj_instructor = new Object();
        $(document).ready(function () {
            var str = "";
            var str1 = "";
            tbl.innerHTML = '';
            var Obj_instructor;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_instructor_detail",//5 instructor 5055 S 2018
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                async:false,
                success: function (result) {
                    if (result.d != "") {
                        Obj_instructor = JSON.parse(result.d);
                        //  console.log(Obj_instructor);
                        debugger;
                        str1 += "<select class='select'><option value='' >Select</option>"
                        for (var i = 0; i < Obj_instructor.length; i++) {
                            str1 += "<option value='" + Obj_instructor[i]['instructor_code'] + "'>" + Obj_instructor[i]['instructor_name'] + "</option>";
                        }
                        str1 += "</select>"
                    }
                    else {
                        $('#save').css('display', 'none');
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });


            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_student_detail",
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    debugger;
                    if (result.d != "") {
                        var sr_no=1;
                        myObject = JSON.parse(result.d);
                        console.log(myObject);
                        str += "<tr>      <td><b>No.</b></td>   <td class='text-align'><b>Student Name<b></td>  <td class='text-align'><b>Instructor  Name</b></td></tr>";
                        for (var i = 0; i < myObject.length; i++) {
                           
                            str += "@<tr id='" + myObject[i]['user_id'] + "'><td>" + (sr_no++) + "</td>   <td >" + myObject[i]['user_name'] + "</td>  </td>  <td  >";

                            str += "<select class='select'><option value='' >Select</option>";

                            for (var j = 0; j < Obj_instructor.length; j++) {
                                if (myObject[i]['pmt_instructor_code'] == Obj_instructor[j]['instructor_code']) {
                                    debugger;
                                    str += "<option value='" + Obj_instructor[j]['instructor_code'] + "' selected>" + Obj_instructor[j]['instructor_name'] + "</option>";
                                } else {
                                    str += "<option value='" + Obj_instructor[j]['instructor_code'] + "'>" + Obj_instructor[j]['instructor_name'] + "</option>";
                                }

                            }

                            str += "</select>";
                            
                            str += "</td>   </tr>";

                       
                        }
                        $('#tbl').append(str);
                        debugger;
                    
                        for (var i = 0; i < myObject.length; i++) {

                            $('#' + myObject[i]['user_id']).find('.select').val(myObject[i]['pmt_instructor_code']);

                       //     $('.select   option[value=' + myObject[i]['pmt_instructor_code'] + ']').attr("selected", true);
                            
                        }

                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });


       
        });



        $('#save').click(function () {
            debugger;
            var myarrray = new Array();
            $('#tbl tbody tr').each(function () {
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
                    debugger;
                    console.log(error);
                }
            });
        });


    </script>
</asp:Content>
   