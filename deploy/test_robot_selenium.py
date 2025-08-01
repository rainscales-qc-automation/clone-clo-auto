#!/usr/bin/env python3

import sys
import os
sys.path.append('/app')

from SeleniumLibrary import SeleniumLibrary
from libs.browser_options import get_chrome_options

def test_robot_selenium():
    print("Testing Robot Framework SeleniumLibrary...")
    
    try:
        # Create SeleniumLibrary instance
        selenium_lib = SeleniumLibrary()
        
        # Get Chrome options from our function
        chrome_options = get_chrome_options()
        print(f"Chrome options type: {type(chrome_options)}")
        print(f"Chrome options: {chrome_options}")
        
        # Try to open browser like Robot Framework does
        print("Opening browser with SeleniumLibrary...")
        selenium_lib.open_browser("https://www.google.com", "chrome", options=chrome_options)
        
        print("✅ Browser opened successfully!")
        
        # Get page title
        title = selenium_lib.get_title()
        print(f"✅ Page title: {title}")
        
        # Close browser
        selenium_lib.close_browser()
        print("✅ Browser closed successfully!")
        
        return True
        
    except Exception as e:
        print(f"❌ Error with SeleniumLibrary: {e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    success = test_robot_selenium()
    sys.exit(0 if success else 1)
