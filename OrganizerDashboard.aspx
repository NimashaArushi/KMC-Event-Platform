
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrganizerDashboard.aspx.cs" Inherits="Kmc_Login.OrganizerDashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Organizer Dashboard</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet" />

    <style>
        :root {
            --bg-color: #0B0F19;        
            --card-bg: #111827;       
            --card-border: #2D1F47;  
            --primary-purple: #8B5CF6; 
            --purple-hover: #7C3AED;  
            --text-main: #FFFFFF;     
            --text-muted: #9CA3AF;    
            --input-bg: #1F2937;     
            --input-border: #374151;  
        }

        body {
            font-family: 'Inter', 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0;
            padding: 0;
        }

      
        .navbar {
            background-color: #111827;
            color: #FFFFFF;
            padding: 16px 5%; 
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--card-border);
            box-shadow: 0 4px 20px rgba(139, 92, 246, 0.15);
        }

        .navbar h2 {
            margin: 0;
            margin-left: 20px; 
            font-size: 20px;
            font-weight: 700;
            background: linear-gradient(135deg, #A78BFA 0%, #FFFFFF 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .btn-logout {
            background-color: rgba(239, 68, 68, 0.1);
            color: #F87171;
            border: 1px solid rgba(239, 68, 68, 0.3);
            padding: 8px 18px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s ease;
        }

        .btn-logout:hover {
            background-color: #EF4444;
            color: #FFFFFF;
            border-color: #EF4444;
        }

      
        .container {
            width: 92%;
            max-width: 1280px;
            margin: 35px auto;
            display: flex;
            gap: 30px;
        }

      
        .card {
            background-color: var(--card-bg);
            border-radius: 14px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.5);
            padding: 28px;
            border: 1px solid var(--card-border);
        }

        .form-section {
            flex: 1;
        }

        .table-section {
            flex: 1.5;
        }

        .card h3 {
            margin-top: 0;
            color: var(--text-main);
            border-bottom: 2px solid var(--primary-purple);
            padding-bottom: 12px;
            font-size: 19px;
            font-weight: 700;
            letter-spacing: -0.3px;
        }

        
        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-muted);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .form-control {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid var(--input-border);
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 14px;
            color: var(--text-main);
            background-color: var(--input-bg);
            transition: all 0.2s ease;
        }

        .form-control:focus {
            border-color: var(--primary-purple);
            outline: none;
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.25);
            background-color: #111827;
        }

        
        .btn-submit {
            background: linear-gradient(135deg, #8B5CF6 0%, #6D28D9 100%);
            color: #FFFFFF;
            border: none;
            padding: 14px;
            width: 100%;
            border-radius: 8px;
            font-weight: 600;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 15px rgba(139, 92, 246, 0.3);
            margin-top: 8px;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, #7C3AED 0%, #5B21B6 100%);
            transform: translateY(-1px);
            box-shadow: 0 6px 20px rgba(139, 92, 246, 0.4);
        }

      
        .gridview-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 18px;
            border-radius: 8px;
            overflow: hidden;
            border: 1px solid var(--card-border);
        }

        .gridview-table th {
            background-color: #1F1535;
            color: #C4B5FD;
            text-align: left;
            padding: 14px;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid var(--card-border);
        }

        .gridview-table td {
            padding: 14px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            font-size: 14px;
            color: #E5E7EB;
        }

        .gridview-table tr:hover {
            background-color: rgba(139, 92, 246, 0.08);
        }

      
        #lblMsg {
            font-weight: 500;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        
        <!--  Navigation Bar -->
        <div class="navbar">
            <h2>KMC Community - Organizer Dashboard</h2>
            <div>
                <span style="margin-right: 15px;">Welcome, <asp:Label ID="lblUser" runat="server" Font-Bold="true"></asp:Label></span>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
        </div>

        <!-- Main Content -->
        <div class="container">
            
            <!--  Create Event Form -->
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

            <!--  Published Events Table -->
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