<%@ Page Title="Let's Chat" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="login2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
            
        }
        td {
            margin:5px;
            padding:10px;
           
        }
        .div_main {
            font-size:21px;
            text-align:center;
            font-weight:bold;
        }
        .gender {
            
        }
        .forget {
            text-decoration:none;
            color:black;
            font-size:12px;
        }
        
    </style>
    <script language="javascript" type="text/javascript">
        function PasswordCheck(object, args) {
            args.IsValid = (args.Value.length > 4);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <form id="form1" runat="server">
      <table cellpadding="0" cellspacing="0" class="auto-style1">
          
          <tr >
              <td>
                  <div id="div_reguser" class="div_main">
                      <p>
                          Registered User
                      </p>
                  </div>
                  <asp:Image ID="Image1" Width="100%"  ImageUrl="./Images/System/divider_hor_down.png" runat="server" />
              </td>
              <td rowspan="2">
                  <img src="./Images/System/divider_ver_right.png" alt="divider" height="300px" />
              </td>
              <td >
                  <div id="div_newuser" class="div_main">
                      <p>
                          New User
                      </p>
                  </div>
                  <asp:Image ID="Image2" Width="100%"  ImageUrl="./Images/System/divider_hor_down.png" runat="server" />
              </td>
          </tr>
          
                    <tr>
                        <td style="width:48%">
                            
                <table cellpadding="0" cellspacing="0" class="auto-style1">
                    <tr class="login_tr">
                        <td class="auto-style2" >
                            <asp:Label ID="LabelUsername" CssClass="labeltext" runat="server" Text="Email"></asp:Label>
                        </td>
                        <td class="auto-style2">
                            <asp:TextBox ID="TextBoxLoginEmail" runat="server" placeholder="Your Email" ValidationGroup="Login" CausesValidation="True" ></asp:TextBox>&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Email is Required" Text="*" Font-Size="X-Large" ValidationGroup="Login" ControlToValidate="TextBoxLoginEmail"></asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidatorEmailSignin" runat="server" ControlToValidate="TextBoxLoginEmail" Display="Dynamic" ErrorMessage="Enter a valid E-mail" Font-Size="X-Large" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Login">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr class="login_tr">
                        <td>
                            <asp:Label ID="LabelPassword" CssClass="labeltext" runat="server" Text="Password" placeholder="Your Password"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="TextBoxLoginPassword" runat="server" placeholder="Your Pasword" TextMode="Password" ValidationGroup="Login" CausesValidation="True"></asp:TextBox>&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Password Required For Login" Font-Size="X-Large" ControlToValidate="TextBoxLoginPassword" Display="Dynamic" ValidationGroup="Login">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="login_tr">
                        <td colspan="2">
                            <center>
                            <asp:Button ID="ButtonLogin" CssClass="button" runat="server" Text="Login" OnClick="ButtonLogin_Click" ValidationGroup="Login" /><br/><br />
                                <asp:LinkButton ID="LinkButtonForgetPassword" runat="server" CssClass="forget" ToolTip="Click here to reset your password" OnClick="LinkButtonForgetPassword_Click">Forgot Password?</asp:LinkButton>
                                </center>
                        </td>
                        
                    </tr>
                </table>
                            </td>
                        
                        <td style="width:48%">
                            
                            <table cellpadding="0" cellspacing="0" class="auto-style1">
                                <tr class="login_tr">
                                    <td class="login_td">
                                        <asp:Label ID="LabelSignupName" CssClass="labeltext" runat="server" Text="Name"></asp:Label>
                                    </td>
                                    <td class="login_td">
                                        <asp:TextBox ID="TextBoxSignupName" runat="server" placeholder="Your Name" ValidationGroup="Signup" CausesValidation="True"></asp:TextBox>&nbsp<asp:RequiredFieldValidator  ID="RequiredFieldValidatorNameSignup" runat="server" ControlToValidate="TextBoxSignupName" Display="Dynamic" ErrorMessage="Name is Required" Font-Size="X-Large" ValidationGroup="Signup">*</asp:RequiredFieldValidator>
                                        
                                    </td>
                                </tr >
                                <tr class="login_tr">
                                    <td class="login_td">
                                        <asp:Label ID="LabelSignupEmail" CssClass="labeltext" runat="server" Text="Email" ></asp:Label>
                                    </td>
                                    <td class="login_td">
                                        <asp:TextBox ID="TextBoxSignupEmail" runat="server" placeholder="Your Email" ValidationGroup="Signup" CausesValidation="True"></asp:TextBox>&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Email is Required" Font-Size="X-Large" ValidationGroup="Signup" ControlToValidate="TextBoxSignupEmail">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="RegularExpressionValidatorEmailSignup" runat="server" ControlToValidate="TextBoxSignupEmail" Display="Dynamic" ErrorMessage="Email is not valid" Font-Size="X-Large" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="Signup">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr class="login_tr">
                                    <td class="login_td">
                                        <asp:Label ID="LabelSignUpPassword" CssClass="labeltext" runat="server" Text="Password"></asp:Label>
                                    </td>
                                    <td class="login_td">
                                        <asp:TextBox ID="TextBoxSignupPassword" runat="server" placeholder="Your Password" TextMode="Password" ValidationGroup="Signup" CausesValidation="True"></asp:TextBox>&nbsp<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Password is Required" Font-Size="X-Large" ControlToValidate="TextBoxSignupPassword" Display="Dynamic" ValidationGroup="Signup">*</asp:RequiredFieldValidator><asp:CustomValidator ID="CustomValidatorPassowrd" runat="server" ErrorMessage="Password must be between 5 to 8"   ValidationGroup="Signup" ControlToValidate="TextBoxSignupPassword" Display="Dynamic" ClientValidationFunction="PasswordCheck" Font-Size="X-Large" >*</asp:CustomValidator>
                                    </td>
                                </tr>
                                <tr class="login_tr">
                                    <td class="login_td" >
                                        <asp:Label ID="LabelGender" CssClass="labeltext" runat="server" Text="Gender"></asp:Label>
                                    </td>
                                    <td class="login_td">
                                        <asp:RadioButton Checked="true" CssClass="gender" Text="Male" ID="RadioButtonMale" GroupName="Gender" runat="server" />
                                        <asp:RadioButton CssClass="gender" Text="Female" ID="RadioButtonFemale" GroupName="Gender" runat="server" />
                                    </td>
                                </tr>
                                <tr class="login_tr">
                                    <td class="login_td">
                                        <asp:Label ID="LabelSignupImage" CssClass="labeltext" runat="server" Text="Profile Picture"></asp:Label>
                                    </td>
                                    <td class="login_td">
                                        <div class="fileinputs">
	                                        <asp:FileUpload ID="FileUploadImage" CssClass="file" runat="server" />
                                            <div class="fakefile">
                                                <img style="width:20px;height:20px" alt="Select Profile Image" src="Images/System/upload.png" />
                                            </div>
                                         </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <center>
                                        <asp:Button CausesValidation="true" ID="ButtonSignUp" CssClass="button" runat="server" Text="Sign Up" OnClick="ButtonSignUp_Click" ValidationGroup="Signup" />
                                            </center>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        </tr>
                    </table>
                <div style="text-align:center;vertical-align:central">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Signup" Font-Size="X-Small" CssClass="error" DisplayMode="List" />
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ValidationGroup="Login" Font-Size="X-Small" CssClass="error" DisplayMode="List" />
                <asp:Label ID="LabelState" CssClass="labelstate" runat="server"></asp:Label>
                    </div>
        </form>
</asp:Content>

