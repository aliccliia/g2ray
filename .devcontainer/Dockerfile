FROM alpine:latest

RUN apk add --no-cache curl bash uuidgen

# Install Xray-core
RUN bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install

# Copy the setup script
COPY setup_xray.sh /usr/local/bin/setup_xray.sh
RUN chmod +x /usr/local/bin/setup_xray.sh

EXPOSE 443
