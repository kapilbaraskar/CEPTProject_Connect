using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.OleDb;

public partial class Admin_Master_Upload_Student_Wise_Course : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        /*
    
        OleDbConnection con = new OleDbConnection(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\CEPT-Kamlesh\Demo_Student_Wise_Course.xls;Extended Properties=Excel 8.0;");
        
        DataTable dt = new DataTable();
        dt.Columns.Add("user_id");
        dt.Columns.Add("user_name");
        dt.Columns.Add("course_code");

        con.Open();

        OleDbCommand cmd = con.CreateCommand();
        cmd.CommandText = @"select * from [Sheet1$]";
        cmd.CommandType = CommandType.Text;

        var reader = cmd.ExecuteReader();

        while (reader.Read())
        {
            DataRow dr = dt.NewRow();
            dr["user_id"] = reader.GetDouble(0);
            dr["user_name"] = reader.GetString(1);
            dr["course_code"] = reader.GetDouble(2);
            dt.Rows.Add(dr);
        }

        con.Close();
        */

        string user = Session["UserId"].ToString();

        if (!IsPostBack)
        {
            if (Session["user_type"].ToString() != "A")
            {


                if (Session["user_type"].ToString() == "S")
                {
                    Response.Redirect("~/Student/Dashboard.aspx?autho=false");
                }
                else if (Session["user_type"].ToString() == "I")
                {
                    Response.Redirect("~/IT/IT_dashboard.aspx?autho=false");
                }
                else if (Session["user_type"].ToString() == "A1")
                {
                    Response.Redirect("~/Admin/Master/admin_dashboard.aspx?autho=false");
                }

            }
        }

    }

}