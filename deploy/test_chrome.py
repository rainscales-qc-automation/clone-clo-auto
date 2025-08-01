#!/usr/bin/env python3

import sys
import os
sys.path.append('/app')

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import tempfile
import uuid
import time

def test_chrome_driver():
    print("Testing ChromeDriver...")
    
    # Create Chrome options similar to browser_options.py
    options = Options()
    
    # Create unique user data directory
    temp_dir = tempfile.gettempdir()
    unique_id = f"{str(uuid.uuid4())[:8]}_{int(time.time())}"
    user_data_dir = f"{temp_dir}/chrome_user_data_{unique_id}"
    
    # Ensure the directory exists
    os.makedirs(user_data_dir, exist_ok=True)
    print(f"Using user data dir: {user_data_dir}")
    
    # Essential Chrome options
    options.add_argument("--headless=new")
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--window-size=1920,1080")
    options.add_argument("--remote-debugging-port=0")
    options.add_argument(f"--user-data-dir={user_data_dir}")
    
    # Additional stability options
    options.add_argument("--disable-background-timer-throttling")
    options.add_argument("--disable-backgrounding-occluded-windows")
    options.add_argument("--disable-renderer-backgrounding")
    options.add_argument("--disable-features=TranslateUI")
    options.add_argument("--disable-ipc-flooding-protection")
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
    
    try:
        print("Creating WebDriver...")
        driver = webdriver.Chrome(options=options)
        print("✅ WebDriver created successfully!")
        
        print("Testing navigation...")
        driver.get("https://www.google.com")
        print(f"✅ Page title: {driver.title}")
        
        driver.quit()
        print("✅ WebDriver closed successfully!")
        return True
        
    except Exception as e:
        print(f"❌ Error creating WebDriver: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    success = test_chrome_driver()
    sys.exit(0 if success else 1)
