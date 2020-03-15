#!/bin/sh

FOLDER=$(date +%Y-%m-%dT%H:%M)
DUMP_BUCKET=healthworkers-dumps
REPORTS_BUCKET=healthworkers-exports

mongodump -h $MONGO_HOST  --ssl --authenticationDatabase admin --username $MONGO_USER --password $MONGO_PASSWORD

aws s3 cp --recursive ./dump s3://$DUMP_BUCKET/$FOLDER/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
