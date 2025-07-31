# Jenkins CI/CD Setup for Robot Framework Tests

Hướng dẫn thiết lập Jenkins để tự động chạy test Robot Framework khi push code lên Git.

## 📋 Yêu cầu hệ thống

- Jenkins server đã được cài đặt
- Python 3.10 trên Jenkins server
- Git trên Jenkins server
- Quyền truy cập vào repository

## 🚀 Cách thiết lập

### 1. Chuẩn bị Jenkins Server

Chạy script kiểm tra môi trường:
```bash
chmod +x jenkins-setup.sh
./jenkins-setup.sh
```

### 2. Tạo Jenkins Job

1. **Tạo New Item trong Jenkins:**
   - Chọn "Pipeline"
   - Đặt tên job (ví dụ: "Robot-Framework-Tests")

2. **Cấu hình Pipeline:**
   - Trong phần "Pipeline", chọn "Pipeline script from SCM"
   - SCM: Git
   - Repository URL: URL của repository này
   - Branch: */main (hoặc branch bạn muốn)
   - Script Path: `Jenkinsfile`

### 3. Thiết lập Webhook (Tự động trigger)

#### Với GitHub:
1. Vào Settings > Webhooks của repository
2. Add webhook:
   - Payload URL: `http://your-jenkins-url/github-webhook/`
   - Content type: `application/json`
   - Events: "Just the push event"

#### Với GitLab:
1. Vào Settings > Webhooks của project
2. Add webhook:
   - URL: `http://your-jenkins-url/project/YOUR_JOB_NAME`
   - Trigger: "Push events"

### 4. Cấu hình Jenkins Credentials (nếu cần)

Nếu repository là private:
1. Vào Manage Jenkins > Manage Credentials
2. Add credentials cho Git access

## 📁 Cấu trúc file được tạo

```
├── Jenkinsfile                 # Pipeline script chính
├── jenkins-setup.sh           # Script kiểm tra môi trường
├── docker-compose.jenkins.yml # Docker setup (tùy chọn)
├── Dockerfile.robot          # Docker image (tùy chọn)
└── README-Jenkins.md         # Hướng dẫn này
```

## 🔧 Jenkinsfile Features

- **Tự động tạo Python 3.10 virtual environment**
- **Cài đặt dependencies từ requirements.txt**
- **Chạy tests bằng run_tests.py**
- **Archive kết quả test**
- **Publish Robot Framework reports**
- **Cleanup tự động**

## 📊 Kết quả Test

Sau khi chạy, Jenkins sẽ:
- Archive tất cả file trong thư mục `results/`
- Hiển thị Robot Framework reports (nếu có plugin)
- Gửi email thông báo (nếu được cấu hình)

## 🐳 Chạy với Docker (Tùy chọn)

Nếu muốn chạy tests trong Docker container:

```bash
# Build image
docker build -f Dockerfile.robot -t robot-tests .

# Chạy tests
docker-compose -f docker-compose.jenkins.yml up robot-tests

# Với Selenium Grid
docker-compose -f docker-compose.jenkins.yml up
```

## 🔍 Troubleshooting

### Lỗi Python 3.10 không tìm thấy:
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install python3.10 python3.10-venv python3.10-dev

# CentOS/RHEL
sudo yum install python310 python310-devel
```

### Lỗi permissions:
```bash
# Đảm bảo Jenkins user có quyền
sudo usermod -a -G docker jenkins
sudo systemctl restart jenkins
```

### Lỗi Git access:
- Kiểm tra SSH keys hoặc credentials trong Jenkins
- Đảm bảo Jenkins có quyền clone repository

## 📧 Email Notifications

Để bật email notifications, thêm vào `post` section của Jenkinsfile:

```groovy
post {
    always {
        emailext (
            subject: "Robot Tests: ${env.JOB_NAME} - ${env.BUILD_NUMBER}",
            body: "Build ${env.BUILD_NUMBER} completed with status: ${currentBuild.result}",
            to: "your-email@example.com"
        )
    }
}
```

## 🎯 Next Steps

1. Push các file này lên repository
2. Tạo Jenkins job theo hướng dẫn
3. Test bằng cách push code mới
4. Kiểm tra kết quả trong Jenkins dashboard

## 📞 Support

Nếu gặp vấn đề, kiểm tra:
- Jenkins console output
- File `jenkins-setup.sh` output
- Jenkins system logs
