<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Class.aspx.cs" Inherits="WebApplication1.Class" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <script language="javascript">
        function a(number) {
            if (document.getElementById(number).value == "Active") {
                document.getElementById(number).value = "Inactive";
            } else { document.getElementById(number).value = "Active"; }
        }
    </script>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#classlist" data-toggle="tab">Class List</a></li>
        <li><a href="#newclass" data-toggle="tab">New Class</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane tab-pane-content active" id="classlist">
            <h3>
                Class List</h3>
            <div>
                <table id="studentTable" class="table table-condensed tablesorter">
                    <thead>
                        <tr>
                            <th width="20px;">
                                No.
                            </th>
                            <th width="300px;">
                                Specialized
                            </th>
                            <th width="150px;">
                                Name
                            </th>
                            <th width="100px">
                                Student List
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
                                Software Engineering
                            </td>
                            <td>
                                SE0572
                            </td>
                            <td>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#example">
                                    Show</button>
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
                                Financial Analysis
                            </td>
                            <td>
                                FA0606
                            </td>
                            <td>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#example">
                                    Show</button>
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
                                Business Analysis
                            </td>
                            <td>
                                BA60567
                            </td>
                            <td>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#example">
                                    Show</button>
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
        <div class="tab-pane tab-pane-content" id="newclass">
            <div>
                <!-- Form -->
                <form class="form-horizontal" id="new-class-form">
                <h3>
                    New Class</h3>
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            Class Name( <a style="color: Red;">*</a> )</label>
                        <div class="controls">
                            <input id="txtName" name="name" type="text" placeholder="" style="width: 200px;"
                                class="input-xlarge">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="specialized">
                            Specialized</label>
                        <div class="controls">
                            <select id="class" name="class" class="input-small" style="width: 200px;">
                                <option>Software Engineering</option>
                                <option>Financial Analysis</option>
                                <option>Business Analysis</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="specialized">
                            Student list</label>
                        <div class="controls">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#example">
                                Show</button>
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
    <div id="example" class="modal hide fade in" style="display: none;">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                &times;</button>
            <h3>
                Student List</h3>
        </div>
        <div class="modal-body">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>
                            No.
                        </th>
                        <th>
                            Student Name
                        </th>
                        <th>
                            Student ID
                        </th>
                        <th>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            1
                        </td>
                        <td>
                            Pham Huy Hoang
                        </td>
                        <td>
                            HoangPH
                        </td>
                        <td>
                            <a href="#">Detele</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            2
                        </td>
                        <td>
                            Nguyen Thanh Binh
                        </td>
                        <td>
                            BinhNT
                        </td>
                        <td>
                            <a href="#">Detele</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            3
                        </td>
                        <td>
                            Nguyen Quoc Huy
                        </td>
                        <td>
                            HuyNQ
                        </td>
                        <td>
                            <a href="#">Detele</a>
                        </td>
                    </tr>
                </tbody>
            </table>
            Add student :
            <input type="text" style="width: 200px;" />
            <br />
            <input type="button" class="btn btn-primary" value="Add" style="margin-left: 90px;"></input>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary">
                    Ok</button>
                <button type="button" data-dismiss="modal" class="btn">
                    Close</button>
            </div>
        </div>
    </div>
</asp:Content>
