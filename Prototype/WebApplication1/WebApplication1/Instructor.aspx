<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Instructor.aspx.cs" Inherits="WebApplication1.Instructor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <h3>
        Instructor List</h3>
        <input type="text" style="width:200px;" />
        <button class="btn btn-primary">Search</button><br /><br />
    <asp:Table ID="Table1" border="1" runat="server">
        <asp:TableHeaderRow Width="100px">
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>Full Name</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>ID</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>Position</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>Email</h6></asp:TableCell>
        </asp:TableHeaderRow>
        <asp:TableHeaderRow Width="100px">
            <asp:TableCell Width="100px" HorizontalAlign="Center">Toi Ten La</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">Latt12345</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">Admin</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">latt@yahoo.com</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><a href="#">Edit</a></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><a href="#">Delete</a></asp:TableCell>
        </asp:TableHeaderRow>
        <asp:TableHeaderRow Width="100px">
            <asp:TableCell Width="100px" HorizontalAlign="Center">Ten Toi La</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">Latt6789</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">Teacher</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">latt@yahoo.com</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><a href="#">Edit</a></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><a href="#">Delete</a></asp:TableCell>
        </asp:TableHeaderRow>
        <asp:TableHeaderRow Width="100px">
            <asp:TableCell Width="100px" HorizontalAlign="Center">Ten La Toi</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">Ttl0001</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">Teacher</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center">Toitl@yahoo.com</asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><a href="#">Edit</a></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><a href="#">Delete</a></asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table><br />
    <h3>Create new :</h3>
    Full Name :
    <input type="text" style="width:200px;"/>
    <br /><br />
    ID :
    <input type="text" style="width:200px;margin-left:50px;"/>
    <br /><br />
    Position :
    <input type="text" style="width:200px;margin-left:16px;"/>
    <br /><br />
    Email :
    <input type="text" style="width:200px;margin-left:33px;"/>
    <br /><br />
    <button type="button" class="btn btn-primary"style="margin-left:80px;">Add new</button>
</asp:Content>
