<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Import.aspx.cs" Inherits="Access_Control_Elizma.Import" %>

<!-- Declares the document type as HTML -->
<!DOCTYPE html>

<!-- Starts the HTML document -->
<html xmlns="http://www.w3.org/1999/xhtml">

<!-- Head section for the server-side -->
<head runat="server">

    <!-- The title of the webpage -->
    <title>Access Control Optimi College</title>

    <!-- The Links to Google Fonts to import 'Raleway' and 'Roboto' fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Raleway:ital,wght@1,300&family=Roboto&display=swap" rel="stylesheet"/>

    <!-- This links the external CSS file named "Export_CSS.css" -->
    <link rel="stylesheet" href="ImportCSS.css" />

    <!-- This code includes the jQuery library from a CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- This code links the jQuery UI CSS file -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>

        //Below is the JavaScript/Jquery to open the Help pdf and Troubleshooting pdf.
        // A variable is declared.
        var pdfTabs = {};

        // A function is defined to open PDF files based on the given type.
        function openPDF(event, pdfType) {
            // The  default action prevented e.g the following a link
            event.preventDefault();

            // If the PDF type is 'Help', the 'Help' PDF will open in a new tab/window.
            if (pdfType === 'Help') {
                pdfTabs.Help = window.open('Images/Help.pdf', '_blank');
            }
            // If the PDF type is 'Troubleshoot', the 'troubleshoot' PDF will open in a new tab/window.
            else if (pdfType === 'Troubleshoot') {
                pdfTabs.Troubleshoot = window.open('Images/Troubleshooting.pdf', '_blank');
            }

            // Check if the PDF tab/window in question is closed.
            checkTabClosed(pdfType);
        }

        //A function is defined to check if a specific PDF tab/window is closed.
        function checkTabClosed(pdfType) {
            //The interval for checking is cleared if the 'help' tab/window is closed.
            var checkInterval = setInterval(function () {
                // If the 'Help' tab/window is closed, clear the interval for checking.
                if (pdfType === 'Help' && pdfTabs.Help && pdfTabs.Help.closed) {
                    clearInterval(checkInterval);
                }
                //The interval for checking is cleared if the 'Troubleshoot' tab/window is closed.
                else if (pdfType === 'Troubleshoot' && pdfTabs.Troubleshoot && pdfTabs.Troubleshoot.closed) {
                    clearInterval(checkInterval);
                }
            }, 1000); // The PDF tab/window is cheked every 1 second to see if it's closed.
        }

    </script>
    
</head>
<body>
    <form id="form1" runat="server">
        
        <div class="top-bar">

            <div class="logo">
                <a href="https://optimicollege.co.za/">
                     <!--The logo picture with a href tag to take the user to Optimi College main wepage upon clicking on the picture-->
                    <img src="Images/LOGO_OptimiCollege_ITAcdemy.png" alt="Logo" />

                </a>
            </div>
            <!--This is a container, containing all the href links button on the top-left of the webpage.-->
            <!--Once the user clicks on the button it will open a new webpage depending which the href link is linked to that button-->
            <div class="container">
                <asp:LinkButton runat="server" CssClass="TroubleShoot_button" ID="HelpLinkButton" OnClientClick="openPDF(event, 'Help')" Text="Help"></asp:LinkButton>
                <asp:LinkButton runat="server" CssClass="TroubleShoot_button" OnClientClick="openPDF(event, 'Troubleshoot')" Text="Troubleshoot"></asp:LinkButton>
                <asp:LinkButton runat="server" CssClass="import_button" Text="Export" PostBackUrl="Export.aspx"></asp:LinkButton>
            </div>

        </div>
        <div>
        </div>
        <table class="auto-style1">
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                    <!-- The ASP.NET FileUpload control element with the ID "FileUpload_Excel" with its recommended style -->
                    <asp:FileUpload ID="FileUpload_Excel" CssClass="FileUpload_Excel" runat="server" style="border-radius: 5px;"/>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                    <!-- The ASP.NET GridView_Employee control is wrapped within a div and the scrollbar is added in the styles. -->
                    <div style="overflow:auto; max-height:300px;">
                        <!-- Below is an ASP.NET GridView control with the ID "GridView_upload". -->
                        <asp:GridView ID="GridView_upload" CssClass="GridView_upload" runat="server" Width="98%">
                            <HeaderStyle CssClass="header-style" />
                        </asp:GridView>
                        </div>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                     <!-- Below is the ASP.NET Label element named "Lbl_Error"-->
                    <asp:Label ID="Lbl_Error" runat="server" Text="Label" Visible="false"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>
                    <!-- The code below is an ASP.NET Button element with the ID "Btn_Load" with its style preference. -->  
                    <asp:Button ID="Btn_Load" CssClass="Btn_Load" runat="server" OnClick="Btn_Load_Click" Text="Load"
                    style="border-radius: 5px;"/>

                    <!-- The code below is an ASP.NET Button element with the ID "Btn_Import" with its style preference. -->  
                    <asp:Button ID="Btn_Import" CssClass="Btn_Import" runat="server" OnClick="Btn_Import_Click" style="border-radius: 5px;" Text="Import" />

                    <!-- The code below is an ASP.NET Button element with the ID "Btn_ResfreshImport" with its style preference. -->  
                    <asp:Button ID="Btn_ResfreshImport" CssClass="Btn_ResfreshImport" runat="server" style="border-radius: 5px;" Text="Refresh" OnClick="Btn_ResfreshImport_Click" />
                </td>
                <td>
                    &nbsp;</td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td colspan="2">
                    <!-- Below is the ASP.NET Label element named "Lbl_Success" with text "Label".-->
                    <asp:Label ID="Lbl_Success" runat="server" Text="Label" Visible="false"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
       
    </form>
        <!-- The footer section with the class "bottom-bar" -->
        <footer class="bottom-bar">   
        <!-- The Paragraph element displaying the copyright information. -->
        <p>&copy; 2023 Trinity Software (Ptl)Ltd. All rights reserved.</p>
        </footer>
</body>
</html>
