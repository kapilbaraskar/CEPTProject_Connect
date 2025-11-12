<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test_drp.aspx.cs" Inherits="Student_test_drp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>
    <script src="../Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.min.js" type="text/javascript"></script>

    <script type="text/javascript">

        var option_len = 10;
        var obj_option = { 'AAA': '<option value="AAA">AAA</option>',
            'BBB': '<option value="BBB">BBB</option>',
            'CCC': '<option value="CCC">CCC</option>',
            'DDD': '<option value="DDD">DDD</option>',
            'EEE': '<option value="EEE">EEE</option>',
            'FFF': '<option value="FFF">FFF</option>',
            'GGG': '<option value="GGG">GGG</option>',
            'HHH': '<option value="HHH">HHH</option>',
            'III': '<option value="III">III</option>',
            'JJJ': '<option value="JJJ">JJJ</option>'
        };

        function add_drp() {
            var len = $('#div_parent').children().length;

            if (len < option_len) {
                var obj_selection = {};
                var str_child = '';

                for (var i = 0; i < len; i++) {
                    var drp = $('#div_parent').children()[i].getElementsByClassName('cls_drp')[0];
                    obj_selection[drp.value] = true;
                }

                for (var key in obj_option) {
                    if (obj_selection[key] == undefined || obj_selection[key] != true)
                        str_child += obj_option[key];
                }

                var id = (new Date()).getTime();
                if (str_child != '') {
                    str_append = '<div id="div_child' + id + '"><select id="drp' + id + '" class="cls_drp" onchange="drp_change()"><option value="">-- Select --</option>' + str_child + '</select><input type="button" id="btn' + id + '" value="-" style="vertical-align:super;" onclick="remove_drp(this)" /></div>';

                    $('#div_parent').append(str_append);
                }
            } 
        }

        function remove_drp(cur_ele) {
            $(cur_ele).closest('div').remove();
            drp_change();
        }

        function drp_change() {
            var len = $('#div_parent').children().length;
            var obj_selection = {};
            var obj_value_selection = {};

            for (var i = 0; i < len; i++) {
                var drp = $('#div_parent').children()[i].getElementsByClassName('cls_drp')[0];
                obj_selection[drp.id] = drp.value;
                obj_value_selection[drp.value] = true;
            }

            for (var i = 0; i < len; i++) {
                var drp = $('#div_parent').children()[i].getElementsByClassName('cls_drp')[0];
                var str_child = '';
                for (var key in obj_option) {
                    if (obj_selection[drp.id] == key || obj_value_selection[key] == undefined || obj_value_selection[key] != true)
                        str_child += obj_option[key];
                }
                drp.innerHTML = '<option value="">-- Select --</option>' + str_child;
                drp.value = obj_selection[drp.id];
            }
        }
    </script>
</head>
<body class="container">
    
    <input type="button" id="btn_add" value="Add" onclick="add_drp()" style="margin-top:20px;margin-bottom:20px;" />

    <div id="div_parent">
        <div id="div_child1">
            <select id="drp1" class="cls_drp" onchange="drp_change()">
                <option value="">-- Select --</option>
                <option value="AAA">AAA</option>
                <option value="BBB">BBB</option>
                <option value="CCC">CCC</option>
                <option value="DDD">DDD</option>
                <option value="EEE">EEE</option>
                <option value="FFF">FFF</option>
                <option value="GGG">GGG</option>
                <option value="HHH">HHH</option>
                <option value="III">III</option>
                <option value="JJJ">JJJ</option>
            </select>
        </div>
    </div>

    <%--<form>
        <div>
            <label>Username</label>
            <input class="text-box single-line input-validation-error" data-val="true" data-val-regex="Please enter valid email id." data-val-regex-pattern="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$" data-val-required="The Mail field is required." id="mail" name="mail" type="text" value="" />
            <span class="field-validation-valid" data-valmsg-for="mail" data-valmsg-replace="true"></span>

            <label>Password</label>
            <input class="text-box single-line valid" data-val="true" data-val-required="The Password field is required." data-val-length="The field password must be a string with a minimum length of 4 and a maximum length of 10." data-val-length-max="10" data-val-length-min="4" id="password" name="password" type="text" value="" />
            <span class="field-validation-valid" data-valmsg-for="password" data-valmsg-replace="true"></span>

            <label>user_id</label>
            <input class="input-validation-error" data-val="true" data-val-required="The UserId field is required." id="txt_userid" name="user_id" type="text" value="" />
            <span class="field-validation-valid" data-valmsg-for="user_id" data-valmsg-replace="true"></span>
        </div>
        <input type="submit" value="Submit" />
    </form>--%>

    <div id="div_print" runat="server"></div>
</body>
</html>
