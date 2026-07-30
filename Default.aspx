<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Web Form with Master Page.aspx.cs" Inherits="Kmc_Login.Web_Form_with_Master_Page" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>KMC Platform - Login</title>
    <link href="StyleSheet1.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        
        <table class="center-table">
            <tr>
                <td>
                    <!-- Login Form Box -->
                    <div class="login-card">
                        
                        <h2>KMC Login</h2>

                        <div class="form-group">
                            <label for="txtEmail">Email Address :</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <label for="txtPassword">Password :</label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" />
                        </div>

                        <div class="message-group">
                            <asp:Label ID="lblMessage" runat="server" CssClass="error-message"></asp:Label>
                        </div>

                    </div>
                </td>
            </tr>
        </table>

    </form>
</body>
</html>