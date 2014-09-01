using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Data.SqlClient;
public partial class Download : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //get query string
        char[] ch={'_'};
        DataConnection db = new DataConnection();
        
        String query = "select location from files where id=" + ((Request.QueryString["file"]).Split(ch))[0]+";";
        db.connect_db();
        SqlDataReader drr = db.execute_select_query(query);
        if (drr.Read())
        {
            query = (String)drr[0];
        }
        db.close_connection();
        download(query);
        Response.Redirect("./Chat.aspx");
       
    }
    private string download(string strURL) {
        try
        {
            
            WebClient req = new WebClient();
            HttpResponse response = HttpContext.Current.Response;
            response.Clear();
            response.ClearContent();
            response.ClearHeaders();
            response.Buffer = true;
            response.AddHeader("Content-Disposition", "attachment;filename=\"" + Server.MapPath(".")+strURL + "\"");
            byte[] data = req.DownloadData(Server.MapPath(".")+strURL);
            response.BinaryWrite(data);
            response.End();
            return "File Downloading...";
        }
        catch (Exception ex)
        {
            return ex.Message;
        }
        
    }
}