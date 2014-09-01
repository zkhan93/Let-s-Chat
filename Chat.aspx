<%@ Page Title="Let's Chat" MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="Chat" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link rel="Stylesheet" href="./Stylesheet/chatcss.css" />
    <script type="text/Javascript" src="./Scripts/chat.js" ></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form id="form1" runat="server" defaultbutton="ButtonSend">
      
        <asp:SqlDataSource ID="SqlDataSourceChatRooms" runat="server" ConnectionString="<%$ ConnectionStrings:chat_room_dbConnectionString %>" SelectCommand="SELECT [chat_image], [chat_name], [user_created], [id] FROM [chat_rooms]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceChatUsers" runat="server" ConnectionString="<%$ ConnectionStrings:chat_room_dbConnectionString %>" SelectCommand="select profile_image, name from users where chat_id&lt;&gt;0 and chat_id=@chat_id and state=1">
            <SelectParameters>
                <asp:SessionParameter Name="chat_id" SessionField="Chat_Id" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <table cellpadding="0" cellspacing="0" class="auto-style1">
            <tr>
                <td>
                    
                            
                            <table cellpadding="0" cellspacing="5px" class="auto-style1" >
                                <tr>
                                    <td colspan="4">
                                         <table class="auto-style2">
                                    <tr >
                                        <td  style="width:20%">
                                           
                                                <center>
                                                    <a href="User_Profile.aspx" alt="Change User profile" title="Change User profile">
                                                        <asp:Image ID="ImageUserPicture" CssClass="user_image" runat="server" />
                                                    </a><br/>
                                                </center>
                                           
                                        </td>
                                        <td class="chat_head" style="width:60%">
                                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                <ContentTemplate>
                                                    <div class="div_head">
                                                        <asp:Literal ID="LiteralUserName" runat="server"></asp:Literal><asp:Literal ID="LiteralUserEmail" runat="server"></asp:Literal>
                                                        <asp:Label ID="LabelActiveChat" runat="server" CssClass="font"></asp:Label>
                                                    </div>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            
                                           
                                        </td>
                                        <td  style="width:20%">
                                           
                                                <center>
                                                    <asp:Button ID="ButtonLogout" CssClass="button_logout" runat="server" Text=" Log Out " OnClick="ButtonLogout_Click" />
                                                </center>
                                           
                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">
                                            <asp:Image runat="server" CssClass="divider_horizontal" ImageUrl="~/Images/System/divider_hor_down.png" />
                                        </td>
                                    </tr>
                                </table>
                                    </td>
                                </tr>
                                <tr >
                                    <td >
                                        <div class="div_label">
                                            <asp:Label ID="LabelFilesHeader" CssClass="labeltext" runat="server" Text="Shared Files"></asp:Label>
                                        </div>
                                        
                                    </td>
                                    <td >
                                        <div class="div_label">
                                            <asp:Label ID="LabelMessagesHeader" CssClass="labeltext" runat="server" Text="Messages"></asp:Label>
                                        </div>
                                    </td>
                                    <td colspan="2" >
                                        <div class="div_label">
                                            <asp:Label ID="LabelChatRoomsHeader" CssClass="labeltext" runat="server" Text="Chat Rooms"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:30%" >
                                        <div style="width:100%;height:400px;max-height:400px">
                                            
                                            <table cellpadding="0" cellspacing="0" style="width:100%">
                                            <tr >
                                                <td style="border:1px solid black;border-radius:3px;">
                                                    <div id="div_files" class="div_scroll" style="height:110px;max-height:110px; overflow:auto;">
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <asp:Timer ID="Timer" runat="server"  OnTick="Timer_Tick" Interval="1000"></asp:Timer>
                                                    <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Interval="2000"></asp:Timer>
                                                    <asp:Literal ID="Literalfileslist" runat="server"></asp:Literal>
                                                    
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                            
                                        </div>
                                        
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >
                                                    <div class="div_label" style="height:15px;">
                                                       
                                                                <asp:Label ID="LabelChatUsers" CssClass="labeltext" runat="server" Text="Online Users"></asp:Label>
                                                            
                                                        
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="border:1px solid black;border-radius:3px;">
                                                    <div id="div_users" class="div_scroll" style="height:232px;max-height:232px;overflow:auto;">
                                                        <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                            <ContentTemplate>
                                                                <asp:Literal ID="LiteralChatUsers" runat="server"></asp:Literal>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>
                                                      </div>
                                                </td>
                                            </tr>
                                        </table>
                                        </div>
                                        
                                        
                                        
                                    </td>
                                    <td style="width:40%;border:1px solid black;border-radius:3px;">
                                        <div id="div_msg" class="div_scroll" style="max-width:500px;height:400px; overflow:auto;">
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <asp:Literal ID="LiteralMessagesShow" runat="server"></asp:Literal>
                                                    
                                         </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                    </td>
                                    <td colspan="2" style="width:30%;border:1px solid black;border-radius:3px;">
                                        <table cellpadding="0" cellspacing="0" style="height:400px;width:100%;">
                                            <tr>
                                                <td>
                                                    <div id="div_chat" class="div_scroll" style="height:400px;overflow:auto">
                                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="GridViewChatRoomList" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="SqlDataSourceChatRooms" ForeColor="Black" GridLines="Horizontal" OnSelectedIndexChanged="GridViewChatRoomList_SelectedIndexChanged" Width="100%" ShowHeader="False" DataKeyNames="user_created,id" BackColor="#F9F9F9" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px">
                                                    <Columns>
                                                        <asp:TemplateField ShowHeader="False">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" CommandName="Select" Height="40px" ImageUrl='<%# Eval("chat_image") %>' Text="Select" Width="40px" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="chat_name" HeaderText="chat_name" SortExpression="chat_name" />
                                                    </Columns>
                                                    <EditRowStyle Width="20px" />
                                                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                                    <RowStyle Height="20px" />
                                                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                                        <SortedDescendingHeaderStyle BackColor="#242121" />
                                                    </asp:GridView>
                                                    </ContentTemplate>
                                            </asp:UpdatePanel>
                                                    </div>
                                                </td>
                                            </tr>
                                            
                                        </table>
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="width:100%">
                                        <div class="state">
                                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                            <ContentTemplate>
                                                <asp:Label ID="LabelState" runat="server" Font-Size="Small"></asp:Label>
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        </div>
                                        
                                    </td>
                                    <td colspan="2" style="width:100%">
                                        
                                            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                <ContentTemplate>
                                                    <div style="text-align:center;width:100%">
                                                    <asp:Button Visible="false" CssClass="button_logout" ID="ButtonDeleteChat" runat="server" Text="Remove Chat" OnClick="ButtonDeleteChat_Click" />
                                                    </div>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        
                                        
                                    </td>
                                </tr>
                                
                            </table>
                        
                    
                </td>
            </tr>
            <tr>
                <td>
                    <table cellpadding="0" cellspacing="0" class="auto-style1">
                        <tr>
                            <td style="width:68%">
                                <table class="auto-style1">
                                    <tr>
                                        <td>
                                            <asp:TextBox onkeyup="ReplaceChars()" style="width:100%;height:50px" ID="TextBoxUserTypeMessage" runat="server" Placeholder="Your Message"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table class="auto-style1">
                                                <tr>
                                                    <td style="width:30px">
                                                        <asp:Button ID="ButtonSend" CssClass="button_chats" runat="server" Text="Send" OnClick="ButtonSend_Click" />
                                                    </td>
                                                    <td>
                                                        <div class="fileinputs">
                                                            <asp:FileUpload CssClass="file" style="width:90px; top: 0px; left: 0px;" ID="UploadFile" runat="server" />
                                                            <div class="fakefile">
                                                                <img style="width:20px;height:20px" alt="Select Profile Image" src="Images/System/upload.png" /> <asp:Label ID="LabelFileState" runat="server" Text="Share File"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    
                                                </tr>
                                            </table>
                                            
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width:2%">
                                <asp:Image ID="Image2" style="height:90px;margin-left:10px" alt="divider" runat="server" ImageUrl="~/Images/System/divider_ver_right.png" />
                            </td>
                            <td style="width:30%">
                                <table class="auto-style1">
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="TextBoxChatRoomName" runat="server" placeholder="Chat Room Name"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="ButtonCreate" CssClass="button_chats" runat="server" Text="Create New" OnClick="ButtonCreate_Click" />
                                                    </td>
                                                    <td>
                                                        <div class="fileinputs">
                                                            <asp:FileUpload style="width:90px" CssClass="file" ID="UploadFileChatRoomImage" runat="server" />
                                                            <div class="fakefile">
                                                                <img style="width:20px;height:20px" alt="Select Profile Image" src="Images/System/upload.png" />
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</asp:Content>

