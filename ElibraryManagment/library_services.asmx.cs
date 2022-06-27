using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Contexts;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;

namespace ElibraryManagment
{
    /// <summary>
    /// Summary description for library_services
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class library_services : System.Web.Services.WebService
    {
        JavaScriptSerializer js = new JavaScriptSerializer();
        #region InsertbookInfo
        [WebMethod]
        [ScriptMethod (ResponseFormat = ResponseFormat.Json)]

        public void InsertAndUpdate_bookInfo(string insertObject)
        {
            book bookdata = JsonConvert.DeserializeObject<book>(insertObject);

            using (SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("InsertUpdateBookInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@cmdType", SqlDbType.VarChar).Value = bookdata.Bookid == 0 ? "NEW" : "UPDATE";
                cmd.Parameters.Add("@bookid", SqlDbType.Int).Value = bookdata.Bookid;
                cmd.Parameters.Add("@writerid", SqlDbType.Int).Value = bookdata.Writerid;
                cmd.Parameters.Add("@bookcategory", SqlDbType.VarChar).Value = bookdata.Bookcategory;
                cmd.Parameters.Add("@bookname", SqlDbType.VarChar).Value = bookdata.Bookname;
                cmd.Parameters.Add("@bookprice", SqlDbType.Decimal).Value = bookdata.Bookprice;
                con.Open();

                if (cmd.ExecuteNonQuery() > 0)
                {
                    Context.Response.Write(js.Serialize("Inserted"));
                }
                else
                {
                    Context.Response.Write(js.Serialize("Invalid"));
                }
            }
        }
        #endregion

        #region InsertWriterInfo
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]

        public void InsertAndUpdate_WriterInfo(string insertObject) {

            writer writerdata = JsonConvert.DeserializeObject<writer>(insertObject);

            using(SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("InsertUpdateWriterInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@cmdType", SqlDbType.VarChar).Value = writerdata.Writerid == 0 ? "NEW" : "UPDATE";
                cmd.Parameters.Add("@writerid", SqlDbType.Int).Value = writerdata.Writerid;
                cmd.Parameters.Add("@writername", SqlDbType.VarChar).Value = writerdata.Writername;
                cmd.Parameters.Add("@contact", SqlDbType.VarChar).Value = writerdata.Contact;
                cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = writerdata.Email;
                cmd.Parameters.Add("@writeraddress", SqlDbType.VarChar).Value = writerdata.Address;
                con.Open();

                if (cmd.ExecuteNonQuery() > 0)
                {
                    Context.Response.Write("Inserted");
                }
                else
                {
                    Context.Response.Write("Invalid");
                }

            }
        }

        #endregion

        #region booktableShow
        [WebMethod]
        [ScriptMethod (ResponseFormat = ResponseFormat.Json)]

        public void GetBookTableInfo()
        {
            List<bookTable> listdata = new List<bookTable>();
            using (SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("GetBookInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    bookTable obj = new bookTable();
                    obj.bookid = Convert.ToInt32(rdr["bookID"]);
                    obj.bookcategory = rdr["bookCategory"].ToString();
                    obj.bookname = rdr["bookName"].ToString();
                    obj.writerid = Convert.ToInt32(rdr["writerID"]);
                    obj.writername = rdr["writerName"].ToString();
                    obj.price = Convert.ToDecimal(rdr["bookPrice"]);
                    listdata.Add(obj);

                }
            }
            Context.Response.Write(js.Serialize(listdata));
        }

        #endregion

        #region GetWriterTableInfo
        
        [WebMethod]
        [ScriptMethod (ResponseFormat = ResponseFormat.Json)]

        public void GetWriterTableInfo()
        {
            List<WriterTable> listdata = new List<WriterTable>();
            using (SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("GetWriterInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    WriterTable obj = new WriterTable();
                    obj.writerid = Convert.ToInt32(rdr["writerID"]);
                    obj.writername = rdr["writerName"].ToString();
                    obj.contact = rdr["contact"].ToString();
                    obj.email = rdr["email"].ToString();
                    obj.writeraddress = rdr["writerAddress"].ToString();
                    listdata.Add(obj);
                }
            }
            Context.Response.Write(js.Serialize(listdata));

        }

        #endregion

        #region ViewBookTable

        [WebMethod]
        [ScriptMethod (ResponseFormat= ResponseFormat.Json)]

        public void GetElibraryAll_Info()
        {
            List<bookView> listdata = new List<bookView>();
            using(SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("GetAllElibraryInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    bookView obj = new bookView();
                    obj.writername = rdr["writerName"].ToString();
                    obj.bookname = rdr["bookName"].ToString();
                    obj.bookcategory = rdr["bookCategory"].ToString();
                    obj.price = Convert.ToDecimal(rdr["bookPrice"]);
                    obj.contact = rdr["contact"].ToString();
                    obj.email = rdr["email"].ToString();
                    obj.address = rdr["writerAddress"].ToString();
                    listdata.Add(obj);

                }
                
            }
            Context.Response.Write(js.Serialize(listdata));
        }

        #endregion

        #region DeleteBookTableData
        [WebMethod]
        [ScriptMethod (ResponseFormat = ResponseFormat.Json)]

        public void DeletedBook(int bookid)
        {
            using(SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("DeletedBookInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = bookid;
                con.Open();
                if(cmd.ExecuteNonQuery()> 0)
                {
                    Context.Response.Write(js.Serialize("Deleted"));
                }
                else
                {
                    Context.Response.Write(js.Serialize("Invalid"));
                }
            }
        }

        #endregion

        [WebMethod]
        [ScriptMethod (ResponseFormat = ResponseFormat.Json)]

        public void DeleteWriter(int writerid)
        {
            using(SqlConnection con = new SqlConnection(DbConnection.DataBaseConnection))
            {
                SqlCommand cmd = new SqlCommand("DeletedWriterInfo", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@id", SqlDbType.Int).Value = writerid;
                con.Open();
                if(cmd.ExecuteNonQuery()> 0)
                {
                    Context.Response.Write(js.Serialize("Deleted"));
                }
                else
                {
                    Context.Response.Write(js.Serialize("Invalid"));
                }
            }
        }



    }

}
