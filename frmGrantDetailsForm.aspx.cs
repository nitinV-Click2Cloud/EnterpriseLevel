using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TTSHWeb.TTSHWCFReference;
namespace TTSHWeb
{
    public partial class frmGrantDetailsForm : System.Web.UI.Page
    {
        #region " Page Load "
        protected void Page_Load(object sender, EventArgs e)
        {
            SearchBox.SearchFilterCriteria = TTSHWeb.SearchBox.FilterCriteria.GRANT;
            SearchBox.ButtonSearchClick += SearchBox_ButtonSearchClick;
            SearchBox.ButtonClearClick += SearchBox_ButtonClearClick;
            if (!IsPostBack)
            {
                ShowPanel(); FillGridMain();
            }
        }
        #endregion

        #region " Methods & Functions "
        protected void ShowPanel(string type = "Main")
        {
            DivMain.Style["display"] = "block";
            DivEntry.Style["display"] = "block";
            //  btnSave.Visible = true;
            //  btnSave.Text = "Save";
            BindCombo();
            if (type.ToLower() == "entry")
            {

                DivMain.Style["display"] = "none";

                switch (HdnMode.Value.ToLower())
                {

                    case "insert":
                        //  btnSave.Text = "Save";
                        break;
                    case "update":
                        // btnSave.Text = "Update";
                        break;
                    case "delete":
                        // btnSave.Text = "Delete";
                        break;
                    case "view":
                        // btnSave.Visible = false;
                        break;
                }
            }
            else
            {
                DivEntry.Style["display"] = "none";
            }
        }
        protected void FillGridMain()
        {
            TTSHWCFServiceClient cl = new TTSHWCFServiceClient();
            try
            {
                List<Grant_Details> lstgrantDetail = new List<Grant_Details>();
                lstgrantDetail = cl.FillGrantDetailGrid().ToList();
                RptGrantGrid.DataSource = lstgrantDetail;
                RptGrantGrid.DataBind();
            }
            catch (Exception ex)
            {

                this.MsgBox(ex.Message.ToString().Replace("'"," "));
                
            }
        }
        protected void ClearHDN()
        {
            HdnAwardLetterFile.Value = "";
            HdnGranDId.Value = "0";
            HdnMode.Value = "Insert";
            HdnProjectId.Value = "0";
        }
        protected void BindCombo() 
        {
            //ddlGrantDetailStatus.FillCombo(DropDownName.GrantDetailStatus);
            ddlDuration.FillCombo(DropDownName.GrantDuration);
        }
        #endregion

        #region " Events "
         void SearchBox_ButtonClearClick(object sender, EventArgs e)
        {
            FillGridMain();
        }

        void SearchBox_ButtonSearchClick(object sender, EventArgs e)
        {
            SearchBox.SearchInputValue = ((TextBox)(SearchBox.FindControl("txtSearch"))).Text;
            TTSHWCFServiceClient client = new TTSHWCFServiceClient();

            if (string.IsNullOrEmpty(SearchBox.ErrorString))
            {
                Search[] lst = SearchBox.SearchOutput;

                try
                {

                    
                    client.Open();
                    string UserID = Convert.ToString(Session["UserID"]).ToUpper();
                    Project_DataOwner[] oDOList = client.GetProjectsByDO("Grant", UserID);
                    DataOwner_Entity[] oDataOwner = client.GetAllDataOwner("TAdmin");

                    var AdminArray = (from s in oDataOwner
                                      select s.GUID).ToList();

                    bool IsAdmin = AdminArray.Contains(UserID);


                    List<Search> oNewGrid = new List<Search>();
                    List<Search> oOldSearch = new List<Search>();

                    if (IsAdmin == false)
                    {
                        if (lst != null && lst.Count() > 0 && oDOList != null && oDOList.Count() > 0)
                        {
                            oOldSearch = lst.ToList();
                            oNewGrid = oOldSearch.Where(z => z.iRecordExists == 0).Where(z => oDOList.Any(x => x.s_DisplayProject_ID == z.s_Display_Project_ID)).ToList();
                            //oNewGrid.ForEach(i => i.Status = "New");
                            oOldSearch.RemoveAll(z => z.iRecordExists == 0);
                            oOldSearch.AddRange(oNewGrid);

                            foreach (var element in oOldSearch)
                            {
                                if (element.iRecordExists == 0)
                                {
                                    element.Status = "New";
                                }
                                else
                                {
                                    bool flag = false;
                                    foreach (var item in oDOList)
                                    {
                                        if (item.s_DisplayProject_ID == element.s_Display_Project_ID)
                                        {
                                            flag = true;
                                            break;
                                        }
                                        else
                                        {
                                            flag = false;
                                        }
                                    }
                                    if (flag == true)
                                    {
                                        element.Status = "Edit";
                                    }
                                    else
                                    {
                                        element.Status = "View";
                                    }
                                }
                            }

                            oOldSearch = oOldSearch.OrderByDescending(z => z.i_ID).ToList();

                            RptGrantGrid.DataSource = oOldSearch; /*use the object according to your need*/
                            RptGrantGrid.DataBind();
                        }
                        else
                        {
                            foreach (var element in lst)
                            {
                                if (element.iRecordExists == 0)
                                {
                                    element.Status = "New";
                                }
                                else
                                {
                                    bool flag = false;
                                    foreach (var item in oDOList)
                                    {
                                        if (item.s_DisplayProject_ID == element.s_Display_Project_ID)
                                        {
                                            flag = true;
                                            break;
                                        }
                                        else
                                        {
                                            flag = false;
                                        }
                                    }
                                    if (flag == true)
                                    {
                                        element.Status = "Edit";
                                    }
                                    else
                                    {
                                        element.Status = "View";
                                    }
                                }
                            }

                            RptGrantGrid.DataSource = lst; /*use the object according to your need*/
                            RptGrantGrid.DataBind();
                        }
                    }
                    else
                    {


                        oOldSearch = lst.ToList();
                        oNewGrid = oOldSearch.Where(z => z.iRecordExists == 0).ToList();
                        oOldSearch.RemoveAll(z => z.iRecordExists == 0);
                        oOldSearch.AddRange(oNewGrid);

                        foreach (var element in oOldSearch)
                        {
                            if (element.iRecordExists == 0)
                            {
                                element.Status = "New";
                            }
                            else
                            {
                                element.Status = "Edit";
                            }
                        }
                        oOldSearch = oOldSearch.OrderByDescending(z => z.i_Project_ID).ToList();

                        RptGrantGrid.DataSource = oOldSearch; /*use the object according to your need*/
                        RptGrantGrid.DataBind();
                    }
                }
                catch (Exception ex)
                {

                }
                client.Close();

              
            }
            else
            {
              
                RptGrantGrid.DataSource = null;
                RptGrantGrid.DataBind();
            }
        }
        protected void lnkback_Click(object sender, EventArgs e)
        {
            ClearHDN(); ShowPanel(); 
        }
        #endregion

        #region " Repeater Event "
        protected void RptGrantGrid_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
             try
            {
                if (e.CommandName != "")
                {
                    ClearHDN();
                    HdnProjectId.Value = e.CommandArgument.ToString();
                    if (e.CommandName.ToLower() == "cmddelete" | e.CommandName.ToLower() == "cmdedit" | e.CommandName.ToLower() == "cmdview" | e.CommandName.ToLower() == "cmdadd")
                    {
                        HdnMode.Value = e.CommandName.ToString().ConverMode();

                        ShowPanel("entry");
                        bool enabled = (e.CommandName.ToString().ConverMode().ToLower() == "delete" || e.CommandName.ToString().ConverMode().ToLower() == "view") ? false : true;

                       
                        if (HdnMode.Value.ToLower() == "insert")
                        {
                          //  FillProjectDataForNewEntry();
                        }
                        else
                        {
                            HdnGranDId.Value = e.CommandArgument.ToString();
                           // FillControl();
                        }
                    }
                }
            }
            catch (Exception ex)
            {

                this.MsgBox(ex.Message.ToString());
            }
        } 
        #endregion

       

    }
}