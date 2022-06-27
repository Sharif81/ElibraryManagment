using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ElibraryManagment
{
    public class bookTable
    {
        public int bookid { get; set; }
        public string bookcategory { get; set; }
        public string bookname { get; set; }
        public int writerid { get; set; }
        public string writername { get; set; }
        public decimal price { get; set; }
    }
}