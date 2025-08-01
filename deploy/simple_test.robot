*** Settings ***
Library    SeleniumLibrary
Library    ../libs/browser_options.py

*** Test Cases ***
Simple Browser Test
    [Documentation]    Simple test to verify browser opens correctly
    ${chrome_options}=    Get Chrome Options
    Open Browser    https://www.google.com    chrome    options=${chrome_options}
    ${title}=    Get Title
    Log    Page title: ${title}
    Should Contain    ${title}    Google
    Close Browser
