FROM python:3.11-slim

WORKDIR /app

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 复制项目
COPY . .

# 安装python依赖
RUN pip install --no-cache-dir -r requirements.txt

# 创建日志目录
RUN mkdir -p /CLIProxyAPI/logs

# 端口
EXPOSE 8317

# 启动
CMD ["python", "main.py"]