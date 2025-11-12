<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GridviewTest.aspx.cs" Inherits="GridviewTest" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server" PageSize="100" AllowPaging="True" AutoGenerateColumns="False"
            AlternatingRowStyle-BackColor="ActiveBorder" OnPageIndexChanged="GridView1_PageIndexChanged"
            OnPageIndexChanging="GridView1_PageIndexChanging" OnSelectedIndexChanging="GridView1_SelectedIndexChanging"
            OnRowDeleted="GridView1_RowDeleted" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing"
            OnRowUpdating="GridView1_RowUpdating" OnRowCancelingEdit="GridView1_RowCancelingEdit"
            OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand">
            <AlternatingRowStyle BackColor="ActiveBorder" />
            <Columns>
                <asp:BoundField ReadOnly="true" DataField="user_id" HeaderText="Student Code" SortExpression="user_id" />
                <asp:BoundField ReadOnly="true" DataField="user_name" HeaderText="Student Name" SortExpression="user_id" />
                <asp:TemplateField HeaderText="User Type">
                    <ItemTemplate>
                        <asp:Label ID="lbl_dept" runat="server" Text='<%#Bind("user_type") %>'>  
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox runat="server" Text='<%# Bind("user_type") %>' ID="txt_user_type"></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Department">
                    <ItemTemplate>
                        <asp:Label ID="lbl_dept_code" runat="server" Text='<%#Bind("dept_code") %>'>  
                        </asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList runat="server" ID="drp_dept_code" DataTextField="dept_code" DataValueField="dept_name">
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Edit">
                    <ItemTemplate>
                        <asp:LinkButton runat="server" ID="lnk_edit" CommandName="edit" CommandArgument='<%# Eval("user_id") %>'>Edit</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:CommandField ShowSelectButton="True" />
                <asp:CommandField ShowDeleteButton="True" />--%>
                <asp:CommandField ShowEditButton="True" />
            </Columns>
            <PagerSettings FirstPageText="First" />
        </asp:GridView>
    </div>
    <div>
        <asp:ObjectDataSource ID="profileDataSource" runat="server" SelectMethod="GetProfileData"
            EnablePaging="true" MaximumRowsParameterName="pageSize" StartRowIndexParameterName="startRowIndex"
            TypeName="" SelectCountMethod="TotalRowCount" SortParameterName="sortExpression">
            <SelectParameters>
                <asp:Parameter Name="startRowIndex" Type="Int32" />
                <asp:Parameter Name="pageSize" Type="Int32" />
                <asp:Parameter Name="sortExpression" Type="String" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
    <div style="display: none;">
        <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged">
        </asp:Calendar>
    </div>
    </form>
</body>
</html>
