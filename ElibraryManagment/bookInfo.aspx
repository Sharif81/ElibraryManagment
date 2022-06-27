<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="bookInfo.aspx.cs" Inherits="ElibraryManagment.bookInfo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    


    <style>
        #book-info {
            margin-top: 80px;
        }

        #btn-submit {
            margin-top: 30px;
        }

        #book-table {
            margin-top: 30px;
           
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <section id="book-info">
        <div class="container-fluid">
            <div class="row">               
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="book">Book Category</label>
                        <select id="bookcategory" class="form-control form-control-md">
                            <option value="na">Select Book Category</option>
                            <option value="Computer Science & Engineering">Computer Science & Engineering</option>
                            <option value="Electrical Engineering">Electrical Engineering</option>
                            <option value="Electronics Engineering">Electronics Engineering</option>
                            <option value="Civil Engineering">Civil Engineering</option>
                            <option value="Mechanical Engineering">Mechanical Engineering</option>
                            <option value="Power Engineering">Power Engineering</option>
                            <option value="Environment Engineering">Environment Engineering</option>
                            <option value="Marine Engineering">Marine Engineering</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="bookname">Book Name</label>
                        <input type="text" class="form-control" id="bookname" placeholder="Enter your book name">
                    </div>
                </div>
                 <div class="col-md-2">
                    <div class="form-group">
                        <label for="writername">Writer Name</label>                       
                         <asp:DropDownList runat="Server" CssClass="form-control" ClientIDMode="Static" ID="writername"></asp:DropDownList>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group">
                        <label for="bookprice">Book Price</label>
                        <input type="text" class="form-control" id="bookprice" placeholder="Enter your book price">
                    </div>
                </div>
                <div class="col-md">
                    <div class="form-group">
                        <button type="button" data-id="0" class="btn btn-success form-control" id="btn-submit"><i class="fa-solid fa-square-plus"></i> Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="book-table">
        <div class="container-fluid">
            <div class="col-md-12">
                <table class="table table-bordered table-hover text-center" id="show-book-table">
                    <thead class="bg-info">
                        <tr>
                            <th class="text-center">SL#</th>
                            <th class="text-center">Book ID</th>
                            <th class="text-center">Book Category</th>
                            <th class="text-center">Book Name</th>
                            <th class="text-center">Writer Name</th>
                            <th class="text-center">Price</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                    </tbody>
                </table>
            </div>
        </div>
    </section>



    <script>
        $(document).ready(function () {         
            Get_book_table_info();   
            $("#btn-submit").on('click', function () {
                var obj = {
                    Bookid: parseInt($(this).attr('data-id')),
                    Writerid: parseInt($('#writername>option:selected').val()),
                    Bookcategory: $('#bookcategory>option:selected').text(),
                    Bookname: $('#bookname').val(),
                    Bookprice: parseFloat($('#bookprice').val())
                }
                if (obj.Bookcategory == 'Select Book Category' || obj.Bookname == '' || obj.Bookprice == '') {


                   swal("Hi!", "Something Wrong!", "warning");
                    return false;
                }
                else {
                    save_book_info(obj);
                }

                
            })

            $(document).on('click', '.tableid', function () {
                var tableid = parseInt($(this).attr('data-id'));
                swal({
                    title: "Are you sure?",
                    text: "You will not be able to deleted this file!",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                    .then((willDelete) => {
                        if (willDelete) {
                            DeletedBookTable(tableid);

                            swal("Poof! Your file has been deleted!", {
                                icon: "success",
                            });
                        } else {
                            swal("Your file is safe!");
                        }
                    });
               
            });

            $(document).on('click', '.edit-btn', function () {
                $("html, body").animate({ scrollTop: 0 }, 50);
                $('#bookcategory').val($(this).attr('data-bookcat')).trigger('change');
                $('#bookname').val($(this).attr('data-bookname'));
                $('#writername').val($(this).attr('data-writerid')).trigger('change');
                $('#bookprice').val($(this).attr('data-price'));
                $('#btn-submit').attr('data-id', $(this).attr('data-bookid')).html('<i class="fa-solid fa-edit"></i> Update');
                
            })




        });

        function save_book_info(obj) {
            $.post('<%=Page.ResolveUrl("~/library_services.asmx/InsertAndUpdate_bookInfo")%>', { insertObject: JSON.stringify(obj) }, function (data, status, xhr) {
                if (status == 'success') {
                    swal("Hi!", "Book Information Save Successfully!", "success");
                    Get_book_table_info();
                }
                else {
                    swal("Hi!", "Something Wrong!", "warning");
                }
            });
            bookResetForm();
        }


        function bookResetForm() {
            $("#bookname, #bookprice").val('');
            $("#bookcategory").val("na");
            $("#writername").val("0");
            $('#btn-submit').attr('data-id', '0').html('<i class="fa-solid fa-square-plus"></i> Submit');
        }


        function Get_book_table_info() {
            $.getJSON('<%=Page.ResolveUrl("~/library_services.asmx/GetBookTableInfo")%>', function (data, status, xhr) {
                if (status == 'success') {
                    var tbody_tr = '';
                    $.each(data, function (i, r) {

                        tbody_tr += '<tr><td>' + (i + 1) + '</td><td>' + r.bookid + '</td><td>' + r.bookcategory + '</td><td>' + r.bookname + '</td><td>' + r.writername + '</td><td>' + r.price + '</td><td><button type="button" data-bookid="' + r.bookid + '" data-bookname="'+r.bookname+'" data-bookcat="' + r.bookcategory + '" data-writerid="'+r.writerid+'" data-price="'+r.price+'" class="edit-btn btn btn-info"><i class="fa fa-edit"></i></button> <button type="button" data-id="' + r.bookid + '" class="btn btn-danger tableid"><i class="fa fa-trash"></i></button></td></tr>';
                    });
                    $("#show-book-table>tbody").empty().append(tbody_tr);

                        $("#show-book-table").DataTable();                    
                                  
                }

            });
        }

  
        function DeletedBookTable(tableid) {
            $.post('<%=Page.ResolveUrl("~/library_services.asmx/DeletedBook")%>', { bookid: tableid }, function (data, status, xhr) {

                if (status == 'success') {

                    Get_book_table_info();

          
                }
            });
        }

      
    </script>

</asp:Content>
