# NodejsDocker-ssh
NodejsDocker with ssh server and git

## Usage
``` bash
git clone https://github.com/GlorYouth/NodejsDocker-ssh.git && cd NodejsDocker-ssh
docker build -t my-node-ssh .
docker run -d -p 2223:22 -e ROOT_PASSWORD="MySecret@123" --name ssh my-node-ssh
```
