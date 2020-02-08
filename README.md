# Simple Route 53 dynamic DNS service

A simple systemd service to update a Route 53 record with your public IP address.
Useful for tracking your home network IP address,
similar to dynamic DNS services like DynDNS.

# Setting up

On AWS,
you will need to set up a hosted zone in Route 53 and create an IAM limited-access user with at least `route53:ChangeResourceRecordSets` access.
This policy allows the minimum permissions:

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

You will need to have the [AWS CLI](https://aws.amazon.com/cli/) installed.

To configure your AWS API credentials,
update interval,
hosted zone and DNS record name,
edit `/etc/route53-dynamic-dns/config`.

By default the service is configured to update every 30 minutes.