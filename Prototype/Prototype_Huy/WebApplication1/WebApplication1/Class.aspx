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
    <br />
    <div class="tab-content">
        <div class="tab-pane tab-pane-content active" id="classlist">
            <h3>
                Class List</h3>
            <div>
                <table id="studentTable" class="table table-condensed tablesorter">
                    <thead>
                        <tr>
                            <th width="50px;">
                                No.
                            </th>
                            <th width="300px;">
                                Specialized
                            </th>
                            <th width="100px;">
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
                                <p>
                                    <a data-toggle="modal" href="#example" onclick="#example.modal("show");" class="btn btn-primary">Test</a></p>
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
                                Finalcal Analysis
                            </td>
                            <td>
                                FA0606
                            </td>
                            <td>
                                <input type="button" value="Show" style="margin-left: 10px;" class="btn-primary" />
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
                                Bussiness Analysis
                            </td>
                            <td>
                                BA60567
                            </td>
                            <td>
                                <input type="button" value="Show" style="margin-left: 10px;" class="btn-primary" />
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
        <div class="tab-pane tab-pane-content" id="newclass">
            <div>
                <!-- Form -->
                <form class="form-horizontal" id="new-class-form">
                <h3>
                    New Class</h3>
                <fieldset>
                    <div class="control-group">
                        <label class="control-label" for="name">
                            Class Name</label>(<label style="color: Red;">*</label>)
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
                                <option>Finacial Analysis</option>
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
    <div id="example" class="modal hide fade in" style="display:none;">
        <div class="modal-header">
            <a class="close" data-dismiss="modal"></a>
            <h3>
                Ths</h3>
        </div>
        <div class="modal-body">
            <h3>
                Ths</h3>
        </div>
        <div class="modal-footer">
            <a href="#" class="btn">aa</a> 
        </div>
    </div>
</asp:Content>
