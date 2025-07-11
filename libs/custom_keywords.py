


def strip_text(text: str) -> str:
    """
    Loại bỏ khoảng trắng ở đầu và cuối chuỗi.
    """
    str_text = text.strip()
    return str_text

def get_variables():
    """
    Hàm get_variables() mà Robot Framework sẽ gọi để lấy các biến động
    """
    return {
        "STRIP_TEXT": strip_text  # Không có dấu ngoặc đơn!
    }