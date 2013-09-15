<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Course.aspx.cs" Inherits="WebApplication1.Course" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <h3>
        Manage Course</h3>
    Course :<asp:DropDownList ID="DropDownList2" runat="server">
        <asp:ListItem>DMath</asp:ListItem>
        <asp:ListItem>SPM</asp:ListItem>
        <asp:ListItem>XML</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    Start Date: 10-12-2012 End Date: 12-2-2013
    <br />
    <br />
    <asp:Table ID="Table1" border="1" runat="server">
        <asp:TableHeaderRow Width="100px">
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>Block</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>Teacher</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>Class</h6></asp:TableCell>
        </asp:TableHeaderRow>
        <asp:TableHeaderRow Width="100px">
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>1</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>HoangPH</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>SE0572</h6></asp:TableCell>
        </asp:TableHeaderRow>
        <asp:TableHeaderRow Width="100px">
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>2,3</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>Binh</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>SE0570</h6></asp:TableCell>
        </asp:TableHeaderRow>
        <asp:TableHeaderRow Width="100px">
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>5</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>Binh</h6></asp:TableCell>
            <asp:TableCell Width="100px" HorizontalAlign="Center"><h6>SE0569</h6></asp:TableCell>
        </asp:TableHeaderRow>
    </asp:Table>
    <br />
    <h3>
        Add New Course
    </h3>
    Course
    <asp:DropDownList ID="DropDownList4" runat="server">
        <asp:ListItem>DMath</asp:ListItem>
        <asp:ListItem>SPM</asp:ListItem>
        <asp:ListItem>XML</asp:ListItem>
    </asp:DropDownList>
    or create new
    <input type="text" />
    <br />
    <br />
    Start Date:<input type="text" id="startdate" />
    End Date:<input type="text" id="enddate" />
    <br />
    <br />
    Teacher :
    <asp:DropDownList ID="DropDownList3" runat="server">
        <asp:ListItem>Than Van Su</asp:ListItem>
        <asp:ListItem>Kieu Trong Khanh</asp:ListItem>
        <asp:ListItem>Lai Duc Hung</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    Class :
    <asp:DropDownList ID="DropDownList5" runat="server">
        <asp:ListItem>Se0572</asp:ListItem>
        <asp:ListItem>SE0579</asp:ListItem>
        <asp:ListItem>SE0569 Hung</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    Block :
    <asp:DropDownList ID="DropDownList1" runat="server">
        <asp:ListItem>1</asp:ListItem>
        <asp:ListItem>2</asp:ListItem>
        <asp:ListItem>2,3</asp:ListItem>
    </asp:DropDownList>
    <br />
    <br />
    <button type="button" class="btn btn-primary">
        Create</button>
</asp:Content>
