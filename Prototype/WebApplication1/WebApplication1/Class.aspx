<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Class.aspx.cs" Inherits="WebApplication1.Class" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <h3>
        Manage Class</h3>
    Class :
    <asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem>SE572</asp:ListItem>
        <asp:ListItem>SE570</asp:ListItem>
        <asp:ListItem>SE569</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    Quantity : <a style="margin-left: 20px; font-size: 20px;">3</a>
    <br />
    <br />
    Student List :<br />
    <select data-placeholder="Student list" style="width: 500px; height: 50px;" multiple
        class="chosen-select" size="20px">
        <option value=""></option>
        <option value="HuyNQ60551">HuyNQ60551</option>
        <option value="BinhNT60321">BinhNT60321</option>
        <option value="HoangPH60547">HoangPH60547</option>
    </select>
    <h3>
        Add New Class :</h3>
    Class Name :
    <input type="text" style="width: 200px" />
    <br />
    <br />
    Student :
    <br />
    <select data-placeholder="Student list" style="width: 500px; height: 50px;" multiple
        class="chosen-select" size="20px">
        <option value=""></option>
        <option value="HuyNQ60551">HuyNQ60551</option>
        <option value="BinhNT60321">BinhNT60321</option>
        <option value="HoangPH60547">HoangPH60547</option>
    </select>
</asp:Content>
