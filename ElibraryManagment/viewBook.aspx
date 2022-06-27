<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="viewBook.aspx.cs" Inherits="ElibraryManagment.viewBook" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #view-table {
            margin-top: 80px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <section id="view-table">
        <div class="container-fluid">
            <div class="col-md-12">
                <table class="table table-bordered table-hover text-center" id="Elibrary-table-show">
                    <thead class="bg-info">
                        <tr>
                            <th class="text-center">SL#</th>
                            <th class="text-center">Writer Name</th>
                            <th class="text-center">Book Name</th>
                            <th class="text-center">Book Category</th>
                            <th class="text-center">Price</th>
                            <th class="text-center">Contact</th>
                            <th class="text-center">Email</th>
                            <th class="text-center">Address</th>
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

            Get_Elibrary_all_info();
        });
        function Get_Elibrary_all_info() {
            $.getJSON('<%=Page.ResolveUrl("~/library_services.asmx/GetElibraryAll_Info")%>', function (data, status, xhr) {
                if (status == 'success') {
                    var tbody_r = '';
                    $.each(data, function (i, r) {
                        tbody_r += '<tr><td>' + (i + 1) + '</td><td>' + r.writername + '</td><td>' + r.bookname + '</td><td>' + r.bookcategory + '</td><td>' + r.price + '</td><td>' + r.contact + '</td><td>' + r.email + '</td><td>' + r.address + '</td></tr>';
                    });
                    $("#Elibrary-table-show>tbody").empty().append(tbody_r);
                    $("#Elibrary-table-show").DataTable();
                }
            });
        }
        
    </script>

</asp:Content>
