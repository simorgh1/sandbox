FROM ubuntu:18.04

LABEL maintainer="Bahram Maravandi"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       openssh-server \
       python3-setuptools \
       wget rsyslog systemd systemd-cron sudo iproute2

# ssh service config
COPY ssh/sshd_config /etc/ssh
RUN chmod 644 /etc/ssh/sshd_config

# ssh service start script
COPY ssh/start-sshd.sh .
RUN chmod +x start-sshd.sh

CMD ["/lib/systemd/systemd"]        