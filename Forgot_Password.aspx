<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Forgot_Password.aspx.cs" Inherits="Forgot_Password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form id="from1" runat="server">
        <table cellpadding="0" cellspacing="0" width="100%" style="text-align:center">
        <tr>
            <td colspan="3">
                <div class="div_main" >
                      <p>
                          Forgot Password
                      </p>
                  </div>
            </td>
        </tr>
            <tr>
            <td colspan="3" style="padding:5px">
                <asp:Image ImageUrl="~/Images/System/divider_hor_down.png" CssClass="divider_horizontal" runat="server" />
            </td>
        </tr>
        <tr>
            <td  style=" width:45%;padding:5px">
                <asp:Label CssClass="labeltext" ID="LabelFrogotEmail" runat="server" Text="Email"></asp:Label>
            </td>
            <td>
                <asp:Image ImageUrl="~/Images/System/divider_ver_right.png" Height="50px" Width="10px" runat="server" />
            </td>
            <td style="width:45%;">
                <asp:TextBox Width="50%" ID="TextBoxForgotEmail" runat="server"></asp:TextBox><br/>
                <asp:RegularExpressionValidator ID="RegularExpressionValidatorForgotEmail" runat="server" ErrorMessage="Not a valid Email" Text="Not a valid Email" ControlToValidate="TextBoxForgotEmail" Font-Size="X-Small" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td  style="text-align:center" colspan="2">
                
            </td>
            <td style="padding:5px">
                <table cellpadding="0" cellspacing="0" style=" width:100%; text-align:center">
                    <tr>
                        <td>
                            <asp:Button CssClass="button" ID="ButtonForgotPassword" runat="server" Text="Submit" OnClick="ButtonForgotPassword_Click" />
                        </td>
                        <td>
                            <asp:Button CssClass="button_logout" ID="ButtonBack" runat="server" Text="Back" OnClick="ButtonBack_Click" />
                        </td>
                    </tr>
                </table>
                
            </td>
        </tr>
        <tr>
            <td colspan="3" style="padding:5px">
                <asp:Label ID="LabelState" runat="server" Font-Size="Small"></asp:Label>
            </td>
        </tr>
    </table>
    </form>
    
</asp:Content>

