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
            return "Hi " + name;
        }

        public string HelloMethodWithRef(ref string name)
        {
            return "Hi " + name;
        }
    }
}

