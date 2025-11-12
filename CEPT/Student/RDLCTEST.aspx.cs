using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL.Master;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Student_RDLCTEST : System.Web.UI.Page
{

    Masters objmaster = new Masters();

    protected void Page_Load(object sender, EventArgs e)
    {

        DataTable dt = objmaster.get_all_student_data();

        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Report.rdlc");

        ReportDataSource datasource = new ReportDataSource("Dataset1",dt);
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.DataSources.Add(datasource);

    }
}