using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_Test : System.Web.UI.Page
{
    public delegate int delg(int a, int b);

    protected void Page_Load(object sender, EventArgs e)
    {
        test_linq();

        test_delegate();
    }

    public void test_linq()
    {
        //
    }

    public void test_delegate()
    {
        delg obj_delegate = new delg(fnSum);

        obj_delegate += new delg(fnSubstract);

        obj_delegate += new delg(fnMultiplication);

        obj_delegate += new delg(fnDivision);

        int a = 5;
        int b = 2;

        div_display.InnerHtml += "Value 1 :: " + a + "<br/>";
        div_display.InnerHtml += "Value 2 :: " + b + "<br/>";

        int res = obj_delegate(a, b);

        obj_delegate -= new delg(fnSubstract);

        obj_delegate -= new delg(fnDivision);

        int res2 = obj_delegate(a, b);

        int res3 = find_max(a, b);

        div_display.InnerHtml += "Max Value :: " + res3 + "<br/>";

        int res4 = find_min(a, b);

        div_display.InnerHtml += "Min Value :: " + res4 + "<br/>";
    }

    public int fnSum(int a, int b)
    {
        div_display.InnerHtml += "Addition Result :: " + (a + b) + "<br/>";
        return a + b;
    }

    public int fnSubstract(int a, int b)
    {
        div_display.InnerHtml += "Substraction Result :: " + (a - b) + "<br/>";
        return a - b;
    }

    public int fnMultiplication(int a, int b)
    {
        div_display.InnerHtml += "Multiplication Result :: " + (a * b) + "<br/>";
        return a * b;
    }

    public int fnDivision(int a, int b)
    {
        div_display.InnerHtml += "Division Result :: " + (a / b) + "<br/>";
        return a / b;
    }

    Func<int, int, int> find_max = delegate(int a, int b)
    {
        if (a >= b) return a;
        else return b;
    };

    Func<int, int, int> find_min = (int a, int b) => (a <= b) ? a : b;
}