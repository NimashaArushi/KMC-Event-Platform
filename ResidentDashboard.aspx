<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResidentDashboard.aspx.cs" Inherits="Kmc_Login.ResidentDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Resident Dashboard - KMC Community</title>
    
    <link href="StyleSheet2.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <h2>KMC Community - Resident Dashboard</h2>
            <div>
                <span style="margin-right:15px;">Welcome, 
                    <asp:Label ID="lblUser" runat="server" Font-Bold="true"></asp:Label>
                </span> 
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <div class="container">
            <div class="card">
                <h3>Explore Community Events</h3>
                <div class="search-box">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search events by title or location..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearch_Click" />
                </div>

                <!-- Msg alert -->
                <asp:Label ID="lblMsg" runat="server" Font-Bold="true" style="margin-bottom:15px; display:block;"></asp:Label>

                <!-- Event Field GridView -->
                <asp:GridView ID="gvPublicEvents" runat="server" AutoGenerateColumns="false" CssClass="gridview-table"
                    EmptyDataText="No community events available right now!" OnRowCommand="gvPublicEvents_RowCommand">

                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Title" HeaderText="Event Title" />
                        <asp:BoundField DataField="EventDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Location" HeaderText="Location" />
                        <asp:BoundField DataField="Description" HeaderText="Description" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:Button ID="btnRegisterEvent" runat="server" Text="Join Event" CssClass="btn-register" CommandName="RegisterEvent" CommandArgument='<%# Eval("Id") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </form>
</body>
</html>