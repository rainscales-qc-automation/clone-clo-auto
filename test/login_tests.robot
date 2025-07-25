*** Settings ***
Resource    ../pages/page_object/login_page.robot
Resource    ../pages/page_object/dashboard_page.robot
Resource    ../pages/page_object/categories.robot
Resource    ../resources/browser_setup.robot
Variables    ../libs/data_reader.py

Library    OperatingSystem
# Suite Setup    Open Browser To Login Page
# Suite Teardown    Close Browser and Quit
*** Test Cases ***
Verify Login With User Admin
    [Documentation]    Test case to verify valid login with user admin
   
    Open Browser To Login Page
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    ${TITLE}=    Get Dashboard Title Is Displayed
    Should Be Equal As Strings    ${TITLE}    Dashboard    Không hiển thị tiêu đề Dashboard sau khi đăng nhập với tài khoản Admin

    # Should Be Equal As Strings    ${title}    Dashboard

    ${RESULT}=    Get Title Categories    Quản trị hệ thống
    # Log    message=Result: ${result}
    Should Be True    ${RESULT}    Không tìm thấy danh mục "Quản trị hệ thống" tại user Admin

    Close Browser and Quit

Verify Login With User Lecturer
    [Documentation]    Test case to verify valid login with user lecturer
    Open Browser To Login Page
    Login User   ${username_lecturer}    ${password_lecturer}
    Get Dashboard Title Is Displayed

    # Should Be Equal As Strings    ${title}    Dashboard    ${msg_error}
    ${result}=    Get Title Categories    Quản trị hệ thống
    Should Not Be True   ${result}    Tìm thấy danh mục "Quản trị hệ thống" tại user Lecturer
    Close Browser and Quit

Verify Login With Invalid User
    [Documentation]    Test case to verify invalid login
    Open Browser To Login Page
    Login User   ${username_invalid}    ${password_invalid}
    ${is_displayed}=    Is Error Message Displayed
    Should Be True    ${is_displayed}    Không hiển thị thông báo lỗi khi đăng nhập với tài khoản không hợp lệ

    ${is_title_login_form}=    Is Login Page Displayed
    Should Be True    ${is_title_login_form}    Không hiển thị trang đăng nhập sau khi đăng nhập với tài khoản không hợp lệ
    Close Browser and Quit


Verify Login With Multiple Accounts From Excel
    [Documentation]    Kiểm tra đăng nhập thành công và thất bại từ file Excel
    FOR    ${USER}    IN    @{ROBOT_USERS_PANDAS}
        Open Browser To Login Page
        Log To Console    Đang kiểm tra user: ${USER['username']} | ${USER['expected_result']}
        Login User    ${USER['username']}    ${USER['password']}

        Run Keyword If    '${USER['expected_result']}' == 'success'
        ...    Log To Console    Đăng nhập thành công với user: ${USER['username']}

        Run Keyword If    '${USER['expected_result']}' == 'fail'    
        ...    Log To Console    Đăng nhập thất bại với user: ${USER['username']} | Thông báo: ${MSG_ERROR}

        Close Browser and Quit
    END

