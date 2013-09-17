<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Course.aspx.cs" Inherits="WebApplication1.Course" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <script language="javascript">
        function a(number) {
            if (document.getElementById(number).value == "Active") {
                document.getElementById(number).value = "Inactive";
            } else { document.getElementById(number).value = "Active"; }
        }
    </script>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#courselist" data-toggle="tab">Course List</a></li>
        <li><a href="#newcourse" data-toggle="tab">New Course</a></li>
    </ul>
    <br />
    <div class="tab-content">
        <div class="tab-pane tab-pane-content active" id="courselist">
            <h3>
                Course List</h3>
            <div>
                <table id="courseTable" class="table table-condensed tablesorter">
                    <thead>
                        <tr>
                            <th width="50px;">
                                No.
                            </th>
                            <th width="100px;">
                                Name
                            </th>
                            <th width="100px;">
                                Specialized
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
                                XML
                            </td>
                            <td>
                                Software Engineering
                            </td>
                            <td>
                                <input type="button" value="Active" id="1" class="btn-primary" onclick="a(1);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#">2</a>
                            </td>
                            <td>
                                Advanced Corporate Finance
                            </td>
                            <td>
                                Financial Analysis
                            </td>
                            <td>
                                <input type="button" value="Active" id="2" class="btn-primary" onclick="a(2);" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <a href="#">3</a>
                            </td>
                            <td>
                                Principles of Marketing
                            </td>
                            <td>
                                Bussiness Analysis
                            </td>
                            <td>
                                <input type="button" value="Active" class="btn-primary" id="3" onclick="a(3);" />
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
        <div class="tab-pane tab-pane-content" id="newcourse">
            <div>
                <!-- Form -->
                <form class="form-horizontal" id="new-course-form">
                <h3>
                    New Course</h3>
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
