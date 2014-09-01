<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="User_Profile.aspx.cs" Inherits="User_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form id="form1" runat="server">

        <table cellpadding="0" cellspacing="0" class="auto-style1" style="text-align:right;margin-bottom:10px;">
            <tr>
                <td colspan="3">
                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr>
                            <td style="width: 30%">
                                <asp:Label CssClass="font" ForeColor="Black" Font-Size="XX-Large" ID="LabelDispalyName" runat="server"></asp:Label>
                            </td>
                            <td style="text-align:center">
                                <asp:Image CssClass="user_image" ID="ImageUser" runat="server" />
                                
                                    <div style="text-align:center;position:relative;">
                                    <asp:FileUpload style="border:1px solid black;position:relative;text-align:right;-moz-opacity:0;filter:alpha(opacity:0);opacity:0;z-index:2;width:90px;height:20px;" ID="UploadFileImage" runat="server" />
                                    <div style="position:absolute;left:0px;top:0px;z-index:1;width:100%;text-align:center;">
                                                <img style="width:20px;height:20px" alt="Select Profile Image" src="Images/System/upload.png" />
                                    </div>
                                </div> <asp:Label ID="LabelChangeImage" CssClass="labeltext" runat="server" Text="Change Picture"></asp:Label>
                               
                                
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div>
                                    <asp:Image ID="Image1" CssClass="divider_horizontal" runat="server" ImageUrl="~/Images/System/divider_hor_down.png" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label CssClass="labeltext" ID="LabelName" runat="server" Text="Name"></asp:Label>
                            </td>
                            <td style="text-align:center">
                                <asp:TextBox ID="TextBoxName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label CssClass="labeltext" ID="LabelEmail" runat="server" Text="Email"></asp:Label>
                            </td>
                            <td style="text-align:center">
                                <asp:TextBox ID="TextBoxEmail" runat="server" ValidationGroup="Updatedetails"></asp:TextBox><br/>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Email is not Valid" Font-Size="X-Small" ValidationGroup="Updatedetails" ControlToValidate="TextBoxEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">Email is not Valid</asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="auto-style2">
                                <asp:Label CssClass="labeltext" ID="LabelNewPassword" runat="server" Text="New Password"></asp:Label>
                            </td>
                            <td style="text-align:center">
                                <asp:TextBox ID="TextBoxNewPassword" runat="server" TextMode="Password" ValidationGroup="Updatedetails"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style2">
                                <asp:Label CssClass="labeltext" ID="LabelConfirmPassword" runat="server" Text="Confirm Password"></asp:Label>
                            </td>
                            <td style="text-align:center">
                                <asp:TextBox ID="TextBoxConfirmPassword" runat="server" TextMode="Password" ValidationGroup="Updatedetails"></asp:TextBox><br/>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Password not Matched" Font-Size="X-Small" ControlToCompare="TextBoxConfirmPassword" ControlToValidate="TextBoxNewPassword" ValidationGroup="Updatedetails">Password not matched</asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" style="text-align:center">
                                <asp:Label ID="LabelState" runat="server" Font-Size="Small"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div>
                                    <asp:Image ID="Image2" CssClass="divider_horizontal" runat="server" ImageUrl="~/Images/System/divider_hor_up.png" />
                                </div>
                            </td>
                        </tr>
            
                    </table>
                </td>
            </tr>
            <tr style="text-align:center">
                <td>
                    <asp:Button ID="ButtonUpdate" CssClass="button_logout" runat="server" Text="Update" OnClick="ButtonUpdate_Click" ValidationGroup="Updatedetails" />
                </td>
                <td>
                    <asp:Button ID="ButtonReset" CssClass="button_logout" runat="server" Text="Reset" OnClick="ButtonReset_Click" />
                </td>
                <td>
                        <asp:Button ID="ButtonBack" CssClass="button_logout" runat="server" Text="Back" OnClick="ButtonBack_Click" />
                </td>
            </tr>
        </table>




    </form>
</asp:Content>

