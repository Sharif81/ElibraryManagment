<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="writerInfo.aspx.cs" Inherits="ElibraryManagment.writerInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #writer-info {
            margin-top: 80px;
        }
        #labelWriterAddress {
            margin-top: 20px;
        }
        #btn-submit {
            margin-top: 52px;
        }
        #writer-table {
            margin-top: 50px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
     <section id="writer-info">
        <div class="container-fluid">
            <div class="row">               
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="writername">Writer Name</label>
                        <input type="text" class="form-control" id="writername" placeholder="Enter Writer Name" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="contact">Contact Number</label>
                        <input type="text" class="form-control" id="contact" placeholder="Enter writer contact number">
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="emali">Email</label>
                        <input type="text" class="form-control" id="email" placeholder="Enter writer email">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="writeraddress" id="labelWriterAddress">Writer Address</label>
                        <textarea typeof="text" class="form-control" id="writeraddress" placeholder="Enter writer address"></textarea>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="form-group">
                        <button type="button" class="btn btn-success form-control" data-id="0" id="btn-submit"><i class="fa-solid fa-square-plus"></i> Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

     <section id="writer-table">
        <div class="container-fluid">
            <div class="col-md-12">
                <table class="table table-bordered table-hover text-center" id="writer-table-show">
                    <thead class="bg-info">
                        <tr>
                            <th class="text-center">SL#</th>
                            <th class="text-center">Writer ID</th>
                            <th class="text-center">Writer Name</th>
                            <th class="text-center">Address</th>
                            <th class="text-center">Contact</th>
                            <th class="text-center">Email</th>
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

            Get_writer_table_info();

            $("#btn-submit").on('click', function () {
                var obj = {
                    Writerid: $(this).attr('data-id'),
                    Writername: $("#writername").val(),
                    Contact: $("#contact").val(),
                    Email: $("#email").val(),
                    Address: $("#writeraddress").val()
                }

                if (obj.Writername == '' || obj.Contact == '' || obj.Email == '' || obj.Address == '') {
                    swal("Hi!", "Something Wrong!", "warning");
                    return false;
                }
                else {
                    save_writer_info(obj);
                }
            });



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
                            DeleteWriterTable(tableid);
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
                $("#writername").val($(this).attr('data-writername'));
                $("#contact").val($(this).attr('data-contact'));
                $("#email").val($(this).attr('data-email'));
                $("#writeraddress").val($(this).attr('data-writeraddress'));
                $("#btn-submit").attr('data-id', $(this).attr('data-id')).html('<i class="fa-solid fa-edit"></i> Update');
                return false;

            });


        });

        function save_writer_info(obj) {

            $.post('<%=Page.ResolveUrl("~/library_services.asmx/InsertAndUpdate_WriterInfo")%>', { insertObject: JSON.stringify(obj) }, function (data, status, xhr) {
                if (status == 'success') {
                    swal("Hi!", "Writer Information Save Successfully!", "success");

                    Get_writer_table_info();
                }
                else {
                    swal("Hi!", "Something Wrong!", "warning");
                }                 
            });
            WriterResetForm();
           
        }

        function WriterResetForm() {
            $("#writername, #contact, #email, #writeraddress").val('');
            $("#btn-submit").attr('data-id', '0').html('<i class="fa-solid fa-square-plus"></i> Submit');
        }


        function Get_writer_table_info() {
            $.getJSON('<%=Page.ResolveUrl("~/library_services.asmx/GetWriterTableInfo")%>', function (data, status, xhr) {

                if (status == 'success') {
                    var tbody_r = '';
                    $.each(data, function (i, r) {

                        tbody_r += '<tr><td>' + (i + 1) + '</td><td>' + r.writerid + '</td><td>' + r.writername + '</td><td>' + r.writeraddress + '</td><td>' + r.contact + '</td><td>' + r.email + '</td><td><button type="button" data-id="' + r.writerid + '" data-writername="' + r.writername + '" data-writeraddress="' + r.writeraddress + '" data-contact="' + r.contact + '"  data-email="' + r.email + '" class="edit-btn btn btn-info"><i class="fa fa-edit"></i></button> <button data-id="' + r.writerid + '" type="button" class="btn btn-danger tableid"><i class="fa fa-trash"></i></button></td></tr>'
                    });

                    $("#writer-table-show>tbody").empty().append(tbody_r);
                    $("#writer-table-show").DataTable();
                }
            });
        }

        function DeleteWriterTable(tableid) {
            $.post('<%=Page.ResolveUrl("~/library_services.asmx/DeleteWriter")%>', { writerid: tableid }, function (data, status, xhr) {
                if (status == 'success') {

                    Get_writer_table_info();
                }
            });
        }

    </script>

</asp:Content>
