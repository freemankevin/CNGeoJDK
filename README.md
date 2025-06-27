# CNGeoJDK

基于 `eclipse-temurin:8-jdk-focal`（Ubuntu 20.04）的多架构 Docker 基础镜像，支持 Java 应用，包含 OpenJDK 8、最新 GDAL、网络工具、微软雅黑和仿宋字体，设置 Asia/Shanghai 时区。

## 功能

- OpenJDK 8、最新 GDAL（Ubuntu GIS PPA）
- 网络工具：`curl`、`net-tools`、`iputils-ping`
- 中文字体：微软雅黑、仿宋（`fonts-noto-cjk`）
- 时区：Asia/Shanghai
- 支持 `linux/amd64` 和 `linux/arm64`
- 自动构建：代码提交及每月更新 GDAL

## 安装使用

1. 克隆仓库：

   ```bash
   git clone https://github.com/yourusername/CNGeoJDK.git
   cd CNGeoJDK
   ```

2. 构建镜像：

   ```bash
   docker buildx create --use
   docker buildx build --platform linux/amd64,linux/arm64 -t freelabspace/cngeojdk:latest .
   ```

3. 运行容器（替换 `app.jar` 为你的 Java 应用）：

   ```bash
   docker run -d -p 8080:8080 -v $(pwd)/app.jar:/app/app.jar freelabspace/cngeojdk:latest
   ```

## 验证

- Java：`docker run --rm freelabspace/cngeojdk:latest java -version`

- GDAL：`docker run --rm freelabspace/cngeojdk:latest gdalinfo --version`

- 字体：`docker run --rm freelabspace/cngeojdk:latest fc-list | grep Noto`

