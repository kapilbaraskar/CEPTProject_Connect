using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_test_dates : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        DateTime start_date = Cal_start_date.SelectedDate;
        DateTime end_date = Cal_end_date.SelectedDate;

        Dictionary<string, int> dic_week_day = new Dictionary<string, int>();
        dic_week_day["Sunday"] = 1;
        dic_week_day["Monday"] = 2;
        dic_week_day["Tuesday"] = 3;
        dic_week_day["Wednesday"] = 4;
        dic_week_day["Thursday"] = 5;
        dic_week_day["Friday"] = 6;
        dic_week_day["Saturday"] = 7;

        DateTime first_day = start_date.AddDays(1 - start_date.Day);
        int selected_day = dic_week_day[Drp_day_of_week.SelectedValue.ToString()];

        string str_html = "";
        for (DateTime i = first_day; i <= end_date; i = i.AddMonths(1))
        {
            int day_of_week = dic_week_day[i.DayOfWeek.ToString()];
            
            DateTime temp_date;

            if (day_of_week > selected_day)
            {
                temp_date = i.AddDays((7 - day_of_week) + selected_day);
            }
            else
            {
                temp_date = i.AddDays(selected_day - day_of_week);
            }

            DateTime last_day_of_month = (temp_date.AddMonths(1)).AddDays(-temp_date.Day);

            if (Drp_occurrence.SelectedValue.ToString() == "odd")
            {
                if (start_date <= temp_date && temp_date <= end_date && temp_date <= last_day_of_month)
                {
                    str_html += "<br />" + temp_date.ToString();
                }

                DateTime res_date = temp_date.AddDays(14);

                if (start_date <= res_date && res_date <= end_date && res_date <= last_day_of_month)
                {
                    str_html += "  ,  " + res_date.ToString();
                }

                res_date = temp_date.AddDays(28);

                if (start_date <= res_date && res_date <= end_date && res_date <= last_day_of_month)
                {
                    str_html += "  ,  " + res_date.ToString();
                }
            }
            else if (Drp_occurrence.SelectedValue.ToString() == "even")
            {
                DateTime res_date = temp_date.AddDays(7);

                if (start_date <= res_date && res_date <= end_date && res_date <= last_day_of_month)
                {
                    str_html += "<br />" + res_date.ToString();
                }

                res_date = temp_date.AddDays(21);

                if (start_date <= res_date && res_date <= end_date && res_date <= last_day_of_month)
                {
                    str_html += "  ,  " + res_date.ToString();
                }
            }
            else
            {
                int occurrence = Int32.Parse(Drp_occurrence.SelectedValue.ToString());

                DateTime res_date = temp_date.AddDays((occurrence - 1) * 7);

                if (start_date <= res_date && res_date <= end_date && res_date <= last_day_of_month)
                {
                    str_html += "<br />" + res_date.ToString();
                }
            }
        }

        Div_result.InnerHtml = str_html;
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        DateTime cur_date = Cal_start_date.SelectedDate;
        DateTime end_date = Cal_end_date.SelectedDate;
        int skip_weeks = Int32.Parse(txt_skip_week.Value.ToString());
        string selected_weekdays = txt_weekdays.Value;

        Dictionary<string, int> dic_week_day = new Dictionary<string, int>();
        dic_week_day["Sunday"] = 1;
        dic_week_day["Monday"] = 2;
        dic_week_day["Tuesday"] = 3;
        dic_week_day["Wednesday"] = 4;
        dic_week_day["Thursday"] = 5;
        dic_week_day["Friday"] = 6;
        dic_week_day["Saturday"] = 7;

        string str_html = "";
        for (int i = dic_week_day[cur_date.DayOfWeek.ToString()]; i <= 7; i++)
        {
            if (cur_date <= end_date && selected_weekdays.Contains(cur_date.DayOfWeek.ToString()))
            {
                str_html += "<br />" + cur_date.ToString();
            }

            cur_date = cur_date.AddDays(1);
        }

        cur_date = cur_date.AddDays(skip_weeks * 7);

        while (cur_date <= end_date)
        {
            for (int i = 0; i < 7; i++)
            {
                if (cur_date <= end_date && selected_weekdays.Contains(cur_date.DayOfWeek.ToString()))
                {
                    str_html += "<br />" + cur_date.ToString();
                }

                cur_date = cur_date.AddDays(1);
            }

            cur_date = cur_date.AddDays(skip_weeks * 7);
        }

        Div_result.InnerHtml = str_html;
    }
}