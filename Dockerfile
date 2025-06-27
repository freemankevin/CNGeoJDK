# 使用eclipse-temurin:8-jdk作为基础镜像
FROM eclipse-temurin:8-jdk

# 设置非交互式安装，设置时区为Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# 安装时区配置工具并设置时区
RUN apt-get update && apt-get install -y \
    tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*

# 安装常用网络工具和中文字体
RUN apt-get update && apt-get install -y \
    curl \
    net-tools \
    iputils-ping \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

# 添加Ubuntu GIS PPA并安装GDAL
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && echo "Adding Ubuntu GIS PPA..." \
    && add-apt-repository ppa:ubuntugis/ppa \
    && apt-get update \
    && echo "Checking available GDAL versions..." \
    && apt-cache madison gdal-bin \
    && apt-get install -y gdal-bin libgdal-dev \
    && rm -rf /var/lib/apt/lists/*