using System;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Tcp;

namespace RemotingBug
{
    public class Server
    {
        public static int Main(string [] args)
        {
            TcpChannel chan = new TcpChannel(8085);
            ChannelServices.RegisterChannel(chan);
            RemotingConfiguration.RegisterWellKnownServiceType(Type.GetType("RemotingBug.Interface,shared"),
                                                               "SayHello", WellKnownObjectMode.SingleCall);
            System.Console.WriteLine("Listening. Hit <enter> to exit...");
            System.Console.ReadLine();
            return 0;
        }
    }
}

