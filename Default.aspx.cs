using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.IO;
using System.Data;
using System.Configuration;
using System.Drawing;

public partial class login2 : System.Web.UI.Page
{
    DataConnection db = new DataConnection();
    string query;
    private SqlDataReader drr;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["User_Id"] != null)
        {
            //logout user
            try{
            query = "update users set state=0 , chat_id=0 where id=" + Session["User_Id"] + ";";
            db.connect_db();
            db.execute_update_query(query);
            db.close_connection();
            LabelState.Text = "";
            }
            catch(Exception ex)
            {
                LabelState.Text = ex.Message;
            }
            finally
            {
                LabelState.ForeColor=Color.Red;
                LabelState.Text += " You have been Logged Out.. Login Again!";
                Session.Abandon();
            }
        }
    }
    protected void ButtonLogin_Click(object sender, EventArgs e)
    {
        
        if (Page.IsValid)
        {
            try
            {
                query = "select * from users where email='" + TextBoxLoginEmail.Text + "';";
                db.connect_db();
                drr = db.execute_select_query(query);
                if (drr.Read() && (String)drr["password"] == TextBoxLoginPassword.Text)
                {
                    if ((int)drr["state"] != 0)
                    {
                        LabelState.ForeColor = Color.Red;
                        LabelState.Text = "Multiple logins not allowed";
                    }
                    else
                    {
                        Session["User_Name"] = drr["name"];
                        Session["User_Id"] = drr["id"];
                        Session["User_Email"] = drr["email"];
                        Session["User_Image"] = drr["profile_image"];
                        Session["Chat_Id"] = drr["chat_id"];
                        drr.Close();
                        LabelState.ForeColor = Color.Green;
                        LabelState.Text = "Login sucessfull redirecting..";
                        query = "update users set state=1 where id=" + Session["User_Id"] + ";";
                        db.execute_update_query(query);
                        db.close_connection();
                        Response.Redirect("Chat.aspx");

                        //set image url here to display
                    }



                }
                else
                {
                    LabelState.ForeColor = Color.Red;
                    LabelState.Text = "Login failed try Again!";

                }
            }
            catch (Exception ex)
            {
                LabelState.Text = ex.Message;
            }
            finally
            {
                db.close_connection();
            }
        }
    }
    protected void ButtonSignUp_Click(object sender, EventArgs e)
    {
        
        if (Page.IsValid)
        {
            String filename, gender = "Male";
            try
            {
                if (RadioButtonFemale.Checked)
                    gender = "Female";
                query = "select count(*) from users where email='" + TextBoxSignupEmail.Text + "';";
                db.connect_db();
                drr = db.execute_select_query(query);

                if (drr.Read())
                {
                    if ((int)drr[0] == 1)
                    {
                        LabelState.ForeColor = Color.Red;
                        LabelState.Text = "Email already registered try a different one";

                    }
                    else if ((int)drr[0] == 0)
                    {
                        drr.Close();
                        if (FileUploadImage.HasFile)
                        {
                            filename = FileUploadImage.FileName;
                            if (Path.GetExtension(filename).ToLower() != ".jpg")
                            {
                                LabelState.ForeColor = Color.Red;
                                LabelState.Text = "Select Appropriate Image";
                                return;
                            }
                            else
                            {
                                query = "select count(*) from users;";
                                drr = db.execute_select_query(query);
                                drr.Read();
                                filename = "user_" + ((int)drr[0] + 1) + "_0" + ".jpg";
                                //  filename="user_"+
                                drr.Close();
                                FileUploadImage.SaveAs(Server.MapPath("~/Images/User_images/") + filename);
                                ImageResizer.ImageJob i = new ImageResizer.ImageJob(Server.MapPath(".") + "/Images/User_images/" + filename, Server.MapPath(".") + "/Images/User_images/" + filename, new ImageResizer.ResizeSettings("width=100;height=100;format=jpg;mode=crop"));
                                i.Build();
                            }

                        }
                        else
                        {
                            if (gender == "Female")
                                filename = "Default_Female_0.png";
                            else
                                filename = "Default_Male_0.png";
                        }

                        query = "insert into users(name,email,password,profile_image,gender) values('" + TextBoxSignupName.Text + "','" + TextBoxSignupEmail.Text + "','" + TextBoxSignupPassword.Text + "','./Images/User_images/" + filename + "','" + gender + "');";
                        if (db.execute_insert_query(query) == 1)
                        {
                            TextBoxSignupEmail.Text = TextBoxSignupName.Text = TextBoxSignupPassword.Text = "";
                            TextBoxLoginEmail.Focus();
                            LabelState.ForeColor = Color.Green;
                            LabelState.Text = "SignUp Sucessfull, Now you can LogIn";
                        }
                        else
                        {
                            LabelState.ForeColor = Color.Red;
                            LabelState.Text = "SignUp Failed Try again";
                        }
                    }
                }

            }
            catch (Exception ee)
            {
                LabelState.Text = ee.Message;
            }
            finally
            {
                db.close_connection();
            }
        }
    }
    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        args.IsValid = args.Value.Length > 4;
    }
    protected void LinkButtonForgetPassword_Click(object sender, EventArgs e)
    {
        Response.Redirect("Forgot_Password.aspx");
    }
}