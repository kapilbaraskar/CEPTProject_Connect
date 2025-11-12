using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using System.IO;
using System.Security.Cryptography;
using CCA.Util;

public partial class ResetPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["UN"] != null && Request.QueryString["UN"].ToString() != "")
            {
                hfUserId.Value = Request.QueryString["UN"].ToString();
            }
        }
        catch (Exception ex)
        {
            //throw ex;
        }
    }
}