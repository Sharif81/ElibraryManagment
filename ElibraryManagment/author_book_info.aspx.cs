using ElibraryManagment.datasets;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ElibraryManagment
{
    public partial class author_book_info : System.Web.UI.Page
    {
        Bookdataset writer_ds = new Bookdataset();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GetAllWriter();
            }
        }

        private void GetAllWriter()
        {
            using (SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("GetAllWriterID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                if (rdr.HasRows)
                {
                    Writerlist.DataSource = rdr;
                    Writerlist.DataValueField = "WriterID";
                    Writerlist.DataTextField = "WriterName";
                    Writerlist.DataBind();
                    Writerlist.Items.Insert(0, new ListItem("Select Writer Name", "0"));
                }
                else
                {
                    Writerlist.DataSource = null;
                    Writerlist.DataBind();
                    Writerlist.Items.Insert(0, new ListItem("Select Writer Name", "0"));
                }
            }
        }

        protected void show_writerBooksInfo(object sender, EventArgs e)
        {
            int writerid = Convert.ToInt32(Writerlist.SelectedItem.Value);

            Bookdataset ws = Get_report_data(writerid);

            WriterRV.ProcessingMode = ProcessingMode.Local;
            WriterRV.SizeToReportContent = true;
            WriterRV.Width = Unit.Percentage(100);

            WriterRV.Height = Unit.Percentage(100);
            WriterRV.ZoomMode = ZoomMode.Percent;
            WriterRV.ZoomPercent = 100;
            WriterRV.ShowZoomControl = true;
            WriterRV.BackColor = System.Drawing.Color.DeepSkyBlue;

            foreach (RenderingExtension extension in WriterRV.LocalReport.ListRenderingExtensions())
            {
                if (extension.Name == "IMAGE" || extension.Name == "WORD" || extension.Name == "Excel")
                {
                    FieldInfo fi = extension.GetType().GetField("m_isVisible", BindingFlags.Instance | BindingFlags.NonPublic);
                    fi.SetValue(extension, false);
                }
            }

            WriterRV.LocalReport.DataSources.Clear();
            WriterRV.LocalReport.DataSources.Add(new ReportDataSource("writerds", ws.Tables[0]));
            WriterRV.LocalReport.ReportPath = Server.MapPath("~/reports/writer_book_report_template.rdlc");

        }

        private Bookdataset Get_report_data(int writerid)
        {
            using (SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("GetAllElibraryInfoBywriterid", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@writerid", SqlDbType.Int).Value = writerid;
                con.Open();
                try
                {
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(writer_ds, writer_ds.Book_info.ToString());
                    return writer_ds;
                }
                catch (Exception)
                {

                    throw;
                }
            }

        }


    }
}