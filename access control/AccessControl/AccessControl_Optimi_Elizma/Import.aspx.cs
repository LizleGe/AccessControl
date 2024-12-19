using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Data.OleDb;
using Dapper;

namespace Access_Control_Elizma
{
    public partial class Import : System.Web.UI.Page
    {
        // This is the method of Page_Load which is triggered when the webpage is loaded.
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        // In the code below is a private property that holds a DataTable related to the Excel data. 
        private DataTable ExcelDataTable
        {
            // This code checks if the "ViewState" contains any data for the Excel DataTable.
            get
            {
                // If there is data that can be stored in the "ViewState" for Excel, it will be retrieved and returned as a DataTable.
                if (ViewState["ExcelData"] != null)
                {
                    return (DataTable)ViewState["ExcelData"];
                }
                // When there is no data in the ""viewstate, it will return null.
                return null;
            }
            // This code sets the value of the Excel DataTable in the ViewState.
            set
            {
                // It will store the DataTable in the ViewState for later retrieval.
                ViewState["ExcelData"] = value;
            }
        }


        //This method, HideColumnsByName hides a column by a name. This is to hide the name and surname of the employees for the POPI Act. 
        private void HideColumnsByName(string columnName)
        {
            // The code below will check, if the spesific column exist in the Gridview, GridView_upload.
            if (GridView_upload.HeaderRow.Cells.Cast<TableCell>().Any(cell => cell.Text.ToLower() == columnName.ToLower()))
            {
                //The index of the column is retrieved. 
                int columnIndex = GridView_upload.HeaderRow.Cells.GetCellIndex(GridView_upload.HeaderRow.Cells
                    .Cast<TableCell>()
                    .First(cell => cell.Text.ToLower() == columnName.ToLower()));

                // The column will be hidden in HeaderRow.
                GridView_upload.HeaderRow.Cells[columnIndex].Visible = false;

                // The column will be hidden in the DataRows
                foreach (GridViewRow row in GridView_upload.Rows)
                {
                    // Hide the respective cell in each row
                    row.Cells[columnIndex].Visible = false;
                }
            }
        }



        /* This method, Btn_Import_Click will import an excel file to the SQL Server Database.
            The data from an ExcelDataTable will be imported to an SQL Server database.
            It checks for the columns named "First Name" and "Last Name" in the Excel data,
            and removes them if they are present. A connection to the SQL Server is made and 
            then the ExcelDataTable data will be imported to the SQL. It also executes stored 
            procedures to manage data in the SQL Server, and updates the labels to show 
            success or error messages based on the process outcome*/

        protected void Btn_Import_Click(object sender, EventArgs e)
        {
            // The code checks if there is data in the ExcelDataTable.
            if (ExcelDataTable != null && ExcelDataTable.Rows.Count > 0)
            {
                try
                {
                    // The columns are checked and then removed if the specified name columns are present.
                    if (ExcelDataTable.Columns.Contains("First Name"))
                    {
                        ExcelDataTable.Columns.Remove("First Name");
                    }
                    if (ExcelDataTable.Columns.Contains("Last Name"))
                    {
                        ExcelDataTable.Columns.Remove("Last Name");
                    }

                    // A connection is established to SQL Server using the connection string from the configuration file.
                    string connectionString = ConfigurationManager.ConnectionStrings["Optimi_CollegeConnectionString"].ConnectionString;
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Open(); // The connection is opened to SQL connection

                        // The SQL Bulk Copy object is created to efficiently write data to SQL Server
                        using (SqlBulkCopy bulkCopy = new SqlBulkCopy(connection))
                        {
                            //The destination SQL table is specified. 
                            bulkCopy.DestinationTableName = "ImportEmployee"; 

                            // The data from ExcelDataTable to the designated SQL table is written. 
                            bulkCopy.WriteToServer(ExcelDataTable);
                        }

                        // The stored procedures are executed in the SQL Server to manage the data when its imported.
                        connection.Execute("DeleteDuplicateRecords", commandType: CommandType.StoredProcedure);
                        connection.Execute("ImportAndSortEmployeeRecords", commandType: CommandType.StoredProcedure);
                    }

                    // The label is updated to indicate successful data upload to the SQL Server.
                    Lbl_Success.Visible = true;
                    Lbl_Success.Text = "Data uploaded successfully to SQL Server!";
                    

                    // The Lbl.Error label will be hidden if it was previously shown.
                    Lbl_Error.Visible = false;
                }
                catch (Exception ex)
                {
                    // Exception handling is done by displaying an error messages in the label.
                    Lbl_Error.Visible = true;
                    Lbl_Error.Text = "Error occurred while uploading data: " + Server.HtmlEncode(ex.Message);


                    // The Lbl.Success label will be hidden if it was previously shown.
                    Lbl_Success.Visible = false;
                }
            }
            else
            {
                // An error message will be displayed if there is no data in ExcelDataTable to upload.
                Lbl_Error.Visible = true;
                Lbl_Error.Text = "No data to upload to SQL Server.";


                // The Lbl.Success label will be hidden if it was previously shown.
                Lbl_Success.Visible = false;
            }
        }



        /* This method Btn_Load_Click will be responsible for the upload 
            functionality for an Excel file to be displayed in a gridview. 
            It will check if a file has been selected, then it will verify the file extension.
            It then saves it to the server, reads the Excel data into a DataTable,
            binds the DataTable to the GridView(GridView_upload), hides specific 
            columns ("First Name" and "Last Name"), and 
            displays error messages based on the file upload status*/

        protected void Btn_Load_Click(object sender, EventArgs e)
        {
            // The success label is hidden on the file submission attempt.
            Lbl_Success.Visible = false;

            // The code verifies if the file has been uploaded.
            if (FileUpload_Excel.HasFile)
            {
                try
                {
                    string fileName = Path.GetFileName(FileUpload_Excel.FileName);
                    string fileExtension = Path.GetExtension(fileName);
                    string fileLocation = Server.MapPath("~") + fileName;

                    // The file is checked to see if it has the correct extention.
                    if (fileExtension == ".xls" || fileExtension == ".xlsx")
                    {
                        FileUpload_Excel.SaveAs(fileLocation);

                        // The excel file is read into a DataTable using OleDb.
                        DataTable d_table = ReadExcelFile(fileLocation);

                        // The DataTable is checked to see if it contains data after reading the Excel file.
                        if (d_table != null && d_table.Rows.Count > 0)
                        {
                            ExcelDataTable = d_table; // The DataTable is stored in a property
                                                 // The data gets bind to the datatable
                            GridView_upload.DataSource = ExcelDataTable;
                            GridView_upload.DataBind();

                            // After binding , the specified columns ("First Name" and "Last Name") are hidden.
                            HideColumnsByName("First Name");
                            HideColumnsByName("Last Name");

                            // Hide the error label after successful file processing
                            Lbl_Error.Visible = false;
                        }
                        else
                        {
                            // Display an error if no data found in the Excel file or an issue occurred while reading
                            Lbl_Error.Visible = true;
                            Lbl_Error.Text = "No data found in the Excel file or an error occurred while reading!!!";

                            // The Lbl.Success label will be hidden if it was previously shown.
                            Lbl_Success.Visible = false;
                        }
                    }
                    else
                    {
                        // An error message will be shown for an invalid file format (only Excel files are allowed!!).
                        Lbl_Error.Visible = true;
                        Lbl_Error.Text = "Only Excel files are allowed!!!";

                        // The Lbl.Success label will be hidden if there was an error.
                        Lbl_Success.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    // An error message will be shown if an error occurs with the specified error plus the message.
                    Lbl_Error.Visible = true;
                    Lbl_Error.Text = "Error occurred: " + ex.Message;

                    // The Lbl.Success label will be hidden if there is an error.
                    Lbl_Success.Visible = false;
                }
            }
            else
            {
                // An error message will be shown for an invalid file format (Please select an Excel file to upload!!!).
                Lbl_Error.Visible = true;
                Lbl_Error.Text = "Please select an Excel file to upload!!!";

                // The Lbl.Success label will be hidden if there is an error.
                Lbl_Success.Visible = false;
            }
        }




        // This is the method, GridView_upload_SelectedIndexChanged, that handles the event when a selection change occurs in the GridView_upload control.
        protected void GridView_upload_SelectedIndexChanged(object sender, EventArgs e)
        {
            // The data source of the GridView_upload is set to the ExcelDataTable.
            GridView_upload.DataSource = ExcelDataTable;

            // The data from the ExcelDataTable is bound to the GridView_upload.
            GridView_upload.DataBind();
        }


      
        //This is a method called, ReadExcelFile that will read the data from the Excel file and store it into a Datatable.
        private DataTable ReadExcelFile(string filePath)
        {
            DataTable Data_Table = new DataTable(); // An empty DataTable is created to store the Excel file.

            string Connection_String = ""; // An empty string is started to hold the connection string.
            string File_Extension = Path.GetExtension(filePath); // The file extension of the provided file path is taken.

            // The file extension of the Excel file type is checked and set the appropriate connection string.
            if (File_Extension == ".xls")
            {
                // For the Excel 97-2003 format (.xls)
                Connection_String = $"Provider=Microsoft.Jet.OLEDB.4.0;Data Source={filePath};Extended Properties='Excel 8.0;HDR=YES;'";
            }
            else if (File_Extension == ".xlsx")
            {
                // For the Excel 2007 and later (.xlsx)
                Connection_String = $"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={filePath};Extended Properties='Excel 12.0;HDR=YES;'";
            }

            // The OleDbConnection is used to establish a connection to the Excel file.
            using (OleDbConnection connection = new OleDbConnection(Connection_String))
            {
                connection.Open(); // The connection to the Excel file is opened.

                // The schema information is retrieved about the tables, within the Excel file
                DataTable schema = connection.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);

                // The schema information is checked to see if it is available and contains tables.
                if (schema != null && schema.Rows.Count > 0)
                {
                    // The name of the first sheet in the Excel file is retrieved. 
                    string sheetview = schema.Rows[0]["TABLE_NAME"].ToString();

                    // The OleDbDataAdapter is used to fetch the data from the specified sheet in the Excel file.
                    OleDbDataAdapter adapter = new OleDbDataAdapter($"SELECT * FROM [{sheetview}]", connection);

                    // The DataTable 'Data_Table' is filled with the data retrieved from the Excel sheet.
                    adapter.Fill(Data_Table);
                }
            }

            return Data_Table; // The populated DataTable containing Excel data is returned.
        }


        //This is the method, Btn_ResfreshImport_Click that will start once the refresh button is clicked. 
        protected void Btn_ResfreshImport_Click(object sender, EventArgs e)
        {
            Response.Redirect(Request.RawUrl);// The current page is refreshed by redirecting to the original request URL if the refresh button is clicked.
        }


        // The method, HelpLinkButton_Click that iniates once the user clicks on the Help button. 
        protected void HelpLinkButton_Click(object sender, EventArgs e)
        {
            HelpLinkButton.Text = "Help"; // If the user clicks on the help button it will open the pdf file. 
        }
    }
}