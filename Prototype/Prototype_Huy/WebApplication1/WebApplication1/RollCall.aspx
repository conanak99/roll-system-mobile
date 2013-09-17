<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="RollCall.aspx.cs" Inherits="WebApplication1.RollCall" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <script language="javascript">
        function a(number) {
            if (document.getElementById(number).value == "Active") {
                document.getElementById(number).value = "Inactive";
            } else { document.getElementById(number).value = "Active"; }
        }
    </script>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#rollcalllist" data-toggle="tab">Roll Call List</a></li>
        <li><a href="#newrollcall" data-toggle="tab">New Roll Call</a></li>
    </ul>
    <br />
    <div class="tab-content">
        <div class="tab-pane tab-pane-content active" id="rollcalllist">
            <h3>
                Roll Call List</h3>
            <div>
                <table id="rollcallTable" class="table table-condensed tablesorter">
                    <thead>
                        <tr>
                            <th width="50px;">
                                No.
                            </th>
                            <th width="100px;">
                                Instructor
                            </th>
                            <th width="70px;">
                                Course
                            </th>
                            <th width="70px;">
                                Class
                            </th>
                            <th width="50px;">
                                Students
                            </th>
                            <th width="100px;">
                                Dates
                            </th>
                            <th width="100px;">
                                Time
                            </th>
                            <th width="70px;">
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
                                XML
                            </td>
                            <td>
                                SE60577
                            </td>
                            <td>
                                <input type="button" value="Show" style="margin-left:10px;" class="btn-primary" />
                            </td>
                            <td>
                                From 10-04-2013 to 10-05-2013
                            </td>
                            <td>
                                7:00-11:00
                            </td>
                            <td>
                                <input type="button" value="Active" id="1" class="btn-primary" onclick="a(1);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#">1</a>
                            </td>
                            <td>
                                Nguyen Thanh Binh
                            </td>
                            <td>
                                Advanced Corporate Finance
                            </td>
                            <td>
                                FA60544
                            </td>
                            <td>
                                <input type="button" value="Show" style="margin-left:10px;" class="btn-primary" />
                            </td>
                            <td>
                                From 10-04-2013 to 10-05-2013
                            </td>
                            <td>
                                14:00-17:00
                            </td>
                            <td>
                                <input type="button" value="Active" id="2" class="btn-primary" onclick="a(2);" />
                            </td>
                        </tr>
                        <tr>
                           <td>
                                <a href="#">1</a>
                            </td>
                            <td>
                                Nguyen Quoc Huy
                            </td>
                            <td>
                                Principles of Marketing
                            </td>
                            <td>
                                SE60522
                            </td>
                            <td>
                                <input type="button" value="Show" style="margin-left:10px;" class="btn-primary"/>
                            </td>
                            <td>
                                From 10-04-2013 to 10-05-2013
                            </td>
                            <td>
                                9:00-12:30
                            </td>
                            <td>
                                <input type="button" value="Active" id="3" class="btn-primary" onclick="a(3);" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div>
                    <ul class="pagination pagination-right">
                        <li><a href="#">Prev</a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">Next</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="tab-pane tab-pane-content" id="newrollcall">
            <div>
                <!-- Form -->
                <form class="form-horizontal" id="new-course-form">
                <h3>
                    New Roll Call</h3>
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            Course Name</label>(<label style="color: Red;">*</label>)
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
                                <option>Bussiness Analysis</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                        </div>
                    </div>
                    <br />
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary" id="addCourse">
                            Add</button>
                        <button type="reset" class="btn" id='btnresetcourse'>
                            Cancel</button>
                    </div>
                </fieldset>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
