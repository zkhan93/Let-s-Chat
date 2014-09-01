<%@ Application Language="C#" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e) 
    {
        // Code that runs on application startup
      
    }
    
    void Application_End(object sender, EventArgs e) 
    {
        //  Code that runs on application shutdown

    }
        
    void Application_Error(object sender, EventArgs e) 
    { 
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e) 
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e) 
    {
        DataConnection db = new DataConnection();
        //logout user
        try
        {
            
            String query = "update set state=0, chat_id=0 where id=" + Session["User_Id"] + ";";
            db.connect_db();
            if (db.execute_update_query(query) == true)
            {
                Session.Abandon();
            }
        }
        catch (Exception ex)
        {

        }
        finally
        {
            db.close_connection();
            
        }
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }
       
</script>
