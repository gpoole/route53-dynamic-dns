#!/bin/bash
echo "Installing services..."
cp route53-dynamic-dns.service /etc/systemd/system
cp route53-dynamic-dns.timer /etc/systemd/system
cp -f ./update-route53-dynamic-dns.sh /usr/bin/

mkdir -p /etc/route53-dynamic-dns/
if ! [ -r /etc/route53-dynamic-dns/config ]; then
  echo "Installing /etc/route53-dynamic-dns/config..."
  cp ./config.example /etc/route53-dynamic-dns/config
fi

echo "Enabling services..."
systemctl enable route53-dynamic-dns.service route53-dynamic-dns.timer
systemctl start route53-dynamic-dns.timer

echo "Done."