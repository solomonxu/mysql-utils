#!/usr/bin/bash

## check and install mysql client
mysql_cmd=`which mysql`
echo mysql_cmd=$mysql_cmd
if [ -z "$mysql_cmd" ]; then
   echo "MySQL not installed on this host. Start to install mysql now..."
   yum install -y mysql
fi

## define variables
pattern1=orchestration
pattern2="/app-orch /resource-manager /build-biz"

## get some pod of wisecloud
pod_names=`kubectl -n wisecloud-controller get pod -o wide | grep $pattern1 | awk '{print $1}'`
echo pod_names=$pod_names
if [ -z "$pod_names" ]; then
   echo "Pod with pattern "$pattern1"* not found. Please check if this shell run on correct K8s cluter with wisecloud-controller."
   #exit 1
fi

## get containter pod of wisecloud
for patt in $pattern2; do
    docker_container_id=`docker ps | grep $patt | awk '{print $1}' | tail -1`
	if [ -n "$docker_container_id" ]; then
        break;
	fi
done
echo docker_container_id=$docker_container_id
if [ -z "$docker_container_id" ]; then
   echo "Container with pattern [${pattern2}]* not found on this host. Please login to other hosts with wisecloud-controller, then run this shell again."
   exit 2
fi

## get mysql config from environment variables of container
`docker inspect $docker_container_id | grep DB | awk '{print $1}' | awk -F '[",]' '{print "export " $2}'`
#echo "DB_URL=$DB_URL DB_PORT=$DB_PORT DB_USER=$DB_USER DB_PASSWORD=$DB_PASSWORD DB_NAME=$DB_NAME"
echo DB_URL=$DB_URL
echo DB_PORT=$DB_PORT
echo DB_USER=$DB_USER
echo DB_PASSWORD=$DB_PASSWORD
echo DB_NAME=$DB_NAME
if [[ -z "$DB_URL" ]] || [[ -z "$DB_PORT" ]] || [[ -z "$DB_USER" ]] || [[ -z "$DB_PASSWORD" ]]; then
   echo "Some MYSQL config($DB_URL $DB_PORT $DB_USER $DB_PASSWORD) not found."
   exit 3
fi

## mysql login
echo "Try to login to MYSQL database now. The default database is $DB_NAME. If you want to use other database, please input 'use dbname;'."
echo 
mysql --host="$DB_URL" --port="$DB_PORT" --user="$DB_USER" --password="$DB_PASSWORD" --database="$DB_NAME"
