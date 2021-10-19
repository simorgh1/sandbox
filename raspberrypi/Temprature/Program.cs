using System;
using Iot.Device.CpuTemperature;
using System.Threading;

namespace IOT
{
    class Program
    {
        static CpuTemperature temperature = new CpuTemperature();
        static void Main(string[] args)
        {
            while (true)
            {
                if (temperature.IsAvailable)
                {
                    Console.WriteLine($"CPU temp: {temperature.Temperature.Celsius:.##}C");
                }

                Thread.Sleep(5000); // sleep for 5000 milliseconds, 2 seconds
            }
        }
    }
}
