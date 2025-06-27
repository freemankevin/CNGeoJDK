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

# 安装常用网络工具
RUN apt-get update && apt-get install -y \
    curl \
    net-tools \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# 添加Ubuntu GIS PPA以获取最新GDAL版本
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:ubuntugis/ppa \
    && apt-get update \
    && rm -rf /var/lib/apt/lists/*

# 安装GDAL，使用环境变量指定版本（默认使用最新版）
ARG GDAL_VERSION=latest
RUN echo "Requested GDAL_VERSION: $GDAL_VERSION" && \
    if [ "$GDAL_VERSION" = "latest" ]; then \
      apt-get update && \
      apt-get install -y gdal-bin libgdal-dev && \
      rm -rf /var/lib/apt/lists/*; \
    else \
      echo "Checking available GDAL versions..." && \
      apt-cache madison gdal-bin && \
      apt-get update && \
      apt-get install -y gdal-bin=$GDAL_VERSION libgdal-dev=$GDAL_VERSION && \
      rm -rf /var/lib/apt/lists/*; \
    fi

# 安装中文字体（微软雅黑和仿宋，通过noto-cjk）
RUN apt-get update && apt-get install -y \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*