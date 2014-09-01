using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;

public partial class User_Profile : System.Web.UI.Page
{
    string query;
    DataConnection db = new DataConnection();
    SqlDataReader drr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Session["Chat_Id"] == null)
            {
                Response.Redirect("./Default.aspx");
            }
            
            TextBoxName.Text = (String)Session["User_Name"];
            TextBoxEmail.Text = (String)Session["User_Email"];
        }
        LabelDispalyName.Text = (String)Session["User_Name"];
        ImageUser.ImageUrl = (String)Session["User_Image"];
        
    }
    protected void ButtonBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("./Chat.aspx");
    }
    protected void ButtonUpdate_Click(object sender, EventArgs e)
    {
        String pass, image,filename;
        try
        {
            pass = null;
            image = (String)Session["User_Image"];
            //upload image update tbale upload file with user_id 
            query = "select count(*) from users where email='" + TextBoxEmail.Text + "';";
            db.connect_db();
            drr = db.execute_select_query(query);
            drr.Read();
            
            if ((int)drr[0] == 0 || ((int)drr[0] == 1 && (String)Session["User_Email"] == TextBoxEmail.Text))
            {
                drr.Close();
                if (TextBoxNewPassword.Text.Length > 0)
                    pass = TextBoxNewPassword.Text;
                if (UploadFileImage.HasFile)
                {
                    filename = UploadFileImage.FileName;
                    if (Path.GetExtension(filename).ToLower() != ".jpg" && Path.GetExtension(filename).ToLower() != ".png")
                    {
                        LabelState.ForeColor = Color.Red;
                        LabelState.Text = "Select Appropriate Image";
                        return;
                    }
                    else
                    {
                        char[] ch = { '_' };
                        String tmp_str = (((String)Session["User_Image"]).Split(ch, 4))[3];
                        ch[0] = '.';
                        int file_count = int.Parse(tmp_str.Split(ch, 2)[0]);
                        filename = "user_" + (int)Session["User_Id"]+"_"+(file_count+1)+Path.GetExtension(filename).ToLower();
                        UploadFileImage.SaveAs(Server.MapPath(".") + "/Images/User_images/" + filename);
                        ImageResizer.ImageJob i = new ImageResizer.ImageJob(Server.MapPath(".") + "/Images/User_images/" + filename, Server.MapPath(".") + "/Images/User_images/" + filename, new ImageResizer.ResizeSettings("width=100;height=100;format=jpg;mode=crop"));
                        i.Build();
                        
                        image = "./Images/User_images/" + filename;
                    }
                }
                if(pass==null)
                    query = "update users set name='" + TextBoxName.Text + "',email='" + TextBoxEmail.Text + "',profile_image='" + image + "' where id=" + (int)Session["User_Id"] + ";";
                else
                    query = "update users set name='" + TextBoxName.Text + "',email='" + TextBoxEmail.Text + "',profile_image='" + image + "',password='"+pass+"' where id=" + (int)Session["User_Id"] + ";";
                if (db.execute_update_query(query) == true)
                {
            
                    query = "select name,email,profile_image from users where id="+(int)Session["User_Id"]+";";
                    drr=db.execute_select_query(query);
                    drr.Read();
                    Session["User_Name"] = (String)drr[0];
                    Session["User_Email"] = (String)drr[1];
                    Session["User_Image"] = (String)drr[2];
                    drr.Close();
                    LabelState.ForeColor = Color.Green;
                    LabelState.Text = "Profile updated sucessfully";
                }
                else
                {
                    LabelState.ForeColor = Color.Red;
                    LabelState.Text = "Failed to update profile";
                }
            }
            else
            {
                LabelState.ForeColor = Color.Red;
                LabelState.Text = "Email already registed try a different one..";
            }
        }
        catch (Exception ex)
        {
            LabelState.ForeColor = Color.Red;
            LabelState.Text = ex.StackTrace+"\n"+ex.Message;
        }
        finally
        {
            LabelDispalyName.Text = (String)Session["User_Name"];
            ImageUser.ImageUrl = (String)Session["User_Image"];
            db.close_connection();
        }

    }
    protected void ButtonReset_Click(object sender, EventArgs e)
    {
        
        TextBoxName.Text = (String)Session["User_Name"];
        TextBoxEmail.Text = (String)Session["User_Email"];
        TextBoxNewPassword.Text = "";
        TextBoxConfirmPassword.Text = "";
    }
}