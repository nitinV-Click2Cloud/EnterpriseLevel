<%@ Page Title="" Language="C#" MasterPageFile="~/TTSHMasterPage/TTSH.Master" AutoEventWireup="true" CodeBehind="frmGrantDetailsForm.aspx.cs" Inherits="TTSHWeb.frmGrantDetailsForm" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/SearchBox.ascx" TagPrefix="uc1" TagName="SearchBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(function () {
            $('[id*=tblSingleBudget] tbody tr input[type=text]').keydown(function (e) {
                var n = $("input:text").length;
                if (e.which == 13) { //Enter key
                    e.preventDefault(); //Skip default behavior of the enter key
                    var nextIndex = $('input:text').index(this) + 1;
                    if (nextIndex < n)
                        $('input:text')[nextIndex].focus();
                    else {
                        $('input:text')[nextIndex - 1].blur();
                    }
                }
            });
        });


    </script>
    <script src="Scripts/Webform/jsGrantDetails.js"></script>

    <!-- hide grid Years
        
        $('[id*=tblSingleBudget] tbody').find('tr[rid*=trY1]').css('display','none')
        -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">
    <div class="GrantDetail container" runat="server" id="DivMain">
        <div class="row">
            <div class="col-md-6 col-sm-6 paging">
                <h1>Grant Detail View <span>Search, Filter and Edit Grant Details</span></h1>

            </div>
            <div class="col-md-6 col-sm-6 paging">
                <div class="grid-search">
                    <uc1:searchbox runat="server" id="SearchBox" />
                </div>
            </div>
        </div>
        <div class="row">



            <div class="col-md-12">
                <div class="tblResposiveWrapper">
                    <table id="tblResposive">
                        <thead>
                            <tr>
                                <th style="width: 100px">Project ID</th>
                                <th>Project Title</th>
                                <th>Project Category</th>

                                <th>Grant Detail Status</th>
                                <th>DSRB/IRB No.</th>
                                <th>PI Name</th>

                                <th style="width: 95px">Action</th>
                            </tr>
                        </thead>

                        <tbody>

                            <asp:Repeater ID="RptGrantGrid" OnItemCommand="RptGrantGrid_ItemCommand"  runat="server">
                                <ItemTemplate>
                                    <tr>
                                        <td data-th="Project ID">
                                            <p><%#Eval("s_Display_Project_ID") %></p>
                                        </td>
                                        <td data-th="Project Title">
                                            <p><%#Eval("s_Project_Title") %></p>
                                        </td>
                                        <td data-th="Project Category">
                                            <p><%#Eval("Project_Category_Name") %></p>
                                        </td>
                                        <td data-th="Grant Detail Status">
                                            <p><%#Eval("GrantDetailStatus") %></p>
                                        </td>
                                        <td data-th="DSRB/IRB No.">

                                            <p><%#Eval("s_IRB_No") %></p>
                                        </td>
                                        <td data-th="PI Name">
                                            <p><%#Eval("PI_Name") %></p>
                                        </td>

                                        <td data-th="Action">
                                            <p class="grid-action">
                                                <asp:PlaceHolder ID="PlaceHolder3" runat="server" Visible='<%# "New".Contains(Eval("GrantDetailStatus").ToString()) %>'>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="cmdAdd" OnClientClick="ResetAll();DoPostBack();return true;" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.i_Project_ID")%>'>
												
													<img title="Add Regulatory Detail" alt="" style="width:20px;" src="Images/Add-New.png"></asp:LinkButton>
                                                </asp:PlaceHolder>

                                                <asp:PlaceHolder ID="PlaceHolder1" runat="server" Visible='<%# Eval("GrantDetailStatus").ToString()!="New" %>'>

                                                    <asp:LinkButton ID="ImgEdit" runat="server" CommandName="cmdEdit" OnClientClick="ResetAll();DoPostBack();return true;" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.GD_ID")%>'>
												
													<img title="Edit Regulatory Detail" alt="" src="Images/icon-edit.png"></asp:LinkButton></asp:PlaceHolder>
                                                <asp:PlaceHolder ID="PlaceHolder2" runat="server" Visible='<%# Eval("GrantDetailStatus").ToString()!="New" %>'>
                                                    <asp:LinkButton ID="ImgDelete" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.GD_ID")%>' OnClientClick='<%# String.Format("return ConfirmDelete(\"{0}\");",  Eval("GD_ID")) %>' CommandName="cmdDelete" runat="server">
                                                        <img title="Delete Regulatory Detail" alt="" src="Images/icon-delete.png">
                                                    </asp:LinkButton></asp:PlaceHolder>

                                                <asp:PlaceHolder ID="PlaceHolder4" runat="server" Visible='<%# Eval("GrantDetailStatus").ToString()!="New" %>'>
                                                    <asp:LinkButton ID="ImgView" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.GD_ID")%>' OnClientClick="ResetAll();DoPostBack();return true;" CommandName="cmdView" runat="server">
                                                    
												<img title="View Regulatory Detail" alt="" src="Images/icon-view.png">
                                                    </asp:LinkButton></asp:PlaceHolder>
                                            </p>
                                        </td>
                                    </tr>
                                </ItemTemplate>

                            </asp:Repeater>

                        </tbody>
                    </table>

                    <!-- Grid View -->



                    <!-- Grid View -->
                </div>
            </div>

        </div>
        <div class="row" id="Paging">
            <div class="col-md-6 paging">
                <div class="page-info">
                    <h3>18  Results Found</h3>
                    <p>Showing Page 2 of Total 4 Pages | <a href="#">First Page</a> | <a href="#">Last Page</a></p>
                </div>
            </div>
            <div class="col-md-6 paging">
                <div class="pages">
                </div>
            </div>
        </div>
        <div class="row margin-top frmAction" style="margin-top: 5px;">
            <div class="col-md-12">
                <p style="text-align: left">



                    <asp:Button CssClass="action" ID="btnNew" runat="server" Text="Add New Project" OnClientClick="window.open( 'frmProject_Master.aspx?NewPage=true','_blank' );return false;" />

                </p>
            </div>
        </div>
    </div>


    <div class="GrantDetail container" id="DivEntry" runat="server">
        <span style="float: right; margin-top: 65px">
            <asp:LinkButton ID="lnkback" Text="Back to View" OnClick="lnkback_Click" runat="server"></asp:LinkButton></span>
        <div class="row">
            <div class="col-md-6 col-sm-6">
                <h1>Grant Details <span>Grant Entry Form <b>( Project ID:</b><b id="DispProjectId" runat="server"> </b>)</span></h1>
            </div>

        </div>
        <div class="row">
            <div class="col-md-12">
                <h3 class="frmHead" data-frm="frmDetails">Project Details <span>( - )</span></h3>
            </div>
        </div>
        <div class="frmProject">

            <div class="frm frmDetails" style="display: block;">
                <div class="row">
                    <div class="col-md-6 col-sm-6">

                        <p>
                            <label>Project Title <b>*</b></label>
                            <asp:TextBox ID="TxtProjTitle" CssClass="ctltext" TextMode="MultiLine" runat="server" Enabled="false" onmousedown="return false" onkeydown="return false"></asp:TextBox>
                        </p>

                        <p>
                            <label>Alias 1</label>
                            <asp:TextBox ID="TxtAlias1" CssClass="ctlinput" runat="server" Enabled="false" onmousedown="return false" onkeydown="return false"></asp:TextBox>
                        </p>

                        <p>
                            <label>Short Title</label>
                            <asp:TextBox ID="TxtShortTitle" CssClass="ctlinput" runat="server" Enabled="false" onmousedown="return false" onkeydown="return false"></asp:TextBox>
                        </p>

                    </div>
                    <div class="col-md-6 col-sm-6">
                        <p>
                            <label>Project Category <b>*</b></label>


                            <asp:TextBox ID="TxtprojCategory" CssClass="ctlinput" runat="server" Enabled="false" onmousedown="return false" onkeydown="return false"></asp:TextBox>
                        </p>
                        <p>
                            <label>Alias 2</label>
                            <asp:TextBox ID="TxtAlias2" CssClass="ctlinput" runat="server" Enabled="false" onmousedown="return false" onkeydown="return false"></asp:TextBox>
                        </p>
                        <p>
                            <label>DSRB/IRB No</label>
                            <asp:TextBox ID="TxtIrbNo" CssClass="ctlinput" runat="server" Enabled="false" onmousedown="return false" onkeydown="return false"></asp:TextBox>

                        </p>
                    </div>
                </div>


            </div>

        </div>

        <div class="row">
            <div class="col-md-12 col-sm-12">
                <h3 class="frmHead" data-frm="frmPI">Principal Investigator (PI) Details <span>( - )</span>
                </h3>
                <%--  <p runat="server" id="PMorePi"><span>+</span>  <a class="newPI link" data-frm="frmNewPIDetails">Record New PI Details</a></p>--%>
            </div>
        </div>

        <div class="frm frmPI" style="display: block;">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="tblResposiveWrapper">
                        <table id="tblPiDetail" class="tblResposive">
                            <thead>
                                <tr>

                                    <th style="width: 450px; text-align: left">Department</th>
                                    <th style="text-align: left">PI Name</th>
                                    <th style="text-align: left">Email</th>
                                    <th style="text-align: left">Phone</th>
                                    <th style="text-align: left">PI MCR No.</th>
                                    <th style="width: 45px; text-align: right">Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <asp:Repeater ID="rptrPIDetails" runat="server">
                                    <ItemTemplate>
                                        <tr data-th="Department" piid="<%# Eval("i_ID")%>">
                                            <td data-th="Department">
                                                <p><%# Eval("s_DeptName") %></p>
                                            </td>
                                            <td data-th="PI Name">
                                                <p><%# Eval("s_PIName") %></p>
                                            </td>
                                            <td data-th="Email">
                                                <p><%# Eval("s_Email") %></p>
                                            </td>
                                            <td data-th="Phone">
                                                <p><%# Eval("s_Phone_no") %></p>
                                            </td>
                                            <td data-th="PI MCR No.">
                                                <p><%# Eval("s_MCR_No") %></p>
                                            </td>
                                            <td data-th="Action" style="text-align: right">
                                                <p class="grid-action">

                                                    <asp:LinkButton ID="ImgDelete" CommandArgument='<%# DataBinder.Eval(Container, "DataItem.i_ID")%>' OnClientClick="return delPiRows(this);" CommandName="cmdDelete" runat="server">
                                                        <img title="Delete Pi Detail" alt="" src="../images/icon-delete.png">
                                                    </asp:LinkButton>

                                                </p>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>




                            </tbody>
                        </table>
                    </div>
                    <%--  <p runat="server" id="Pmore" class="align-right"><a class="link" onclick="AddMorePI();">+ Add More PI</a></p>--%>
                </div>
            </div>
        </div>

        <%--    <div class="frmNewPIDetails" style="display: none;">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <h3 runat="server" id="hrMorePi" style="color: rgb(228, 16, 83); margin-bottom: 1em;">Record New Principal Investigator (PI) Details					                  
                    </h3>
                </div>
            </div>
            <asp:UpdatePanel runat="server" ID="UpPi">
                <ContentTemplate>
                    <div class="row">
                        <div class="col-md-6 col-sm-6">
                            <p>
                                <label>Department <b>*</b></label>
                                <asp:HiddenField ID="HdnNewDeptId" runat="server" />

                                <asp:TextBox ID="TxtNewDepartment" onpaste="return false;" placeholder="Type Keyword to search Department" CssClass="ctlinput" runat="server"></asp:TextBox>

                            </p>
                            <p>
                                <label>First / Given Name <b>*</b></label>
                                <asp:TextBox ID="txtPiFirstName" CssClass="ctlinput" onkeypress="return RestrictPower(event);" placeholder="First Name" runat="server"></asp:TextBox>
                            </p>
                            <p>
                                <label>PI Email <b>*</b></label>
                                <asp:TextBox ID="txtPIEmailAddress" onblur="checkValidEmail(this);" placeholder="PI Email" CssClass="ctlinput" runat="server"></asp:TextBox>
                            </p>


                        </div>
                        <div class="col-md-6 col-sm-6">
                            <p>
                                <label>PI MCR No.<b>*</b></label>
                                <asp:TextBox ID="txtPIMCR_NO" CssClass="ctlinput" placeholder="PI MCR No" runat="server"></asp:TextBox>
                            </p>
                            <p>
                                <label>Last Name / Surname <b>*</b></label>
                                <asp:TextBox ID="txtPiLastName" CssClass="ctlinput" onkeypress="return RestrictPower(event);" placeholder="Last Name" runat="server"></asp:TextBox>
                            </p>
                            <p>
                                <label>Phone No.</label>
                                <asp:TextBox ID="txtPiPhNo" CssClass="ctlinput" onKeypress="return SingaporePhformat();" onpaste="return false" placeholder="Phone No" runat="server"></asp:TextBox>
                            </p>

                        </div>
                    </div>
                    <div class="row margin-top frmAction">
                        <div class="col-md-12">
                            <p style="text-align: right">


                                <asp:Button CssClass="action" ID="btnPISave" runat="server" Text="Save" />
                                <asp:Button CssClass="action" ID="btnPICancel" runat="server" OnClientClick="return ClearCloseNewPiSection();" Text="Reset" />

                            </p>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

        <div class="frmAddMorePIDetails" style="display: none;">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <h3 style="color: rgb(228, 16, 83); margin-bottom: 1em;">Add  Principal  Investigator (PI)					                  
                    </h3>
                </div>
            </div>

            <div class="row">
                <div class="col-md-6 col-sm-6">
                    <p>
                        <label>Department <b>*</b></label>
                        <asp:HiddenField ID="HdnDeptId" runat="server" />
                        <asp:HiddenField ID="HdnDeptTxt" runat="server" />
                        <asp:TextBox ID="TxtDepartment" onpaste="return false;" onblur="ClearOnblur(this);" onKeydown="items('');" placeholder="Type Keyword to search Department" CssClass="ctlinput" runat="server"></asp:TextBox>
                    </p>
                    <p>
                        <label>PI Email </label>
                        <asp:TextBox ID="txtPIEmail" CssClass="ctlinput" placeholder="PI Email" runat="server"></asp:TextBox>
                    </p>
                    <p>
                        <label>Phone No.</label>
                        <asp:TextBox ID="txtPiPhoneNo" CssClass="ctlinput" placeholder="Phone No" runat="server"></asp:TextBox>
                    </p>

                </div>
                <div class="col-md-6 col-sm-6">
                    <p>
                        <label>PI Name<b>*</b></label>
                        <asp:HiddenField ID="HdnpiId" runat="server" />
                        <asp:HiddenField ID="HdnPITxt" runat="server" />
                        <asp:TextBox ID="TxtPIName" onpaste="return false;" onblur="CheckPiOnBlur(this);" onKeydown="items('pi');" onchange="items('pi')" placeholder="Type Keyword to search PI" CssClass="ctlinput" runat="server"></asp:TextBox>

                    </p>
                    <p>
                        <label>PI MCR No.</label>
                        <asp:TextBox ID="txtPiMCRNo" CssClass="ctlinput" placeholder="PI MCR No" runat="server"></asp:TextBox>
                    </p>
                </div>
            </div>
            <div class="row margin-top frmAction">
                <div class="col-md-12">
                    <p style="text-align: right">


                        <asp:Button CssClass="action" ID="btnMorePiSave" runat="server" Text="Save" />
                        <asp:Button CssClass="action" ID="btnMorePiCancel" OnClientClick="return ClearCloseMorePiSection();" runat="server" Text="Reset" />

                    </p>
                </div>
            </div>

        </div>--%>

        <div class="row">
            <div class="col-md-12">
                <h3 class="frmHead" data-frm="frmSingleProject">Grant Detail <span>( - )</span></h3>
            </div>
        </div>
        <div class="frm frmSingleProject" style="display: block;">
            <div class="row">
                <div class="col-md-6 col-sm-6">
                      <p>
                        <label>Grant Id<b>*</b></label>

                        <asp:TextBox ID="TxtGrantId" CssClass="ctlinput" runat="server"></asp:TextBox>

                    </p>
                    
                    <p>
                        <label>Grant Type<b>*</b></label>


                        <asp:TextBox ID="TxtGrantType" CssClass="ctlinput" runat="server"></asp:TextBox>

                    </p>
                    <p>
                        <label>Grant Sub-Sub Category<b>*</b></label>


                        <asp:TextBox ID="TxtGrantSSType" CssClass="ctlinput" runat="server"></asp:TextBox>

                    </p>
                    <p>
                        <label>Date of Award Letter<b>*</b></label>


                        <asp:TextBox ID="TxtDateofAwardLetter" CssClass="ctlinput ctlinput-sm datepicker" runat="server"></asp:TextBox>

                    </p>
                    <p>
                        <label>Award Letter<b>*</b></label>


                        <asp:FileUpload ID="FldAwardLetterfil" CssClass="ctlinput" runat="server" />
                        <asp:HiddenField ID="HdnAwardLetterFile" runat="server" />
                    </p>
                    <span>
                        <asp:LinkButton ID="LnkAwardLetterfile" runat="server"></asp:LinkButton></span>

                    <p>
                        <label>
                            New Grant Expiry Date<b>*</b>
                        </label>
                        <asp:TextBox ID="TxtNewGrantExpDate" CssClass="ctlinput ctlinput-sm datepicker" runat="server"></asp:TextBox>
                    </p>
                </div>
                <div class="col-md-6 col-sm-6">
                  <p>
                        <label>Grant Details Status<b>*</b></label>
                         <asp:DropDownList ID="ddlGrantDetailStatus" runat="server" CssClass="ctlselect"></asp:DropDownList>

                    </p>
                    <p>
                        <label>Grant Sub Category<b>*</b></label>


                        <asp:TextBox ID="TxtGrantSubType" CssClass="ctlinput" runat="server"></asp:TextBox>

                    </p>
                    <p>
                        <label>Grant Sub-Sub-Sub Category<b>*</b></label>


                        <asp:TextBox ID="TxtGrantSSSType" CssClass="ctlinput" runat="server"></asp:TextBox>

                    </p>
                    <p>
                        <label>Grant Expiry Date<b>*</b></label>


                        <asp:TextBox ID="TxtGrantExpDate" CssClass="ctlinput ctlinput-sm datepicker" runat="server"></asp:TextBox>

                    </p>
                    <p>
                        <label>Any Extension</label>
                        <asp:DropDownList ID="ddlExtension" runat="server" CssClass="ctlselect">
                            <asp:ListItem Text="--Select--" Value="-1" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Yes" Value="1"></asp:ListItem>
                            <asp:ListItem Text="No" Value="0"></asp:ListItem>
                        </asp:DropDownList>
                    </p>
                    <p>
                        <label>Select Duration<b>*</b></label>
                        <asp:DropDownList ID="ddlDuration" runat="server" CssClass="ctlselect">
                        </asp:DropDownList>
                    </p>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-md-12">
                <h3 class="frmHead" data-frm="frmTTSHPiDetail">TTSH PI Details Year Wise Budget Distribution (Single Project) <span>( - )</span></h3>
            </div>
        </div>
        <div class="frm frmTTSHPiDetail" style="display: block;">
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <p>
                        <label>PI Name<b>*</b></label>
                        <asp:DropDownList ID="ddlPIName" runat="server"></asp:DropDownList>

                    </p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-sm-12">
                    <div class="tblResposiveWrapper">
                        <table id="tblSingleBudget" class="tblResposive">
                            <thead>
                                <tr>

                                    <th style="width: 100px; text-align: left">Year</th>
                                    <th style="width: 550px; text-align: left">Factors</th>
                                    <th>Estimated Budget</th>
                                    <th>Actual Spending</th>
                                   
                                </tr>
                            </thead>

                            <tbody>
                                <tr rid="trY1">
                                    <td rowspan="4" data-th="Year">
                                        <span id="Year1">Year1</span>
                                    </td>
                                    <td data-th="Factors">
                                        <span>Man Power</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                   
                                </tr>
                                <tr rid="trY1">

                                    <td data-th="Factors">
                                        <span>Consumables</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY1">

                                    <td data-th="Factors">
                                        <span>Equipment</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY1">

                                    <td data-th="Factors">
                                        <span>Miscellaneuos</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY1">

                                    <td data-th="Factors">
                                        <span style="font-weight: bold">Year1 Total</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <span style="font-weight: bold" id="Y1EstTotal"></span>
                                    </td>
                                    <td data-th="Actual Spending">
                                        <span style="font-weight: bold" id="Y1ActTotal"></span>
                                    </td>

                                </tr>

                                <tr rid="trY2">
                                    <td rowspan="4" data-th="Year">
                                        <span id="Span1">Year2</span>
                                    </td>
                                    <td data-th="Factors">
                                        <span>Man Power</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                   
                                </tr>
                                <tr rid="trY2">

                                    <td data-th="Factors">
                                        <span>Consumables</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY2">

                                    <td data-th="Factors">
                                        <span>Equipment</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY2">

                                    <td data-th="Factors">
                                        <span>Miscellaneuos</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY2">

                                    <td data-th="Factors">
                                        <span style="font-weight: bold">Year2 Total</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <span style="font-weight: bold" id="Span2"></span>
                                    </td>
                                    <td data-th="Actual Spending">
                                        <span style="font-weight: bold" id="Span3"></span>
                                    </td>

                                </tr>

                                <tr rid="trY3">
                                    <td rowspan="5" data-th="Year">
                                        <span id="Span4">Year3</span>
                                    </td>
                                    <td data-th="Factors">
                                        <span>Man Power</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                    
                                </tr>
                                <tr rid="trY3">

                                    <td data-th="Factors">
                                        <span>Consumables</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY3">

                                    <td data-th="Factors">
                                        <span>Equipment</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY3">

                                    <td data-th="Factors">
                                        <span>Miscellaneuos</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY3">

                                    <td data-th="Factors">
                                        <span style="font-weight: bold">Year3 Total</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <span style="font-weight: bold" id="Span5"></span>
                                    </td>
                                    <td data-th="Actual Spending">
                                        <span style="font-weight: bold" id="Span6"></span>
                                    </td>

                                </tr>

                                <tr rid="trY4">
                                    <td rowspan="4" data-th="Year">
                                        <span id="Span7">Year4</span>
                                    </td>
                                    <td data-th="Factors">
                                        <span>Man Power</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY4">

                                    <td data-th="Factors">
                                        <span>Consumables</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY4">

                                    <td data-th="Factors">
                                        <span>Equipment</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY4">

                                    <td data-th="Factors">
                                        <span>Miscellaneuos</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY4">

                                    <td data-th="Factors">
                                        <span style="font-weight: bold">Year4 Total</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <span style="font-weight: bold" id="Span8"></span>
                                    </td>
                                    <td data-th="Actual Spending">
                                        <span style="font-weight: bold" id="Span9"></span>
                                    </td>

                                </tr>

                                <tr rid="trY5">
                                    <td rowspan="4" data-th="Year">
                                        <span id="Span10">Year5</span>
                                    </td>
                                    <td data-th="Factors">
                                        <span>Man Power</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                   
                                </tr>
                                <tr rid="trY5">

                                    <td data-th="Factors">
                                        <span>Consumables</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY5">

                                    <td data-th="Factors">
                                        <span>Equipment</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY5">

                                    <td data-th="Factors">
                                        <span>Miscellaneuos</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY5">

                                    <td data-th="Factors">
                                        <span style="font-weight: bold">Year5 Total</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <span style="font-weight: bold" id="Span11"></span>
                                    </td>
                                    <td data-th="Actual Spending">
                                        <span style="font-weight: bold" id="Span12"></span>
                                    </td>

                                </tr>

                                <tr rid="trY6">
                                    <td rowspan="4" data-th="Year">
                                        <span id="Span13">Year6</span>
                                    </td>
                                    <td data-th="Factors">
                                        <span>Man Power</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                   
                                </tr>
                                <tr rid="trY6">

                                    <td data-th="Factors">
                                        <span>Consumables</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY6">

                                    <td data-th="Factors">
                                        <span>Equipment</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY6">

                                    <td data-th="Factors">
                                        <span>Miscellaneuos</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY6">

                                    <td data-th="Factors">
                                        <span style="font-weight: bold">Year6 Total</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <span style="font-weight: bold" id="Span14"></span>
                                    </td>
                                    <td data-th="Actual Spending">
                                        <span style="font-weight: bold" id="Span15"></span>
                                    </td>

                                </tr>

                                <tr rid="trY7">
                                    <td rowspan="4" data-th="Year">
                                        <span id="Span16">Year7</span>
                                    </td>
                                    <td data-th="Factors">
                                        <span>Man Power</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                  
                                </tr>
                                <tr rid="trY7">

                                    <td data-th="Factors">
                                        <span>Consumables</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY7">

                                    <td data-th="Factors">
                                        <span>Equipment</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY7">

                                    <td data-th="Factors">
                                        <span>Miscellaneuos</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trY7">

                                    <td data-th="Factors">
                                        <span style="font-weight: bold">Year7 Total</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <span style="font-weight: bold" id="Span17"></span>
                                    </td>
                                    <td data-th="Actual Spending">
                                        <span style="font-weight: bold" id="Span18"></span>
                                    </td>

                                </tr>

                                <tr rid="trYMonths">
                                    <td rowspan="4" data-th="Year">
                                        <span id="Span19">6 Months</span>
                                    </td>
                                    <td data-th="Factors">
                                        <span>Man Power</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                    
                                </tr>
                                <tr rid="trYMonths">

                                    <td data-th="Factors">
                                        <span>Consumables</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trYMonths">

                                    <td data-th="Factors">
                                        <span>Equipment</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trYMonths">

                                    <td data-th="Factors">
                                        <span>Miscellaneuos</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>
                                    <td data-th="Actual Spending">
                                        <input type="text" style="width: 200px" class="ctlinput" />
                                    </td>

                                </tr>
                                <tr rid="trYMonths">

                                    <td data-th="Factors">
                                        <span style="font-weight: bold">6 Months Total</span>
                                    </td>
                                    <td data-th="Estimated Budget">
                                        <span style="font-weight: bold" id="Span20"></span>
                                    </td>
                                    <td data-th="Actual Spending">
                                        <span style="font-weight: bold" id="Span21"></span>
                                    </td>

                                </tr>
                            </tbody>
                        </table>
                    </div>

                </div>

            </div>




        </div>

        <div id="HdnSection">
            <asp:HiddenField ID="HdnMode" Value="Insert" runat="server" />
            <asp:HiddenField ID="HdnProjectId" Value="0" runat="server" />
            <asp:HiddenField ID="HdnGranDId" Value="0" runat="server" />
        </div>
    </div>
</asp:Content>
