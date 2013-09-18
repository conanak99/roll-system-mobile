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
                            <th width="20px;">
                                No.
                            </th>
                            <th width="100px;">
                                Instructor
                            </th>
                            <th width="70px;">
                                Subject
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
                                <button class="btn btn-primary" data-toggle="modal" data-target="#example">
                                    Show</button>
                            </td>
                            <td>
                                From 10-04-2013 to 10-05-2013
                            </td>
                            <td>
                                7:00-11:00
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
                                Advanced Corporate Finance
                            </td>
                            <td>
                                FA60544
                            </td>
                            <td>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#example">
                                    Show</button>
                            </td>
                            <td>
                                From 10-04-2013 to 10-05-2013
                            </td>
                            <td>
                                14:00-17:00
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
                                Principles of Marketing
                            </td>
                            <td>
                                SE60522
                            </td>
                            <td>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#example">
                                    Show</button>
                            </td>
                            <td>
                                From 10-04-2013 to 10-05-2013
                            </td>
                            <td>
                                9:00-12:30
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
        <div class="tab-pane tab-pane-content" id="newrollcall">
            <div>
                <!-- Form -->
                <form class="form-horizontal" id="new-rollcall-form">
                <h3>
                    New Roll Call</h3>
                <fieldset>
                    <div class="control-group">
                        <div class="controls">
                            Instructor :
                            <select id="Select1" name="class" class="input-small" style="width: 200px; margin-left: 20px;">
                                <option>Pham Huy Hoang</option>
                                <option>Nguyen Thanh Binh</option>
                                <option>Nguyen Quoc Huy</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            Subject :
                            <select id="Select2" name="class" class="input-small" style="width: 200px; margin-left: 30px;">
                                <option>XML</option>
                                <option>Principles of Marketing</option>
                                <option>Advanced Corporate Finance</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            Class :
                            <select id="Select3" name="class" class="input-small" style="width: 200px; margin-left: 41px;">
                                <option>SE0670</option>
                                <option>FA0767</option>
                                <option>BA0654</option>
                            </select>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            Students :
                            <button class="btn btn-primary" data-toggle="modal" data-target="#example" style="margin: 20px;">
                                Show</button>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            Start Date :
                            <div class="input-append date" id="startdate" data-date-format="dd-mm-yyyy" style="margin-left: 12px;
                                margin-right: 50px;">
                                <input class="span2" style="width: 160px;" size="16" type="text" value="12-02-2013"
                                    readonly><span class="add-on"><i class="icon-th"></i></span>
                            </div>
                            End Date :
                            <div class="input-append date" id="enddate" data-date-format="dd-mm-yyyy">
                                <input class="span2" style="width: 160px; margin-left: 10px;" size="16" type="text"
                                    value="12-02-2013" readonly><span class="add-on"><i class="icon-th"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            <a style="margin-right: 45px; color: Black; text-decoration: none;">Time :</a>
                            <select class="timerollcall" multiple>
                                <option>7h - 8h45</option>
                                <option>9h - 10h45</option>
                                <option>11h - 12h</option>
                            </select>
                        </div>
                    </div>
                    <br />
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary" id="addrollcall">
                            Add</button>
                        <button type="reset" class="btn" id='btnresetrollcall'>
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
