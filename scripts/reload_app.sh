#!/bin/bash

/var/apps/mymoney/start-application

#Slack Notification
curl -X POST --data-urlencode 'payload={"text": "Deployment '${DEPLOYMENT_ID}' of '${APPLICATION_NAME}' on '${DEPLOYMENT_GROUP_NAME}' has completed"}' https://hooks.slack.com/services/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
