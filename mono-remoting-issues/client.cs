using System;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Tcp;
using System.Threading;

namespace RemotingBug
{
    public class Client
    {
        delegate string HelloMethodDelegate(string name);
        delegate string HelloMethodWithRefDelegate(ref string name);

        public static int Main(string [] args)
        {
            TcpChannel chan = new TcpChannel();
            ChannelServices.RegisterChannel(chan);
            Interface obj = (Interface)Activator.GetObject(typeof(RemotingBug.Interface), "tcp://192.168.2.55:8085/SayHello");
            if (obj == null)
            {
                System.Console.WriteLine("Could not locate server");
                return -1;
            }

            HelloMethodDelegate method = new HelloMethodDelegate(obj.HelloMethod);
            HelloMethodWithRefDelegate method_with_ref = new HelloMethodWithRefDelegate(obj.HelloMethodWithRef);
            IAsyncResult ret;

            // Test 1: direct call
            string a = obj.HelloMethod("A");
            Console.WriteLine("Test 1: {0}", a);

            // Test 2: delegate call
            string b = method("B");
            Console.WriteLine("Test 2: {0}", b);

            // Test 3: async call, with ref
            string arg = "C";
            ret = method_with_ref.BeginInvoke(ref arg, null, null);
            string c = method_with_ref.EndInvoke(ref arg, ret);
            Console.WriteLine("Test 3: {0}", c);

            // Test 4: async call, no ref
            ret = method.BeginInvoke("D", null, null);
            string d = method.EndInvoke(ret);
            Console.WriteLine("Test 4: {0}", d);

            return 0;
        }
    }
}

