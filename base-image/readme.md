## Imagem Linux com Powershell

Basta executar Pull Request no repositorio do Github para gerar nova imagem
[devops-agent-pool-linux](https://github.com/lzocateli/devops-agent-pool-linux)


Nome da Imagem:
```
lzocateli/az-powershell-linux
```

Tag version:
```
15.4.0-ubuntu-24.04
```

Local para o dockerfile:
```
devops-agent-pool-linux/base-image/linux
```

Imagem argumentos:
```
--build-arg Env_HttpProxy=proxy.xyz.com:80 --build-arg Env_NoProxy=xyz.com
```

Baypass proxy: (Se não possuir proxy, inclua dois espaços a esquerda desse campo)
```
xyz\.com
```
---

## Imagem do agent

Nome da Imagem:
```
lzocateli/devops-agent-pool-linux-x64
```

Tag version:
```
3.0.0
```

Local para o dockerfile:
```
devops-agent-pool-linux/base-image/agent
```

Imagem argumentos:
```
--build-arg Env_HttpProxy=proxy.xyz.com:80 --build-arg Env_NoProxy=xyz.com
```
Baypass proxy: (Se não possuir proxy, inclua dois espaços a esquerda desse campo)
```
xyz\.com
```
