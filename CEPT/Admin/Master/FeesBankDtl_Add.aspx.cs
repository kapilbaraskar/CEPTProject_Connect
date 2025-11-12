using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Master_FeesBankDtl_Add : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        hdn_sem.Value = Request.QueryString["s"];
        hdn_year.Value = Request.QueryString["y"];
        hdn_dept.Value = Request.QueryString["d"];
        hdn_prog.Value = Request.QueryString["p"];
        hdn_allo_year.Value = Request.QueryString["a"];
        hdn_nationality.Value = Request.QueryString["n"];
    }
}