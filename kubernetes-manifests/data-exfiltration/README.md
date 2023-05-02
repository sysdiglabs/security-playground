# Steal Data / Exfiltrate Data flow

| Attack Step | Curl Command | Expected Sysdig Event |
|---|---|--|
| Install nmap, openssh | `curl -X POST http://192.168.1.15/exec -d 'command=apk add nmap openssh'` | Launch Package Management Process in Container |
| x | x | x |


Or for some quick testing try the sec-playground-menu.sh bash script

```bash
$ ./sec-playground-menu.sh 
What is the http address of your target? [http://192.168.1.15]: 

Select an Exploit:
1) Read Sensitive File
2) Write script to /tmp
3) Exec bad script
4) Run Port Scan
5) Dump Environment Variables
6) Install PSQL Tools
7) Dump DB
8) Exfiltrate Data
9) Open Reverse Shell
0) Exit
Choose an option: 
```