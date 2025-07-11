*** Settings ***
Resource    ../pages/page_object/login_page.robot
Resource    ../pages/page_object/dashboard_page.robot
Resource    ../pages/page_object/categories.robot
Resource    ../resources/browser_setup.robot
Resource    ../pages/page_object/add_assessment_page.robot
Resource    ../pages/page_object/all_courses_page.robot
Resource    ../pages/page_object/course_detail_page.robot

Resource    ../pages/locator/course_detail_page_locator.robot


Test Setup    Open Browser To Login Page
Test Teardown    Close Browser and Quit

*** Test Cases ***

Verify Form Add Assessment is Displayed
    [Documentation]    Test case to verify the form Thêm đánh giá mới hiển thị
    
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Hide Tool Bar Button
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    # Open Add Assessment Form
    ${LINKS}=    Get Link From Href    ${ADD_ASSESSMENT_BUTTON_LOCATOR}
    Go to    ${LINKS}

    ${IS_VISIBLE}=    Is Assessment Title Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị

Verify Add Assessment Successfully
    [Documentation]    Test case to add an assessment

    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Hide Tool Bar Button
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    # Open Add Assessment Form
    ${LINKS}=    Get Link From Href    ${ADD_ASSESSMENT_BUTTON_LOCATOR}
    Go to    ${LINKS}
    Fill Assessment Form    Assessment 1    Đánh giá thường xuyên    20    Written Paper    60    100    50    Planned

    ${IS_VISIBLE}=    Is Assessment Button Visible
    Should Be True    ${IS_VISIBLE}    Nút "Thêm bài kiểm tra" không hiển thị sau khi thêm đánh giá thành công

    ${NAME_COURSE_TABLE}=    Get Name Assessment In Table
    Should Be Equal As Strings    ${NAME_COURSE_TABLE}     Assessment 1    Tên bài kiểm tra không khớp với tên đã thêm    strip_spaces=True
    ${LOAI_DANH_GIA_TABLE}=    Get Loai Danh Gia In Table
    Should Be Equal As Strings    ${LOAI_DANH_GIA_TABLE}    Đánh giá thường xuyên    Loại đánh giá không khớp với loại đã thêm    strip_spaces=True
    ${TY_TRONG_TABLE}=    Get Ty Trong In Table
    Should Be Equal As Strings    ${TY_TRONG_TABLE}    20    Tỷ trọng không khớp với tỷ trọng đã thêm    strip_spaces=True
    ${THOI_GIAN_TABLE}=    Get Thoi Gian In Table  
    Should Be Equal As Strings    ${THOI_GIAN_TABLE}    60    Thời gian không khớp với thời gian đã thêm    strip_spaces=True
    ${TRANG_THAI_TABLE}=    Get Trang Thai In Table 
    Should Be Equal As Strings    ${TRANG_THAI_TABLE}    Planned    Trạng thái không khớp với trạng thái đã thêm    strip_spaces=True 


Verify Leave Required Fields Empty
    [Documentation]    Test case Bỏ trống các trường bắt buộc
    
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Hide Tool Bar Button
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form
    Click Button Add Assessment 

    ${IS_VISIBLE}=    Is Assessment Title Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị


Verify Fill Assessment With HighWeight   
    [Documentation]    Nhập tỷ trọng > 100
    
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Hide Tool Bar Button
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form     
    Fill Assessment Form    Assessment 1    Đánh giá thường xuyên    110    Written Paper    60    100    50    Planned

    ${IS_VISIBLE}=    Is Assessment Button Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị

Verify Fill Assessment WithInvalidPassScore
    [Documentation]    Điểm đạt > Tổng điểm
    
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Hide Tool Bar Button
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form     
    Fill Assessment Form    Assessment 1    Đánh giá thường xuyên    20    Written Paper    60    100    110    Planned

    ${IS_VISIBLE}=    Is Assessment Button Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị

Verify Fill Assessment WithSpecialDescription
    [Documentation]    Tên đánh giá có ký tự đặc biệt
    
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Hide Tool Bar Button
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form     
    Fill Assessment Form    @#!%&()_+E13     Đánh giá thường xuyên    20    Written Paper    60    100    50    Planned

    ${IS_VISIBLE}=    Is Assessment Button Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị



***** Keywords ***
# Tạo một hàm để get link trên thẻ href
Get Link From Href
    [Arguments]    ${href}
    ${link}=    Get Element Attribute    ${href}    href
    RETURN    ${link}