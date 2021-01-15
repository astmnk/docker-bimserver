#!/bin/bash

set -em

BIM_SERVER_HOST="localhost"
BIM_SERVER_PORT="8080"

wait_for_host_and_port_to_open () {
	RETRIES=0
	MAX_RETRIES=5
	while ! timeout 1 bash -c "cat < /dev/null > /dev/tcp/$1/$2"; 
	do 
		echo "Waiting for host $1 to become available on port $2 ($RETRIES)";
		sleep 15;
		RETRIES=$((RETRIES+1))
		if [ "$RETRIES" -gt "$MAX_RETRIES" ]; then
			exit 4;
		fi
	done
}

get_current_server_state () {
	curl -X POST -H "Content-Type: application/json" -d '{  
	  "request": {
	    "interface": "AdminInterface",
	    "method": "getServerInfo"
	  }
	}' "http://${BIM_SERVER_HOST}:${BIM_SERVER_PORT}/bimserver/json"
}

apply_setup_settings () {
	result=$(curl -X POST -H "Content-Type: application/json" -d '{  
	  "request": {
	    "interface": "AdminInterface",
	    "method": "setup",
	    "parameters": {
	      "siteAddress": "'"$BIM_SITE_ADDRESS"'",
	      "smtpServer":"'"$BIM_SMTP_SERVER"'",
	      "smtpSender":"'"$BIM_SMTP_SENDER"'",
	      "adminName":"'"$BIM_ADMIN_NAME"'",
	      "adminUsername":"'"$BIM_ADMIN_USERNAME"'",
	      "adminPassword":"'"$BIM_ADMIN_PASSWORD"'"
	    }  
	  }
	}' "http://${BIM_SERVER_HOST}:${BIM_SERVER_PORT}/bimserver/json" )
	if [ $result != '{"response":{"result":{}}}' ]; then
		echo "BIMServer setup failed, server response: $result"
		exit 5
	fi
}

setup_application () {
	wait_for_host_and_port_to_open "$BIM_SERVER_HOST" "$BIM_SERVER_PORT"
	current_state=$(get_current_server_state)
	if [[ $current_state == *"NOT_SETUP"* ]]; then		
		apply_setup_settings
	fi

}

#END OF PRIVATE FUNCS

if [ "$1" = 'bimserver' ]; then	
	catalina.sh run &
	setup_application
	fg 1		
fi

exec "$@"