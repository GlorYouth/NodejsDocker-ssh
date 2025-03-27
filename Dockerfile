FROM node:23-alpine

# 安装 OpenSSH 服务
RUN apk update && apk add --no-cache openssh git

# 创建 SSH 目录并设置权限
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# 生成 SSH 主机密钥
RUN ssh-keygen -A

# 配置 SSH 服务
RUN echo "Port 22" >> /etc/ssh/sshd_config && \
    echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config

# 创建运行时目录并设置权限
RUN mkdir -p /var/run/sshd && chmod 0755 /var/run/sshd

# 设置环境变量（密码passwd）
ENV ROOT_PASSWORD=passwd

# 暴露 SSH 端口
EXPOSE 22

# 以非守护进程模式启动 SSH 服务
CMD echo "root:${ROOT_PASSWORD}" | chpasswd && /usr/sbin/sshd -D
