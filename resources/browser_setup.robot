*** Settings ***
Library    SeleniumLibrary
Variables    ../libs/browser_options.py
   

Resource   ../resources/variables.robot
Resource   ../resources/browser_setup.robot


*** Keywords ***
Open Browser To Login Page
    [Documentation]    Open the browser to the login page with specified options

    Open Browser    ${BASE_URL}    ${BROWSER}    options=${OPTIONS}
    Maximize Browser Window
    Set Selenium Timeout    10s

Close Browser and Quit
    Close Browser
