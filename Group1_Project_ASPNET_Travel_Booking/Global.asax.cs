using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            ScriptResourceDefinition jQuery = new ScriptResourceDefinition
            {
                Path = "~/Scripts/jquery-1.9.1.min.js",
                DebugPath = "~/Scripts/jquery-1.9.1.js",
                CdnPath = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.9.1.min.js",
                CdnDebugPath = "https://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.9.1.js",
                CdnSupportsSecureConnection = true,
                LoadSuccessExpression = "window.jQuery"
            };
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", jQuery);
        }
    }
}