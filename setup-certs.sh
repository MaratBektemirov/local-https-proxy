#!/usr/bin/env bash
# One-time: generate certs from server_name in nginx/nginx.conf
set -euo pipefail

cd "$(dirname "$0")"
mkdir -p certs

command -v mkcert >/dev/null || {
  echo "Install mkcert first" >&2
  exit 1
}

hosts=()
while IFS= read -r host; do
  [[ -z "$host" ]] && continue
  hosts+=("$host")
done < <(grep -E '^\s*server_name' nginx/nginx.conf | sed 's/.*server_name //;s/;//' | tr ' ' '\n' | sed '/^$/d' | sort -u)

((${#hosts[@]})) || {
  echo "No server_name found in nginx/nginx.conf" >&2
  exit 1
}

mkcert -install 2>/dev/null || true
mkcert -cert-file certs/cert.pem -key-file certs/key.pem "${hosts[@]}"

echo ""
echo "Add to hosts:"
for host in "${hosts[@]}"; do
  echo "  127.0.0.1 $host"
done
