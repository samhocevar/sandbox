using System;
using System.Runtime.Remoting;
using System.Runtime.Remoting.Channels;
using System.Runtime.Remoting.Channels.Tcp;

namespace RemotingBug
{
    public class Interface : MarshalByRefObject
    {
        public string HelloMethod(string name)
        {
            return string.Format("{0} #{1}", name, ++counter);
        }

        public string HelloMethodWithRef(ref string name) { return HelloMethod(name); }

        private static int counter = 0;
    }
}

