FROM python:3.11-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 拉取 CLIProxyAPIPlus 项目
RUN git clone https://github.com/router-for-me/CLIProxyAPIPlus.git .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 创建目录
RUN mkdir -p /root/.cli-proxy-api
RUN mkdir -p /CLIProxyAPI/logs

# 复制你的配置
COPY config.yaml /CLIProxyAPI/config.yaml

# 端口
EXPOSE 8317

# 启动服务
CMD ["python", "main.py", "--config", "/CLIProxyAPI/config.yaml"]
