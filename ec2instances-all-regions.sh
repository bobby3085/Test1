#!/bin/bash
#Get list of all AWS regions

#.exe not required in aws.exe

regions=$(aws.exe ec2 describe-regions --output text --query 'Regions[].RegionName')

#loop through all regions
for region in $regions; do
	echo "instances in region ; $region"
	#describe instances in the current region
	#remove .exe from aws.exe 

	aws.exe ec2 describe-instances --region "$region"\
		--query 'Reservations[*].Instances[*].[InstanceId, State.Name, InstanceType, Placement.AvailabiltyZone, Tags[?Key=='Name'].value |[0]]'\
		--output table
	echo "" #add a blank line between regions
done
