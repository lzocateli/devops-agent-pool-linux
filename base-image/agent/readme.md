- Create image agent, Dockerfile in this folder will already copy all content to the container, including its **".proxybypass"** file, if necessary.

```powershell
docker build -t lzocateli/devops-agent-deploypool-linux:1.0.0 --build-arg Env_HttpProxy=proxy.mydomain.com:80 --build-arg Env_NoProxy=mydns.com .
```
- Upload your image to your container registry:

```powershell
docker push lzocateli/devops-agent-deploypool-linux:1.0.0
```
