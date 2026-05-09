#!/bin/bash

# ایجاد یک شناسه منحصربه‌فرد
UUID=$(uuidgen)
# یافتن آدرس دامنه اختصاصی کادسپیس
DOMAIN="${CODESPACE_NAME}-443.app.github.dev"

# ساخت فایل کانفیگ Xray
cat <<EOF > /usr/local/etc/xray/config.json
{
  "inbounds": [{
    "port": 443,
    "protocol": "vless",
    "settings": {
      "clients": [{"id": "$UUID"}],
      "decryption": "none"
    },
    "streamSettings": {
      "network": "ws",
      "wsSettings": {"path": "/vless"}
    }
  }],
  "outbounds": [{"protocol": "freedom"}]
}
EOF

# اجرای سرویس در پس‌زمینه
nohup xray run -c /usr/local/etc/xray/config.json > /dev/null 2>&1 &

# چاپ لینک نهایی برای کپی کردن
echo "========================================"
echo "      G2RAY FIXED CONFIG LINK          "
echo "========================================"
echo ""
echo "vless://$UUID@$DOMAIN:443?type=ws&security=tls&path=%2Fvless#G2Ray_Fixed"
echo ""
echo "========================================"
