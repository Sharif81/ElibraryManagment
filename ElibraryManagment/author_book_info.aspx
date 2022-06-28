<%@ Page Title="Author Book Information Report" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="author_book_info.aspx.cs" Inherits="ElibraryManagment.author_book_info" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style>

    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <div class="row" style="margin-top: 80px;">
        <div class="col-md-4">
            <asp:DropDownList runat="server" ID="Writerlist" CssClass="form-control" ClientIDMode="Static" ></asp:DropDownList>
        </div>
        <div class="col-md-2">
            <asp:Button ID="Runreport" OnClick="show_writerBooksInfo" runat="server" CssClass="btn btn-success" Text="Run Report" />
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <rsweb:ReportViewer ID="WriterRV" runat="server"></rsweb:ReportViewer>
        </div>
    </div>

</asp:Content>
