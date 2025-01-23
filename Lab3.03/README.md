# 3.3 Use Docker
## Tóm tắt lệnh thường dùng hằng ngày
```sh
# Tóm tắt các lệnh Docker

## Lệnh Docker cơ bản
# Kiểm tra phiên bản Docker
docker --version

# Kiểm tra trạng thái Docker
docker info

# Danh sách tất cả các lệnh Docker
docker --help

## Làm việc với Docker Images
# Liệt kê các Docker Images
docker images

# Tải một image từ Docker Hub
docker pull <image-name>:<tag>

# Xóa một image
docker rmi <image-id>

# Xây dựng image từ Dockerfile
docker build -t <image-name>:<tag> .

# Gắn thẻ (tag) cho một image
docker tag <image-id> <new-image-name>:<new-tag>

# Đẩy image lên Docker Hub
docker push <image-name>:<tag>

## Làm việc với Containers
# Liệt kê các container đang chạy
docker ps

# Liệt kê tất cả container (bao gồm cả container đã dừng)
docker ps -a

# Chạy một container
docker run -d --name <container-name> <image-name>:<tag>

# Dừng một container
docker stop <container-id>

# Khởi động lại container
docker restart <container-id>

# Xóa một container
docker rm <container-id>

# Truy cập vào một container đang chạy
docker exec -it <container-id> /bin/bash

## Lệnh về Mạng (Network)
# Liệt kê các mạng (network)
docker network ls

# Tạo một mạng mới
docker network create <network-name>

# Kết nối một container vào mạng
docker network connect <network-name> <container-id>

# Ngắt kết nối một container khỏi mạng
docker network disconnect <network-name> <container-id>

## Xem Logs và Debug
# Xem logs của container
docker logs <container-id>

# Theo dõi logs theo thời gian thực
docker logs -f <container-id>

# Xem chi tiết thông tin của container
docker inspect <container-id>

# Kiểm tra hiệu suất container
docker stats

## Dọn dẹp hệ thống
# Xóa các container đã dừng
docker container prune

# Xóa các image không sử dụng
docker image prune

# Xóa toàn bộ tài nguyên không sử dụng (container, image, network, volume)
docker system prune -a

## Các lệnh thường dùng hàng ngày
# Kiểm tra container đang chạy
docker ps

# Kiểm tra các image có sẵn
docker images

# Chạy một container
docker run -d --name <container> <image>

# Dừng một container
docker stop <container>

# Xóa một container
docker rm <container>

# Tải một image
docker pull <image>

# Xây dựng một image
docker build -t <image-name>:<tag> .

# Xem logs của container
docker logs <container>

# Truy cập vào container
docker exec -it <container> /bin/bash

```