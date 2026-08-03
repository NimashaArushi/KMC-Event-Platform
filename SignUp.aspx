<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="Kmc_Login.SignUp" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up - KMC App</title>
    <link href="StyleSheet2.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <table class="center-table">
            <tr>
                <td>
                    <div class="login-card">
                        <h2>KMC Sign Up</h2>

                        <div class="message-group">
                            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
                        </div>

                        <div class="form-group">
                            <label for="txtEmail">Email Address :</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtPassword">Password :</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtConfirmPassword">Confirm Password :</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>

                         <div class="form-group">
                            <label>Register As:</label>
                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Resident (Public User)" Value="Resident"></asp:ListItem>
                                <asp:ListItem Text="Event Organizer" Value="Organizer"></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" CssClass="btn-login" OnClick="btnSignUp_Click" />
                        </div>

                        <div class="form-group" style="margin-top: 15px; text-align: center;">
                            <span>Already have an account? </span>
                          <asp:HyperLink ID="linkLogin" runat="server" NavigateUrl="Default.aspx">Login Here</asp:HyperLink>
                        </div>

                    </div>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
