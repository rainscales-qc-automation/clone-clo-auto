# Robot Framework Test Runner

Thư mục này chứa các module Python để chạy test Robot Framework và gửi email kết quả.

## Cấu trúc thư mục

```
test_runner/
├── __init__.py          # Package initialization
├── config.py            # Cấu hình email và test
├── email_sender.py      # Module gửi email
├── result_parser.py     # Module phân tích kết quả test
├── test_runner.py       # Module chính chạy test
└── README.md           # Tài liệu này
```

## Chức năng

1. **Chạy tất cả test Robot Framework** trong thư mục `test/`
2. **Thu thập kết quả** từ file output.xml
3. **Gửi email** kết quả test với các file đính kèm (log.html, report.html, output.xml)

## Cách sử dụng

### Chạy từ script chính:
```bash
python run_tests.py
```

### Chạy trực tiếp từ module:
```bash
python -m test_runner.test_runner
```

### Sử dụng trong code Python:
```python
from test_runner.test_runner import RobotTestRunner

runner = RobotTestRunner()
success, results, email_sent = runner.run_full_test_cycle()
```

## Cấu hình

Chỉnh sửa file `config.py` để thay đổi:
- Thông tin email SMTP
- Đường dẫn thư mục test và kết quả
- Các tùy chọn khác

## Kết quả email

Email sẽ chứa:
- Tóm tắt kết quả test (số test pass/fail, tỷ lệ thành công)
- Thời gian chạy test
- Danh sách test bị fail (nếu có)
- File đính kèm: log.html, report.html, output.xml

## Yêu cầu

- Python 3.6+
- Robot Framework
- Các dependencies trong requirements.txt
- Kết nối internet để gửi email
