*** Settings ***
Documentation     Page Object in Robot Framework
Library           SeleniumLibrary

Resource    ../pages/page_object/login_page.robot
Resource    ../pages/page_object/common_page.robot
Resource    ../pages/page_object/program_page.robot
Resource    ../pages/page_object/dashboard_page.robot
Resource    ../pages/page_object/categories.robot
Resource    ../resources/browser_setup.robot

*** Test Cases ***
Verify successful create new program
    [Documentation]    This test case verifies creation of a new program
    [Tags]    Smoke
    Open Browser To Login Page
    # Click Hide Popup
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Click Create New Program
    Click Submit Button Create New Program
    Verify Create Program Successful
    Close Browser and Quit

Verify create program fails when all fields are empty
    [Documentation]    This test case create program fails
    [Tags]    Smoke
    Open Browser To Login Page
    # Click Hide Popup
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Click Create New Program With Data Incorrect
    Click Submit Button Create New Program
    Verify Create Program Failed
    Close Browser and Quit

Verify go to Program page
    [Documentation]    Verify go to Program page
    [Tags]    Search    Smoke
    Open Browser To Login Page
    # Click Hide Popup
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Program Management Page
    Verify go to Program Successful
    Close Browser and Quit

Search for program by Name
    [Documentation]    Verify that the program search returns correct results when searching by name.
    [Tags]    Search    Smoke
    Open Browser To Login Page
    # Click Hide Popup
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Program Management Page
    Input Search
    Click Search
    Verify Search Program Successful
    Close Browser and Quit
Search for program not found
    [Documentation]    Verify that the program search returns not found
    [Tags]    Search    Smoke
    Open Browser To Login Page
    # Click Hide Popup
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Program Management Page
    Input Invalid data
    Click Search
    Verify Search Program Not found
    Close Browser and Quit