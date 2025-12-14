# Hệ Thống Quản Lý Sinh Viên

Dự án quản lý sinh viên đơn giản với:
- **Frontend**: Vue.js 3
- **Backend**: Laravel 11
- **Database**: SQL Server 2022
- **Container**: Docker & Docker Compose

## Cấu Trúc Dự Án

```
OSS_DOCKER_2/
├── docker-compose.yml          # Cấu hình Docker Compose
├── backend/                    # Laravel Backend
│   ├── app/
│   │   ├── Http/Controllers/
│   │   │   └── StudentController.php
│   │   └── Models/
│   │       └── Student.php
│   ├── database/
│   │   ├── migrations/
│   │   └── seeders/
│   ├── routes/
│   │   └── api.php
│   └── Dockerfile
├── frontend/                   # Vue.js Frontend
│   ├── src/
│   │   ├── App.vue
│   │   └── main.js
│   ├── public/
│   └── Dockerfile
└── README.md
```

## Yêu Cầu Hệ Thống

- Docker Desktop (Windows/Mac) hoặc Docker Engine (Linux)
- Docker Compose
- ít nhất 4GB RAM
- Ports: 3000 (Vue), 8000 (Laravel), 1433 (SQL Server)

## Cài Đặt và Chạy

### 1. Clone hoặc tải dự án

```bash
cd OSS_DOCKER_2
```

### 2. Khởi động các container

```bash
docker-compose up -d --build
```

Lệnh này sẽ:
- Tải và build các Docker images
- Tạo network cho các services
- Khởi động SQL Server, Laravel và Vue.js
- Tự động chạy migrations và seeders

### 3. Truy cập ứng dụng

- **Frontend (Vue.js)**: http://localhost:3000
- **Backend API (Laravel)**: http://localhost:8000
- **API Endpoints**: http://localhost:8000/api/students

### 4. Kiểm tra logs

```bash
# Xem logs của tất cả services
docker-compose logs -f

# Xem logs của từng service
docker-compose logs -f laravel
docker-compose logs -f vue
docker-compose logs -f sqlserver
```

## API Endpoints

### Lấy danh sách sinh viên
```
GET /api/students
```

### Thêm sinh viên mới
```
POST /api/students
Content-Type: application/json

{
  "student_code": "SV001",
  "full_name": "Nguyễn Văn An",
  "email": "nguyenvanan@example.com",
  "phone": "0912345678",
  "date_of_birth": "2000-01-15",
  "class_name": "CNTT2020A"
}
```

### Lấy thông tin sinh viên
```
GET /api/students/{id}
```

### Cập nhật sinh viên
```
PUT /api/students/{id}
Content-Type: application/json

{
  "student_code": "SV001",
  "full_name": "Nguyễn Văn An Updated",
  ...
}
```

### Xóa sinh viên
```
DELETE /api/students/{id}
```

## Dữ Liệu Mẫu

Hệ thống đã được cấu hình sẵn với 8 sinh viên mẫu:
- SV001 đến SV008
- Thông tin đầy đủ: tên, email, số điện thoại, ngày sinh, lớp

## Dừng và Xóa

### Dừng containers
```bash
docker-compose stop
```

### Dừng và xóa containers
```bash
docker-compose down
```

### Dừng và xóa containers + volumes (xóa cả database)
```bash
docker-compose down -v
```

## Troubleshooting

### Laravel không kết nối được SQL Server

1. Kiểm tra SQL Server đã sẵn sàng:
```bash
docker-compose logs sqlserver
```

2. Kiểm tra kết nối từ Laravel container:
```bash
docker-compose exec laravel bash
php artisan migrate:status
```

### Vue không kết nối được API

1. Kiểm tra biến môi trường trong `frontend/.env`:
```
VUE_APP_API_URL=http://localhost:8000/api
```

2. Kiểm tra Laravel đang chạy:
```bash
curl http://localhost:8000/api/students
```

### Reset database

```bash
# Xóa volumes và khởi động lại
docker-compose down -v
docker-compose up -d --build
```

## Cấu Hình Database

- **Server**: sqlserver (trong Docker network)
- **Database**: StudentManagement
- **Username**: sa
- **Password**: YourStrong@Passw0rd
- **Port**: 1433

**Lưu ý**: Để thay đổi mật khẩu, cập nhật trong `docker-compose.yml` và `backend/.env`

## Phát Triển

### Chạy migrations thủ công
```bash
docker-compose exec laravel php artisan migrate
```

### Chạy seeders thủ công
```bash
docker-compose exec laravel php artisan db:seed
```

### Truy cập vào container
```bash
# Laravel
docker-compose exec laravel bash

# Vue
docker-compose exec vue sh

# SQL Server
docker-compose exec sqlserver bash
```

## License

MIT

