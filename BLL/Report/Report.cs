using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using BLL.Utilities;
using XSD.Masters;


namespace BLL.Report
{
    public class Report : ServerBase
    {
        public DataTable GetreportMaster()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number " +
                        "FROM Ra_detail INNER JOIN " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON " +
                         "Ra_detail.Document_number = Ra_Header.Document_number " +
                        "WHERE (Ra_Header.ra_flag = 'Y')  " +
                        "ORDER BY  Ra_Header.Document_number,Ra_Header.RA_bill_no";
            //
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable getstageposodata(string po_so_number, string vendor_code, string route, string company, string location, string plant, string doctype)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = @"select CONVERT(varchar,send_date,103) as send_date1,CONVERT(varchar,receive_date,103) as receive_date1,* from Ra_status where  flag='Y'";

            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " and (Ra_status.Vendor_code = '" + vendor_code + "')";

            }
            if (po_so_number != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.Po_so_number  = '" + po_so_number + "')";

            }
            if (company != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_status.Company_code = '" + company + "')";

            }
            if (location != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_status.location_code = '" + location + "')";

            }
            if (plant != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_status.Plant_code = '" + plant + "')";

            }
            if (doctype != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_status.doc_type = '" + doctype + "')";

            }
            if (route != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_status.root_name = '" + route + "')";

            }

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetcancelreportMaster1(string user)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number,Ra_Header.created_by, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number " +
                        "FROM Ra_detail INNER JOIN " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master  ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON " +
                         "Ra_detail.Document_number = Ra_Header.Document_number inner join  user_cs_rights ON user_cs_rights.company_id =  Ra_Header.Company_code " +
                        "WHERE (Ra_Header.ra_flag = 'C') and user_cs_rights.user_id='" + user + "' and user_cs_rights.active_flag='Y' " +
                        "ORDER BY  Ra_Header.Document_number,Ra_Header.RA_bill_no";
            //
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetcancelreportMaster(string userid)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number,Ra_Header.created_by, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number " +
                        "FROM Ra_detail INNER JOIN " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON " +
                         "Ra_detail.Document_number = Ra_Header.Document_number " +
                        "WHERE (Ra_Header.ra_flag = 'C') AND ((Ra_Header.created_by='" + userid + "')  OR  (Ra_Header.last_modified_by='" + userid + "')) " +
                        "ORDER BY  Ra_Header.Document_number,Ra_Header.RA_bill_no";
            //
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable getroutename(string posonumber)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = @"SELECT distinct root_name,root_receive_date FROM Ra_status where PO_so_number='" + posonumber + "'";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable getroutedepartmentname(string routename)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = @"select stage_depart,sr_no from Dept_Stage_rout where root_name='" + routename + "' order by sr_no ASC";
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetreportMaster(string userid)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number " +
                        "FROM Ra_detail INNER JOIN " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON " +
                         "Ra_detail.Document_number = Ra_Header.Document_number " +
                        "WHERE (Ra_Header.ra_flag = 'Y') AND (Ra_Header.created_by='" + userid + "') OR (Ra_Header.last_modified_by='" + userid + "') " +
                        "ORDER BY  Ra_Header.Document_number,Ra_Header.RA_bill_no DESC";
            //
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetreportMaster_user(string userid, string dtenter)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.invoice_date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number " +
                        "FROM Ra_detail right JOIN " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON " +
                         "Ra_detail.Document_number = Ra_Header.Document_number " +
                        "WHERE (Ra_Header.ra_flag = 'Y') AND ((Ra_Header.created_by='" + userid + "') OR (Ra_Header.last_modified_by='" + userid + "')) ";

            if (dtenter != "")
            {
                SqlSelect = SqlSelect + " AND ((Ra_Header.created_date = '" + dtenter + "') OR (Ra_Header.last_modified_date = '" + dtenter + "'))";
            }


            SqlSelect = SqlSelect + " ORDER BY  Ra_Header.Document_number,Ra_Header.RA_bill_no DESC";
            
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }



        public DataTable GetreportMaster(string vendor_code, string po_so_number, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number " +
                        "FROM Ra_status INNER JOIN " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON " +
                         "Ra_status.Document_number = Ra_Header.Document_number ";


            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " where (vendor_details.vendor_code = '" + vendor_code + "')";

            }

            if (po_so_number != "")
            {
                if (vendor_code != "")
                {
                    SqlSelect = SqlSelect + " AND (order_master.po_so_number  = '" + po_so_number + "')";
                }
                else
                {
                    SqlSelect = SqlSelect + " where (order_master.po_so_number  = '" + po_so_number + "')";
                }
            }
            if (received_date != "")
            {
                if (vendor_code != "" || po_so_number != "")
                {
                    SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
                }
                else
                {
                    SqlSelect = SqlSelect + " where (Ra_Header.invoice_date >= '" + received_date + "')";
                }
            }
            if (send_date != "")
            {
                if (vendor_code != "" || po_so_number != "" || received_date != "")
                {
                    SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
                }
                else
                {
                    SqlSelect = SqlSelect + " where (Ra_Header.invoice_date <= '" + send_date + "')";
                }
            }
            SqlSelect = SqlSelect + " AND Ra_Header.ra_flag='Y' ORDER BY Ra_Header.Document_number,Ra_Header.RA_bill_no";
            //vendor_details.vendor_code, 
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetreportMaster_general_m(string vendor_code, string po_so_number, string received_date, string send_date, string company, string user)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number " +
                        "FROM Ra_status INNER JOIN " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON " +
                         "Ra_status.Document_number = Ra_Header.Document_number INNER JOIN " +
                      " user_cs_rights  on user_cs_rights.company_id = Ra_Header.Company_code  where ((Ra_Header.ra_flag = 'Y') or  (Ra_Header.ra_flag='N')) and user_cs_rights.user_id='" + user + "' and user_cs_rights.active_flag='Y' ";


            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " and (vendor_details.vendor_code = '" + vendor_code + "')";

            }
            if (company != "")
            {
                SqlSelect = SqlSelect + " and (Ra_Header.Company_code = '" + company + "')";

            }

            if (po_so_number != "")
            {
                SqlSelect = SqlSelect + " AND (order_master.po_so_number  = '" + po_so_number + "')";

            }
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            SqlSelect = SqlSelect + "  ORDER BY Ra_Header.Document_number,Ra_Header.RA_bill_no";
            //vendor_details.vendor_code, 
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetreportMaster(string vendor_code, string po_so_number, string company, string location, string plant, string doctype, string route)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element,ra_header.invoice_number, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number " +
                        "FROM Ra_status INNER JOIN " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON " +
                         "Ra_status.Document_number = Ra_Header.Document_number ";


            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " where (vendor_details.vendor_code = '" + vendor_code + "')";

            }
            if (po_so_number != "")
            {
                if (vendor_code != "")
                {
                    SqlSelect = SqlSelect + " AND (order_master.po_so_number  = '" + po_so_number + "')";
                }
                else
                {
                    SqlSelect = SqlSelect + " where (order_master.po_so_number  = '" + po_so_number + "')";
                }
            }
            if (company != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.Company_code = '" + company + "')";

            }
            if (location != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.location_code = '" + location + "')";

            }
            if (plant != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.plant_code = '" + plant + "')";

            }
            if (doctype != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.doc_type = '" + doctype + "')";

            }
            if (route != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_status.root_name = '" + route + "')";

            }
            SqlSelect = SqlSelect + " AND Ra_Header.ra_flag='Y' ORDER BY Ra_Header.Document_number,Ra_Header.RA_bill_no";
            //vendor_details.vendor_code, 
            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetreportMaster(string company, string vendor, string po_so, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105) " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number, Ra_Header.invoice_number,  Ra_Header.common_flag " +

                        "FROM " +
                        "Ra_Header INNER JOIN " +
                         "vendor_details INNER JOIN " +
                         "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number INNER JOIN " +
                     " Ra_status ON Ra_Header.PO_so_number = Ra_status.PO_so_number " +

                        "WHERE ((Ra_Header.ra_flag = 'Y') or  (Ra_Header.ra_flag='N'))  AND (Ra_Header.Company_code = '" + company + "')  AND (Ra_Header.Vendor_code = '" + vendor + "')";


            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.doc_type = '" + po_so + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date <= '" + send_date + "')";
            //}


            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            SqlSelect = SqlSelect + " ORDER BY vendor_details.vendor_code, Ra_Header.Document_number,Ra_Header.RA_bill_no";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetreportMasterinprocess(string company, string vendor, string po_so, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105)  " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element,  " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number, Ra_Header.invoice_number, Ra_Header.common_flag " +
                        "FROM     " +
                        "Ra_Header INNER JOIN  " +
                        "vendor_details INNER JOIN  " +
                        "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number " +
                        "INNER JOIN " +
                        "Ra_status ON Ra_Header.Document_number = Ra_status.Document_number " +
                        "WHERE  (Ra_Header.Company_code = '" + company + "')  AND (Ra_Header.Vendor_code = '" + vendor + "') AND ((Ra_Header.ra_flag = 'Y') or  (Ra_Header.ra_flag='N')) ";


            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.doc_type = '" + po_so + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date <= '" + send_date + "')";
            //}
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            SqlSelect = SqlSelect + " AND (Ra_status.send_date IS NULL) ORDER BY vendor_details.vendor_code, Ra_Header.Document_number,Ra_Header.RA_bill_no";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetreportMasterinpaid(string company, string vendor, string po_so, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105)  " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element,  " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number, Ra_Header.invoice_number, Ra_Header.common_flag " +
                        "FROM   Ra_detail INNER JOIN  " +
                        "Ra_Header INNER JOIN  " +
                        "vendor_details INNER JOIN  " +
                        "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON  " +
                        "Ra_detail.Document_number = Ra_Header.Document_number INNER JOIN " +
                        "Ra_status ON Ra_Header.Document_number = Ra_status.Document_number " +
                        "inner join ( SELECT distinct  f.Document_number FROM (SELECT Company_code, Document_number FROM Ra_status AS Ra_status_4  " +
                        "WHERE (Document_number NOT IN (SELECT DISTINCT Document_number  FROM  Ra_status AS Ra_status_3  " +
                        "WHERE (send_date IS NULL)))) as f) as f1 " +
                        "on  Ra_detail.Document_number = f1.document_number " +
                        "WHERE  (Ra_Header.Company_code = '" + company + "')  AND (Ra_Header.Vendor_code = '" + vendor + "') AND ((Ra_Header.ra_flag = 'Y') or  (Ra_Header.ra_flag='N')) ";


            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.doc_type = '" + po_so + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date <= '" + send_date + "')";
            //}
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            SqlSelect = SqlSelect + "  ORDER BY vendor_details.vendor_code, Ra_Header.Document_number,Ra_Header.RA_bill_no";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetreportMasterinprocessdelay(string company, string vendor, string po_so, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT DISTINCT  " +
                        "vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, CONVERT(varchar, Ra_Header.po_so_date, 105)  " +
                        "AS PO_SO_Date, Ra_Header.order_value, CONVERT(varchar, Ra_Header.Bill_Date, 105) AS Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element,  " +
                        "CONVERT(varchar, Ra_Header.bill_rec_date, 105) AS Bill_Rec_Date, order_master.currency, Ra_Header.Document_number, Ra_Header.invoice_number, Ra_Header.common_flag " +
                        "FROM   Ra_detail INNER JOIN  " +
                        "Ra_Header INNER JOIN  " +
                        "vendor_details INNER JOIN  " +
                        "order_master ON vendor_details.vendor_code = order_master.vendor_code ON Ra_Header.PO_so_number = order_master.po_so_number ON  " +
                        "Ra_detail.Document_number != Ra_Header.Document_number INNER JOIN " +
                        "Ra_status ON Ra_Header.Document_number = Ra_status.Document_number " +
                        "WHERE  (Ra_Header.Company_code = '" + company + "')  AND (Ra_Header.Vendor_code = '" + vendor + "') AND ((Ra_Header.ra_flag = 'Y') or  (Ra_Header.ra_flag='N'))";


            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.doc_type = '" + po_so + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date <= '" + send_date + "')";
            //}
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            SqlSelect = SqlSelect + " AND (Ra_status.Document_number IN " +
                         " (SELECT DISTINCT Document_number " +
                         "   FROM          Ra_status AS Ra_status_1 " +
                         "   WHERE      (send_date IS NULL))) " +
                         "  GROUP BY vendor_details.vendor_code, vendor_details.vendor_name, order_master.po_so_number, Ra_Header.project_code, Ra_Header.po_so_date, " +
                         "  Ra_Header.order_value, Ra_Header.Bill_Date, Ra_Header.RA_bill_no, order_master.wbs_element, " +
                         "  Ra_Header.bill_rec_date, order_master.currency, Ra_Header.Document_number, Ra_Header.invoice_number, Ra_Header.common_flag " +
                         "  HAVING      (SUM(CONVERT(int, Ra_status.max_days)) - SUM(DATEDIFF(day, Ra_status.receive_date, GETDATE())) < 0) ORDER BY vendor_details.vendor_code, Ra_Header.Document_number,Ra_Header.RA_bill_no";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetEdearning()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT ed_code,ed_name from ed_master where ed_flag = 'Y' and ed_type = 'E' order by ed_code";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetExtradeduction()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT ed_code,ed_name from ed_master where ed_flag = 'Y' and ed_type = 'X' order by ed_code";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetDeductions()
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT ed_code,ed_name from ed_master where ed_flag = 'Y' and ed_type = 'D' order by ed_code";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }
        public DataTable Getreported(string str, string vendor_code, string po_so_number, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT  RA_bill_no,Document_number," + str + " from " +
                        "(SELECT Ra_Header.RA_bill_no,Ra_detail.Document_number,ed_code,Amount " +
                        "FROM  Ra_detail INNER JOIN " +
                        "Ra_Header ON Ra_detail.Document_number = Ra_Header.Document_number ";
            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " and  (Ra_Header.Vendor_code = '" + vendor_code + "') ";
            }
            if (po_so_number != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.PO_so_number = '" + po_so_number + "')";
            }
            if (received_date != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";

            }
            if (send_date != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";

            }

            SqlSelect = SqlSelect + " ) As source PIVOT ( max(Amount)  for ed_code IN ( " + str + " ) ) As pvt ORDER BY pvt.Document_number";


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Getreportedextded(string str, string vendor_code, string po_so_number, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT  RA_bill_no,Document_number," + str + " from " +
                        "(SELECT Ra_Header.RA_bill_no,Ra_detail.Document_number,ed_code,Amount " +
                        "FROM  Ra_detail INNER JOIN " +
                        "Ra_Header ON Ra_detail.Document_number = Ra_Header.Document_number ";
            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " and  (Ra_Header.Vendor_code = '" + vendor_code + "') ";
            }
            if (po_so_number != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.PO_so_number = '" + po_so_number + "')";
            }
            if (received_date != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";

            }
            if (send_date != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";

            }

            SqlSelect = SqlSelect + " ) As source PIVOT ( max(Amount)  for ed_code IN ( " + str + " ) ) As pvt ORDER BY pvt.Document_number";


            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Getreportedear(string str, string vendor_code, string po_so_number, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = "SELECT  RA_bill_no,Document_number," + str + " from " +
                        "(SELECT Ra_Header.RA_bill_no,Ra_detail.Document_number,ed_code,Amount " +
                        "FROM  Ra_detail INNER JOIN " +
                        "Ra_Header ON Ra_detail.Document_number = Ra_Header.Document_number  ";
            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " and  (Ra_Header.Vendor_code = '" + vendor_code + "') ";
            }
            if (po_so_number != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.PO_so_number = '" + po_so_number + "')";
            }
            if (received_date != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";

            }
            if (send_date != "")
            {

                SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";

            }

            SqlSelect = SqlSelect + " ) As source PIVOT ( max(Amount)  for ed_code IN ( " + str + " ) ) As pvt ORDER BY pvt.Document_number";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable Getpendingdelayreport(string company_code, string stage_code, string po_so)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            //SqlSelect = "select * from  (SELECT stage_code, receive_date_total, send_date_total, receive_date_total - send_date_total AS Pendin,sr_num " +
            //            "FROM (SELECT sr_num,stage_code, COUNT(send_date) AS send_date_total, COUNT(receive_date) AS receive_date_total " +
            //            "FROM  Ra_status WHERE (Company_code = '" + company_code + "') ";
            //if (po_so != "")
            //{
            //    SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            //}
            //SqlSelect = SqlSelect + "   AND (stage_code IN (" + stage_code + ")) " +
            //               "GROUP BY stage_code, sr_num) AS derivedtbl_1) as a left outer join (SELECT sr_num,COUNT(*) AS delay_bills, stage_code " +
            //               "FROM (SELECT sr_num,stage_code, DATEDIFF(day, receive_date, send_date) AS days_taken_for_process , max_days,max_days -DATEDIFF(day, receive_date, send_date)AS more_then_max_day " +
            //               "FROM Ra_status WHERE (Company_code = '" + company_code + "') ";

            //if (po_so != "")
            //{
            //    SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            //}

            //SqlSelect = SqlSelect + "  AND (stage_code IN  (" + stage_code + "))) AS derivedtbl_1 " +
            //       "WHERE (more_then_max_day < 0) GROUP BY stage_code, sr_num) as b on a.stage_code=b.stage_code ORDER BY a.sr_num";



            //            SqlSelect="select distinct a.stage_code,receive_date_total,send_date_total,Pendin,sr_num,b.delay_bills from "+
            //" (SELECT stage_code, receive_date_total, send_date_total, receive_date_total - send_date_total AS Pendin,sr_num "+
            // " FROM (SELECT sr_num,stage_code, COUNT(send_date) AS send_date_total, COUNT(receive_date) AS receive_date_total"+
            //  " FROM  Ra_status WHERE (Company_code = '" + company_code + "')"; 

            //            if (po_so != "")
            //            {
            //                SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            //            }

            //            SqlSelect = SqlSelect + " AND (stage_code IN (" + stage_code + ")) GROUP BY stage_code, sr_num) AS derivedtbl_1) as a left outer join " +
            //    " (select  c.stage_code,delay_bills from "+
            //" (SELECT sr_num,COUNT(*) AS delay_bills, stage_code FROM (SELECT sr_num,stage_code, DATEDIFF(day, receive_date, send_date) AS days_taken_for_process ,"+
            //"     max_days,max_days -DATEDIFF(day, receive_date, send_date)AS more_then_max_day FROM Ra_status WHERE "+
            //     " (Company_code = '" + company_code + "') ";

            //          if (po_so != "")
            //          {
            //                SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            //          }


            //          SqlSelect = SqlSelect + " AND (stage_code IN (" + stage_code + ")))" +
            //          " AS derivedtbl_1 WHERE (more_then_max_day < 0)GROUP BY stage_code, sr_num) as d right outer join" +
            //           " (select * from  Ra_status where  (Company_code = '" + company_code + "')";

            //           if (po_so != "")
            //          {
            //                SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            //          }

            //           SqlSelect = SqlSelect + " AND  (stage_code IN (" + stage_code + "))) as c " +
            //          " on d.stage_code=c.stage_code GROUP BY c.stage_code, c.sr_num,d.delay_bills ) as b on a.stage_code=b.stage_code" +
            //           " ORDER BY a.sr_num";


            SqlSelect = "select distinct a.stage_code,receive_date_total,send_date_total,Pendin,a.sr_num,d.delay_bills from " +
" (SELECT stage_code, receive_date_total, send_date_total, receive_date_total - send_date_total AS Pendin,sr_num " +
" FROM (SELECT sr_num,stage_code, COUNT(send_date) AS send_date_total, COUNT(receive_date) AS receive_date_total " +
 " FROM  Ra_status WHERE (Company_code = '" + company_code + "') and flag='Y' ";
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            }

            SqlSelect = SqlSelect + " AND (stage_code IN (" + stage_code + ")) GROUP BY stage_code, sr_num) AS derivedtbl_1) as a left outer join ( SELECT sr_num,COUNT(*) AS delay_bills, stage_code FROM " +
             " (SELECT sr_num,stage_code, DATEDIFF(day, receive_date, send_date) AS days_taken_for_process , " +
           " max_days,max_days -DATEDIFF(day, receive_date, send_date)AS more_then_max_day FROM Ra_status WHERE (Company_code = '" + company_code + "') AND flag='Y' ";

            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            }

            SqlSelect = SqlSelect + " AND (stage_code IN (" + stage_code + "))) AS " +
       " derivedtbl_1 WHERE more_then_max_day < 0 GROUP BY stage_code, sr_num) as d on a.stage_code = d.stage_code  and a.sr_num = d.sr_num order by a.sr_num";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Getpendingdelayreport_vendorwise(string company_code, string stage_code, string po_so, string vendor, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            SqlSelect = @"select distinct a.stage_code,receive_date_total,send_date_total,Pendin,a.sr_num,d.delay_bills from  
(SELECT stage_code, receive_date_total, send_date_total, receive_date_total - send_date_total AS Pendin,sr_num  
FROM (SELECT Ra_status.sr_num,Ra_status.stage_code, COUNT(Ra_status.send_date) AS send_date_total, COUNT(receive_date) AS receive_date_total  
FROM  Ra_status,Ra_Header WHERE (Ra_status.Company_code = '" + company_code + "') and flag='Y' and Ra_Header.Document_number = Ra_status.Document_number";
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.doc_type = '" + po_so + "')";
            }
            if (vendor != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.Vendor_code IN (" + vendor + "))";
            }
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }
            SqlSelect = SqlSelect + " AND (stage_code IN (" + stage_code + ")) GROUP BY stage_code, sr_num) AS derivedtbl_1) as a " +
               "left outer join ( SELECT sr_num,COUNT(*) AS delay_bills, stage_code FROM (SELECT Ra_status.sr_num,Ra_status.stage_code, DATEDIFF(day, Ra_status.receive_date, Ra_status.send_date) AS days_taken_for_process , " +
   "Ra_status.max_days,Ra_status.max_days -DATEDIFF(day, Ra_status.receive_date, Ra_status.send_date)AS more_then_max_day FROM Ra_status,Ra_Header WHERE " +
   "(Ra_status.Company_code = '" + company_code + "') AND Ra_status.flag='Y' AND Ra_Header.Document_number = Ra_status.Document_number";
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.doc_type = '" + po_so + "')";
            }
            if (vendor != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.Vendor_code IN (" + vendor + "))";
            }
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }
            SqlSelect = SqlSelect + " AND (Ra_status.stage_code IN (" + stage_code + "))) AS  derivedtbl_1 " +
"WHERE more_then_max_day < 0 GROUP BY stage_code, sr_num) as d on a.stage_code = d.stage_code  and a.sr_num = d.sr_num " +
   "order by a.sr_num";
            //            SqlSelect = "select distinct a.stage_code,receive_date_total,send_date_total,Pendin,a.sr_num,d.delay_bills from " +
            //" (SELECT stage_code, receive_date_total, send_date_total, receive_date_total - send_date_total AS Pendin,sr_num " +
            //" FROM (SELECT sr_num,stage_code, COUNT(send_date) AS send_date_total, COUNT(receive_date) AS receive_date_total " +
            // " FROM  Ra_status WHERE (Company_code = '" + company_code + "') and flag='Y' ";
            //            if (po_so != "")
            //            {
            //                SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            //            }
            //            if (vendor != "")
            //            {
            //                SqlSelect = SqlSelect + " AND (Vendor_code IN (" + vendor + "))";
            //            }
            //            SqlSelect = SqlSelect + " AND (stage_code IN (" + stage_code + ")) GROUP BY stage_code, sr_num) AS derivedtbl_1) as a left outer join ( SELECT sr_num,COUNT(*) AS delay_bills, stage_code FROM " +
            //             " (SELECT sr_num,stage_code, DATEDIFF(day, receive_date, send_date) AS days_taken_for_process , " +
            //           " max_days,max_days -DATEDIFF(day, receive_date, send_date)AS more_then_max_day FROM Ra_status WHERE (Company_code = '" + company_code + "') AND flag='Y' ";

            //            if (po_so != "")
            //            {
            //                SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            //            }
            //            if (vendor != "")
            //            {
            //                SqlSelect = SqlSelect + " AND (Vendor_code IN (" + vendor + "))";
            //            }

            //            SqlSelect = SqlSelect + " AND (stage_code IN (" + stage_code + "))) AS " +
            //       " derivedtbl_1 WHERE more_then_max_day < 0 GROUP BY stage_code, sr_num) as d on a.stage_code = d.stage_code  and a.sr_num = d.sr_num order by a.sr_num";

            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Getpendingdelayreportdetails(string company_code, string stage_code, string po_so)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            SqlSelect = "SELECT        derivedtbl_1.sr_num, CONVERT(varchar, derivedtbl_1.receive_date, 105) AS receive_date, CONVERT(varchar, derivedtbl_1.send_date, 105) AS send_date, derivedtbl_1.Document_number, derivedtbl_1.RA_bill_no, derivedtbl_1.Vendor_code, " +
                        "vendor_details.vendor_name, derivedtbl_1.stage_code, Department_master.Department_name,derivedtbl_1.remarks,derivedtbl_1.days_taken_for_process " +
                        "FROM  (SELECT        sr_num, stage_code, receive_date, send_date, Document_number, Vendor_code, RA_bill_no, DATEDIFF(day, receive_date, send_date) " +
                        "AS days_taken_for_process, max_days, max_days - DATEDIFF(day, receive_date, send_date) AS more_then_max_day,remarks " +
                        "FROM Ra_status AS Ra_status_1 " +
                        "WHERE        (Company_code = '" + company_code + "') and flag='Y' ";

            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            }


            SqlSelect = SqlSelect + "     AND (stage_code IN (" + stage_code + "))) AS derivedtbl_1 INNER JOIN " +
                       "vendor_details ON derivedtbl_1.Vendor_code = vendor_details.vendor_code INNER JOIN " +
                       "Department_master ON derivedtbl_1.stage_code = Department_master.Department_id " +
                       "WHERE        (derivedtbl_1.more_then_max_day < 0) ";






            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Getpendingdelayreportdetails_dashborad(string company_code, string stage_code, string doc_type, string vendor, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            //SqlSelect = "SELECT        derivedtbl_1.sr_num, CONVERT(varchar, derivedtbl_1.receive_date, 105) AS receive_date, CONVERT(varchar, derivedtbl_1.send_date, 105) AS send_date, derivedtbl_1.Document_number, derivedtbl_1.RA_bill_no, derivedtbl_1.Vendor_code, " +
            //            "vendor_details.vendor_name, derivedtbl_1.stage_code, Department_master.Department_name " +
            //            "FROM  (SELECT        sr_num, stage_code, receive_date, send_date, Document_number, Vendor_code, RA_bill_no, DATEDIFF(day, receive_date, send_date) " +
            //            "AS days_taken_for_process, max_days, max_days - DATEDIFF(day, receive_date, send_date) AS more_then_max_day " +
            //            "FROM Ra_status AS Ra_status_1 " +
            //            "WHERE        (Company_code = '" + company_code + "') and flag='Y' ";

            //if (po_so != "")
            //{
            //    SqlSelect = SqlSelect + " AND (doc_type = '" + po_so + "')";
            //}


            //SqlSelect = SqlSelect + "     AND (stage_code IN (" + stage_code + "))) AS derivedtbl_1 INNER JOIN " +
            //           "vendor_details ON derivedtbl_1.Vendor_code = vendor_details.vendor_code INNER JOIN " +
            //           "Department_master ON derivedtbl_1.stage_code = Department_master.Department_id " +
            //           "WHERE        (derivedtbl_1.more_then_max_day < 0) ";




            SqlSelect = "SELECT      derivedtbl_1.PO_so_number, derivedtbl_1.sr_num, CONVERT(varchar, derivedtbl_1.receive_date, 105) AS receive_date, " +
" CONVERT(varchar, derivedtbl_1.send_date, 105) AS send_date, derivedtbl_1.Document_number, derivedtbl_1.RA_bill_no," +
  " derivedtbl_1.Vendor_code, vendor_details.vendor_name, derivedtbl_1.stage_code, Department_master.Department_name,derivedtbl_1.remarks,datediff(day,derivedtbl_1.receive_date,GETDATE()) as day_process,Ra_Header.invoice_number,Ra_Header.invoice_amount,CONVERT(nvarchar,Ra_Header.invoice_Date,105) as invoice_Date, Ra_Header.net_payable_amt ,derivedtbl_1.root_name  " +
" FROM  (SELECT     root_name,  PO_so_number,  sr_num, stage_code, receive_date, send_date, Document_number, Vendor_code, RA_bill_no,remarks " +
 " FROM Ra_status AS Ra_status_1 WHERE        ( Company_code = " + company_code + ") and flag='Y' ";

            if (doc_type != "")
            {
                SqlSelect = SqlSelect + " AND (doc_type = '" + doc_type + "')";
            }
            if (vendor != "")
            {
                SqlSelect = SqlSelect + " AND (Vendor_code IN (" + vendor + "))";
            }
            SqlSelect = SqlSelect + "  AND  (receive_date IS NOT NULL) AND (send_date IS NULL)  " +
           " AND (stage_code IN (" + stage_code + "))) AS derivedtbl_1 " +
           " INNER JOIN vendor_details ON derivedtbl_1.Vendor_code = vendor_details.vendor_code INNER JOIN Department_master ON " +
           " derivedtbl_1.stage_code = Department_master.Department_id INNER JOIN  Ra_Header ON derivedtbl_1.Document_number = Ra_Header.Document_number and Ra_Header.ra_flag='Y' ";

            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }




            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable Getdepartmentname(string stage_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            SqlSelect = "SELECT Department_id,Department_name FROM Department_master WHERE (Department_id IN (" + stage_code + "))";





            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetoverallReport(string company_code, string vendor_code, string po_so, string received_date, string send_date, string user)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";

            //        SqlSelect = "SELECT a.Company_code, a.company_name, a.TOTAL_BILL,z.SUM_BILL, b.IN_PROCESS_BILL, "+
            //                    "ISNULL(a.TOTAL_BILL, 0) -  ISNULL(b.IN_PROCESS_BILL, 0) AS paid_bill, c.completed_bill_delay, "+
            //                    "d.inprocess_bill_delay FROM (SELECT  Ra_status.Company_code, COUNT(DISTINCT Ra_status.Document_number) AS "+
            //                    "TOTAL_BILL, company_mst.company_name FROM  Ra_status INNER JOIN company_mst ON "+
            //                    "Ra_status.Company_code = company_mst.company_code INNER JOIN Ra_Header ON  "+
            //                    "Ra_status.Document_number = Ra_Header.Document_number WHERE  "+
            //                    "(Ra_status.Company_code IN (" + company_code + ")) AND (Ra_status.flag= 'Y')";

            //        if (vendor_code != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_status.Vendor_code IN (" + vendor_code + "))";
            //        }
            //          if (po_so != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_status.doc_type = '" + po_so + "')";
            //        }
            //        if (received_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
            //        }
            //        if (send_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
            //        }

            //      SqlSelect = SqlSelect + "  GROUP BY Ra_status.Company_code, company_mst.company_name) "+
            //                  "AS a  INNER JOIN (SELECT Ra_status_5.Company_code, COUNT(DISTINCT Ra_status_5.Document_number) AS "+
            //                  "IN_PROCESS_BILL FROM  Ra_status AS Ra_status_5 INNER JOIN  Ra_Header ON  "+
            //                  "Ra_status_5.Document_number = Ra_Header.Document_number  WHERE  Ra_status_5.Company_code IN (" + company_code + ") AND (Ra_Header.ra_flag= 'Y')";
            //          if (vendor_code != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_status_5.Vendor_code IN (" + vendor_code + "))";
            //        }
            //          if (po_so != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_status_5.doc_type = '" + po_so + "')";
            //        }
            //        if (received_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
            //        }
            //        if (send_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
            //        }


            //SqlSelect = SqlSelect + " AND (Ra_status_5.send_date IS NULL)  GROUP BY Ra_status_5.Company_code) AS b ON a.Company_code = b.Company_code inner join "+
            //            "(SELECT  Company_code, sum(CAST( Ra_Header.net_payable_amt AS INT)) AS SUM_BILL FROM  "+
            //            "Ra_header WHERE (Company_code IN (" + company_code + "))  and (Ra_Header.ra_flag = 'Y') ";

            //           if (vendor_code != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.Vendor_code IN (" + vendor_code + "))";
            //        }
            //          if (po_so != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.doc_type = '" + po_so + "')";
            //        }
            //        if (received_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
            //        }
            //        if (send_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
            //        }

            //        SqlSelect = SqlSelect + " GROUP BY Company_code) as z on a.company_code=z.company_code "+
            //                " LEFT OUTER JOIN (SELECT Company_code, COUNT(Document_number) AS completed_bill_delay FROM (SELECT Company_code, Ra_status_4.Document_number FROM Ra_status AS Ra_status_4  "+
            //                " WHERE (Document_number NOT IN (SELECT DISTINCT Ra_status_3.Document_number "+
            //                "FROM  Ra_status AS Ra_status_3,Ra_Header WHERE (Ra_status_3.Company_code IN ((" + company_code + ")) and (Ra_Header.ra_flag = 'Y') and (send_date IS NULL))))";
            //            if (vendor_code != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_status_3.Vendor_code IN (" + vendor_code + "))";
            //        }
            //          if (po_so != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_status_3.doc_type = '" + po_so + "')";
            //        }
            //        if (received_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
            //        }
            //        if (send_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
            //        }
            //       SqlSelect = SqlSelect + " GROUP BY Company_code, Document_number  HAVING (SUM(CONVERT(int, max_days)) - SUM(DATEDIFF(day, receive_date, send_date)) < 0)) AS comp_bill "+
            //                   "GROUP BY Company_code) AS c ON a.Company_code = c.Company_code LEFT OUTER JOIN  "+
            //                   "(SELECT Company_code, COUNT(Document_number) AS inprocess_bill_delay FROM "+
            //                   "(SELECT Company_code, Document_number FROM Ra_status AS Ra_status_2 WHERE "+
            //                   "(Document_number IN ((SELECT DISTINCT Ra_status_1.Document_number FROM Ra_status AS Ra_status_1 INNER JOIN  Ra_Header ON "+
            //                   "Ra_status_1.Document_number = Ra_Header.Document_number  WHERE (Ra_status_1.Company_code IN (" + company_code + ")) and (Ra_Header.ra_flag = 'Y') and ";
            //    if (vendor_code != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_status_1.Vendor_code IN (" + vendor_code + "))";
            //        }
            //          if (po_so != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_status_1.doc_type = '" + po_so + "')";
            //        }
            //        if (received_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
            //        }
            //        if (send_date != "")
            //        {
            //            SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
            //        }

            //   SqlSelect =  SqlSelect + "  (send_date IS NULL))) )  GROUP BY Company_code, Document_number HAVING "+
            //                  "(SUM(CONVERT(int, max_days)) - SUM(DATEDIFF(day, receive_date, getdate())) < 0)) AS inprocess_bill "+
            //            "GROUP BY Company_code) AS d ON a.Company_code = d.Company_code";





            SqlSelect = "SELECT a.Company_code, a.company_name, a.TOTAL_BILL,z.SUM_BILL,ISNULL(b.IN_PROCESS_BILL,0) AS IN_PROCESS_BILL, ISNULL(a.TOTAL_BILL, 0) -  ISNULL(b.IN_PROCESS_BILL, 0) AS paid_bill, ISNULL(c.completed_bill_delay,0) AS completed_bill_delay, " +
                         "ISNULL(d.inprocess_bill_delay,0) AS inprocess_bill_delay FROM (SELECT  Ra_status.Company_code, COUNT(DISTINCT Ra_status.Document_number) AS TOTAL_BILL, company_mst.company_name " +
                         "FROM  Ra_status INNER JOIN company_mst ON Ra_status.Company_code = company_mst.company_code INNER JOIN " +
                         "Ra_Header ON Ra_status.Document_number = Ra_Header.Document_number INNER JOIN user_cs_rights ON Ra_status.Company_code = user_cs_rights.company_id " +
                         "WHERE (Ra_status.flag= 'Y') and user_cs_rights.user_id='" + user + "' and user_cs_rights.active_flag='Y' ";

            if (company_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.Company_code ='" + company_code + "')";
            }

            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.Vendor_code IN (" + vendor_code + "))";
            }
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.doc_type = '" + po_so + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status.receive_date <= '" + send_date + "')";
            //}
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            SqlSelect = SqlSelect + " GROUP BY Ra_status.Company_code, company_mst.company_name,user_cs_rights.company_id) AS a  left outer JOIN " +
                   "(SELECT Ra_status_5.Company_code, COUNT(DISTINCT Ra_status_5.Document_number) AS IN_PROCESS_BILL " +
                   "FROM  Ra_status AS Ra_status_5 INNER JOIN " +
                   " Ra_Header ON Ra_status_5.Document_number = Ra_Header.Document_number  WHERE (Ra_status_5.flag= 'Y') ";

            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }
            if (company_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_5.Company_code ='" + company_code + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_5.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_5.receive_date <= '" + send_date + "')";
            //}

            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_5.Vendor_code IN (" + vendor_code + "))";
            }
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_5.doc_type = '" + po_so + "')";
            }
            SqlSelect = SqlSelect + "  AND (Ra_status_5.send_date IS NULL) " +
                     " GROUP BY Ra_status_5.Company_code) AS b ON a.Company_code = b.Company_code inner join " +
                     "(SELECT  Company_code, sum(CAST( Ra_Header.net_payable_amt AS INT)) AS SUM_BILL " +
                      "FROM            Ra_header " +
                      "WHERE     ra_flag='Y' ";
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_5.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_5.receive_date <= '" + send_date + "')";
            //}
            if (company_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.Company_code ='" + company_code + "')";
            }
            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.Vendor_code IN (" + vendor_code + "))";
            }
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.doc_type = '" + po_so + "')";
            }

            SqlSelect = SqlSelect + " GROUP BY Company_code) as z " +
                   "on a.company_code=z.company_code LEFT OUTER JOIN " +
                  "(SELECT Company_code, COUNT(Document_number) AS completed_bill_delay " +
                  "FROM (SELECT Ra_status_4.Company_code,Ra_status_4.Document_number FROM Ra_status AS Ra_status_4   INNER JOIN " +
                   "   Ra_Header ON Ra_status_4.Document_number = Ra_Header.Document_number WHERE" +
                  "(Ra_status_4.Document_number NOT IN (SELECT DISTINCT Document_number  FROM  Ra_status AS Ra_status_3 WHERE (send_date IS NULL))) and (Ra_status_4.flag= 'Y') ";
            if (company_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_4.Company_code ='" + company_code + "')";
            }
            if (po_so != "")
            {
                SqlSelect = SqlSelect + "and (Ra_status_4.doc_type= '" + po_so + "')";
            }
            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_4.Vendor_code IN (" + vendor_code + "))";
            }

            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_4.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_4.receive_date <= '" + send_date + "')";
            //}
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            SqlSelect = SqlSelect + " GROUP BY Ra_status_4.Company_code, Ra_status_4.Document_number HAVING (SUM(CONVERT(int, max_days)) - SUM(DATEDIFF(day, receive_date, send_date)) < 0)) AS comp_bill " +
                     "GROUP BY Company_code) AS c ON a.Company_code = c.Company_code LEFT OUTER JOIN (SELECT Company_code, COUNT(Document_number) AS inprocess_bill_delay " +
                     "FROM (SELECT Ra_status_2.Company_code, Ra_status_2.Document_number FROM Ra_status AS Ra_status_2 INNER JOIN " +
                    " Ra_Header ON Ra_status_2.Document_number = Ra_Header.Document_number WHERE (Ra_status_2.Document_number IN " +
                     "(SELECT DISTINCT Document_number FROM Ra_status AS Ra_status_1 WHERE (send_date IS NULL))) and (Ra_status_2.flag= 'Y') ";

            if (company_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_2.Company_code ='" + company_code + "')";
            }
            if (po_so != "")
            {
                SqlSelect = SqlSelect + "and (Ra_status_2.doc_type= '" + po_so + "')";
            }
            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_2.Vendor_code IN (" + vendor_code + "))";
            }
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_2.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_2.receive_date <= '" + send_date + "')";
            //}

            SqlSelect = SqlSelect + " GROUP BY Ra_status_2.Company_code, Ra_status_2.Document_number " +
                      "HAVING (SUM(CONVERT(int, max_days)) - SUM(DATEDIFF(day, receive_date, getdate())) < 0)) AS inprocess_bill   GROUP BY Company_code) AS d ON a.Company_code = d.Company_code";









            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }


        public DataTable GetoverallvendorReport(string company_code, string vendor_code, string po_so, string received_date, string send_date)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            SqlSelect = "SELECT a.Company_code, a.company_name,a.Vendor_code, a.vendor_name, a.TOTAL_BILL, b.IN_PROCESS_BILL, ISNULL(a.TOTAL_BILL, 0) -  ISNULL(b.IN_PROCESS_BILL, 0) AS paid_bill, c.completed_bill_delay, " +
                         "d.inprocess_bill_delay FROM (SELECT  Ra_status.Company_code, COUNT(DISTINCT Ra_status.Document_number) AS TOTAL_BILL, company_mst.company_name,Ra_Header.Vendor_code,vendor_details.vendor_name " +
                         "FROM  Ra_status INNER JOIN company_mst ON Ra_status.Company_code = company_mst.company_code INNER JOIN " +
                         "Ra_Header ON Ra_status.Document_number = Ra_Header.Document_number " +
                         "INNER JOIN  vendor_details ON Ra_Header.Vendor_code = vendor_details.vendor_code " +
                         "WHERE (Ra_status.Company_code IN (" + company_code + ")) and Ra_status.flag='Y' ";

            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.Vendor_code IN (" + vendor_code + "))";
            }
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status.doc_type = '" + po_so + "')";
            }
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
            //}

            SqlSelect = SqlSelect + " GROUP BY Ra_status.Company_code, company_mst.company_name, Ra_Header.Vendor_code, vendor_details.vendor_name) AS a LEFT OUTER JOIN " +
                   "(SELECT Ra_status_5.Company_code,Ra_status_5.Vendor_code, COUNT(DISTINCT Ra_status_5.Document_number) AS IN_PROCESS_BILL " +
                   "FROM  Ra_status AS Ra_status_5 INNER JOIN " +
                   " Ra_Header ON Ra_status_5.Document_number = Ra_Header.Document_number  WHERE (Ra_status_5.Company_code IN (" + company_code + ")) and Ra_status_5.flag='Y' ";

            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
            //}
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }
            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_5.Vendor_code IN (" + vendor_code + "))";
            }
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_5.doc_type = '" + po_so + "')";
            }
            SqlSelect = SqlSelect + "  AND (Ra_status_5.send_date IS NULL)  and (Ra_status_5.flag='Y') " +
                     " GROUP BY   Ra_status_5.Company_code,Ra_status_5.Vendor_code) AS b ON a.Company_code = b.Company_code and a.Vendor_code = b.Vendor_code LEFT OUTER JOIN " +
                     "(SELECT Company_code,Vendor_code, COUNT(Document_number) AS completed_bill_delay " +
                     "FROM (SELECT Ra_status_4.Company_code, Ra_status_4.Document_number,Ra_status_4.Vendor_code FROM Ra_status AS Ra_status_4  INNER JOIN " +
                   "   Ra_Header ON Ra_status_4.Document_number = Ra_Header.Document_number WHERE " +
                     "(Ra_status_4.Document_number NOT IN (SELECT DISTINCT Document_number  FROM  Ra_status AS Ra_status_3 WHERE  (send_date IS NULL))) AND Ra_status_4.Company_code IN (" + company_code + ")  AND Ra_status_4.flag= 'Y'  ";

            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }
            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_4.receive_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_status_4.receive_date <= '" + send_date + "')";
            //}

            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_4.Vendor_code IN (" + vendor_code + "))";
            }

            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_4.doc_type = '" + po_so + "')";
            }

            SqlSelect = SqlSelect + "  GROUP BY Ra_status_4.Company_code, Ra_status_4.Document_number,Ra_status_4.Vendor_code HAVING (SUM(CONVERT(int, max_days)) - SUM(DATEDIFF(day, receive_date, send_date)) < 0)) AS comp_bill " +
                    "GROUP BY Company_code,Vendor_code) AS c ON a.Company_code = c.Company_code and a.Vendor_code = c.Vendor_code  LEFT OUTER JOIN (SELECT Company_code,Vendor_code, COUNT(Document_number) AS inprocess_bill_delay " +
                    "FROM (SELECT Ra_status_2.Company_code,Ra_status_2.Vendor_code, Ra_status_2.Document_number FROM Ra_status AS Ra_status_2  INNER JOIN " +
                   "   Ra_Header ON Ra_status_2.Document_number = Ra_Header.Document_number WHERE  (Ra_status_2.Document_number IN " +
                    "(SELECT DISTINCT Document_number FROM Ra_status AS Ra_status_1 WHERE (send_date IS NULL))) and Ra_status_2.flag='Y' and Ra_status_2.Company_code IN (" + company_code + ")";

            //if (received_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date >= '" + received_date + "')";
            //}
            //if (send_date != "")
            //{
            //    SqlSelect = SqlSelect + " AND (Ra_Header.invoice_date <= '" + send_date + "')";
            //}
            if (received_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date >= '" + received_date + "')";
            }
            if (send_date != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_Header.bill_rec_date <= '" + send_date + "')";
            }

            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_2.Vendor_code IN (" + vendor_code + "))";
            }
            if (po_so != "")
            {
                SqlSelect = SqlSelect + " AND (Ra_status_2.doc_type = '" + po_so + "')";
            }

            SqlSelect = SqlSelect + "  GROUP BY Ra_status_2.Company_code, Ra_status_2.Document_number,Ra_status_2.Vendor_code " +
                      "HAVING (SUM(CONVERT(int, max_days)) - SUM(DATEDIFF(day, receive_date, getdate())) < 0)) AS inprocess_bill   GROUP BY Company_code,Vendor_code) AS d ON a.Company_code = d.Company_code and  a.Vendor_code = d.Vendor_code";









            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        public DataTable GetOrderDetail(string po_so_number, string vendor_code)
        {
            DBDataAdpterObject.SelectCommand.Parameters.Clear();
            String SqlSelect = "";
            SqlSelect = "SELECT order_master.po_so_number, order_master.vendor_code,order_master.company_code,order_master.location_code,order_master.plant_code, order_master.po_so_type,vendor_details.vendor_name " +
                        "FROM order_master INNER JOIN " +
                        "vendor_details ON order_master.vendor_code = vendor_details.vendor_code " +
                        "WHERE     (order_master.po_so_number ='" + po_so_number + "')";

            if (vendor_code != "")
            {
                SqlSelect = SqlSelect + " and order_master.vendor_code ='" + vendor_code + "'";
            }





            DBDataAdpterObject.SelectCommand.CommandText = SqlSelect;

            DataSet ds = new DataSet();
            try
            {
                DBDataAdpterObject.Fill(ds);
                if (ds.Tables[0].Rows.Count <= 0)
                    return null;
                else
                    return ds.Tables[0];
            }
            catch (Exception ex)
            {
                return null;
            }
        }

    }
}
