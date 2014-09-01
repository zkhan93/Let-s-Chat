using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;
using System.Net.Mail;

public partial class Forgot_Password : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Id"] == null)
        {
            //logout user;
            Session.Abandon();
        }
    }
    protected void ButtonForgotPassword_Click(object sender, EventArgs e)
    {
        //email the password to user
        DataConnection db=new DataConnection();
        SqlDataReader drr;
        String query = "select password from users where email='"+TextBoxForgotEmail.Text+"';";
        try
        {
            db.connect_db();
            drr = db.execute_select_query(query);

            if (drr.Read())           // check whether email already exists or not in databases 
            {

                MailMessage mailmessage = new MailMessage();
                mailmessage.To.Add(TextBoxForgotEmail.Text);
                mailmessage.From=new MailAddress("letschat.cs@gmail.com");
                mailmessage.Subject = "Let's Chat Account Password";
                mailmessage.Body = "This is a System Generated Message. \n Your Password: " + (String)drr[0];
                drr.Close();
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com");

                smtpClient.EnableSsl = true;
                smtpClient.Port = 587;
                smtpClient.Credentials = new System.Net.NetworkCredential("letschat.cs@gmail.com", "letschat1234cs");

                smtpClient.Send(mailmessage);
                TextBoxForgotEmail.Text = "";
                LabelState.ForeColor = Color.Green;
                LabelState.Text = "Password has been send to your E-mail";
            }
            else
            {
                LabelState.ForeColor = Color.Red;
                LabelState.Text = "E-mail is not Registerd";
            }
        }
        catch (Exception ex)
        {
            LabelState.ForeColor = Color.Red;
            LabelState.Text = ex.Message;
        }
        finally
        {
            db.close_connection();
        }
    }
    protected void ButtonBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("./Default.aspx");
    }
}