using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Configuration;

namespace TTSHWeb
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                HidId.Value = "Rpt_PM";
                btnHidden_OnClick(null, null);
            }

        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                   ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Highliter", "setSelected();", true);
                }
            }
            catch (Exception ex)
            {
                
            }
        }

        protected void btnHidden_OnClick(object sender, EventArgs e)
        {
            try
            {
                string Report_Folder = "TTSHCRIO_REPORT";//ConfigurationManager.AppSettings["ReportFolder"].ToString();
                
                if (HidId.Value.ToString() == "Rpt_PM")
                {
                  //  DivRpt.Visible = true;
                    ReportViewerSSRSDemo.ShowCredentialPrompts = false;
                    
                        ReportViewerSSRSDemo.ServerReport.ReportServerCredentials = new ReportCredentials("testlab\ttshadmin", "Newuser@123", "RSINNGP");
                             //ReportViewerSSRSDemo.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportUserName"].ToString(), ConfigurationManager.AppSettings["ReportPassword"].ToString(), ConfigurationManager.AppSettings["ReportDomain"].ToString());

                    ReportViewerSSRSDemo.ServerReport.ReportServerUrl = new Uri("http://192.168.0.110:7070/ReportServer"); //new Uri(ConfigurationManager.AppSettings["ReportURI"].ToString());

                    ReportViewerSSRSDemo.ServerReport.ReportPath =  Report_Folder + "/ProjectDashBoardRpt";

                    ReportViewerSSRSDemo.ProcessingMode = ProcessingMode.Remote;

                    ReportViewerSSRSDemo.ShowParameterPrompts = false;

                    ReportViewerSSRSDemo.ShowPromptAreaButton = false;

                    ReportViewerSSRSDemo.ServerReport.Refresh();

                }
                else if (HidId.Value.ToString() == "Rpt_CM")
                {
                  //  DivRpt.Visible = true;
                    ReportViewerSSRSDemo.ShowCredentialPrompts = false;

                    //ReportViewerSSRSDemo.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportUserName"].ToString(), ConfigurationManager.AppSettings["ReportPassword"].ToString(), ConfigurationManager.AppSettings["ReportDomain"].ToString());
                    ReportViewerSSRSDemo.ServerReport.ReportServerCredentials = new ReportCredentials("testlab\ttshadmin", "Newuser@123", "RSINNGP");

                    ReportViewerSSRSDemo.ServerReport.ReportServerUrl = new Uri("http://192.168.0.110:7070/ReportServer"); //new Uri(ConfigurationManager.AppSettings["ReportURI"].ToString());

                    ReportViewerSSRSDemo.ServerReport.ReportPath =  Report_Folder + "/ContractStatusDBRpt";

                    ReportViewerSSRSDemo.ProcessingMode = ProcessingMode.Remote;

                    ReportViewerSSRSDemo.ShowParameterPrompts = false;

                    ReportViewerSSRSDemo.ShowPromptAreaButton = false;

                    ReportViewerSSRSDemo.ServerReport.Refresh();

                }
                else if (HidId.Value.ToString() == "Rpt_RM")
                {
                 //   DivRpt.Visible = true;
                    ReportViewerSSRSDemo.ShowCredentialPrompts = false;

                    // ReportViewerSSRSDemo.ServerReport.ReportServerCredentials = new ReportCredentials(ConfigurationManager.AppSettings["ReportUserName"].ToString(), ConfigurationManager.AppSettings["ReportPassword"].ToString(), ConfigurationManager.AppSettings["ReportDomain"].ToString());
                    ReportViewerSSRSDemo.ServerReport.ReportServerCredentials = new ReportCredentials("testlab\ttshadmin", "Newuser@123", "RSINNGP");

                    ReportViewerSSRSDemo.ServerReport.ReportServerUrl = new Uri("http://192.168.0.110:7070/ReportServer"); //new Uri(ConfigurationManager.AppSettings["ReportURI"].ToString());

                    ReportViewerSSRSDemo.ServerReport.ReportPath =  Report_Folder + "/RegulatoryStatusDBRpt";

                    ReportViewerSSRSDemo.ProcessingMode = ProcessingMode.Remote;

                    ReportViewerSSRSDemo.ShowParameterPrompts = false;

                    ReportViewerSSRSDemo.ShowPromptAreaButton = false;

                    ReportViewerSSRSDemo.ServerReport.Refresh();

                }

                else if (HidId.Value.ToString() == "Rpt_GM")
                {
                    //   DivRpt.Visible = true;
                    ReportViewerSSRSDemo.ShowCredentialPrompts = false;

                    ReportViewerSSRSDemo.ServerReport.ReportServerCredentials = new ReportCredentials("testlab\ttshadmin", "Newuser@123", "RSINNGP");

                    ReportViewerSSRSDemo.ServerReport.ReportServerUrl = new Uri("http://192.168.0.110:7070/ReportServer"); //new Uri(ConfigurationManager.AppSettings["ReportURI"].ToString());

                    ReportViewerSSRSDemo.ServerReport.ReportPath =  Report_Folder + "/GrantDashBoardRpt";

                    ReportViewerSSRSDemo.ProcessingMode = ProcessingMode.Remote;

                    ReportViewerSSRSDemo.ShowParameterPrompts = false;

                    ReportViewerSSRSDemo.ShowPromptAreaButton = false;

                    ReportViewerSSRSDemo.ServerReport.Refresh();

                }
                else
                {
                //    DivRpt.Visible = false;
                }
               
                ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "Highliter", "setSelected();", true);

            }
            catch (Exception ex)
            {
                
                
            }
        }

        public sealed class ReportCredentials : IReportServerCredentials
        {
            private string _username;
            private string _password;
            private string _domain;

            public ReportCredentials(string username, string password, string domain)
            {
                _username = username;
                _password = password;
                _domain = domain;
            }
            public System.Net.ICredentials NetworkCredentials
            {
                get { return new System.Net.NetworkCredential(_username, _password, _domain); }
            }
            public bool GetFormsCredentials(out System.Net.Cookie authCookie,
            out string userName,
            out string password,
            out string authority)
            {
                authCookie = null;
                userName = null;
                password = null;
                authority = null;

                return false;
            }

            public System.Security.Principal.WindowsIdentity ImpersonationUser
            {
                get { return null; }
            }
        }
    }
}