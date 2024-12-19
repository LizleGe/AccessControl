using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Dapper;
using System.IO;
using System.Data.OleDb;
using System.Globalization;


namespace Access_Control_Optimi
{
    public partial class Export : System.Web.UI.Page
    {

        //The method of the Page_Load.
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //The columns of the gridview will not generate automatically due to the datasource beacuse it is set to false.      
                GridView_Employees.AutoGenerateColumns = false;

                //The data gets binds to the gridview based on the specific options or conditions.
                BindGridViewBasedOnOption();

                //An onclick atribute is added to the HelpLinkButton that will trigger the JavaScript function "openPDF()" and the default link is disabled.
                HelpLinkButton.Attributes.Add("onclick", "openPDF(); return false;");

            }

        }


        //The DropDownList_SelectOption_SelectedIndexChanged method.
        protected void DropDownList_SelectOption_SelectedIndexChanged(object sender, EventArgs e)
        {
            //Calls the SetGridViewColumnsBasedOnSelectedOption method.
            SetGridViewColumnsBasedOnSelectedOption();

            //The data gets binds to the gridview based on the specific options or conditions.
            BindGridViewBasedOnOption();

            //The labelError will not be visible.
            LabelError.Visible = false;
        }

        //The SetGridViewColumnsBasedOnSelectedOption method.
        private void SetGridViewColumnsBasedOnSelectedOption()
        {
            // The value of the selected item is retrieved from the DropDownList named selectedOption.
            string selectedOption = DropDownList_SelectOption.SelectedValue;

            // The columns are all cleared, in the Gridview control named Gridview_Employees. 
            GridView_Employees.Columns.Clear();

            //Below is a switch case to operate different cases based on which item is selected in the dropdownlist.
            switch (selectedOption)
            {
                // The 'case' when the user selects the All Employees option from the dropdown list.
                case "All Employees":

                    // A new BoundField is created which is a class that represents the columns in the gridview for the data field PersonnelID.
                    BoundField personnelIdColumn1 = new BoundField();   //The datasource field.
                    personnelIdColumn1.DataField = "PersonnelID";       // Indicates the specific field or attribute from the data source.
                    personnelIdColumn1.HeaderText = "Personnel ID";     // Defines the text to be displayed as the title of the column.
                    GridView_Employees.Columns.Add(personnelIdColumn1); // Includes the defined column within the GridView.

                    BoundField cardNumberColumn1 = new BoundField();
                    cardNumberColumn1.DataField = "CardNumber";
                    cardNumberColumn1.HeaderText = "Card Number";
                    GridView_Employees.Columns.Add(cardNumberColumn1);
                    // The caseblock ends.
                    break;


                case "Fire Drill":

                    BoundField dateAndTimeColumn2 = new BoundField();
                    dateAndTimeColumn2.DataField = "DateAndTime";
                    dateAndTimeColumn2.HeaderText = "Date And Time";
                    GridView_Employees.Columns.Add(dateAndTimeColumn2);

                    BoundField personnelIdColumn2 = new BoundField();
                    personnelIdColumn2.DataField = "PersonnelID";
                    personnelIdColumn2.HeaderText = "Personnel ID";
                    GridView_Employees.Columns.Add(personnelIdColumn2);

                    BoundField cardNumberColumn2 = new BoundField();
                    cardNumberColumn2.DataField = "CardNumber";
                    cardNumberColumn2.HeaderText = "Card Number";
                    GridView_Employees.Columns.Add(cardNumberColumn2);

                    BoundField DeviceNameColumn2 = new BoundField();
                    DeviceNameColumn2.DataField = "DeviceName";
                    DeviceNameColumn2.HeaderText = "Device Name";
                    GridView_Employees.Columns.Add(DeviceNameColumn2);

                    BoundField eventPointColumn2 = new BoundField();
                    eventPointColumn2.DataField = "EventPoint";
                    eventPointColumn2.HeaderText = "Event Point";
                    GridView_Employees.Columns.Add(eventPointColumn2);

                    BoundField eventDescriptionColumn2 = new BoundField();
                    eventDescriptionColumn2.DataField = "EventDescription";
                    eventDescriptionColumn2.HeaderText = "Event Description";
                    GridView_Employees.Columns.Add(eventDescriptionColumn2);
                    break;


                case "In & Out":

                    BoundField dateAndTimeColumn3 = new BoundField();
                    dateAndTimeColumn3.DataField = "DateAndTime";
                    dateAndTimeColumn3.HeaderText = "Date And Time";
                    GridView_Employees.Columns.Add(dateAndTimeColumn3);

                    BoundField personnelIdColumn3 = new BoundField();
                    personnelIdColumn3.DataField = "PersonnelID";
                    personnelIdColumn3.HeaderText = "Personnel ID";
                    GridView_Employees.Columns.Add(personnelIdColumn3);

                    BoundField cardNumberColumn3 = new BoundField();
                    cardNumberColumn3.DataField = "CardNumber";
                    cardNumberColumn3.HeaderText = "Card Number";
                    GridView_Employees.Columns.Add(cardNumberColumn3);

                    BoundField eventPointColumn3 = new BoundField();
                    eventPointColumn3.DataField = "EventPoint";
                    eventPointColumn3.HeaderText = "Event Point";
                    GridView_Employees.Columns.Add(eventPointColumn3);

                    BoundField verifyTypeColumn3 = new BoundField();
                    verifyTypeColumn3.DataField = "VerifyType";
                    verifyTypeColumn3.HeaderText = "Verify Type";
                    GridView_Employees.Columns.Add(verifyTypeColumn3);


                    BoundField In_Out_StatusColumn3 = new BoundField();
                    In_Out_StatusColumn3.DataField = "In_OutStatus";
                    In_Out_StatusColumn3.HeaderText = "In/Out Status";
                    GridView_Employees.Columns.Add(In_Out_StatusColumn3);


                    BoundField eventDescriptionColumn3 = new BoundField();
                    eventDescriptionColumn3.DataField = "EventDescription";
                    eventDescriptionColumn3.HeaderText = "Event Description";
                    GridView_Employees.Columns.Add(eventDescriptionColumn3);
                    break;

                case "Late Today":
                    BoundField dateAndTimeColumn4 = new BoundField();
                    dateAndTimeColumn4.DataField = "DateandTime";
                    dateAndTimeColumn4.HeaderText = "Date And Time";
                    GridView_Employees.Columns.Add(dateAndTimeColumn4);

                    BoundField personnelIdColumn4 = new BoundField();
                    personnelIdColumn4.DataField = "PersonnelID";
                    personnelIdColumn4.HeaderText = "Personnel ID";
                    GridView_Employees.Columns.Add(personnelIdColumn4);

                    BoundField FirstLogInTimeColumn4 = new BoundField();
                    FirstLogInTimeColumn4.DataField = "FirstLogInTime";
                    FirstLogInTimeColumn4.HeaderText = "First LogIn Time";
                    GridView_Employees.Columns.Add(FirstLogInTimeColumn4);

                    BoundField lateTodayColumn = new BoundField();
                    lateTodayColumn.DataField = "LateToday";
                    lateTodayColumn.HeaderText = "Late Today";
                    GridView_Employees.Columns.Add(lateTodayColumn);
                    break;


                case "Sign In":

                    BoundField dateAndTimeColumn5 = new BoundField();
                    dateAndTimeColumn5.DataField = "DateAndTime";
                    dateAndTimeColumn5.HeaderText = "Date And Time";
                    GridView_Employees.Columns.Add(dateAndTimeColumn5);

                    BoundField personnelIdColumn5 = new BoundField();
                    personnelIdColumn5.DataField = "PersonnelID";
                    personnelIdColumn5.HeaderText = "Personnel ID";
                    GridView_Employees.Columns.Add(personnelIdColumn5);

                    BoundField cardNumberColumn5 = new BoundField();
                    cardNumberColumn5.DataField = "CardNumber";
                    cardNumberColumn5.HeaderText = "Card Number";
                    GridView_Employees.Columns.Add(cardNumberColumn5);

                    BoundField eventPointColumn5 = new BoundField();
                    eventPointColumn5.DataField = "EventPoint";
                    eventPointColumn5.HeaderText = "Event Point";
                    GridView_Employees.Columns.Add(eventPointColumn5);

                    BoundField eventDescriptionColumn5 = new BoundField();
                    eventDescriptionColumn5.DataField = "EventDescription";
                    eventDescriptionColumn5.HeaderText = "Event Description";
                    GridView_Employees.Columns.Add(eventDescriptionColumn5);
                    break;

                case "Sign Out":

                    BoundField dateAndTimeColumn6 = new BoundField();
                    dateAndTimeColumn6.DataField = "DateAndTime";
                    dateAndTimeColumn6.HeaderText = "Date And Time";
                    GridView_Employees.Columns.Add(dateAndTimeColumn6);

                    BoundField personnelIdColumn6 = new BoundField();
                    personnelIdColumn6.DataField = "PersonnelID";
                    personnelIdColumn6.HeaderText = "Personnel ID";
                    GridView_Employees.Columns.Add(personnelIdColumn6);

                    BoundField DeviceNameColumn6 = new BoundField();
                    DeviceNameColumn6.DataField = "DeviceName";
                    DeviceNameColumn6.HeaderText = "DeviceName";
                    GridView_Employees.Columns.Add(DeviceNameColumn6);

                    BoundField eventPointColumn6 = new BoundField();
                    eventPointColumn6.DataField = "EventPoint";
                    eventPointColumn6.HeaderText = "Event Point";
                    GridView_Employees.Columns.Add(eventPointColumn6);

                    BoundField verifyTypeColumn6 = new BoundField();
                    verifyTypeColumn6.DataField = "VerifyType";
                    verifyTypeColumn6.HeaderText = "Verify Type";
                    GridView_Employees.Columns.Add(verifyTypeColumn6);

                    BoundField eventDescriptionColumn6 = new BoundField();
                    eventDescriptionColumn6.DataField = "EventDescription";
                    eventDescriptionColumn6.HeaderText = "Event Description";
                    GridView_Employees.Columns.Add(eventDescriptionColumn6);
                    break;


                case "Error Records":

                    BoundField dateAndTimeColumn7 = new BoundField();
                    dateAndTimeColumn7.DataField = "DateAndTime";
                    dateAndTimeColumn7.HeaderText = "Date And Time";
                    GridView_Employees.Columns.Add(dateAndTimeColumn7);

                    BoundField DeviceNameColumn7 = new BoundField();
                    DeviceNameColumn7.DataField = "DeviceName";
                    DeviceNameColumn7.HeaderText = "DeviceName";
                    GridView_Employees.Columns.Add(DeviceNameColumn7);

                    BoundField eventPointColumn7 = new BoundField();
                    eventPointColumn7.DataField = "EventPoint";
                    eventPointColumn7.HeaderText = "Event Point";
                    GridView_Employees.Columns.Add(eventPointColumn7);

                    BoundField verifyTypeColumn7 = new BoundField();
                    verifyTypeColumn7.DataField = "VerifyType";
                    verifyTypeColumn7.HeaderText = "Verify Type";
                    GridView_Employees.Columns.Add(verifyTypeColumn7);

                    BoundField In_Out_StatusColumn7 = new BoundField();
                    In_Out_StatusColumn7.DataField = "InOutStatus";
                    In_Out_StatusColumn7.HeaderText = "In/Out Status";
                    GridView_Employees.Columns.Add(In_Out_StatusColumn7);

                    BoundField eventDescriptionColumn7 = new BoundField();
                    eventDescriptionColumn7.DataField = "EventDescription";
                    eventDescriptionColumn7.HeaderText = "Event Description";
                    GridView_Employees.Columns.Add(eventDescriptionColumn7);
                    break;

                case "All Records":

                    BoundField dateAndTimeColumn8 = new BoundField();
                    dateAndTimeColumn8.DataField = "DateAndTime";
                    dateAndTimeColumn8.HeaderText = "Date And Time";
                    GridView_Employees.Columns.Add(dateAndTimeColumn8);

                    BoundField personnelIdColumn8 = new BoundField();
                    personnelIdColumn8.DataField = "PersonnelID";
                    personnelIdColumn8.HeaderText = "Personnel ID";
                    GridView_Employees.Columns.Add(personnelIdColumn8);

                    BoundField cardNumberColumn8 = new BoundField();
                    cardNumberColumn8.DataField = "CardNumber";
                    cardNumberColumn8.HeaderText = "Card Number";
                    GridView_Employees.Columns.Add(cardNumberColumn8);

                    BoundField DeviceNameColumn8 = new BoundField();
                    DeviceNameColumn8.DataField = "DeviceName";
                    DeviceNameColumn8.HeaderText = "Device Name";
                    GridView_Employees.Columns.Add(DeviceNameColumn8);

                    BoundField eventPointColumn8 = new BoundField();
                    eventPointColumn8.DataField = "EventPoint";
                    eventPointColumn8.HeaderText = "Event Point";
                    GridView_Employees.Columns.Add(eventPointColumn8);

                    BoundField verifyTypeColumn8 = new BoundField();
                    verifyTypeColumn8.DataField = "VerifyType";
                    verifyTypeColumn8.HeaderText = "Verify Type";
                    GridView_Employees.Columns.Add(verifyTypeColumn8);

                    BoundField In_Out_StatusColumn8 = new BoundField();
                    In_Out_StatusColumn8.DataField = "InOutStatus";
                    In_Out_StatusColumn8.HeaderText = "In/Out Status";
                    GridView_Employees.Columns.Add(In_Out_StatusColumn8);

                    BoundField eventDescriptionColumn8 = new BoundField();
                    eventDescriptionColumn8.DataField = "EventDescription";
                    eventDescriptionColumn8.HeaderText = "Event Description";
                    GridView_Employees.Columns.Add(eventDescriptionColumn8);

                    BoundField RemarksColumn8 = new BoundField();
                    RemarksColumn8.DataField = "Remarks";
                    RemarksColumn8.HeaderText = "Remarks";
                    GridView_Employees.Columns.Add(RemarksColumn8);
                    break;


                default:
                    break;
            }
        } // Switch case ends.

        // The method for Btn_employeeID_Click.
        protected void Btn_employeeID_Click(object sender, EventArgs e)
        {
            /*Below is the if else statements for the Search Employee button.
            
            If the Textbox TextBox_EmployeeID is empty, 
            and the user clicks on the Search Employee button,
            the error message of Please enter Personnel ID!!!will display
            in the LabelError label.*/
            if (string.IsNullOrEmpty(TextBox_EmployeeID.Text))
            {
                //The end-user will see the label if an error event is triggered. 
                LabelError.Visible = true;

                //The error message that will appear in the Label called LabelError.
                LabelError.Text = "Please enter Personnel ID!!!";
            }

            /*Below condition will happen if above does not happen.*/
            else
            {
                //The end-user will not see the label unless an error event is triggered. 
                LabelError.Visible = false;

                // The method FilterRecordsByEmployeeIDAndDate is called within the Btn_employeeID_Click method.
                FilterRecordsByEmployeeID();
            }
        }


        // The method, GridView_Employees_SelectedIndexChanged.
        protected void GridView_Employees_SelectedIndexChanged(object sender, EventArgs e)
        {
            // The Gridview_Employees is checked to see if a row is selected. 
            if (GridView_Employees.SelectedRow != null)
            {
                // The position of the cell is defined that holds the employee identification number within the chosen row.
                int personnelIdIndex = 2;
                // The employee identification number is obtained from the cell in the chosen row based on the provided index.
                string personnelId = GridView_Employees.SelectedRow.Cells[personnelIdIndex].Text;

            }
        }

        //This method will bind data to the gridview based on the selected options in the dropdownlist.
        private void BindGridViewBasedOnOption()
        {
            //The selected value is retrieved from the Dropdownlist.
            string selectedOption = DropDownList_SelectOption.SelectedValue;
            //The connection string is established to connect to the SQL database.
            string connectionString = ConfigurationManager.ConnectionStrings["Optimi_CollegeConnectionString"].ConnectionString;

            //Below is a switch case code to switch between the selected options in the dropdownlist.
            try
            {
                //Database connection to SQL is established.
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    //The connection is opened.
                    connection.Open();
                    // Set up a blank string variable for queries and create a list to store dynamic objects.
                    string query = string.Empty;
                    var employees = new List<dynamic>();


                    //The query to be executed is determined based on the selectedOption.
                    switch (selectedOption)
                    {
                        //The queries are specified to correspond to various options.
                        //Below all the stored procedures are called from SQL Database.
                        case "All Employees":
                            query = "EXEC AllEmployees";
                            break;
                        case "Fire Drill":
                            query = "EXEC FireDrill";
                            break;
                        case "In & Out":
                            query = "EXEC EmployeeInAndOut";
                            break;
                        case "Late Today":
                            query = "EXEC LateEmployees";
                            break;
                        case "Sign In":
                            query = "EXEC EmployeeSignIn";
                            break;
                        case "Sign Out":
                            query = "EXEC EmployeeSignOut";
                            break;
                        case "Error Records":
                            query = "EXEC ErrorRecords";
                            break;
                        case "All Records":
                            query = "EXEC ShowAllRecords";
                            break;

                        default:
                            break;
                    }

                    // The query needs to run if it contains valid content.
                    if (!string.IsNullOrEmpty(query))
                    {
                        //Run the query and get information into the 'employees' list.
                        employees = connection.Query(query).ToList();
                    }
                    //Use the collected information to fill up the GridView and display it.
                    GridView_Employees.DataSource = employees;
                    GridView_Employees.DataBind();
                }
            }
            catch (Exception ex)
            {
                //If something goes wrong, show the error message on the LabelError area.
                // ""Error: " + ex.Message;" If any error occurs the error, followed by the message will display to the user.
                LabelError.Visible = true;
                LabelError.Text = "Error: " + ex.Message;
            }
        }


        /*This method, FilterRecordsByEmployeeIDAndDate filters data in the GridView_Employees based on the 
         * user-provided personnel ID and, optionally, the date ranges as well.
         * It verifies the presence of an personnel ID, validates it, searches 
         * and filters data in the GridView_Employees accordingly, handles date range filtering, 
         * and manages error messages for invalid inputs.
        */
        private void FilterRecordsByEmployeeID()
        {
            // Check if the TextBox_EmployeeID is empty.
            if (string.IsNullOrEmpty(TextBox_EmployeeID.Text))
            {
                // An error message of "Please enter a Personnel ID!!!" will show if user did not entered personnel ID in the textbox.
                LabelError.Visible = true;
                LabelError.Text = "Please enter a Personnel ID!!!";

                // The method stops the execution as the personnel ID  is empty.
                return;
            }

            // The Textbox_EmployeeID is checked for an input and perform a filtering logic if it's not empty.
            string selectedOption = DropDownList_SelectOption.SelectedValue;
            string connectionString = ConfigurationManager.ConnectionStrings["Optimi_CollegeConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                int employeeId;
                // The entered text is converted to an integer if its possible.
                if (int.TryParse(TextBox_EmployeeID.Text, out employeeId))
                {
                    // The column index for the personnel ID is retrieved. 
                    int personnelIdIndex = GetPersonnelIdColumnIndex(); // This method is below the FilterRecordsByEmployeeIDAndDate method.

                    // If the index, personnel ID is found.
                    if (personnelIdIndex >= 0)
                    {
                        // The Loop will go through each row in the Gridview_Employees. 
                        foreach (GridViewRow row in GridView_Employees.Rows)
                        {
                            // The row is checked to see if it contains data.
                            if (row.RowType == DataControlRowType.DataRow)
                            {
                                // The text of the Personnel ID cell is retrieved in the existing row.
                                string personnelIdCellText = row.Cells[personnelIdIndex].Text;

                                //The row will be visible if the personnel ID matches, if not, the row will be hidden.
                                if (personnelIdCellText == TextBox_EmployeeID.Text)
                                {
                                    row.Visible = true;
                                }
                                else
                                {
                                    row.Visible = false;
                                }
                            }
                        }
                    }

                    // The LabelError will be hidden after the search.
                    LabelError.Visible = false;

                    //Available dates are checked before the records are filtered by the date range. 
                    if (!string.IsNullOrEmpty(TextBox_StartDate.Text) && !string.IsNullOrEmpty(TextBox_EndDate.Text))
                    {
                        FilterRecordsByDateRange(); // The method FilterRecordsByDateRange is called if above happens.
                    }
                }
                else
                {
                    // An error message for an invalid personnel ID will show in the LabelError.
                    LabelError.Visible = true;
                    LabelError.Text = "Please enter a valid Employee ID!!!";
                }
            }
        }


        /*This is the method, GetPersonnelIdColumnIndex. This code tries to find where the column 
         * with the label "Personnel ID" is in the table. It checks each column name until it finds 
         * the one called "Personnel ID". If it finds it, it will tells us where it is. If it doesn't 
         * find it at all, it says it's not there by giving a number (-1) that means "nowhere."*/
        private int GetPersonnelIdColumnIndex()
        {
            // The personnelID column index is defined in the Gridview_Employees.
            int personnel_ID_Index = -1;

            // A loop runs through each column in the Gridview_Employees to find the personnel ID column.
            for (int x = 0; x < GridView_Employees.Columns.Count; x++)
            {
                // The column header text is checked to see if it matches the "Personnel ID".
                if (GridView_Employees.Columns[x].HeaderText == "Personnel ID")
                {
                    // If there is a match, an index "x" will be assigned to personnel_ID_Index.
                    personnel_ID_Index = x;
                    //The loop will exit if the index is found.
                    break;
                }
            }

            // The index of the Personnel ID column is return if the -1 is not found.
            return personnel_ID_Index;
        }




        // This method, TextBox_StartDate_TextChanged is called when the text in the textbox, TextBox_StartDate changes.
        protected void TextBox_StartDate_TextChanged(object sender, EventArgs e)
        {
            FilterRecordsByDateRange(); // The method, FilterRecordsByDateRange is called to filter records based on the date range.
        }

        // This method, FilterRecordsByDateRange is called when the text in the textbox, TextBox_EndDate changes.
        protected void TextBox_EndDate_TextChanged(object sender, EventArgs e)
        {
            FilterRecordsByDateRange(); // The method, FilterRecordsByDateRange is called to filter records based on the date range.
        }

        // The GridView_Employees is checked to see if it is empty or has no rows.
        private bool CheckIfGridIsEmpty()
        {
            return GridView_Employees.Rows.Count == 0; // It will return true, if the GridView_Employees has no rows, otherwise it will be returned false.
        }

        // This method, Btn_Search_Click will be executed, when the Search button is clicked.
        protected void Btn_Search_Click(object sender, EventArgs e)
        {
            // The textbox, TextBox_StartDate and textbox, TextBox_EndDate are checked to see if its empty. 
            if (string.IsNullOrWhiteSpace(TextBox_StartDate.Text) || string.IsNullOrWhiteSpace(TextBox_EndDate.Text))
            {
                LabelError.Visible = true;
                LabelError.Text = "Please enter both Start and End dates!!!"; // The error message will show in the LabelError if dates are missing.
            }

            // The gridview, Gridview_Employees will be checked to see if its empty.
            else if (CheckIfGridIsEmpty())
            {
                LabelError.Visible = true;
                LabelError.Text = "No data Selected!!!"; // The error message will show in the LabelError if there is no data in the GridView, Gidview_Employees.
            }

            //The code checks, if no option is selected in the dropdown, DropDownList_SelectOption.
            else if (DropDownList_SelectOption.SelectedIndex == 0)
            {
                LabelError.Visible = true;
                LabelError.Text = "Please select Personnel ID!!!"; // The error message will show in the LabelError if no option is selected.
            }
            else
            {
                FilterRecordsByDateRange(); // The method FilterRecordsByDateRange is called based on the above conditions.
            }
        }



        /* 
        This method, FilterRecordsByDateRange filters and displays records in the Gridview_Employees based on the user-entered dates.
        It retrieves the start and end dates from TextBox inputs.
        These dates are parsed into a specific format ("yyyy-MM-dd").
        It then iterates through each row in the GridView_Employees, checking if it's a visible data row.

        Thereafter, it retrieves the date and time from the first cell of each row, 
        parsing it into a specific format ("dd MMM yyyy HH:mm:ss").
        It will then Determine if the record's date falls within the specified date range.
        The row's visibility is adjusted, based on whether the date falls within the correct range.
        Hides the error label if the dates are parsed correctly; otherwise, displays an error for an incorrect date format.
        */
        private void FilterRecordsByDateRange()
        {
            string Start_Date_Text = TextBox_StartDate.Text; // This code will retrieve the start date from the TextBox, Textbx_StartDate.
            string End_Date_Text = TextBox_EndDate.Text; // This code will retrieve the end date from the TextBox, Textbx_EndDate.

            DateTime Start_Date; // A DateTime variable, Start_Date is Initialized to store the parsed start date.
            DateTime End_Date; // A DateTime variable, End_Date, is Initialized to store the parsed end date.

            try
            {
                // This code will try to parse the start and end dates using a specific date format.
                if (DateTime.TryParseExact(Start_Date_Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out Start_Date) &&
                    DateTime.TryParseExact(End_Date_Text, "yyyy-MM-dd", CultureInfo.InvariantCulture, DateTimeStyles.None, out End_Date))
                {
                    // The foreach loop to go through each row in the GridView_Employees.
                    foreach (GridViewRow row in GridView_Employees.Rows)
                    {
                        // This code checks if the row is a data row and currently visible.
                        if (row.RowType == DataControlRowType.DataRow && row.Visible)
                        {
                            string Date_And_Time = row.Cells[0].Text; // This code retrieves the date and time from the first cell in the row.
                            DateTime Record_Date; // A DateTime variable, Record_Date, is Initialized to store the parsed end date.

                            // This code tries to parse the date and time from the cell using a specific date format.
                            if (DateTime.TryParseExact(Date_And_Time, "dd MMM yyyy HH:mm:ss", CultureInfo.InvariantCulture, DateTimeStyles.None, out Record_Date))
                            {
                                // The code checks if the record's date falls within the specified date range.
                                bool DateIsInRange = (Record_Date >= Start_Date && Record_Date <= End_Date.AddDays(1).AddTicks(-1));
                                row.Visible = DateIsInRange; // The code sets the row visibility based on whether it falls within the date range.
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // If there is an error, the LabelError will show the error message.
                // Thhe error message will be visible to the user.
                LabelError.Visible = true;
                LabelError.Text = "Error: " + ex.Message;
            }
        }


        /**
        * This method, Btn_Export_Click is responsible for the export functionality 
        * triggered once the Export button, Btn_Export is clicked. It will generate an Excel
        * file based on the data present in the GridView_Employees.
        * If the GridView contains rows, it will start the file download. If not, it will displays an error message.
        */
        protected void Btn_Export_Click(object sender, EventArgs e)
        {
            if (GridView_Employees.Rows.Count > 0)
            {
                // The response buffer is cleared and prepared for the file to be downloaded.
                Response.Clear();
                Response.Buffer = true;
                Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
                Response.Charset = "";
                Response.ContentType = "application/vnd.ms-excel";

                // StringWriter and HtmlTextWriter is started to chagne the GridView_Employees content to Excel.
                using (StringWriter sw = new StringWriter())
                {
                    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
                    {
                        GridView_Employees.RenderControl(hw); // This code changes the GridView_Employee content to the StringWriter.
                        Response.Output.Write(sw.ToString()); // This code writes content of the StringWriter to Response.
                        Response.Flush(); // Flushes the content from the buffer.
                        Response.End(); // The response is ended after sending the file.
                    }
                }

                // The client-side script(javascript) is executed to show the file downloaded message.
                ClientScript.RegisterStartupScript(this.GetType(), "DisplayFileDownloadedMessage", "showFileDownloadedMessage();", true);

                // Any error messages are hidden and the downloaded file message is displayed.
                downloadMessage.Style["display"] = "none";
                errorMessage.Style["display"] = "none";
            }
            else
            {
                // The rror message is shown and other messages are hidden. 
                errorMessage.Style["display"] = "block";
                downloadMessage.Style["display"] = "none";
                fileDownloadedMessage.Style["display"] = "none";
            }
        }


        /*
        * This method, 'VerifyRenderingInServerForm', is an overridden function. 
        * It's an essential method to avoid errors related to the rendering of 
        * server controls within the form tag context, to make sure they display correctly 
        * on the web page.
        */
        public override void VerifyRenderingInServerForm(Control control)
        {
            // This method makes sure that server controls are shown correctly within a specific form area. If removed an error occurs.
        }

        //This is the method, Btn_Refresh_Click for the Refresh button. 
        protected void Btn_Refresh_Click(object sender, EventArgs e)
        {
            // Redirects the user to the current page URL to refresh the content.
            Response.Redirect(Request.Url.AbsoluteUri);
        }

        //This is the method, HelpLinkButton_Click for the HelpLinkButton button. 
        protected void HelpLinkButton_Click(object sender, EventArgs e)
        {
            // The text of the HelpLinkButton is changed to "Help".
            HelpLinkButton.Text = "Help";
        }

    }
}
