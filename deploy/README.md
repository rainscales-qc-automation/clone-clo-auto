# Robot Framework CI/CD với Docker và Jenkins

Dự án này cung cấp một quy trình CI/CD hoàn chỉnh cho Robot Framework test automation sử dụng Docker và Jenkins.

## 📋 Tổng quan

Quy trình CI/CD này bao gồm:
- **Docker**: Containerization cho môi trường test nhất quán
- **Jenkins**: Automation pipeline cho CI/CD
- **Robot Framework**: Test automation framework
- **Selenium**: Web browser automation
- **Chrome**: Headless browser cho testing

## 🏗️ Cấu trúc thư mục

```
deploy/
├── Dockerfile              # Docker image cho Robot Framework
├── docker-compose.yml      # Production environment
├── docker-compose.dev.yml  # Development environment
├── Jenkinsfile             # Jenkins pipeline
├── nginx.conf              # Nginx config cho results viewer
├── build.sh                # Script build Docker image
├── run-tests.sh            # Script chạy tests
├── dev.sh                  # Script development environment
├── view-results.sh         # Script xem kết quả tests
└── README.md               # Documentation này
```

## 🚀 Bắt đầu nhanh

### 1. Build Docker Image

```bash
cd deploy
chmod +x *.sh
./build.sh
```

### 2. Chạy Tests

```bash
./run-tests.sh
```

### 3. Xem kết quả

```bash
./view-results.sh
```

Mở browser và truy cập: http://localhost:8080

## 🛠️ Development Environment

### Khởi động môi trường development

```bash
./dev.sh start
```

### Truy cập container để debug

```bash
./dev.sh shell
```

### Chạy tests trong development environment

```bash
./dev.sh test
```

### Dừng môi trường development

```bash
./dev.sh stop
```

## 📊 Jenkins Pipeline

### Cấu hình Jenkins

1. **Cài đặt Jenkins plugins cần thiết:**
   - Docker Pipeline
   - Robot Framework Plugin (optional)
   - Git Plugin

2. **Tạo Jenkins Pipeline Job:**
   - Chọn "Pipeline" project
   - Trong Pipeline section, chọn "Pipeline script from SCM"
   - Chọn Git và nhập repository URL
   - Script Path: `deploy/Jenkinsfile`

### Pipeline Stages

1. **Checkout**: Lấy code từ repository
2. **Prepare Environment**: Tạo thư mục kết quả
3. **Build Docker Image**: Build image với Python 3.10 + Chrome
4. **Test Docker Image**: Kiểm tra các component
5. **Run Robot Framework Tests**: Chạy tests trong container
6. **Process Test Results**: Xử lý và archive kết quả

## 🐳 Docker Images

### Base Image
- **Python 3.10-slim**: Base image nhẹ
- **Chrome**: Google Chrome stable
- **ChromeDriver**: Tự động tải version phù hợp
- **Xvfb**: Virtual display cho headless testing

### Environment Variables
- `DISPLAY=:99`: Virtual display
- `ROBOT_REPORTS_DIR=/app/results`: Thư mục kết quả
- `ROBOT_TESTS_DIR=/app/test`: Thư mục tests

## 📁 Kết quả Tests

Kết quả tests được lưu trong thư mục `results/`:
- `output.xml`: Raw test results
- `report.html`: HTML report
- `log.html`: Detailed test log

## 🔧 Customization

### Thay đổi cấu hình tests

Chỉnh sửa file `test_runner/config.py`:

```python
TEST_CONFIG = {
    "test_directory": "test",
    "results_directory": "results",
    "output_file": "output.xml",
    "log_file": "log.html",
    "report_file": "report.html"
}
```

### Thay đổi Chrome options

Chỉnh sửa file `libs/browser_options.py` để thêm/bớt Chrome options.

### Email notifications

Cấu hình email trong `test_runner/config.py`:

```python
EMAIL_CONFIG = {
    "host": "smtp.gmail.com",
    "mail": "your-email@gmail.com",
    "password": "your-app-password",
    "port": 587,
    "mail_goal": ["recipient@gmail.com"]
}
```

## 🐛 Troubleshooting

### Lỗi Chrome không khởi động được

```bash
# Kiểm tra Chrome version
docker run --rm robot-framework-tests:latest google-chrome --version

# Kiểm tra ChromeDriver version
docker run --rm robot-framework-tests:latest chromedriver --version
```

### Lỗi không có display

Đảm bảo Xvfb đang chạy trong container:

```bash
docker run --rm robot-framework-tests:latest ps aux | grep Xvfb
```

### Lỗi permission denied

```bash
# Cấp quyền execute cho scripts
chmod +x deploy/*.sh
```

### Debug trong container

```bash
# Truy cập container để debug
./dev.sh shell

# Hoặc chạy container với bash
docker run -it --rm robot-framework-tests:latest bash
```

## 📝 Scripts Reference

### build.sh
```bash
./build.sh [tag]           # Build Docker image với tag tùy chọn
```

### run-tests.sh
```bash
./run-tests.sh             # Chạy tests với cấu hình mặc định
./run-tests.sh -t dev      # Chạy với image tag 'dev'
./run-tests.sh -r /tmp     # Lưu kết quả vào /tmp
```

### dev.sh
```bash
./dev.sh start             # Khởi động development environment
./dev.sh stop              # Dừng development environment
./dev.sh shell             # Mở shell trong container
./dev.sh test              # Chạy tests
./dev.sh logs              # Xem logs
```

### view-results.sh
```bash
./view-results.sh          # Xem kết quả trên port 8080
./view-results.sh -p 9000  # Xem kết quả trên port 9000
```

## 🔗 Links hữu ích

- [Robot Framework Documentation](https://robotframework.org/robotframework/)
- [Selenium Library](https://robotframework.org/SeleniumLibrary/)
- [Docker Documentation](https://docs.docker.com/)
- [Jenkins Documentation](https://www.jenkins.io/doc/)

## 📞 Hỗ trợ

Nếu gặp vấn đề, hãy kiểm tra:
1. Docker đã được cài đặt và chạy
2. Ports 8080 không bị conflict
3. Quyền execute cho các script files
4. Cấu hình email (nếu sử dụng)

---

**Lưu ý**: Đảm bảo Docker daemon đang chạy trước khi sử dụng các scripts.
