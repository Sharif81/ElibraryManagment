using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ElibraryManagment
{
    public partial class bookInfo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                GetAllWriterId();
            }
        }

        private void GetAllWriterId()
        {
            SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection);
            SqlCommand cmd = new SqlCommand("GetAllWriterId", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                writername.DataSource = rdr;
                writername.DataValueField = "WriterID";
                writername.DataTextField = "WriterName";
                writername.DataBind();
                writername.Items.Insert(0, new ListItem("Select Writer Name", "0"));
            }
            else
            {
                writername.DataSource = null;
                writername.DataBind();
                writername.Items.Insert(0, new ListItem("Select Writer Name", "0"));
            }
        }
    }
}