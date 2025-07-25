# variables/pandas_data_reader.py
import pandas as pd
import os

# Lấy đường dẫn tuyệt đối của thư mục chứa file pandas_data_reader.py
# current_dir = os.path.dirname(os.path.abspath(__file__))
# data_dir = os.path.join(current_dir, '..', 'data')

# users_excel_path =  os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'data_push', 'CLO.xlsx')
# Hoặc nếu bạn muốn sử dụng đường dẫn tương đối
users_excel_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'pages', 'data_push', 'CLO.xlsx')


df_users = r"..\pages\data_push\CLO.xlsx"

# def clean_string(value):
#     if isinstance(value, str):
#         return value.strip()
#     return value 
def strip_text(text: str) -> str:
    """
    Loại bỏ khoảng trắng ở đầu và cuối chuỗi.
    """
    return text.strip()

def read_excel_sheet(sheet_name: str) -> list:
    """
    Đọc dữ liệu sản phẩm từ file Excel bằng pandas và trả về list of dictionaries.
    """
    try:
        # Đọc Excel vào DataFrame
        df = pd.read_excel(users_excel_path, sheet_name=sheet_name, engine='openpyxl')
        # Chuyển DataFrame thành list of dictionaries
        return df.to_dict(orient='records')
    
    except FileNotFoundError:
        print(f"Lỗi: Không tìm thấy file Excel tại {users_excel_path}")
        return []
    except Exception as e:
        print(f"Lỗi khi đọc file Excel với pandas: {e}")
        return []
    

def get_variables():
    return {
        "ROBOT_USERS_PANDAS": read_excel_sheet('account'),
        "ROBOT_COURSE_PANDAS": read_excel_sheet('createcourse'),
        "ROBOT_CLO_PANDAS": read_excel_sheet('clo'),
        "ROBOT_CHAPTER_PANDAS": read_excel_sheet('chapter'),
    }
    
# print(read_excel_sheet('createcourse'))