*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
# Library    RPA.Desktop
Resource    ../pages/page_object/login_page.robot
Resource    ../pages/page_object/create_course_page.robot
Resource    ../pages/page_object/chapter_page.robot
#Resource    ../test/login_tests.robot
Resource    ../resources/browser_setup.robot
Resource    ../resources/variables.robot
Variables    ../libs/data_reader.py
Test Setup    Open Browser To Login Page
#Suite Setup    Open Browser To Login Page
Suite Teardown    Close Browser and Quit
*** Test Cases ***

Tcs 01: Func-Chapter: Create Chapter with fully field
    [Documentation]    Kiểm tra việc nhập giá trị vào các trường của tạo chương
   
    [Tags]    smoke    create course
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    #Go to create course
    View Course Name From Table
    Click Element   ${VIEWCOURSE_BTN} 
    Click Button ThemChuong
    Go To Create Chapter    2    Chương 1   Chương 1: Tìm hiểu khái niệm    Mục tiêu    2    Offline    BLC01 - CL01        
