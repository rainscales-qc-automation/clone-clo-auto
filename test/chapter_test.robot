*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
# Library    RPA.Desktop
Resource    ../pages/page_object/login_page.robot
Resource    ../pages/page_object/create_course_page.robot
Resource    ../pages/page_object/chapter_page.robot
Resource    ../test/login_tests.robot    
Resource    ../resources/browser_setup.robot
Resource    ../resources/variables.robot
Variables    ../libs/data_reader.py
Test Setup    Open Browser To Login Page
#Suite Setup    Open Browser To Login Page
Suite Teardown    Close Browser and Quit
*** Test Cases ***

Tcs 01: Func-Chapter: Create Chapter with fully field
    [Documentation]    Kiểm tra việc nhập giá trị vào các trường của tạo chương
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    create course
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    #Go to create course
    View Course Name From Table
    Click Element   ${VIEWCOURSE_BTN} 
    Click Button ThemChuong
    FOR    ${CHAPTER}    IN    @{ROBOT_CHAPTER_PANDAS}
        Go To Create Chapter
        ...    ${CHAPTER['HOCPHAN_VL']}    ${CHAPTER['SOCHUONG_VL']}    ${CHAPTER['TIEUDECHUONG_VL']}
        ...    ${CHAPTER['NOIDUNGCHUONG_VL']}    ${CHAPTER['MUCTIEUHOCTAP_VL']}    ${CHAPTER['TIME_VL']}
        ...    ${CHAPTER['PHUONGPHAPDAY_VL']}    ${CHAPTER['CLOLIENQUAN_VL']}
        #Wait Until Page Contains    ${CHAPTER['EXPECTED_RESULT']}    timeout=10s
        Log To Console    message=Đã tạo chương: ${CHAPTER['TIEUDECHUONG_VL']}
    END

