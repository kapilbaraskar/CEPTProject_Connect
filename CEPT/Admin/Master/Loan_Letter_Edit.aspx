<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Loan_Letter_Edit.aspx.cs" Inherits="Admin_Master_Loan_Letter_Edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/ckeditor2/ckeditor.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            get_profile_details();
        });

        function get_profile_details() {
            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_parameter_value",
                data: "{param_name :'loan_letter_pdf'}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                async: false,
                success: function (data) {
                    if (data.d[0] != null) {
                        var p_details = JSON.parse(data.d);
                        $('#txt_projects').val(p_details[0].disable_message);
                    }
                },
                error: function (data) {
                    alert(data);
                }
            });
        }

        function save_loan_letter() {
            var text = "";
            if (CKEDITOR.instances.txt_projects.getData() == "") {
            }
            else {
                text = CKEDITOR.instances.txt_projects.getData();
            }

            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/save_parameters_value_loanLetter",
                data: "{param_data :'" + text + "'}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                async: false,
                success: function (data) {
                    if (data.d[0] != null) {
                        var p_details = JSON.parse(data.d);
                        if (p_details.status == "True") {
                            alert(p_details.message);
                            get_profile_details();
                        } else {
                            alert(p_details.message);
                        }
                    }
                },
                error: function (data) {
                    alert(data);
                }
            });
        }
    </script>

    <style type="text/css">
        .cls_red
        {
            color: red;
        }
        #div_param_list li
        {
            margin-top:7px !important;
        }
        #cke_txt_projects
        {
            width:1050px !important;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="text-align: center;margin-top:20px;">
         <textarea class="ckeditor" id="txt_projects" rows="3" cols="50" name="address"></textarea>
    </div>

    <div style="text-align: center; margin-top: 10px;">
        <button class="btn  btn-primary" type="button" id="btn_save" onclick="return save_loan_letter()">Submit</button>
    </div>

    <div id="div_param_list" style="padding-bottom: 20px;">
        <ul>
            <li><span class="cls_red">@@lbl_title </span> : Mr/Ms</li>
            <li><span class="cls_red">@@lbl_name </span> : User Name</li>
            <li><span class="cls_red">@@lbl_user_id </span> : User Id</li>
            <li><span class="cls_red">@@lbl_dept_name1 </span> : Dept Name</li>
            <li><span class="cls_red">@@lbl_total_year </span> : Total Year</li>
            <li><span class="cls_red">@@lbl_prog_name </span> : Program Name</li>            
            <%--<li><span class="cls_red">@@lbl_his_her1 </span> : his/her (For all small letters)</li>--%>
            <li><span class="cls_red">@@lbl_his_her2 </span> : his/her (For all small letters)</li>
            <li><span class="cls_red">@@lbl_his_her3 </span> : His/Her (For first letter Capital)</li>
            <li><span class="cls_red">@@lbl_he_she2 </span> : he/she (For all small letters)</li>
            <li><span class="cls_red">@@lbl_he_she3 </span> : He/She (For first letter Capital)</li>
            <li><span class="cls_red">@@lbl_prev_sem </span> : Monsoon/Spring</li>
            <li><span class="cls_red">@@lbl_cur_sem semester </span> : Monsoon/Spring</li>            
            <li><span class="cls_red">@@lbl_fees1 </span> : fees</li>
            <%--<li><span class="cls_red">@@lbl_fees2 </span> : fees</li>--%>            
            <li><span class="cls_red">@@lbl_apprx_grad_year </span> : program completion year</li>
        </ul>
    </div>
</asp:Content>

