<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true"
    CodeBehind="Subject.aspx.cs" Inherits="WebApplication1.Subject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="server">
    <script language="javascript">
        function a(number) {
            if (document.getElementById(number).value == "Active") {
                document.getElementById(number).value = "Inactive";
            } else { document.getElementById(number).value = "Active"; }
        }
    </script>
    <ul class="nav nav-tabs">
        <li class="active"><a href="#Subjectlist" data-toggle="tab">Subject List</a></li>
        <li><a href="#newSubject" data-toggle="tab">New Subject</a></li>
    </ul>
    <div class="tab-content">
        <div class="tab-pane tab-pane-content active" id="Subjectlist">
            <h3>
                Subject List</h3>
            <div>
                <table id="SubjectTable" class="table table-condensed tablesorter">
                    <thead>
                        <tr>
                            <th width="20px;">
                                No.
                            </th>
                            <th width="150px;">
                                Specialized
                            </th>
                            <th width="150px;">
                                Name
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
                                XML
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
                                Advanced Corporate Finance
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
                                Principles of Marketing
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
        <div class="tab-pane tab-pane-content" id="newSubject">
            <div>
                <!-- Form -->
                <form class="form-horizontal" id="new-Subject-form">
                <h3>
                    New Subject</h3>
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            Subject Name( <a style="color: Red;">*</a> )</label>
                        <div class="controls">
                            <input id="txtName" name="name" type="text" placeholder="" style="width: 200px;"
                                class="input-xlarge">
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="specialized">
                            Specialized</label>
                        <div class="controls">
                            <select class="selectpicker" multiple>
                                <option>Software Engineering</option>
                                <option>Business Analysis</option>
                                <option>Financial Analysis</option>
                            </select>
                        </div>
                    </div>
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
