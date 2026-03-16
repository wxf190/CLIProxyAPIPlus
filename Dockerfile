FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 拉源码
RUN git clone https://github.com/router-for-me/CLIProxyAPIPlus.git .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 创建目录
RUN mkdir -p /CLIProxyAPI/logs
RUN mkdir -p /root/.cli-proxy-api

# 下载默认配置
RUN curl -L https://raw.githubusercontent.com/router-for-me/CLIProxyAPIPlus/main/config.example.yaml \
    -o /CLIProxyAPI/config.yaml

# 修改管理key（自动）
RUN sed -i 's/secret-key:.*/secret-key: "19960106whs"/g' /CLIProxyAPI/config.yaml

EXPOSE 8317

CMD ["python", "main.py", "--config", "/CLIProxyAPI/config.yaml"]
