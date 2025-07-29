using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace Group1_Project_ASPNET_Travel_Booking
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);
            routes.Ignore("{resource}.axd/{*pathInfo}");

            routes.MapPageRoute("Default", "Travel/Default", "~/Default.aspx");
            routes.MapPageRoute("About Us", "Travel/AboutUs", "~/About_us_screen.aspx");
            routes.MapPageRoute("Contact Us", "Travel/ContactUs", "~/Contact_us_screen.aspx");
            routes.MapPageRoute("Login", "Travel/Login", "~/Login.aspx");

        }
    }
}
