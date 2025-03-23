#!/bin/bash

#fetch metar data
curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > aviation.json


#use jq to parse data and extract first six values of receipt Time

jq '.[0:6] | .[].receiptTime' aviation.json
#collecting temp for 12 hours and putting in an array
temperatures=$(jq '[.[] | .temp]' aviation.json)

#sum the array 
sum=$(echo $temperatures | jq 'add')

count=$(echo $temperatures | jq 'length')

#average
average=$(echo "scale=2; $sum / $count" | bc)

#output temp
echo "average temperature: $average"

#now checking cloud value for clear
cloud_total=$(jq '[.[] | .clouds[] | select(.cover != "CLR")] | length' aviation.json)

#if more than half were cloudy
if [ "$cloud_total"  -gt 6 ]; then
	echo "Mostly Cloudy: True"
else 
	echo "Mostly Cloudy: False"
fi

