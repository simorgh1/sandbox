using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

namespace src
{
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args) =>
            Host.CreateDefaultBuilder(args)
                .ConfigureWebHostDefaults(webBuilder =>
                webBuilder.ConfigureAppConfiguration((hostingContext, config) =>
                {
                    config.AddJsonFile("/etc/configuration/appsettings.json", optional: true, reloadOnChange: true);
                    config.AddEnvironmentVariables("SQLSERVER_");
                })
                .UseStartup<Startup>());
                }
}
