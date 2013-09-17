<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="RollCall.aspx.cs" Inherits="WebApplication1.RollCall" %>

<asp:Content ID="RollCallContent" ContentPlaceHolderID="ContentPlaceHolder"
    runat="Server">
    <h3>
        Create new Roll Call</h3>
        <br />
    Class:
    <asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem>SE572</asp:ListItem>
        <asp:ListItem>SE570</asp:ListItem>
        <asp:ListItem>SE569</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    Subject:
    <asp:DropDownList ID="DropDownList2" runat="server">
        <asp:ListItem>DMath</asp:ListItem>
        <asp:ListItem>SPM</asp:ListItem>
        <asp:ListItem>XML</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    Teacher:
    <asp:DropDownList ID="DropDownList3" runat="server">
        <asp:ListItem>Than Van Su</asp:ListItem>
        <asp:ListItem>Kieu Trong Khanh</asp:ListItem>
        <asp:ListItem>Lai Duc Hung</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    Start Date:<input type="text" id="startdate" />
    End Date:<input type="text" id="enddate" />
    <br />
    <br />
    Student List:
    <select data-placeholder="Student list" style="width:500px; min-height:50px;" multiple class="chosen-select" tabindex="8">
        <br />
        <option value=""></option>
        <option value="HuyNQ60551">HuyNQ60551</option>
        <option value="BinhNT60321">BinhNT60321</option>
        <option value="HoangPH60547">HoangPH60547</option>
    </select>
    <br />
    <br />
    <button type="button" class="btn btn-primary">
        Create</button>
    <button type="button" class="btn btn-primary">
        Cancel</button>
</asp:Content>
