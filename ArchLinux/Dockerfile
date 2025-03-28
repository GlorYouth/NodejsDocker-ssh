# 使用 Archlinux 官方镜像作为基础镜像
FROM archlinux:latest

# 更新系统，并安装 Node.js、npm 和 OpenSSH
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm nodejs npm openssh git bash wget go && \
    pacman -Scc --noconfirm

# 生成 SSH 主机密钥
RUN ssh-keygen -A

# 配置 SSH 服务
RUN rm -f /etc/ssh/sshd_config && \
    echo -e "Include /etc/ssh/sshd_config.d/*.conf\n" \
    "AuthorizedKeysFile .ssh/authorized_keys\n" \
    "Subsystem sftp internal-sftp\n" \
    "Port 22\n" \
    "ListenAddress 0.0.0.0\n" \
    "PermitRootLogin yes\n" \
    "PasswordAuthentication yes\n" \
    "PermitUserEnvironment yes\n" \
    "AllowTcpForwarding yes\n" \
    "GatewayPorts yes\n" \
    "X11Forwarding yes" > /etc/ssh/sshd_config

# 创建运行时目录并设置权限
RUN mkdir -p /var/run/sshd && chmod 0755 /var/run/sshd

# 设置环境变量（密码passwd）
ENV ROOT_PASSWORD=passwd

# 暴露 SSH 端口
EXPOSE 22

# 以非守护进程模式启动 SSH 服务
CMD echo "root:${ROOT_PASSWORD}" | chpasswd && /usr/sbin/sshd -D
