using System;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Tcp;
using System.Threading;

namespace RemotingBug
{
    public class Client
    {
        delegate string HelloMethodDelegate(string s);
        delegate string HelloMethodWithRefDelegate(ref string s);

        public static int Main(string [] args)
        {
            if (args.Length != 1)
            {
                Console.WriteLine("Usage: client.exe <IP address>");
                return -1;
            }

            ChannelServices.RegisterChannel(new TcpChannel(), false);
            var obj = (Interface)Activator.GetObject(typeof(RemotingBug.Interface), "tcp://" + args[0] + ":8085/SayHello");
            if (obj == null)
                return -1;

            var m1 = new HelloMethodDelegate(obj.HelloMethod);
            var m2 = new HelloMethodWithRefDelegate(obj.HelloMethodWithRef);
            string s = "Hello";
            IAsyncResult tmp;

            // Test 1: direct call
            Console.WriteLine( obj.HelloMethod(s) );

            // Test 2: delegate call
            Console.WriteLine( m1(s) );

            // Test 3: invoke call
            Console.WriteLine( m1.Invoke(s) );

            // Test 4: async call, with ref
            tmp = m2.BeginInvoke(ref s, null, null);
            Console.WriteLine( m2.EndInvoke(ref s, tmp) );

            // Test 5: async call, no ref
            tmp = m1.BeginInvoke(s, null, null);
            Console.WriteLine( m1.EndInvoke(tmp) );

            return 0;
        }
    }
}

