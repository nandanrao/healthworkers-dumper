#!/bin/sh

FOLDER=$(date +%Y-%m-%dT%H:%M)
DUMP_BUCKET=healthworkers-dumps
REPORTS_BUCKET=healthworkers-exports

mongodump -h $MONGO_HOST  --ssl --authenticationDatabase admin --username $MONGO_USER --password $MONGO_PASSWORD

mongoexport --host $MONGO_HOST --ssl --authenticationDatabase admin --username $MONGO_USER --password $MONGO_PASSWORD --db healthworkers --collection messages --type csv --fields timestamp,code,serviceDate,workerPhone,patientPhone,patientName -o reports.csv

aws s3 cp --recursive ./dump s3://$DUMP_BUCKET/$FOLDER/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers

aws s3 cp ./reports.csv s3://$REPORTS_BUCKET/reports/$FOLDER/ --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers
