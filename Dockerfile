# 使用eclipse-temurin:8-jdk-focal（基于Ubuntu 20.04）作为基础镜像
FROM eclipse-temurin:8-jdk-focal

# 设置非交互式安装，设置时区为Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai

# 安装时区配置、网络工具、中文字体、PPA和最新GDAL
RUN apt-get update && apt-get install -y \
    tzdata \
    curl \
    net-tools \
    iputils-ping \
    software-properties-common \
    fonts-noto-cjk \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && add-apt-repository ppa:ubuntugis/ppa \
    && apt-get update \
    && apt-get install -y gdal-bin libgdal-dev \
    && rm -rf /var/lib/apt/lists/*