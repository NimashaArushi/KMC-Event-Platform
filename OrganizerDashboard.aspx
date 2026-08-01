<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrganizerDashboard.aspx.cs" Inherits="Kmc_Login.OrganizerDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Organizer Dashboard</title>
    

    <style>
       
            --primary-color: #16A34A;   
            --secondary-color: #4ADE80; 
            --bg-color: #F0FDF4;      
            --text-color: #14532D;     
            --card-bg: #FFFFFF;         
            --warning-color: #F59E0B;   
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-color);
            margin: 0;
            padding: 0;
        }

        /* Top Navigation Bar */
        .navbar {
            background-color: var(--primary-color);
            color: #FFFFFF;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 8px rgba(22, 163, 74, 0.25);
        }

        .navbar h2 {
            margin: 0;
            font-size: 20px;
            font-weight: 600;
        }

        .btn-logout {
            background-color: transparent;
            color: #FFFFFF;
            border: 1px solid #FFFFFF;
            padding: 6px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-logout:hover {
            background-color: #FFFFFF;
            color: var(--primary-color);
        }

        /* Main Layout */
        .container {
            width: 90%;
            max-width: 1200px;
            margin: 30px auto;
            display: flex;
            gap: 25px;
        }

        /* Card Component */
        .card {
            background-color: var(--card-bg);
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(20, 83, 45, 0.08);
            padding: 24px;
            border: 1px solid var(--secondary-color);
        }

        .form-section {
            flex: 1;
        }

        .table-section {
            flex: 1.5;
        }

        .card h3 {
            margin-top: 0;
            color: var(--primary-color);
            border-bottom: 2px solid var(--secondary-color);
            padding-bottom: 10px;
            font-size: 18px;
            font-weight: 600;
        }

        /* Form Inputs */
        .form-group {
            margin-bottom: 16px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: var(--text-color);
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #BBF7D0;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
            color: var(--text-color);
            background-color: #FAFCF9;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(22, 163, 74, 0.2);
            background-color: #FFFFFF;
        }

        /* Create Event Button */
        .btn-submit {
            background-color: var(--primary-color);
            color: #FFFFFF;
            border: none;
            padding: 12px;
            width: 100%;
            border-radius: 6px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-submit:hover {
            background-color: #15803D; /* Slightly darker green */
        }

        /* Custom Table (GridView) */
        .gridview-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            border-radius: 6px;
            overflow: hidden;
        }

        .gridview-table th {
            background-color: var(--primary-color);
            color: #FFFFFF;
            text-align: left;
            padding: 12px;
            font-size: 14px;
            font-weight: 600;
        }

        .gridview-table td {
            padding: 12px;
            border-bottom: 1px solid #DCFCE7;
            font-size: 14px;
            color: var(--text-color);
        }

        .gridview-table tr:hover {
            background-color: #DCFCE7;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <!-- Top Navigation Bar -->
        <div class="navbar">
            <h2>KMC Community - Organizer Dashboard</h2>
            <div>
                <span style="margin-right: 15px;">Welcome, <asp:Label ID="lblUser" runat="server" Font-Bold="true"></asp:Label></span>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <!-- Main Content -->
        <div class="container">
            
            <!-- 1. Create Event Form -->
            <div class="card form-section">
                <h3>Create New Event</h3>

                <div class="form-group">
                    <label>Event Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g. Health Camp 2026"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Event Date</label>
                    <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Location</label>
                    <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="e.g. Kandy Community Hall"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label>Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Brief about the event..."></asp:TextBox>
                </div>

                <asp:Button ID="btnAddEvent" runat="server" Text="Create Event" CssClass="btn-submit" OnClick="btnAddEvent_Click" />
                
                <div style="margin-top: 12px;">
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </div>
            </div>

            <!-- 2. Published Events Table -->
            <div class="card table-section">
                <h3>Your Published Events</h3>
                <asp:GridView ID="gvEvents" runat="server" AutoGenerateColumns="False" CssClass="gridview-table" EmptyDataText="No events found yet!">
                    <Columns>
                        <asp:BoundField DataField="Id" HeaderText="ID" />
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:BoundField DataField="EventDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Location" HeaderText="Location" />
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </form>
</body>
</html>