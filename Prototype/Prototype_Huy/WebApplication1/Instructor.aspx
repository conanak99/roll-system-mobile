<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Instructor.aspx.cs" Inherits="WebApplication1.Instructor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <script language="javascript">
        function a(number) {
            if (document.getElementById(number).value == "Active") {
                document.getElementById(number).value = "Inactive";
            } else { document.getElementById(number).value = "Active"; }
        }
    </script>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#instructorlist" data-toggle="tab">Instructor List</a></li>
        <li><a href="#newinstructor" data-toggle="tab">New Instructor</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane tab-pane-content active" id="instructorlist">
            <h3>
                Instructor List</h3>
            <div>
                <table id="studentTable" class="table table-condensed tablesorter">
                    <thead>
                        <tr>
                            <th width="20px;">
                                No.
                            </th>
                            <th width="180px;">
                                Name
                            </th>
                            <th width="150px;">
                                Username
                            </th>
                            <th width="150px;">
                                Password
                            </th>
                            <th width="280px;">
                                Address
                            </th>
                            <th width="150px;">
                                Phone
                            </th>
                            <th width="100px;">
                                Active
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <a href="#">1</a>
                            </td>
                            <td>
                                Pham Huy Hoang
                            </td>
                            <td>
                                hoangph
                            </td>
                            <td>
                                hoangph123
                            </td>
                            <td>
                                123 Quang Trung, Q12, tp Ho Chi Minh
                            </td>
                            <td>
                                0909009000
                            </td>
                            <td>
                                <input type="button" value="Active" id="1" class="btn btn-primary" onclick="a(1);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#">2</a>
                            </td>
                            <td>
                                Nguyen Thanh Binh
                            </td>
                            <td>
                                binhnt
                            </td>
                            <td>
                                12345
                            </td>
                            <td>
                                123 Quang Trung, Q12, tp Ha Noi
                            </td>
                            <td>
                                0909009
                            </td>
                            <td>
                                <input type="button" value="Active" id="2" class="btn btn-primary" onclick="a(2);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#">3</a>
                            </td>
                            <td>
                                Nguyen Quoc Huy
                            </td>
                            <td>
                                huynq
                            </td>
                            <td>
                                huynq123
                            </td>
                            <td>
                                123 Quang Trung, Q12, tp Hue
                            </td>
                            <td>
                                0909009
                            </td>
                            <td>
                                <input type="button" value="Active" id="3" class="btn btn-primary" onclick="a(3);" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="pagination pagination-left">
                    <ul>
                        <li><a href="#">Prev</a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">Next</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="tab-pane tab-pane-content" id="newinstructor">
            <div>
                <!-- Form -->
                <form class="form-horizontal" id="new-student-form">
                <h3>
                    New Instructor</h3>
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            Instructor Name( <a style="color: Red;">*</a> )</label>
                        <div class="controls">
                            <input id="txtName" name="name" type="text" placeholder="" style="width: 200px;"
                                class="input-xlarge">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            Address( <a style="color: Red;">*</a> )</label>
                        <div class="controls">
                            <input id="Text1" name="name" type="text" placeholder="" style="width: 200px;" class="input-xlarge">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            Phone number( <a style="color: Red;">*</a> )</label>
                        <div class="controls">
                            <input id="Text2" name="name" type="text" placeholder="" style="width: 200px;" class="input-xlarge">
                        </div>
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary" id="addStudent">
                            Add</button>
                        <button type="reset" class="btn" id='btnResetStudent'>
                            Cancel</button>
                    </div>
                </fieldset>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
