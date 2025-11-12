using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for SBSMessageBox
/// </summary>
public class SBSMessageBox
{
    Page objPage;
    public SBSMessageBox(Page _page)
    {
        objPage = _page;
        //
        // TODO: Add constructor logic here
        //
    }

    public void Show(String Message)
    {
        string cleanMessage = Message.Replace("'", "\\'");
        string script = "<script type=\"text/javascript\">alert('" + cleanMessage + "');</script>";

        // Gets the executing web page
        Page page = HttpContext.Current.CurrentHandler as Page;

        // Checks if the handler is a Page and that the script isn't allready on the Page
        if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
        {
            page.ClientScript.RegisterClientScriptBlock(typeof(SBSMessageBox), "alert", script);
        }

        //Message = Message.Replace('\n', ' ');
        //objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\" type=\"text/javascript\"> window.onload = initMsg; function initMsg() { try {  var wh = document.documentElement.clientHeight; MasterTable.style.height = wh - 97; document.getElementById('MenuDiv').style.height = (wh - 101)+'px'; document.getElementById('MenuDiv').style.left = leftmost+'px'; document.getElementById('innerMenuDiv').style.width = (340)+'px'; document.getElementById('frmMenu').style.left = leftmost+'px'; document.getElementById('frmMenu').style.height = (wh - 109)+'px'; document.getElementById('innerMenuDiv').style.height = (wh - 101)+'px'; alert('" + Message.Replace("'", "\'") + "');} catch(oexception) { } } </script>"); 
        //objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\"> alert('" + Message.Replace("'", "\'") + "'); </script>");
        //Commented on 28-07-2009 objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\" type=\"text/javascript\"> window.onload = initMsg; function initMsg() { try { alert('" + Message.Replace("'", "\'") + "'); var wh = document.documentElement.clientHeight - document.getElementById(\"Header\").clientHeight - document.getElementById(\"Middle\").clientHeight - 4; document.getElementById(\"frmMenu\").style.height = wh+\"px\"; document.getElementById(\"MenuDiv\").style.height = wh+\"px\"; document.getElementById(\"innerMenuDiv\").style.height = wh+\"px\"; document.getElementById(\"innerMenuTable\").style.height = wh - 76+\"px\"; } catch(oexception) { } } </script>");
        //Commented on 26-11-2008 objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\" type=\"text/javascript\"> window.onload = initMsg; function initMsg() { try { alert(\"" + Message.Replace("'", "\'") + "\"); var wh = document.documentElement.clientHeight - document.getElementById(\"trMasterTop\").clientHeight - document.getElementById(\"trMasterMiddle\").clientHeight - 4; document.getElementById(\"frmMenu\").style.height = wh+\"px\"; document.getElementById(\"MenuDiv\").style.height = wh+\"px\"; document.getElementById(\"innerMenuDiv\").style.height = wh+\"px\"; document.getElementById(\"innerMenuTable\").style.height = wh - 76+\"px\"; } catch(oexception) { } } </script>");
        //Comment on 30/09/2008//objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\" type=\"text/javascript\"> var oPopup = window.createPopup(); var oPopBody = oPopup.document.body; oPopBody.style.backgroundColor = \"#f6f7f1\"; oPopBody.style.border = \"solid Black 1px\"; oPopBody.innerHTML = '<table cellpadding=2 cellspacing=0 border=0 height=100% width=100%><tr><td style=\"height:30%; filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr=gray, endColorStr=#lightyellow, gradientType=0); font-size:12px; font-weight:bold; font-family:verdana; color:white;\">&nbsp SPECTRUM</td></tr><tr><td align=\"center\" style=\"height:60%; font-size:8pt; font-weight:bold; font-family:tahoma \">" + Message + "</td></tr><tr><td align=center><hr size=\"1\" style=\"border:1px solid black;\"><button id=\"btnMsgOK\" onclick=\"parent.oPopup.hide();\" style=\"cursor:hand; border:1px solid black; border-left:1px solid white; border-top:1px solid white; background:#cccccc \">&nbsp; &nbsp; &nbsp;<b> OK </b>&nbsp; &nbsp; &nbsp; </button> </td></tr></table>'; oPopup.show(document.documentElement.clientWidth/2 - 150, document.documentElement.clientHeight/2 - 60, 300, 120, document.body); </script>");
        //objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\" type=\"text/javascript\"> var oPopup = window.createPopup(); var oPopBody = oPopup.document.body; oPopBody.style.backgroundColor = \"#f6f7f1\"; oPopBody.style.border = \"solid Black 1px\"; oPopBody.innerHTML = '<table cellpadding=0 cellspacing=0 border=0 height=100% width=100%><tr><td style=\"height:20%; filter: progid:DXImageTransform.Microsoft.Gradient(startColorStr=gray, endColorStr=#lightyellow, gradientType=0); font-size:12px; font-weight:bold; font-family:verdana; color:white;\">&nbsp SPECTRUM</td></tr><tr><td align=\"center\" style=\"height:80%; font-size:12px; font-weight:bold; font-family:verdana \">" + Message + "</td></tr></table>' ; oPopup.show(document.documentElement.clientWidth/2 - 125, document.documentElement.clientHeight/2 - 50, 250, 100, document.body); </script>"); //<tr><td valign=bottom><input id=Button1 onclick=oPopup.hide width=90px type=button value=OK /></td></tr> oPopBody.style.verticalAlign = \"middle\"; 
    }

    public void Confirm(String Message)
    {
        Message = Message.Replace('\n', ' ');
        objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\"> confirm('" + Message.Replace("'", "\'") + "'); </script>");
    }

    public void Prompt(String Message)
    {
        Message = Message.Replace('\n', ' ');
        objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\"> prompt('" + Message.Replace("'", "\'") + "', ''); </script>");
    }

    public void Prompt(String Message, String Default_Value)
    {
        Message = Message.Replace('\n', ' ');
        objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\"> prompt('" + Message.Replace("'", "\'") + "', '" + Default_Value + "'); </script>");
    }

    public void ShowLoading()
    {
        objPage.ClientScript.RegisterClientScriptBlock(this.GetType(), Guid.NewGuid().ToString(), "<script language=\"JavaScript\" type=\"text/javascript\"> var oPopup = window.createPopup(); var oPopBody = oPopup.document.body; oPopBody.style.backgroundColor = \"White\"; oPopBody.innerHTML = '<table cellpadding=0 cellspacing=0 border=0 height=100% width=100%><tr><td align=\"center\" style=\"height:80%; font-size:12px; font-weight:bold; font-family:verdana \"> <img alt=\"\" src=\"D:/HRPortal29-03-2008/SBSPortal/UIL/App_Themes/EmPowerNew/Images/loading3.gif\" /> </td></tr></table>' ; oPopup.show(document.documentElement.clientWidth/2 - 50, document.documentElement.clientHeight/2 - 15, 100, 30, document.body); </script>");
    }
}