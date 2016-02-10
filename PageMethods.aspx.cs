using System;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Configuration;
namespace TTSHWeb
{
    public partial class PageMethods : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }

        }

        [WebMethod()]
        [ScriptMethod()]
        public static string GetValidate(string _ModuleName, string _A, string _B, string _C, string _D)
        {
            string Result = "";
            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(System.Web.HttpContext.Current.Session["WebApiUrl"].ToString());
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                    var response = client.GetAsync(string.Format("api/Validate/{0}?&_A={1}?&_B={2}?&_C={3}?&_D={4}", _ModuleName, _A, _B, _C, _D)) ;
                    
                }
                        
            }
            catch (Exception)
            {

                Result = "#Error";
            }
            return Result;
        }


        [WebMethod]
        [ScriptMethod]
        public static  string[] GetText(string Prefix, int count, string ContextKey)
        {
            //TTSHWCFServiceClient sc = new TTSHWCFServiceClient();
            List<string> lst = new List<string>();
            //lst.AddRange(sc.GetText(Prefix, count, ContextKey));
            using (var client = new HttpClient())
            {
                //  http://aspnet-example-webapi-1stfeb.cloudapps.click2cloud.net/
                client.BaseAddress = new Uri(System.Web.HttpContext.Current.Session["WebApiUrl"].ToString());
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                HttpResponseMessage response =  client.GetAsync(string.Format("api/AutoComplete/{0}?&count={1}?&ContextKey={2}", Prefix, count, ContextKey)).Result;
                if (response.IsSuccessStatusCode && !string.IsNullOrEmpty(response.Content.ReadAsStringAsync().Result))
                {
                    System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    lst = serializer.Deserialize<List<string>>(response.Content.ReadAsStringAsync().Result);
                }
            }
                    return lst.ToArray();
        }

        [WebMethod]
        [ScriptMethod]
        public static string GetPI_MasterDetailsByID(int ID)
        {
            string Result = "";
            try
            {
         //       Result = cl.GetPI_MasterDetailsByID(ID);
            }
            catch (Exception)
            {

                Result = "";
            }
            return Result;
        }

        [WebMethod]
        [ScriptMethod]
        public static string GetCollobrator_MasterDetailByID(int ID)
        {
            string Result = "";
            //TTSHWCFServiceClient cl = new TTSHWCFServiceClient();
            //try
            //{
            //    Result = cl.GetCollobrator_MasterDetailByID(ID);
            //}
            //catch (Exception)
            //{

            //    Result = "";
            //}
            return Result;
        }


       
    }
}
