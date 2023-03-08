## Imagem Linux com Powershell

Basta executar Pull Request no repositorio do Github para gerar nova imagem
[devops-agent-pool-linux](https://github.com/lzocateli/devops-agent-pool-linux)


Nome da Imagem:
```
az-powershell-7.2-ubuntu-20.04
```

Tag version:
```
1.0.0
```

Local para o dockerfile:
```
containers/azdo-base-image/linux
```

Imagem argumentos:
```
--build-arg Env_HttpProxy=proxy.xyz.com:80 --build-arg Env_NoProxy=xyz.com
```

Baypass proxy:
```
xyz\.com
```
---

## Imagem do agent

Nome da Imagem:
```
devops-agent-pool-linux-x64
```

Tag version:
```
1.0.0
```

Local para o dockerfile:
```
containers/azdo-base-image/agent
```

Imagem argumentos:
```
--build-arg Env_HttpProxy=proxy.xyz.com:80 --build-arg Env_NoProxy=xyz.com
```

Baypass proxy:
```
xyz\.com
```
