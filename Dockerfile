FROM ubuntu:22.04

# Instalar SSH y dependencias necesarias para Ansible
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Configurar SSH
RUN mkdir /var/run/sshd

# Crear el usuario "ansible" con contraseña "ansible"
RUN useradd -rm -d /home/ansible -s /bin/bash -g root -G sudo -u 1000 ansible
RUN echo 'ansible:ansible' | chpasswd

# Configurar sudo para que "ansible" no requiera contraseña
RUN echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Exponer el puerto SSH
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]