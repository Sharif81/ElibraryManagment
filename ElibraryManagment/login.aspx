<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="ElibraryManagment.login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        #login-card {

            margin-top: 120px;
            margin-left: 500px;
            font-family:'Berlin Sans FB';
        }
        #login-card img {
            height: 80px;
            width: 100px;
            margin: 0 auto;
          
        }
    </style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder" runat="server">


    <div id="login-card" class="card" style="width: 25em;" >
        <img src="images/loginimg.png" class="card-img-top">
        <div class="card-body">
            <h5 class="card-title text-center">Welcome</h5>

            <div class="mb-3 mt-3">
                <label for="uname" class="form-label">Username:</label>
                <input type="text" class="form-control" id="uname" placeholder="Enter username" name="uname">
            </div>
            <div class="mb-3">
                <label for="pwd" class="form-label">Password:</label>
                <input type="password" class="form-control" id="pwd" placeholder="Enter password" name="pswd">
            </div>
            <button type="button" class="btn btn-primary">Login</button>
            <button type="button" class="btn btn-success">Sign Up</button>
        </div>

    </div>


</asp:Content>
