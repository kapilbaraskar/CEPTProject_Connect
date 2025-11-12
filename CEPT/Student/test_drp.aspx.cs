using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Student_test_drp : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        #region IEnumerable and IEnumerator Example

        //List<int> lst_age = new List<int>();

        //lst_age.Add(10);
        //lst_age.Add(20);
        //lst_age.Add(30);
        //lst_age.Add(40);
        //lst_age.Add(50);

        //IEnumerable<int> IEnumerable_age = (IEnumerable<int>)lst_age;

        //var temp = IEnumerable_age.Select(S => S + 2);

        //IEnumerator<int> IEnumerator_age = lst_age.GetEnumerator();

        //test_IEnumerable1(IEnumerable_age);

        //test_IEnumerator1(IEnumerator_age);

        #endregion

        #region Abstract Class Example

        TempClass tc = new TempClass(1);

        tc.Func1();

        #endregion

        #region Interface Example

        //TempClass2 tc2 = new TempClass2();

        //tc2.Func1();
        //tc2.Func1(5);

        #endregion
    }

    #region IEnumerable and IEnumerator Example

    protected void test_IEnumerable1(IEnumerable<int> IEnumerable_age)
    {
        div_print.InnerHtml += "test_IEnumerable1 Start" + "<br/>";

        foreach (int a in IEnumerable_age)
        {
            div_print.InnerHtml += a.ToString() + "<br/>";

            if (a > 20)
            {
                test_IEnumerable2(IEnumerable_age);
            }
        }

        div_print.InnerHtml += "test_IEnumerable1 End" + "<br/>";
    }

    protected void test_IEnumerable2(IEnumerable<int> IEnumerable_age)
    {
        div_print.InnerHtml += "test_IEnumerable2 Start" + "<br/>";

        foreach (int a in IEnumerable_age)
        {
            div_print.InnerHtml += a.ToString() + "<br/>";
        }

        div_print.InnerHtml += "test_IEnumerable2 End" + "<br/>";
    }

    protected void test_IEnumerator1(IEnumerator<int> IEnumerator_age)
    {
        div_print.InnerHtml += "test_IEnumerator1 Start" + "<br/>";

        while(IEnumerator_age.MoveNext())
        {
            div_print.InnerHtml += IEnumerator_age.Current.ToString() + "<br/>";

            if (IEnumerator_age.Current > 20)
            {
                test_IEnumerator2(IEnumerator_age);
            }
        }

        div_print.InnerHtml += "test_IEnumerator1 End" + "<br/>";
    }

    protected void test_IEnumerator2(IEnumerator<int> IEnumerator_age)
    {
        div_print.InnerHtml += "test_IEnumerator2 Start" + "<br/>";

        while (IEnumerator_age.MoveNext())
        {
            div_print.InnerHtml += IEnumerator_age.Current.ToString() + "<br/>";
        }

        div_print.InnerHtml += "test_IEnumerator2 End" + "<br/>";
    }

    #endregion
}

#region Abstract Class Example

public abstract class TempAbstractClass
{
    internal int aaa = 5;

    public TempAbstractClass()
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Abstract Class Default Constructor : " + DateTime.Now + Environment.NewLine);
    }

    public TempAbstractClass(int a)
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Abstract Class Parameterize Constructor : " + DateTime.Now + Environment.NewLine);
    }

    ~TempAbstractClass()
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Abstract Class Destructor : " + DateTime.Now + Environment.NewLine);
    }

    public abstract void Func1();
    //{
    //    System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Abstract Class Func1 : " + DateTime.Now + Environment.NewLine);
    //}
}

public class TempClass : TempAbstractClass
{ 
    public TempClass()
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Class Default Constructor : " + DateTime.Now + Environment.NewLine);
    }

    public TempClass(int a)
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Class Parameterize Constructor : " + DateTime.Now + Environment.NewLine);
    }

    ~TempClass()
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Class Destructor : " + DateTime.Now + Environment.NewLine);
    }

    public override void Func1()
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Class Func1 aaa : " + aaa.ToString() + DateTime.Now + Environment.NewLine);
    }
}

#endregion

#region Interface Example

public interface TempInterface
{
    void Func1();
}

public interface TempInterface2
{
    void Func1(int a);
}

public class TempClass2 : TempInterface, TempInterface2
{
    public void Func1()
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Class Func1 : " + DateTime.Now + Environment.NewLine);
    }

    public void Func1(int a)
    {
        System.IO.File.AppendAllText(@"C:\Ceptreg_Log\WS_test.txt", "Temp Class2 Func1(int a) : " + a + DateTime.Now + Environment.NewLine);
    }
}

#endregion
