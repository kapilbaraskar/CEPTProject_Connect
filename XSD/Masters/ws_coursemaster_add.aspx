<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ws_coursemaster_add.aspx.cs" Inherits="Admin_Master_ws_coursemaster_add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <style type="text/css">
        input.per_load, select.drpinstructor {
            margin-bottom: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;WS Add New Course
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;margin-bottom: 60px;">
        <%--<div class="panel panel-default" style="display:none;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Retrieve Previous Year Course Data</span></strong></div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div class="form-group col-md-5" style="margin-bottom: 10px;">
                        Previous Year Semester :
                        <span id="spnprevsem"></span>
                    </div>
                </div>
                <div class="row">
                                                                        <%--<div class="form-group col-md-1">
                    Semester :
                </div>
                <div class="form-group col-md-2">
                    <select class="chosen-select" id="drpsemester">
                    </select>
                </div>
                <div class="form-group col-md-1">
                    Year :
                </div>
                <div class="form-group col-md-2">
                    <select class="chosen-select" id="drpyear">
                    </select>
                </div>--%
                    <div class="form-group col-md-1" style="padding-top:8px;">
                        Semester :
                    </div>
                    <div class="form-group col-md-3" style="padding-top:6px;">
                            <select class="chosen-select" id="drpsem">
                            <option value="M">Monsoon</option>
                            <option value="S">Spring</option>
                            </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top:8px;">
                        Course :
                    </div>
                    <div id="div_cur_sem_course" class="form-group col-md-3" style="padding-top:6px;">
                            <select class="chosen-select" id="drcourses">
                            </select>
                    </div>
                    <div id="div_other_sem_course" class="form-group col-md-3" style="padding-top:6px;display:none;">
                            <select class="chosen-select" id="drpothercourse">
                            </select>
                    </div>
                    <div class="form-group col-md-2">
                        <button class="btn btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                   
                </div>
                <%--<div class="row">
                    <div style="margin-left: 41%;" class="form-group col-md-12">
                        <button class="btn  btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>--%
                
            </div>
        </div>--%>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">New Course Data</span></strong>
            </div>
            <div style="padding: 10px;overflow:visible;" id="div_progcoord_panel" class="panel-collapse collapse in">
                <div class="row" style="margin-top:15px;">
                    <div class="form-group col-md-2 color-blue">
                        Course Title : <br/> (Max. 640 Characters)<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-9">
                        <textarea id="txtcourse_title" style="width: 100%;margin-bottom: 0px;" rows="3" cols="50" name="address" maxlength="640" onkeyup="return keyup_charcount(event);" onkeypress="return charcount(event);"></textarea>
                        <span id="spn_title" style="float:right;margin-bottom:10px;">Total Char : 0</span>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                        Category Location Wise<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <select id="drp_category_location_wise" onchange="category_location_change()">
                            <option value="">-- Select Category Location Wise --</option>
                            <option value="On CEPT Campus Courses">On CEPT Campus Courses</option>
                            <option value="Travel Based Outside India">Travel Based Outside India</option>
                            <option value="Travel Based Within India">Travel Based Within India</option>
                        </select>
                    </div>

                    <div class="form-group col-md-1 color-blue">
                        Min : <span id="spn_min"></span>
                    </div>
                    <div class="form-group col-md-1">
                        Max : <span id="spn_max"></span>
                    </div>
                </div>
                
                <div class="row" style="margin-top:15px;">
                    <div class="form-group col-md-2 color-blue">
                        Intake Capacity<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <%--<input type="text" id="txtavailable_seats" class="marg-btm"/>--%>
                        <select id="drpavailable_seats">
                            <option value="">-- Select Intake Capacity --</option>
                        </select>
                    </div>
                    
                    <div class="form-group col-md-1 color-blue">
                        Location<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <input id="txt_location" type="text" />
                    </div>
                </div>
                    
                <div class="row" style="margin-top:15px;">
                    <div class="form-group col-md-2 color-blue">
                        Course Description : <br/> (Min. 150 Words and <br />Max. 300 Words)<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-9">
                        <textarea id="txtcourse_description" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return keyup_wordcount(event);" onkeypress="return wordcount(event);"></textarea>
                        <span id="spn_desc" style="float:right;margin-bottom:10px;">Total Word : 0</span>
                    </div>
                </div>
                
                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                        Prerequisite For Students<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-9">
                        <textarea id="txtcourse_prerequisite" style="width:100%"" rows="6" cols="50" name="address"></textarea>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                        Is it open for Professionals<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <input type="checkbox" id="chk_is_for_professional" class="marg-btm" onchange="chk_change()" />
                    </div>

                    <div class="form-group col-md-1 color-blue">
                        Credits<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <select id="drp_credits">
                            <option value="">-- Select Credits --</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="5">5</option>
                        </select>
                    </div>
                </div>

                <div class="row" id="div_professional_prerequisite" style="display:none;">
                    <div class="form-group col-md-2 color-blue">
                        Professionals Prerequisite<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <input type="text" id="txt_professional_prerequisite" class="marg-btm"/>
                    </div>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        Start Date<span class="cls_mendatory" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <input type="text" id="txt_start_date" class="marg-btm"/>
                    </div>
                    <div class="form-group col-md-1 color-blue">
                        End Date<span class="cls_mendatory" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_end_date" class="marg-btm"/>
                    </div>
                </div>
                
                <div class="row" style="margin-top:10px;">
                    <div class="form-group col-md-2 color-blue">
                        Course Image<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-9">
                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                            <span><strong>Upload Image</strong></span>
                            <input type="file" name="courseImageUpload" id="courseImageUpload" onchange="javascript:return UploadCourseImage();" style="display: none;" />
                        </label>
                        <span id="lbl_courseimage_file_name" style="vertical-align: super;"></span>
                    </div>
                </div>
                
                <div class="row" style="margin-top:15px;">
                    <div class="form-group col-md-2 color-blue">
                        Image Source<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <input type="text" id="txt_image_source" class="marg-btm"/>
                    </div>
                    
                    <div class="form-group col-md-1 color-blue">
                        Inhabitation<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <select id="drp_inhabitation">
                            <option value="">-- Select Inhabitation --</option>
                            <option value="1">Faculty of Architecture</option>
                            <option value="1">Faculty of Design</option>
                            <option value="1">Faculty of Management</option>
                            <option value="1">Faculty of Planning</option>
                            <option value="1">Faculty of Technology</option>
                        </select>
                    </div>
                </div>
                
                <div class="row" style="margin-top: 10px;margin-bottom: 15px;">
                    <div class="form-group col-md-6" style="padding-left: 0px;padding-right: 60px;">
                        <div class="form-group col-md-4 color-blue">
                            Methodology<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                        </div>
                        <div class="form-group col-md-6">
                            <select id="drp_methodology">
                                <option value="">-- Select Methodology --</option>
                                <option value="Travel based">Travel based</option>
                                <option value="Workshop based">Workshop based</option>
                                <option value="Studio based">Studio based</option>
                                <option value="Lecture based">Lecture based</option>
                                <option value="Travel + Lecture based">Travel + Lecture based</option>
                                <option value="Travel + Studio based">Travel + Studio based</option>
                                <option value="Travel + Workshop based">Travel + Workshop based</option>
                            </select>
                        </div>

                        <div class="form-group col-md-4 color-blue" style="margin-top: 10px;">
                            Course Outputs<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                        </div>
                        <div class="form-group col-md-6" style="margin-top: 10px;">
                            <div>
                                <select id="drp_course_output1">
                                    <option value="">-- Select Course Output --</option>
                                    <option value="Installations">Installations</option>
                                    <option value="Models">Models</option>
                                    <option value="Presentation">Presentation</option>
                                    <option value="Products">Products</option>
                                    <option value="Reports">Reports (Soft Copy as well)</option>
                                    <option value="Posters">Posters (Soft Copy as well)</option>
                                    <option value="Booklet">Booklet (Soft Copy as well)</option>
                                    <option value="Photos">Photos (Soft Copy as well)</option>
                                </select>
                            </div>
                            <div>
                                <select id="drp_course_output2">
                                    <option value="">-- Select Course Output --</option>
                                    <option value="Installations">Installations</option>
                                    <option value="Models">Models</option>
                                    <option value="Presentation">Presentation</option>
                                    <option value="Products">Products</option>
                                    <option value="Reports">Reports (Soft Copy as well)</option>
                                    <option value="Posters">Posters (Soft Copy as well)</option>
                                    <option value="Booklet">Booklet (Soft Copy as well)</option>
                                    <option value="Photos">Photos (Soft Copy as well)</option>
                                </select>
                            </div>
                            <div>
                                <select id="drp_course_output3">
                                    <option value="">-- Select Course Output --</option>
                                    <option value="Installations">Installations</option>
                                    <option value="Models">Models</option>
                                    <option value="Presentation">Presentation</option>
                                    <option value="Products">Products</option>
                                    <option value="Reports">Reports (Soft Copy as well)</option>
                                    <option value="Posters">Posters (Soft Copy as well)</option>
                                    <option value="Booklet">Booklet (Soft Copy as well)</option>
                                    <option value="Photos">Photos (Soft Copy as well)</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row-fluid col-md-3" id="dataList_instructor" style="float: left;width: 30%; display: block;">
                        <div class="box-content box-no-padding">
                            <button class="btn btn-primary btn-small" type="button" id="btn_instructor">
                                <i class="icon-plus"></i>&nbsp;Add Instructor
                            </button>
                        </div>
                        <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor">
                            <thead>
                                <tr>
                                    <th>
                                        Instructor
                                    </th>
                                    <th>
                                        Contact hrs
                                    </th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                
                <div class="panel panel-default ">
                    <div class="panel-heading">
                        <b>Expense related to course for students</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">Material Cost</div>
                            <div class="form-group col-md-1"><input type="text" id="txt_material_cost" class="marg-btm" style="width:80%;" onchange="return calc_cost();" /></div>
                            <div class="form-group col-md-1 color-blue">Food Stay</div>
                            <div class="form-group col-md-1"><input type="text" id="txt_food_stay" class="marg-btm" style="width:80%;" onchange="return calc_cost();" /></div>
                            <div class="form-group col-md-1 color-blue">Local Travel</div>
                            <div class="form-group col-md-1"><input type="text" id="txt_local_travel" class="marg-btm" style="width:80%;" onchange="return calc_cost();" /></div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-2 color-blue" style="height: 40px;">Total approx. expense</div>
                            <div class="form-group col-md-1"><div id="div_total_approx_expense" class="marg-btm" style="height: 28px;text-align: center;border-bottom: solid 1px black;"></div></div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">Travel Expense</div>
                            <div class="form-group col-md-1"><input type="text" id="txt_travel_expense" class="marg-btm" style="width:80%;" onchange="return calc_cost();" /></div>
                            <div class="form-group col-md-1"><div id="div_total_expense" class="marg-btm" style="height: 28px;text-align: center;border-bottom: solid 1px black;"></div></div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
        <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdn_course_code" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_sem" runat="server" ClientIDMode="Static"/>
        <asp:HiddenField ID="hdn_year" runat="server" ClientIDMode="Static"/>
    </div>

    
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>

    <script type="text/javascript">

        var action = 'S';

        $(document).ready(function () {
            bindinstructor();
            get_intake_criteria();

            $('#txt_start_date').datepicker({ dateFormat: 'dd/mm/yy' });
            $('#txt_end_date').datepicker({ dateFormat: 'dd/mm/yy' });

            if ($('#hdnusertype').val() == 'A1') {
                var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                  "<i class='icon-save bigger-160'></i>Save</button></td> " +
                  "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                  "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
                $('#submitBtnDiv').html(str);
            }

            $('#btn_instructor').on('click', function () {
                if ($('#tblinstructor tbody tr').length < 3) {
                    var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric(event);' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                    $('#tblinstructor tbody').append(str);
                    
                    category_location_change();
                }
                return false;
            });

            $('#btnapprove').click(function () {
                action = 'A';
                savedata();
            });

            $('#btnsave').click(function () {
                savedata();
            });

            if ($('#hdn_course_code').val() != '' && $('#hdn_sem').val() != '' && $('#hdn_year').val() != '') {
                get_course_data();
            }
        });

        function calc_cost() {
            var material_cost = 0;
            var food_stay = 0;
            var local_travel = 0;
            var approx_expense = 0;
            var travel_expense = 0;
            var total_expense = 0;

            if ($('#txt_material_cost').val() != '')
                if (isNaN($('#txt_material_cost').val()) && parseFloat($('#txt_material_cost').val()).toString() == 'NaN') bootbox.alert('Material Cost must be a Numeric value');
                else material_cost = parseFloat($('#txt_material_cost').val());

            if ($('#txt_food_stay').val() != '')
                if (isNaN($('#txt_food_stay').val()) && parseFloat($('#txt_food_stay').val()).toString() == 'NaN') bootbox.alert('Food Stay must be a Numeric value');
                else food_stay = parseFloat($('#txt_food_stay').val());

            if ($('#txt_local_travel').val() != '')
                if (isNaN($('#txt_local_travel').val()) && parseFloat($('#txt_local_travel').val()).toString() == 'NaN') bootbox.alert('Local Travel must be a Numeric value');
                else local_travel = parseFloat($('#txt_local_travel').val());

            approx_expense = material_cost + food_stay + local_travel;
            $('#div_total_approx_expense').html(approx_expense);

            if ($('#txt_travel_expense').val() != '')
                if (isNaN($('#txt_travel_expense').val()) && parseFloat($('#txt_travel_expense').val()).toString() == 'NaN') bootbox.alert('Travel Expense must be a Numeric value');
                else travel_expense = parseFloat($('#txt_travel_expense').val());

            total_expense = approx_expense+travel_expense;
            $('#div_total_expense').html(total_expense);
        }

        var char_cnt_flag = 1;
        function charcount(e) {
            //if (e.keyCode == 22 || e.which == 22 || e.keyCode == 108 || e.which == 108)

            if ($('#txtcourse_title').val().length >= 640) {
                //bootbox.alert('You Exceeds the Character Limit');
                if (char_cnt_flag == 1) {
                    char_cnt_flag = 0;
                    bootbox.alert('You Exceeds the Character Limit', function () {
                        char_cnt_flag = 1;
                    });
                }
                return false;
            }
        }

        function keyup_charcount(e) {
            /////Character
            $('#spn_title').html('' + 'Total Char : ' + $('#txtcourse_title').val().length);
        }

        var word_cnt_flag = 1;
        function wordcount(e) {
            //if (e.keyCode == 22 || e.which == 22 || e.keyCode == 108 || e.which == 108)
            var arr_words = $('#txtcourse_description').val().trim().split(/\n| /g);
            while (arr_words.indexOf('') > -1) {
                arr_words.splice(arr_words.indexOf(''), 1);
            }

            var false_flag = false;
            if (arr_words.length == 300) {
                var last_char = $('#txtcourse_description').val()[$('#txtcourse_description').val().length - 1];
                if (last_char == ' ' || last_char == '\n') {
                    false_flag = true;
                }
            }
            else if (arr_words.length > 300) {
                false_flag = true;
            }

            if (false_flag) {
                //bootbox.alert('You Exceeds the Word Limit');
                if (word_cnt_flag == 1) {
                    word_cnt_flag = 0;
                    bootbox.alert('You Exceeds the Word Limit', function () {
                        word_cnt_flag = 1;
                    });
                }
                return false;
            }
        }
        var word_cnt_flag = 1;
        function keyup_wordcount(e) {
            var arr_words = $('#txtcourse_description').val().trim().split(/\n| /g);
            while (arr_words.indexOf('') > -1) {
                arr_words.splice(arr_words.indexOf(''), 1);
            }

            $('#spn_desc').html('' + 'Total Word : ' + arr_words.length);
        }

        var FileName = '';
        function UploadCourseImage() {
            try {
                var fileToUpload = GetFileNameFromPath($('#courseImageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/WSCourseImage_upload.ashx',
                                secureuri: false,
                                fileElementId: 'courseImageUpload',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#courseImageUpload').val("");
                                            $('#lbl_courseimage_file_name').html('<b>' + fileToUpload + '</b>');

                                            FileName = data.upfile;
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    alert('Invalid File Type. Please upload jpeg / png file');
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

        function savedata() {
            var obj_course_data = { 'course_code': '', 'course_title': '', 'category_location_wise': '', 'location': '', 'intake_capacity': '', 'credits': '', 'description': '', 'prerequisite': '', 'is_open_for_professional': '', 'professional_prerequisite': '', 'start_date': '', 'end_date': '', 'course_image': '', 'image_source': '', 'inhabitation': '', 'methodology': '', 'course_output1': '', 'course_output2': '', 'course_output3': '', 'instructor': '', 'material_cost': '', 'food_stay': '', 'local_travel': '', 'approx_expense': '', 'travel_expense': '', 'total_expense': '' };

            obj_course_data.course_code = $('#hdn_course_code').val();

            if ($('#txtcourse_title').val() != '' && $('#txtcourse_title').val().length > 640) {
                bootbox.alert('Course Title Exceeds the Character Limit');
                return false;
            }
            obj_course_data.course_title = $('#txtcourse_title').val();
            
            obj_course_data.category_location_wise = $('#drp_category_location_wise').val();
            obj_course_data.location = $('#txt_location').val();
            obj_course_data.intake_capacity = $('#drpavailable_seats').val();
            obj_course_data.credits = $('#drp_credits').val();

            $('#txtcourse_description').keyup();
            if (parseInt($('#spn_desc').html().split(':')[1].trim()) > 300) {
                bootbox.alert('Course Description Exceeds the Word Limit');
                return false;
            }
            obj_course_data.description = $('#txtcourse_description').val();
            obj_course_data.prerequisite = $('#txtcourse_prerequisite').val();

            if ($('#chk_is_for_professional')[0].checked) {
                obj_course_data.is_open_for_professional = 'Y';
                obj_course_data.professional_prerequisite = $('#txt_professional_prerequisite').val();
            }
            else {
                obj_course_data.is_open_for_professional = 'N';
            }

            obj_course_data.start_date = convertDateFormat($('#txt_start_date').val());
            if (obj_course_data.start_date == '') return false;

            obj_course_data.end_date = convertDateFormat($('#txt_end_date').val());
            if (obj_course_data.end_date == '') return false;

            //obj_course_data.course_image = $('#txtcourse_title').val();
            obj_course_data.course_image = FileName;
            obj_course_data.image_source = $('#txt_image_source').val();
            obj_course_data.inhabitation = $('#drp_inhabitation').val();
            obj_course_data.methodology = $('#drp_methodology').val();

            obj_course_data.course_output1 = $('#drp_course_output1').val();
            obj_course_data.course_output2 = $('#drp_course_output2').val();
            obj_course_data.course_output3 = $('#drp_course_output3').val();
            
            obj_course_data.material_cost = $('#txt_material_cost').val();
            obj_course_data.food_stay = $('#txt_food_stay').val();
            obj_course_data.local_travel = $('#txt_local_travel').val();
            obj_course_data.approx_expense = $('#div_total_approx_expense').html();
            obj_course_data.travel_expense = $('#txt_travel_expense').val();
            obj_course_data.total_expense = $('#div_total_expense').html();

            var instructor_data_list = [];
            $('#tblinstructor tbody tr').each(function (i) {
                var instructor_data = { 'instructor_code': '', 'contact_hrs': '' };

                instructor_data.instructor_code = $(this).find(".drpinstructor").val();
                instructor_data.contact_hrs = $(this).find(".per_load").val();

                instructor_data_list.push(instructor_data);
            });

            obj_course_data.instructor = instructor_data_list;

            var All_table_course_data = [obj_course_data, action];
            var json_All_table_course_data = JSON.stringify(All_table_course_data);

            if (json_All_table_course_data.search("'") != -1) {
                json_All_table_course_data = json_All_table_course_data.replace(/\'/g, '\\\'');
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_WS_course_data",

                data: "{ All_table_course_data: '" + json_All_table_course_data + "' }",
                dataType: "json",
                success: function (data) {

                    if (data.d == 'Course Code is already Available , You can not enter same Course Code again') {
                        bootbox.alert(data.d);
                    }
                    else if (data.d == 'Data Saved Successfully') {
                        bootbox.alert(data.d, function () {
                            location.reload();
                            //window.location = "Admin_dashboard.aspx";
                        });
                    }
                    else if (data.d != "") {
                        alert(data.d);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

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

                        if ($("#hdn_utype").val() == 'I2') {
                            instructor = "<select style='width:85%' class='drpinstructor' disabled>";
                        }
                        else {
                            instructor = "<select style='width:85%' class='drpinstructor'>";
                        }

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

        var intake_criteria;
        function get_intake_criteria() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_student_intake_criteria",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        intake_criteria = JSON.parse(data.d)
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        $('#tblinstructor tbody tr td i.icon-trash').live('click', function (e) {
            if ($("#hdn_utype").val() != 'I2') {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {
                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;

                    category_location_change();
                }
            }
        });

        function get_course_data() {

            var course_code = $('#hdn_course_code').val();
            if (course_code == '') return;

            var sem_code = $('#hdn_sem').val();
            if (sem_code == '') return;

            var year_code = $('#hdn_year').val();
            if (year_code == '') return;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_all_ws_course_proposal_data",
                async: false,
                data: "{course_code:'" + course_code + "',sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d[0] != null) {

                        var course_data = JSON.parse(data.d[0]);

                        $('#txtcourse_title').val(course_data[0]["course_name"]);
                        $('#drp_category_location_wise').val(course_data[0]["category_location_wise"]);
                        $('#txt_location').val(course_data[0]["location"]);

                        if (course_data[0]["available_seat"] != '') {
                            $('#drpavailable_seats').append('<option id="' + course_data[0]["available_seat"] + '">' + course_data[0]["available_seat"] + '</option>');
                        }
                        $('#drpavailable_seats').val(course_data[0]["available_seat"]);

                        $('#drp_credits').val(course_data[0]["course_credits"]);
                        $('#txtcourse_description').val(course_data[0]["course_desc"]);
                        $('#txtcourse_prerequisite').val(course_data[0]["prerequisite"]);

                        if (course_data[0]["is_open_for_professional"] == 'Y') {
                            $('#chk_is_for_professional')[0].checked = true;
                            $('#txt_professional_prerequisite').val(course_data[0]["prerequisite_for_prof"]);
                            $('#chk_is_for_professional').change();
                        }

                        //$('#txt_start_date').val(course_data[0]["start_date"]);
                        if (course_data[0]["start_date"] != '') {
                            var temp_date = new Date(course_data[0]["start_date"]);
                            $('#txt_start_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }

                        //$('#txt_end_date').val(course_data[0]["end_date"]);
                        if (course_data[0]["end_date"] != '') {
                            var temp_date = new Date(course_data[0]["end_date"]);
                            $('#txt_end_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }

                        FileName = course_data[0]["image_name"];
                        $('#lbl_courseimage_file_name').html(course_data[0]["image_name"]);
                        $('#txt_image_source').val(course_data[0]["image_source"]);
                        $('#drp_inhabitation').val(course_data[0]["inhabitation"]);
                        $('#drp_methodology').val(course_data[0]["methodology"]);

                        $('#drp_course_output1').val(course_data[0]["course_output1"]);
                        $('#drp_course_output2').val(course_data[0]["course_output2"]);
                        $('#drp_course_output3').val(course_data[0]["course_output3"]);

                        $('#txt_material_cost').val(course_data[0]["material_cost"]);
                        $('#txt_food_stay').val(course_data[0]["food_stay"]);
                        $('#txt_local_travel').val(course_data[0]["local_travel"]);
                        $('#div_total_approx_expense').html(course_data[0]["approx_expense"]);
                        $('#txt_travel_expense').val(course_data[0]["travel_expense"]);
                        $('#div_total_expense').html(course_data[0]["total_expense"]);

                        $('#txtcourse_title').keyup();
                        $('#txtcourse_description').keyup();
                    }

                    $("#tblinstructor tbody").html('');
                    if (data.d[1] != null) {

                        $("#tblinstructor tbody").html('');
                        var course_instructor_data = JSON.parse(data.d[1]);

                        for (var i = 0; i < course_instructor_data.length; i++) {
                            //                            if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            //                                var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric(event);' disabled/></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            //                            }
                            //                            else {
                            var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric(event);' /></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            //                            }
                            $('#tblinstructor tbody').append(str);
                        }

                        $("#tblinstructor tbody tr").each(function (j) {
                            for (var i = 0; i < course_instructor_data.length; i++) {
                                if (j == i) {
                                    $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);
                                    $(this).find(".per_load").val(course_instructor_data[i]["contact_hrs"]);
                                    //    $(this).find(".drpinstructor").chosen();
                                    // $(this).find(".drpinstructor").trigger("liszt:updated");
                                }
                            }
                        });
                    }
                    category_location_change();
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function category_location_change() {
            var min = 0;
            var max = 0;
            var cur_intake_capacity = $('#drpavailable_seats').val();
            if ($('#drp_category_location_wise').val() != '') {
                for (var i = 0; i < intake_criteria.length; i++) {
                    if (intake_criteria[i]['intake_desc'] == $('#drp_category_location_wise').val() && intake_criteria[i]['instructor_type'] == $('#hdn_utype').val()) {
                        min = parseInt(intake_criteria[i]['min']);
                        max = parseInt(intake_criteria[i]['max']);
                        if ($('#tblinstructor tbody tr').length > 1) {
                            max = parseInt(intake_criteria[i]['two_faculty_max']);
                        }
                    }
                }
            }

            $('#spn_min').html(min);
            $('#spn_max').html(max);

            var drpoption = $('#drpavailable_seats option')[0];
            $('#drpavailable_seats').html(drpoption);
            if (min != 0 && max != 0) {
                for (var i = min; i <= max; i++) {
                    $('#drpavailable_seats').append('<option id="' + i + '">' + i + '</option>');
                }
            }

            $('#drpavailable_seats').val(cur_intake_capacity);
        }

        function chk_change() {
            if ($('#chk_is_for_professional')[0].checked) {
                $('#div_professional_prerequisite').css('display', 'block');
            }
            else {
                $('#div_professional_prerequisite').css('display', 'none');
            }
        }

        function convertDateFormat(str_date) {
            if (str_date != '') {
                if (str_date.split('/').length == 3) {
                    var date_split = str_date.split('/');
                    var temp_date = new Date(date_split[1] + '/' + date_split[0] + '/' + date_split[2]);
                    if (temp_date.toString() == 'Invalid Date') {
                        bootbox.alert('Please Enter Date in valid format');
                        return '';
                    }
                    else {
                        return '' + (temp_date.getMonth() + 1) + '/' + temp_date.getDate() + '/' + temp_date.getFullYear();
                    }
                }
                else {
                    bootbox.alert('Please Enter Date in valid format');
                    return '';
                }
            }
            else
                return str_date;
        }
    </script>
</asp:Content>
