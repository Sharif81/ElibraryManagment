using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElibraryManagment
{
    public class book
    {
        public int Bookid { get; set; }
        public int Writerid { get; set; }
        public string Bookcategory { get; set; }
        public string Bookname { get; set; }
        public decimal Bookprice { get; set; }
    }
}