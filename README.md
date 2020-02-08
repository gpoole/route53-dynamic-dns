# Simple Route 53 dynamic DNS service

A simple systemd service to periodically update a Route 53 record with the public IP address of the machine the service is running on.
Useful for when you want a Route 53 A record to track a dynamic public IP address,
for example of a home network.
A self-managed alternative to free dynamic DNS services like DynDNS for AWS users.

# Setting up

On AWS,
you will need to set up a hosted zone in Route 53 and create an IAM limited-access user with at least `route53:ChangeResourceRecordSets` access.
The following sample policy provides the minimum access required (note you need to specify your own hosted zone ID):

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "route53:ChangeResourceRecordSets",
            "Resource": "arn:aws:route53:::hostedzone/<<YOUR HOSTED ZONE ID HERE>>"
        }
    ]
}
```

On the target machine in your own network,
clone this repo and run:

```sh
git clone git@github.com:gpoole/route53-dynamic-dns.git
sudo ./install.sh
```

To configure your AWS API credentials,
the hosted zone and record to update,
edit `/etc/route53-dynamic-dns/config`.

By default the service is configured to update the address every 30 minutes,
but you can change that by updating `OnActiveSec` in [route53-dynamic-dns.timer](./route53-dynamic-dns.timer) and running the installer again.
If you want to manually trigger a one-off update,
run:

```sh
systemctl start route53-dynamic-dns
```