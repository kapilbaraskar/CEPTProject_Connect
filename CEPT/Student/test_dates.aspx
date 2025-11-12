<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test_dates.aspx.cs" Inherits="Student_test_dates" %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title></title>
        <script type="text/javascript">
            function tempFunction() {
                document.getElementById('txt_weekdays').value = '';

                var obj_temp = document.getElementsByClassName('cls_week_check');

                for (var i = 0; i < obj_temp.length; i++) {
                    if (obj_temp[i].checked) {
                        if (document.getElementById('txt_weekdays').value == '')
                            document.getElementById('txt_weekdays').value += obj_temp[i].id;
                        else
                            document.getElementById('txt_weekdays').value += ',' + obj_temp[i].id;
                    }
                }
            }
        </script>
    </head>
    <body>
        <form id="form1" runat="server">
            <div>
                <div style="float:left;">
                    <asp:Calendar ID="Cal_start_date" runat="server"></asp:Calendar>
                </div>
                <div style="float:left;margin-left:20px;">
                    <asp:Calendar ID="Cal_end_date" runat="server"></asp:Calendar>
                </div>
                <div style="clear:both;"></div>
            </div>

            <div style="margin-top:20px;">
                <span>Select Day of Week : </span>
                <asp:DropDownList ID="Drp_day_of_week" runat="server">
                    <asp:ListItem Value="Sunday">Sunday</asp:ListItem>
                    <asp:ListItem Value="Monday">Monday</asp:ListItem>
                    <asp:ListItem Value="Tuesday">Tuesday</asp:ListItem>
                    <asp:ListItem Value="Wednesday">Wednesday</asp:ListItem>
                    <asp:ListItem Value="Thursday">Thursday</asp:ListItem>
                    <asp:ListItem Value="Friday">Friday</asp:ListItem>
                    <asp:ListItem Value="Saturday">Saturday</asp:ListItem>
                </asp:DropDownList>

                <span>Select Occurrence : </span>
                <asp:DropDownList ID="Drp_occurrence" runat="server">
                    <asp:ListItem Value="odd">Odd</asp:ListItem>
                    <asp:ListItem Value="even">Even</asp:ListItem>
                    <asp:ListItem Value="1">1</asp:ListItem>
                    <asp:ListItem Value="2">2</asp:ListItem>
                    <asp:ListItem Value="3">3</asp:ListItem>
                    <asp:ListItem Value="4">4</asp:ListItem>
                    <asp:ListItem Value="5">5</asp:ListItem>
                </asp:DropDownList>

                <asp:Button ID="Button1" runat="server" Text="Get Dates" onclick="Button1_Click" />
            </div>
            
            <br />

            <div style="margin-top:20px;">
                <span>No of Week to skip : </span>
                <input type="text" id="txt_skip_week" runat="server" />
                <input type="text" id="txt_weekdays" runat="server" />

                <br />
                
                <span>Select Days of Week : </span>
                <input type="checkbox" id="Sunday" name="chk_week" class="cls_week_check" /> Sunday
                <input type="checkbox" id="Monday" name="chk_week" class="cls_week_check" /> Monday
                <input type="checkbox" id="Tuesday" name="chk_week" class="cls_week_check" /> Tuesday
                <input type="checkbox" id="Wednesday" name="chk_week" class="cls_week_check" /> Wednesday
                <input type="checkbox" id="Thursday" name="chk_week" class="cls_week_check" /> Thursday
                <input type="checkbox" id="Friday" name="chk_week" class="cls_week_check" /> Friday
                <input type="checkbox" id="Saturday" name="chk_week" class="cls_week_check" /> Saturday

                <asp:Button ID="Button2" runat="server" Text="Get Dates" OnClick="Button2_Click" OnClientClick="tempFunction()" />
            </div>

            <br />

            <div>
                <div><b>Result : </b></div>
                <div runat="server" clientidmode="Static" id="Div_result"></div>
            </div>
        </form>
    </body>
</html>
