FROM ubuntu:18.04
LABEL maintainer="Bahram Maravandi"

ENV pip_packages "ansible pyopenssl"

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       locales \
       openssh-client \
       software-properties-common \
       python3-setuptools \
       wget rsyslog systemd systemd-cron sudo iproute2 iputils-ping \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean \
    && wget https://bootstrap.pypa.io/get-pip.py \
    && python3 get-pip.py
RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

# configure ssh client
COPY ssh/ssh_config /etc/ssh
RUN chmod 644 /etc/ssh/ssh_config

# Fix potential UTF-8 errors with ansible-test.
RUN locale-gen en_US.UTF-8

# Install Ansible via Pip.
RUN pip install $pip_packages

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN echo "[nodes]\nansible_host_1" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]   