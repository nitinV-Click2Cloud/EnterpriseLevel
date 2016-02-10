using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;
using System.Data;
using System.ComponentModel;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Configuration;
using TTSH.Entity;

namespace TTSHWeb
{
    public class tbl_User
    {

        public int ID
        {
            get;
            set;
        }

        public string UserName
        {
            get;
            set;
        }

        public string PassWord
        {
            get;
            set;
        }
        public string Guid
        {
            get;
            set;
        }
    }
    public partial class Login : System.Web.UI.Page
    {
        #region Declaration

        

        #endregion
        protected void Page_Load(object sender, EventArgs e)
        {
		if ( !IsPostBack )
			{
			txtUserName.Focus();
			}

        }

        #region PageLoad
        protected async void btnLogin_Click(object sender, EventArgs e)
        {

            try { 
            using (var client = new HttpClient())
            {
                //  http://aspnet-example-webapi-1stfeb.cloudapps.click2cloud.net/
                Session["WebApiUrl"] = "http://aspnet-example-webapi.cloudapps.click2cloud.net/".ToString();
                //client.BaseAddress = new Uri(ConfigurationManager.AppSettings["WebApiUrl"].ToString());
                client.BaseAddress = new Uri(Session["WebApiUrl"].ToString());
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                // New code:
                HttpResponseMessage response = await client.GetAsync(string.Format("api/User/{0}?&passWord={1}",txtUserName.Text,txtPassword.Text));
                //response.Content.ReadAsStringAsync().Result
                if (response.IsSuccessStatusCode && !string.IsNullOrEmpty(response.Content.ReadAsStringAsync().Result))
                {
                    JavaScriptSerializer serializer = new JavaScriptSerializer();
                    tbl_User user = serializer.Deserialize<tbl_User>(response.Content.ReadAsStringAsync().Result.ToString());
                   Session["UserID"] = user.Guid.ToString();
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                     response = await client.GetAsync("api/Menu/");
                      serializer = new JavaScriptSerializer();
                    //WebApiContrib.Formatting.JavaScriptSerializerFormatter serializer = new WebApiContrib.Formatting.JavaScriptSerializerFormatter();
                    IEnumerable<ADUserDetails> collection = serializer.Deserialize<IEnumerable<ADUserDetails>>(response.Content.ReadAsStringAsync().Result);

                    //List<ADUserDetails> userMenuldt = new List<ADUserDetails>();
                    //userMenuldt = proxy.GetMenusByGroup(string.Empty).ToList();

                    DataTable dttable = new DataTable();
                    dttable = ToDataTable(collection);

                    Session["MenuDT"] = dttable;
                    Response.Redirect("Dashboard.aspx", false);

                }
                else
                {
                      FailureText.Text = "Invalid Login Name/Password.";
                }
                }
            }
            catch (Exception ex)
            {
                FailureText.Text = "Invalid Login Name/Password.";
            }
            
        }
        #endregion

        #region Methods
        // Sapna K: Method to get allowed menu names in session
        private void PopulateMenu()
        {
            try
            {
                Menu UserMenu = (Menu)Master.FindControl("UserMenu");
                // Sapna K: Call Method to get Parent and Child menu names
                DataSet ds = GetDataSetForMenu();
                // Sapna K: Create new arraylist object to store menu item
                System.Collections.ArrayList arrMenus = new System.Collections.ArrayList();
                UserMenu.Items.Clear();
                // Sapna K: Add 'Home' as default menu item
                //MenuItem HomeItem = new MenuItem("Dashboard", "", "", "~/Dashboard.aspx", "_parent");
                //Menu1.Items.Add(HomeItem);
                //arrMenus.Add("Dashboard.aspx");

                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow parentItem in ds.Tables[0].Rows)
                        {
                            // Sapna K: Add Parent Menu Item in allowed menu item list
                            MenuItem categoryItem = new MenuItem((string)parentItem["MenuName"]);

                            UserMenu.Items.Add(categoryItem);
                            arrMenus.Add((string)parentItem["MenuName"]);

                            foreach (DataRow childItem in parentItem.GetChildRows("Children"))
                            {
                                // Sapna K: Add Child Menu Item in allowed menu item list
                                MenuItem childrenItem = new MenuItem((string)childItem["MenuName"], "", "", "~/" + Convert.ToString(childItem["Url"]), "_parent");
                                categoryItem.ChildItems.Add(childrenItem);
                                arrMenus.Add(Convert.ToString(childItem["Url"]));

                            }
                        }
                    }
                }
                HttpContext.Current.Session["AllowedMenus"] = arrMenus;
            }
            catch (Exception Ex) { }
        }

        // Sapna K: Method to get Parent and Child menu names in Data Table and establish a relationship between Parent & Child table
        private DataSet GetDataSetForMenu()
        {
            DataSet ds = new DataSet();
            try
            {
                if (((DataTable)HttpContext.Current.Session["MenuDT"]).Select("[Parent] = '0'").Count() > 0 && ((DataTable)HttpContext.Current.Session["MenuDT"]).Select("[Parent] <> '0'").Count() > 0)
                {
                    DataTable DTParent = ((DataTable)HttpContext.Current.Session["MenuDT"]).Select("[Parent] = '0'").CopyToDataTable();
                    DataTable DTChild = ((DataTable)HttpContext.Current.Session["MenuDT"]).Select("[Parent] <> '0'").CopyToDataTable();
                    ds.Tables.Add(DTParent);
                    ds.Tables.Add(DTChild);
                    DataSet dd = new DataSet();
                    dd = ds;
                    ds.Relations.Add("Children", ds.Tables["Table1"].Columns["Child"], ds.Tables["Table2"].Columns["Parent"]);

                }
            }
            catch (Exception Ex) { }
            return ds;
        }

        /*****************************************/
        public DataTable ToDataTable<T>(IEnumerable<T> data)
        {
            PropertyDescriptorCollection props = TypeDescriptor.GetProperties(typeof(T));
            object[] values = new object[props.Count];
            using (DataTable table = new DataTable())
            {
                long pCt = props.Count;
                for (int i = 0; i < pCt; ++i)
                {
                    PropertyDescriptor prop = props[i];
                    table.Columns.Add(prop.Name, prop.PropertyType);
                }
                foreach (T item in data)
                {
                    long vCt = values.Length;
                    for (int i = 0; i < vCt; ++i)
                    {
                        values[i] = props[i].GetValue(item);
                    }
                    table.Rows.Add(values);
                }
                return table;
            }
        }
        #endregion
    }
}
