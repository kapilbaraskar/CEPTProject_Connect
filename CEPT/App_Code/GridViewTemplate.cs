using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;


public class GridViewTemplate : System.Web.UI.Page, ITemplate
{

    ListItemType templateType;

    string columnName;

    public GridViewTemplate(ListItemType type, string colname)
    {

        templateType = type;

        columnName = colname;

    }


    public void InstantiateIn(System.Web.UI.Control container)
    {

        Literal lc = new Literal();

        LinkButton lb = new LinkButton();
        CheckBox ckh = new CheckBox();
        ckh.ID = "ID" + columnName;
        //TextBox tb1 = new TextBox(); 

        switch (templateType)
        {

            case ListItemType.Header:

                lc.Text = "<B>" + columnName + "</B>";

                lb.Text = "Edit";

                lb.CommandName = "EditButton";

                container.Controls.Add(lb);

                container.Controls.Add(lc);

                break;

            case ListItemType.Item:


                //container.Controls.Add(tb1); 
                container.Controls.Add(ckh);

                break;

            //case ListItemType.EditItem:

            //    TextBox tb = new TextBox();

            //    tb.Text = "";

            //    container.Controls.Add(tb);

            //    break;

            case ListItemType.Footer:

                lc.Text = "<I>" + columnName + "</I>";

                container.Controls.Add(lc);

                break;

        }

    }
}