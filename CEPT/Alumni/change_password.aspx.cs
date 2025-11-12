using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Utilities;

public partial class Alumni_change_password : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Redirect("http://alumni.cept.ac.in/Alumni/register_user.aspx?id=" + Request.QueryString["id"]);

        if (Request.QueryString["id"] != null)
        {
            //EncodingDecoding encoding_decoding = new EncodingDecoding();

            //string dec_email = encoding_decoding.decryptPassword(Request.QueryString["id"].ToString());

            //if (dec_email != "")
            //{
            //    txt_email.Value = dec_email;
            //    txt_email.Attributes.Add("disabled", "disabled");
            //}
        }
        else
        { 
            
        }
    }
}