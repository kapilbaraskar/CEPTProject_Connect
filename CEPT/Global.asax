<%@ Application Language="C#" %>
<%@ Import Namespace="System.Diagnostics" %>
<script RunAt="server">  
    //static int sessioncount = 0;

    void Application_Start(object sender, EventArgs e)
    {
        //Code that runs on application startup
        //string a = Application.ToString();
        //int i = 0;
        ////Application.Lock(); 
        //Application["Application_count"] = i + 1;
        ////Application.UnLock();
    }
    
    void Application_BeginRequest(object sender, EventArgs e)
    {
    }   

    void Application_EndRequest(object sender, EventArgs e)
    {
    }
    
    void Application_End(object sender, EventArgs e)
    {
        //Code that runs on application shutdown
    }

    void Application_Error(object sender, EventArgs e)
    {
        //Code that runs when an unhandled error occurs
    }

    void Session_Start(object sender, EventArgs e)
    {   
        //Application["Application_session_count"]= Convert.ToInt16(sessioncount + 1);
        //Code that runs when a new session is started
        
        string a = Session.SessionID;
        
        //int sessioncount = 0;
        //Application["Application_session_count"]= Convert.ToInt16(sessioncount + 1); 
    }

    void Session_End(object sender, EventArgs e)
    {
        //string a = Session.SessionID;

        //Application["Application_session_count"] = sessioncount--;
        //Code that runs when a session ends. 
        //Note: The Session_End event is raised only when the sessionstate mode
        //is set to InProc in the Web.config file. If session mode is set to StateServer 
        //or SQLServer, the event is not raised.
        //int sessioncount = 0;

        //Application["Application_session_count"] = Convert.ToInt16(sessioncount - 1); 
    }  
</script>
