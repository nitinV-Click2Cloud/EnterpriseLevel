using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TTSHWeb.TTSHWCFReference;
namespace TTSHWeb
{
    public partial class frmGrantSeniorCSCS : System.Web.UI.Page
    {
        #region " Page Load "
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClearHDN();
                ShowPanel(); FillMainGrid();
            }
        }
        #endregion


        #region " Methods and Fucntions "
        protected void ShowPanel(string type = "Main")
        {
            DivMain.Style["display"] = "block";
            DivEntry.Style["display"] = "block";
            btnSave.Visible = true;
            btnSave.Text = "Save";
            FillCombo();
            if (type.ToLower() == "entry")
            {

                DivMain.Style["display"] = "none";

                switch (HdnMode.Value.ToLower())
                {

                    case "insert":
                        btnSave.Text = "Save";
                        break;
                    case "update":
                        btnSave.Text = "Update";
                        break;
                    case "delete":
                        btnSave.Text = "Delete";
                        break;
                    case "view":
                        btnSave.Visible = false;
                        break;
                }
            }
            else
            {
                DivEntry.Style["display"] = "none";
            }
        }
        protected void ClearHDN()
        {
            HdnDeptId.Value = "0";
            HdnDeptTxt.Value = "";
            HdnFldAwardLetter.Value = "";
            HdnGranDId.Value = "0";
            HdnMode.Value = "Insert";
            HdnpiId.Value = "0";
            HdnPITxt.Value = "";
            HdnProjectId.Value = "0";
            HdnPi_ID.Value = "";

        }
        protected void FillMainGrid()
        {
            TTSHWCFServiceClient cl = new TTSHWCFServiceClient();
            List<Senior_CSCS_Details> lstcscs = new List<Senior_CSCS_Details>();
            try
            {
                lstcscs = cl.FillGrantSeniorCSCSGrid().ToList();
                RptGrantGridSeniorCSCS.DataSource = lstcscs;
                RptGrantGridSeniorCSCS.DataBind();
            }
            catch (Exception ex)
            {

                this.MsgBox(ex.Message.ToString().Replace("'", ""));
            }
        }
        protected void FillCombo()
        {
            ddlAwardOrg.FillCombo(DropDownName.GrantAwardingOrganization);
        }
        protected void FillControl()
        {

        }
        protected bool Save()
        {
            try
            {

            }
            catch (Exception ex)
            {

                this.MsgBox(ex.Message.ToString().Replace("'", ""));
            }
            return true;
        }
        #endregion

        #region " Button Event "
        protected void btnNew_Click(object sender, EventArgs e)
        {
            ShowPanel("entry");
        }
        protected void lnkback_Click(object sender, EventArgs e)
        {
            ClearHDN();
            ShowPanel(); 
        }
        #endregion

        #region " Repeater Event "
        protected void RptGrantGridSeniorCSCS_ItemCommand(object source, RepeaterCommandEventArgs e)
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
                        HdnGranDId.Value = e.CommandArgument.ToString();
                        FillControl();

                    }
                }
            }
            catch (Exception ex)
            {

                this.MsgBox(ex.Message.ToString().Replace("'", ""));
            }
        }
        #endregion


    }
}