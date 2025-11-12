using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

namespace BLL.ExtraUtility
{
    /// <summary>
    /// Contains Extra Utilities(Functions). 
    /// </summary>
    public class ExtraUtility
    {
        /// <summary>
        /// Following function clears the data from whole Web Page(Entered Data in Web & HTML Controls).
        /// Parameters  : 1). Page.Controls
        ///             : 2). True
        /// Following function finds all the existing controls from the whole Web Page and 
        /// checks which control is this and clears data from it.
        /// It clears Data From Controls Like  : TextBox (Clears Text)
        ///                                    : DropDownList (Sets SelectedIndex = 0)
        ///                                    : ListBox (Sets SelectedIndex = 0)
        ///                                    : CheckBox (Make Checked = false)
        ///                                    : RadioButton  (Make Checked = false) etc.
        /// </summary>
        /// <param name="controls"></param>
        /// <param name="check"></param>
        public void ClearForm(ControlCollection controls, bool check)
        {
            foreach (Control control in controls)
            {
                if (control is TextBox)
                {
                    if (((TextBox)control).Text == "DD/MM/YYYY")
                        break;
                    else if (((TextBox)control).Text == "DD/MM/YYYY HH:MM")
                        break;
                    else if (((TextBox)control).Text == "HH:MM")
                        break;
                    else
                        ((TextBox)control).Text = "";
                }
                if (control is DropDownList)
                {
                    if (((DropDownList)control).Items.Count > 0)
                        ((DropDownList)control).SelectedIndex = 0;
                }
                if (control is ListBox)
                {
                    if (((ListBox)control).Items.Count > 0)
                        ((ListBox)control).SelectedIndex = 0;
                }
                if (control is CheckBox)
                {
                    ((CheckBox)control).Checked = false;
                }
                if (control is CheckBoxList)
                {
                    if (((ListControl)control).Items.Count >= 0)
                        ((ListControl)control).SelectedIndex = 0;
                }
                if (control is RadioButton)
                {
                    ((RadioButton)control).Checked = false;
                }
                if (control is GridView)
                {
                      var y = control as GridView;

                    //Get all the rows in the grid and place it inside a GridViewRowCollection

                    GridViewRowCollection rowCollection = y.Rows;

                    foreach (GridViewRow gridRow in rowCollection)
                    {

                        //Get all the cells contained in the row

                        TableCellCollection rowCell = gridRow.Cells;

                        //loop thru all the cells in the row

                        foreach (TableCell itemCell in rowCell)
                        {

                            //loop thru all the controls in the cell

                            foreach (Control ctl in itemCell.Controls)
                            {

                                //check if the control is a ImageButton

                                if (ctl is CheckBox)
                                {

                                    ((CheckBox)ctl).Checked = false;

                                }

                            }

                        }
                    }
                }
                if (control.Controls != null && true)
                {
                    ClearForm(control.Controls, true);
                }
            }
        }

        public void ChangeControlStatus(ControlCollection controls)
        {

            foreach (Control ctrl in controls)
            {
                
                    if (ctrl is TextBox)

                        ((TextBox)ctrl).Enabled = false;

                    else if (ctrl is Button)

                        ((Button)ctrl).Enabled = false;

                    else if (ctrl is RadioButton)

                        ((RadioButton)ctrl).Enabled = false;

                    else if (ctrl is ImageButton)

                        ((ImageButton)ctrl).Enabled = false;

                    else if (ctrl is CheckBox)

                        ((CheckBox)ctrl).Enabled = false;

                    else if (ctrl is DropDownList)

                        ((DropDownList)ctrl).Enabled = false;

                    else if (ctrl is HyperLink)

                        ((HyperLink)ctrl).Enabled = false;

                    if (ctrl is GridView)
                    {
                        var y = ctrl as GridView;

                        //Get all the rows in the grid and place it inside a GridViewRowCollection

                        GridViewRowCollection rowCollection = y.Rows;

                        foreach (GridViewRow gridRow in rowCollection)
                        {

                            //Get all the cells contained in the row

                            TableCellCollection rowCell = gridRow.Cells;

                            //loop thru all the cells in the row

                            foreach (TableCell itemCell in rowCell)
                            {

                                //loop thru all the controls in the cell

                                foreach (Control ctl1 in itemCell.Controls)
                                {

                                    //check if the control is a ImageButton

                                    if (ctl1 is CheckBox)
                                    {

                                        ((CheckBox)ctl1).Enabled = false;

                                    }

                                }

                            }
                        }
                    }
               
            }
           

        }
    }
}
