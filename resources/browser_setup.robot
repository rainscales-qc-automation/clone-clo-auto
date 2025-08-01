*** Settings ***
Library    SeleniumLibrary
Library    ../libs/browser_options.py
# Variables    ../libs/browser_options.py
Resource   ../resources/variables.robot
Resource    ../pages/page_object/dashboard_page.robot



*** Keywords ***
Open Browser To Login Page
    [Documentation]    Open the browser to the login page with specified options
    ${chrome_options}=    Get Chrome Options

    Open Browser    ${BASE_URL}    ${BROWSER}    options=${chrome_options}
    Hide Tool Bar Button
    Maximize Browser Window
    Set Selenium Timeout    10s

Close Browser and Quit
    Close Browser
