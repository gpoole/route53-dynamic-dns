#!/bin/bash
PUBLIC_IP=`curl -s https://httpbin.org/ip | sed -nE 's/^.*"origin": "([^"]+)".*$/\1/pg' | tr -d '\n'`

echo "Updating $RECORD_NAME to point to $PUBLIC_IP"

read -r -d '' UPDATE <<JSON
{
    "HostedZoneId": "$HOSTED_ZONE_ID",
    "ChangeBatch": {
        "Comment": "",
        "Changes": [
            {
                "Action": "UPSERT",
                "ResourceRecordSet": {
                    "Name": "$RECORD_NAME",
                    "Type": "A",
                    "TTL": 5,
                    "ResourceRecords": [
                        {
                            "Value": "$PUBLIC_IP"
                        }
                    ]
                }
            }
        ]
    }
}
JSON

aws route53 change-resource-record-sets --cli-input-json "$UPDATE" >/dev/null