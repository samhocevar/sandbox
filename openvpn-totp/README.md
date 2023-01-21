# OpenVPN + TOTP

Fuck 2FA and TOTP, I am fed up with having to pull my phone every two minutes when logging to yet
another service. This script runs forever, updating my OpenVPN login/pass file with the correct
TOTP token.

Usage:

```sh
openvpn-totp.py <totp_file> <cred_file>
```

## What does it do?

Typically your OpenVPN configuration file will have an entry like this:

    auth-user-pass joe.cred

And the `joe.cred` file will have your login and password:

    joe.smith
    AJBgNVBAsMAk9VMSIw

This script will regularly update the `joe.cred` file and append the TOTP token to the password
line, without you having to type it in every time, *e.g.*:

    joe.smith
    AJBgNVBAsMAk9VMSIw903948

## Installing

Requires Python 3 and the oathtool package (`pip3 install oathtool`)

### Windows usage

On Windows the usual way to use this will be through the Task Scheduler, just create a new task and
make sure ALL of the following is true:

 - SET “Run whether user is logged on or not”
 - SET “Do not store password. The task will only have access to local resources”
 - Trigger: “At system startup”
 - Task:
   - Program/script: `C:/Python311/pythonw.exe` (or your preferred Python version)
   - Add arguments:
     - the path to this script, *e.g.* `C:/ProgramData/bin/openvpn-totp.py`
     - the path to the Base32 TOTP secret, *e.g.* `C:/Users/joe/.secrets/vpn.totp`
     - the path to the OpenVPN credential file, *e.g.* `C:/Users/joe/OpenVPN/config/joe.cred`
 - UNSET “Start the task only if the computer is on AC power”
 - UNSET “Stop if the computer switches to battery power”
 - UNSET “Stop the task if it runs longer than: …”

### Linux usage

You may use `crontab` and its special `@reboot` directive. See `man 5 crontab` for more
information.

    @reboot /usr/local/bin/openvpn-totp.py /home/joe/.secrets.vpn.totp /home/joe/OpenVPN/config/joe.cred

## Does this reduce security?

TL;DR: Yes. If unsure, don’t use this.

Of course, TOTP’s main purpose is to mitigate compromised passwords. It prevents situations when
a password is stolen through *e.g.* a phishing operation, when a user re-uses the same password
on multiple services, or when they use a password so simple that it can be easily brute-forced.
The suggested setup for this script still protects you against that, if someone just steals your
password you’re still OK.

**However**, if someone gains control of your whole PC then you’re really screwed because it’s
as if they had both your password and your 2FA device. So don’t fuck up.
