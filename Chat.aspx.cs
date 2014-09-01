using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Drawing;
using System.Text;

public partial class Chat : System.Web.UI.Page
{
   
    DataConnection db = new DataConnection();
    string query;
    private SqlDataReader drr;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session==null)
        {
            
            Response.Redirect("./Default.aspx");
        }
        
        if (Page.IsPostBack == false)
        {
            ImageUserPicture.ImageUrl = (String)Session["User_Image"];
            LiteralUserName.Text = "<p class=\"font\">" + (String)Session["User_Name"]+"<p>";
            LiteralUserEmail.Text= "<p class=\"font2\"><code>" + (String)Session["User_Email"] + "</code></p>";
            TextBoxUserTypeMessage.Focus();
        }
       
    }

   

    protected void ButtonCreate_Click(object sender, EventArgs e)
    {
        try
        {
            query = "select count(*) from chat_rooms where chat_name='" + TextBoxChatRoomName.Text + "';";
            db.connect_db();
            drr = db.execute_select_query(query);
            
            if (drr.Read() && (int)drr[0] == 0)
            {
                drr.Close();
                string filename;
                if (UploadFileChatRoomImage.HasFile==true)
                {
                    filename = UploadFileChatRoomImage.FileName;
                    if (Path.GetExtension(filename).ToLower() != ".jpg" && Path.GetExtension(filename).ToLower() != ".png")
                    {
                        LabelState.ForeColor = Color.Red;
                        LabelState.Text = "Image file Not Valid try a .jpg or .png file";
                        return;
                    }
                    else
                    {
                        //set image id
                        query = "Select count(*) from chat_rooms;";
                        drr = db.execute_select_query(query);
                        drr.Read();
                        filename = "chat_room_image_" + ((int)drr[0]+1) + Path.GetExtension(UploadFileChatRoomImage.FileName);
                        drr.Close();
                        UploadFileChatRoomImage.SaveAs(Server.MapPath(".")+"/Images/ChatRoom_images/"+ filename);
                        ImageResizer.ImageJob i = new ImageResizer.ImageJob(Server.MapPath(".") + "/Images/ChatRoom_images/" + filename, Server.MapPath(".") + "/Images/ChatRoom_images/" + filename, new ImageResizer.ResizeSettings("width=100;height=100;format=jpg;mode=crop"));
                        i.Build();
                    }
                }
                else
                {
                    filename = "Default.png";
                }
                query = "insert into chat_rooms(chat_name,chat_image,user_created) values('" + TextBoxChatRoomName.Text + "','./Images/ChatRoom_images/" + filename + "','" + (int)Session["User_Id"] + "');";
                if (db.execute_insert_query(query) != 1)
                {
                    LabelState.ForeColor = Color.Red;
                    LabelState.Text = "Cannot Create ChatRoom Try Again";
                }
            }
            else
            {
                LabelState.ForeColor = Color.Red;
                LabelState.Text = "Chat Room already exist try different name..";
                return;
            }
        }
        catch (Exception ee)
        {
            LabelState.Text = ee.Message;
        }
        finally
        {
            TextBoxChatRoomName.Text = "";
            db.close_connection();
        }
    }
    protected void ButtonSend_Click(object sender, EventArgs e)
    {
        try
        {
            //check file if exist upload
            if ((int)Session["Chat_Id"] > 0)
            {
                if (UploadFile.HasFile)
                {
                    String filename, extension;
                    extension = Path.GetExtension(UploadFile.FileName);
                    query = "select count(*) from files;";
                    db.connect_db();
                    drr = db.execute_select_query(query);
                    drr.Read();
                    filename = "file_" + (int)drr[0];
                    UploadFile.SaveAs(Server.MapPath("./Uploads/") + filename + extension);
                    drr.Close();
                    query = "insert into files(location,chat_room_id,user_id,file_name) values('./Uploads/" + filename + extension + "'," + (int)Session["Chat_ID"] + "," + (int)Session["User_Id"] + ",'" + UploadFile.FileName + "');";
                    if (db.execute_insert_query(query) == 1)
                    {
                        LabelState.ForeColor = Color.Green;
                        LabelState.Text = "File Uploaded";
                    }
                    else
                    {
                        LabelState.ForeColor = Color.Red;
                        LabelState.Text = "File Not Uploaded Try Again..";
                    }
                    db.close_connection();
                }
                //check for message
                if (TextBoxUserTypeMessage.Text.Length > 0)
                {
                    String tmp = TextBoxUserTypeMessage.Text;

                    query = "insert into messages(chat_room_id,user_id,msg_txt) values(" + Session["Chat_Id"] + "," + Session["User_Id"] + ",'" + tmp + "');";
                    db.connect_db();
                    //LabelState.Text = db.execute_insert_query2(query);
                    if (db.execute_insert_query(query) > 0)
                    {
                        DataConnection.new_message = true;
                        LabelState.ForeColor = Color.Green;
                        LabelState.Text = "Message inserted";
                        TextBoxUserTypeMessage.Text = "";
                        TextBoxUserTypeMessage.Focus();
                    }
                    else
                    {
                        LabelState.ForeColor = Color.Red;
                        LabelState.Text = "Message not send";

                    }
                }
            }
            else
            {
                LabelState.ForeColor = Color.Red;
                LabelState.Text = "Select a Chat Room First";
            }
        }
        catch (Exception ee)
        {
            LabelState.Text = ee.Message;
        }
        finally
        {
            db.close_connection();
            ScriptManager.RegisterStartupScript(UpdatePanel1, this.GetType(), "MyAction", "SetScrollPosition();", true);
        }

    }
    protected void GridViewChatRoomList_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        try
        {
            int selected_chat_room = (int)Session["Chat_Id"];
            if ((int)Session["User_Id"] == (int)GridViewChatRoomList.SelectedDataKey["user_created"])
            {

                ButtonDeleteChat.Visible = true;
            }
            else
            {
                ButtonDeleteChat.Visible = false;
            }
            Session["Chat_id"] = GridViewChatRoomList.SelectedDataKey["id"];
            query = "update users set chat_id=" + Session["Chat_Id"] + " where id=" + Session["User_Id"] + " ;";
            db.connect_db();
            if (db.execute_update_query(query) == true)
            {
                query = "select chat_name from chat_rooms where id=" + Session["Chat_Id"] + ";";
                drr = db.execute_select_query(query);
                if(drr.Read())
                    Session["Active_Chat_Name"] = (String)drr[0];
                drr.Close();
                LabelActiveChat.Text = "you are in " + Session["Active_Chat_Name"] + " chat room";
                LabelState.ForeColor = Color.Green;
                LabelState.Text = "Chat Room Changed ";
            }
            else
            {
                Session["Chat_Id"] = selected_chat_room;
                LabelState.ForeColor = Color.Red;
                LabelState.Text = "Cannot join chat try again";
            }

        }
        catch (Exception ee)
        {
            LabelState.ForeColor = Color.Red;
            LabelState.Text = ee.Message;
        }
        finally
        {
            db.close_connection();
        }
    }
    protected void Timer_Tick(object sender, EventArgs e)
    {

        GridViewChatRoomList.DataBind();
        
        try
        {
            //messages
            StringBuilder tmp_str = new StringBuilder("<table cellpadding=\"0px\" cellspacing=\"0px\" class=\"auto-style1\">");
            query = "SELECT u.profile_image,u.name,m.msg_txt FROM messages AS m INNER JOIN users AS u ON (m.chat_room_id=" + (int)Session["Chat_Id"] + " and u.id=m.user_id);";
            db.connect_db();
            
            drr = db.execute_select_query(query);
            if (drr != null)
            {
                while (drr.Read())
                {
                    tmp_str.Append("<tr class=\"tr\"><td class=\"td1_msg\" class=\"auto-style1\" >");
                    tmp_str.Append("<div class=\"div_img\"><img class=\"msg_img\" src=\"" + (String)drr[0] + "\" alt=\"" + (String)drr[1] + "\" title=\"" + (String)drr[1] + "\"/></div></td>");
                    tmp_str.Append("<td class=\"td2_msg\"><div class=\"div_txt\">" + (String)drr[2] + "</td></tr>"); //supposing it contain no html tags
                }
                drr.Close();
            }
            tmp_str.Append("</table cellpadding=\"0px\" cellspacing=\"0px\">");
            
            LiteralMessagesShow.Text = tmp_str.ToString();
            tmp_str.Clear();
            //files
            query = "select u.profile_image,u.name,f.location,f.file_name,f.id from users u Inner join files f ON (f.chat_room_id=" + Session["Chat_Id"] + " and u.id=f.user_id)";
            drr = db.execute_select_query(query);
            tmp_str.Append("<table  class=\"auto-style1\">");
            if (drr != null)
            {
                while (drr.Read())
                {
                    tmp_str.Append("<tr class=\"tr\"><td class=\"td1_file\">");
                    tmp_str.Append("<div class=\"div_img\"><img class=\"file_img\" src=\"" + (String)drr[0] + "\" alt=\"" + (String)drr[1] + "\" title=\"" + (String)drr[1] + "\"/></div></td>");
                    tmp_str.Append("<td class=\"td2_file\" ><div class=\"div_txt\"><a href=\"./Download.aspx?file=" + (int)drr[4] + "\" class=\"link_file\">" + (String)drr[3] + "</a>");
                    tmp_str.Append("</div></td></tr>");
                }
                drr.Close();
            }
            tmp_str.Append("</table>");
            
            Literalfileslist.Text = tmp_str.ToString();

            //scroll the bar to bottom if new message arrived
            if (DataConnection.new_message)
            {
                ScriptManager.RegisterStartupScript(UpdatePanel1, this.GetType(), "MyAction", "SetScrollPosition();", true);
               
            }
            //chat users 
           
            tmp_str.Clear();

            query = "select profile_image,name from users where chat_id<>0 and id<>"
                +(int)Session["User_Id"]
                +" and chat_id=" 
                + (int)Session["Chat_Id"] 
                + " and state=1;";

            drr = db.execute_select_query(query);
            tmp_str.Append("<table cellpadding=\"0\" cellspacing=\"0\" style=\"width:100%\" >");
            if (drr != null)
            {
                while (drr.Read())
                {
                    tmp_str.Append("<tr class=\"tr\"><td class=\"td1_file\">");
                    tmp_str.Append("<div class=\"div_img\"><img class=\"file_img\" src=\"" + (String)drr[0] + "\" alt=\"" + (String)drr[1] + "\" title=\"" + (String)drr[1] + "\"/></div></td>");
                    tmp_str.Append("<td class=\"td2_file\" ><div class=\"div_txt\">" + (String)drr[1]);
                    tmp_str.Append("</div></td></tr>");
                }
                drr.Close();
            }
            tmp_str.Append("</table>");
            
            LiteralChatUsers.Text = tmp_str.ToString();
            tmp_str.Clear();         
        }
        catch (Exception ee)
        {
            LabelState.ForeColor = Color.Red;
            LabelState.Text = ee.Message;
        }
        finally
        {
            
            db.close_connection();
        }
       
        
        
    }

    
    protected void ButtonLogout_Click(object sender, EventArgs e)
    {
       
        //set users to offline
        try
        {
            query = "update users set state=0 , chat_id=0 where id=" + Session["User_Id"] + ";";
            db.connect_db();
            db.execute_update_query(query);
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
        catch (Exception ee)
        {
            LabelState.ForeColor = Color.Red;
            LabelState.Text = ee.Message;
        }
        finally
        {
            db.close_connection();
        }
    }
    protected void ButtonDeleteChat_Click(object sender, EventArgs e)
    {
        db.connect_db();
        try
        {
            int chat_id=(int)GridViewChatRoomList.SelectedDataKey["id"];
                    //messages delete
                    query = "delete from messages where chat_room_id=" + chat_id + ";";
                    if (db.execute_update_query(query) == true)
                    {
                        //files delete
                        query = "delete from files where chat_room_id=" + chat_id + ";";
                        if (db.execute_update_query(query) == true)
                        {
                            //users change chat_room
                            query = "update users set chat_id=0 where chat_id=" + chat_id + ";";
                            if (db.execute_update_query(query) == true)
                            {
                                //delete chat room
                                query = "delete from chat_rooms where id=" + chat_id + ";";
                                if (db.execute_update_query(query) == true)
                                {

                                    LabelState.ForeColor = Color.Green;
                                    LabelState.Text = "Chat Room Removed";
                                }
                                else
                                {
                                    LabelState.ForeColor = Color.Red;
                                    LabelState.Text = "Error deleting chat room";
                                }
                            }
                            else
                            {
                                LabelState.ForeColor = Color.Red;
                                LabelState.Text = "Error removing users";
                            }
                        }
                        else
                        {
                            LabelState.ForeColor = Color.Red;
                            LabelState.Text = "Error deleting files";
                        }
                    }
                    else
                    {
                        LabelState.ForeColor = Color.Red;
                        LabelState.Text = "Error deleting messages";
                    }
                    //files delete
                    //user chat room change
        }
        catch (Exception ee)
        {
            LabelState.ForeColor = Color.Red;
            LabelState.Text = ee.Message;
        }
        finally
        {
            ButtonDeleteChat.Visible = false;
            db.close_connection();
        }
    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        DataConnection.new_message = false;
    }
}