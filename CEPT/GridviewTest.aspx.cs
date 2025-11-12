using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using BLL.Master;
using System.Configuration;

public partial class GridviewTest : System.Web.UI.Page
{

    Masters objmaster = new Masters(); 

    SqlConnection con = new SqlConnection("Data Source = FWSERVER2\\SQL2008R2; Initial Catalog = CEPT_Reg_latest1; User ID=sa; password=m_pradeep2411;");

    SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["SBSSNDConnectionString"].ConnectionString);

    int page_size = 100;

    protected void Page_Load(object sender, EventArgs e)
    {

        con1.Open();

        con.Open();

        if (con1.State == ConnectionState.Open )
        {
            con1.Close();
        }

        if (!IsPostBack)
        {
            DataTable dt = objmaster.get_user_mst_data_grid("1","1000");

            GridView1.DataSource = dt;
            GridView1.DataBind();

        }
    }
    protected void GridView1_PageIndexChanged(object sender, EventArgs e)
    {
      
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;

        int start = 1;
        int end = ((e.NewPageIndex + 1)  * page_size) + 1;

        DataTable dt = objmaster.get_user_mst_data_grid(start.ToString(),end.ToString());

        GridView1.DataSource = dt;
        GridView1.DataBind();
    }

    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

        Label lbl = (Label)GridView1.Rows[e.NewSelectedIndex].FindControl("lbl_dept");

        string user_id = GridView1.Rows[e.NewSelectedIndex].Cells[0].Text;

        string lbl_str = lbl.Text;

    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        string a = Calendar1.SelectedDate.ToString();
    }
    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string user_id = GridView1.Rows[e.RowIndex].Cells[0].Text;
    }
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {

    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;

        DataTable dt = objmaster.get_user_mst_data_grid("","");

        GridView1.DataSource = dt;
        GridView1.DataBind();
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TextBox txt = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txt_user_type");

        

        string user_id = txt.Text;

    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;

        DataTable dt = objmaster.get_user_mst_data_grid("","");

        GridView1.DataSource = dt;
        GridView1.DataBind();
      //  GridView1.DataBind();
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        DataTable dt = objmaster.Get_department_data();

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            DropDownList drp = (DropDownList)e.Row.FindControl("drp_dept_code");

            if (drp != null)
            {

                drp.DataSource = dt;
                drp.DataTextField = "dept_name";
                drp.DataValueField = "dept_code";
                drp.DataBind();

                drp.Items.Insert(0, "--select--");
            }
        }


    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "edit")
        {
            string a = e.CommandArgument.ToString();


        }
    }
}
