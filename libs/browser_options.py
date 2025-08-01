# variables/browser_options.py
from selenium.webdriver.chrome.options import Options

def get_chrome_options():
    import tempfile
    import uuid
    import os
    import time

    options = Options()

    # Create unique user data directory to avoid conflicts
    temp_dir = tempfile.gettempdir()
    unique_id = f"{str(uuid.uuid4())[:8]}_{int(time.time())}"
    user_data_dir = f"{temp_dir}/chrome_user_data_{unique_id}"

    # Ensure the directory exists and is writable
    os.makedirs(user_data_dir, exist_ok=True)

    # Essential Chrome options for headless testing
    options.add_argument("--headless=new")  # Use new headless mode
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1920,1080")
    options.add_argument("--remote-debugging-port=0")  # Use random port

    # Use unique user data directory
    options.add_argument(f"--user-data-dir={user_data_dir}")

    # Additional stability options
    options.add_argument("--disable-background-timer-throttling")
    options.add_argument("--disable-backgrounding-occluded-windows")
    options.add_argument("--disable-renderer-backgrounding")
    options.add_argument("--disable-features=TranslateUI")
    options.add_argument("--disable-ipc-flooding-protection")

    # Security and stability options
    options.add_argument("--disable-web-security")
    options.add_argument("--disable-features=VizDisplayCompositor")
    options.add_argument("--disable-notifications")
    options.add_argument("--disable-extensions")
    options.add_argument("--disable-plugins")
    options.add_argument("--disable-default-apps")
    options.add_argument("--ignore-ssl-errors=yes")
    options.add_argument("--allow-insecure-localhost")
    options.add_argument("--ignore-certificate-errors")
    options.add_argument("--disable-blink-features=AutomationControlled")
    options.add_argument("--safebrowsing-disable-download-protection")

    # User agent
    options.add_argument('--user-agent=Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36')

    # Preferences
    prefs = {
        "credentials_enable_service": False,
        "profile.password_manager_enabled": False,
        "profile.default_content_settings.popups": 0,
        "profile.default_content_setting_values.notifications": 2,
        "profile.managed_default_content_settings.images": 2
    }
    options.add_experimental_option("excludeSwitches", ["enable-automation", "enable-logging"])
    options.add_experimental_option('useAutomationExtension', False)
    options.add_experimental_option('prefs', prefs)

    return options


# # # Hàm get_variables() mà Robot Framework sẽ gọi để lấy các biến động
# def get_variables():
#     return {
#         "OPTIONS": get_chrome_options()
#     }

# import keyword robot
# from robot.api.deco import keyword

# # create class options
# class browser_options:
#     def __init__(self):
#         self.options = Options()
        
#     @keyword('Get Options')
#     def get_options(self):
#         return self.options.add_argument("--incognito")
    