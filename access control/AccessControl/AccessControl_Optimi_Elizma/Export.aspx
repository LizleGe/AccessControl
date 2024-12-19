<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Export.aspx.cs" Inherits="Access_Control_Optimi.Export" %>

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
    <link rel="stylesheet" href="Export_CSS.css" />

    <!-- This code includes the jQuery library from a CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- This code links the jQuery UI CSS file -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css"/>
    <!-- This code links the jQuery UI CSS file -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
    <!-- This code links the jQuery UI CSS file -->
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
       
    <script>

        //Below is the JavaScript/JQuery for the datepicker
        // This code will execute when the document is fully loaded
        $(document).ready(function () {

            // The datepicker is started for the start date.  
            $('#<%= TextBox_StartDate.ClientID %>').datepicker({
        dateFormat: 'yy-mm-dd', // The format of the date is year-month-day
        onSelect: function (selectedDate) {
            // If a date is selected in the start date datepicker,
            // the minimum date for the end date datepicker is set.
            $('#<%= TextBox_EndDate.ClientID %>').datepicker('option', 'minDate', selectedDate);
        }
    });

    // The datepicker for the end date
    $('#<%= TextBox_EndDate.ClientID %>').datepicker({
        dateFormat: 'yy-mm-dd', // Set the format of the date to year-month-day
        onSelect: function (selectedDate) {
            // If a date is selected in the end date datepicker,
            // the maximum date for the start date datepicker is set.
            $('#<%= TextBox_StartDate.ClientID %>').datepicker('option', 'maxDate', selectedDate);
        }
    });
        });



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




    //Below is the JavaScript/Jquery for the error and download message once the export button is clicked. 
    // A function is defined to check the conditions and perform the actions.
    function checkAndExport() {
        // The gridview is checked to see if it has rows.
        if ($('#<%=GridView_Employees.ClientID %> tr').length > 0) {
                // The download message is shown.
                $('#downloadMessage').show();
                // The file downloaded message is hidden.
                $('#fileDownloadedMessage').hide();
                // A timeout is set to perform actions after a delay.
                setTimeout(function () {
                    // The download message are hidden.
                    $('#downloadMessage').hide();
                    // The file downloaded message is shown for 4 seconds.
                    $('#fileDownloadedMessage').text("File Exported!!!").show().delay(4000).fadeOut();
                }, 3000); // A delay is set before showing the file downloaded message to 3000 milliseconds (3 seconds).
                // This will happen will be true once a file is available for download.
                return true;
            } else {
                // The error message will be shown.
                $('#errorMessage').show();
                // It will return false if no file is available for download.
                return false;
            }
        }
    </script>


</head>
<body>
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
            <asp:LinkButton runat="server" CssClass="import_button" Text="Import" PostBackUrl="Import.aspx"></asp:LinkButton>
        </div>

        </div>

    
    <form id="form1" runat="server">
        <table>
            <tr>
                <td colspan="17">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style82" colspan="17"></td>
            </tr>
            <tr>
                <td class="auto-style49"></td>                
                <td class="auto-style50"></td>
                <!--Below is the Lbl_StartDate-->
                <td class="auto-style71" colspan="2">
                    <!-- Below is the ASP.NET Label element named "Lbl_StartDate" displaying "Start Date" text -->
                    <asp:Label ID="Lbl_StartDate" runat="server" Text="Start Date" style="font-family: 'Roboto', sans-serif; font-weight: bold; font-size: 18px; color: white; background-color: transparent; border: none; padding: 0;"></asp:Label>
                </td>
               
                <td class="auto-style85">
                    
                    <!-- Below is the ASP.NET TextBox control with the ID "TextBox_StartDate" with all the styles. -->
                    <asp:TextBox ID="TextBox_StartDate" runat="server" OnTextChanged="TextBox_StartDate_TextChanged" style="border-radius: 5px;" ></asp:TextBox>
                </td>

                <td class="auto-style50" colspan="4">
                    &nbsp;</td>
                <td class="auto-style50">
                    </td>
                <td class="auto-style50">
                    </td>
                <td class="auto-style52">
                    </td>
                <td class="auto-style50">
                    </td>
                <td class="auto">                  
                    </td>
             
                <td class="auto">
                    <!-- Below is the ASP.NET DropDownList control with the ID "DropDownList_SelectOption" -->
                    <!-- The selectable options within the DropDownList are added for the user to choose from. -->
                    <asp:DropDownList ID="DropDownList_SelectOption" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList_SelectOption_SelectedIndexChanged" style="border-radius: 5px;" Width="182px">
                        <asp:ListItem>Select Option</asp:ListItem>
                        <asp:ListItem>All Employees</asp:ListItem>
                        <asp:ListItem>Fire Drill</asp:ListItem>
                        <asp:ListItem>In &amp; Out</asp:ListItem>
                        <asp:ListItem>Late Today</asp:ListItem>
                        <asp:ListItem>Sign In</asp:ListItem>
                        <asp:ListItem>Sign Out</asp:ListItem>
                        <asp:ListItem>Error Records</asp:ListItem>
                        <asp:ListItem>All Records</asp:ListItem>
                    </asp:DropDownList>

                    </td>

                <td class="auto-style50"></td>
                <td class="auto-style50"></td>

            </tr>
            <tr>
                <td class="auto-style49"></td>
                <td class="auto-style50"></td>

                <td class="auto-style71" colspan="2">
                    <!-- Below is the ASP.NET Label element named "Lbl_EndDate" displaying "End Date" text -->
                    <asp:Label ID="Lbl_EndDate" runat="server" Text="End Date"></asp:Label>
                </td>
                <td class="auto-style85">
                    <!-- Below is the ASP.NET TextBox control with the ID "TextBox_EndDate" with all the styles. -->
                    <asp:TextBox ID="TextBox_EndDate" runat="server" OnTextChanged="TextBox_EndDate_TextChanged" BackColor="White" ForeColor="Black" style="border-radius: 5px;"></asp:TextBox>
                </td>
                <td class="auto-style86">
                    


                    </td>
                <td class="auto-style78">

                    <!-- The code below is an ASP.NET Button element with the ID "Btn_Search" with its style preference. -->
                    <asp:Button ID="Btn_Search" runat="server" OnClick="Btn_Search_Click" Text="Search" style="border-radius: 5px;" />
                    </td>

                <td class="auto-style79">
                    &nbsp;</td>
                <td class="auto-style77" colspan="9">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style95"></td>
                <td class="auto-style96"></td>
                <td class="auto-style89" colspan="2">

                    <!-- Below is the ASP.NET Label element named "Lbl_PersonnelID" displaying "Personnel ID" text -->
                    <asp:Label ID="Lbl_PersonnelID" runat="server" Text="Personnel ID"></asp:Label>
                </td>
                <td class="auto-style85">
                    <!-- Below is the ASP.NET TextBox control with the ID "TextBox_EmployeeID" with all the styles. -->
                    <asp:TextBox ID="TextBox_EmployeeID" runat="server" BackColor="White" ForeColor="Black" style="border-radius: 5px;"></asp:TextBox>
                </td>
                <td class="auto-style86">
                    
                    </td>
                <td class="auto-style78">

                    <!-- The code below is an ASP.NET Button element with the ID "Btn_employeeID" with its style preference. -->
                    <asp:Button ID="Btn_employeeID" runat="server" Text="Search Employee" OnClick="Btn_employeeID_Click" style="border-radius: 5px;"/>
                    </td>
                <td class="auto-style79">
                    </td>
                <td class="auto-style77" colspan="9">
                    </td>
            </tr>
            <tr>
                <td class="auto-style38" colspan="2">&nbsp;</td>
                <td class="auto-style38" colspan="3">&nbsp;</td>
                <td class="auto-style38" colspan="7">&nbsp;</td>
                <td class="auto-style38" colspan="3">&nbsp;</td>
                <td class="auto-style38" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style38" colspan="2">


        <!--The gridview is centered on the webpage.-->           
        <div class="center-gridview"> 
        </div>
                </td>
                <td class="auto-style38" colspan="13">
                    <!-- The ASP.NET GridView_Employee control is wrapped within a div and the scrollbar is added in the styles. -->
                    <div style="overflow:auto; max-height:300px;">
                        <!-- Below is an ASP.NET GridView control with the ID "GridView_Employees". -->
                        <asp:GridView ID="GridView_Employees" runat="server" OnSelectedIndexChanged="GridView_Employees_SelectedIndexChanged">
                        </asp:GridView>
                    </div>



            
                </td>
                <td class="auto-style38" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style80"></td>
                <td class="auto-style81"></td>
                <td class="auto-style82">
                </td>
                <td class="auto-style82">
                </td>
                <td class="auto-style82" colspan="13">
                </td>
            </tr>
            <tr>
                <td class="auto-style49"></td>
                <td class="auto-style50"></td>

                <td class="auto-style66">

                <!-- The code below is an ASP.NET Button element with the ID "Btn_Export" with its style preference. -->       
                <asp:Button ID="Btn_Export" runat="server" CssClass="Btn_Export" OnClick="Btn_Export_Click" Text="Export Data" OnClientClick="return checkAndExport();" style="border-radius: 5px;" />
   
                </td>
                <td class="auto-style66">

                <!-- The code below is an ASP.NET Button element with the ID "Btn_Refresh" with its style preference. -->  
                <asp:Button ID="Btn_Refresh" runat="server" CssClass="Btn_Refresh" OnClick="Btn_Refresh_Click" Text="Refresh" style="border-radius: 5px;" />
                </td>
                <td class="auto-style66" colspan="13">

                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style74"></td>
                <td class="auto-style75"></td>
                <td class="auto-style76" colspan="3">
                                            
                <!-- The container div for the error and download messages for the export button -->
                <div class="message_Container">
                    <!-- The div download message with text, "Preparing download..."  -->
                    <div class="download-message" runat="server" id="downloadMessage" style="display: none;">Preparing Export...</div>
                    <!-- The div file downloaded message, with text, "File downloaded!" -->
                    <div class="download-message" runat="server" id="fileDownloadedMessage" style="display: none;">File Exported!!!</div>
                    <!-- The div file error message, with text, "No file selected for download!!!" -->
                    <div class="error-message" runat="server" id="errorMessage" style="display: none;">No file selected for Export!!!</div>
                </div>

                            
                </td>
                <td class="auto-style76" colspan="12">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style62"></td>
                <td class="auto-style21"></td>

                <td class="auto-style29" colspan="3">
                    
                    <!-- Below is the ASP.NET Label element named "LabelError" -->
                    <asp:Label ID="LabelError" runat="server" Text="Label" Visible="False" Width="346px"></asp:Label>        
                </td>

                <td class="auto-style29" colspan="12">
                    &nbsp;      &nbsp;</td>
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
