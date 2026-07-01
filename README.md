# local-https-proxy

Конфиг: `nginx/nginx.conf`

## macOS

```bash
brew install mkcert nss
chmod +x proxy setup-certs.sh
./setup-certs.sh
sudo sh -c 'echo "127.0.0.1 your-host.com" >> /etc/hosts'
./proxy
```

## Linux

```bash
# mkcert: https://github.com/FiloSottile/mkcert#installation
chmod +x proxy setup-certs.sh
./setup-certs.sh
sudo sh -c 'echo "127.0.0.1 your-host.com" >> /etc/hosts'
./proxy
```

## Windows

```powershell
choco install mkcert
bash setup-certs.sh
# добавить в C:\Windows\System32\drivers\etc\hosts:
# 127.0.0.1 your-host.com
bash proxy
```

Остановка: `./proxy stop` / `bash proxy stop`
