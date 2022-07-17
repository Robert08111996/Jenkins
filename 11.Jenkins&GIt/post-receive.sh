#!/bin/bash

if ! [ -t 0 ]; then
	read -a ref
fi


IFS='/' read -ra REF <<< "${ref[2]}"
branch="${REF[2]}"

if [ $branch == "master" ]; then
	crumb=$(curl -u "David:1234" -s 'http://192.168.0.105:9090//crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
	curl -u "David:1234" -H "$crumb" -X POST http://192.168.0.105:9090/job/maven-job/build?delay=0sec

	if [ $? -eq 0 ]; then
		echo "*** Ok"
	else
		echo "*** Error"
	fi

fi