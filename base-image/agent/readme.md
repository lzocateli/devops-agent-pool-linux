- Create image agent, Dockerfile in this folder will already copy all content to the container, including its **".proxybypass"** file, if necessary.

```powershell
docker build -t nuuvedevops/azdo-agents:linux-x64-agent-1.0.0 --build-arg Env_HttpProxy=proxy.mydomain.com:80 --build-arg Env_NoProxy=mydns.com .
```
- Upload your image to your container registry:

```powershell
docker push nuuvedevops/azdo-agents:linux-x64-agent-1.0.0
```

##### Where:
- `nuuvedevops` = Your docker registry   
- `azdo-agents` = Your path in docker registry   
- `linux-x64-agent-1.0.0` = Your image tag name    
