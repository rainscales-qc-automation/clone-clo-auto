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
    [Tags]    smoke    Add Assessment
 

    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form
 
    ${IS_VISIBLE}=    Is Assessment Title Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị
    

Verify Add Assessment Successfully
    [Documentation]    Test case to add an assessment
    [Tags]    smoke    Add Assessment

    Set Assessment Data Variables    ${LIST_DATA_ASSESSMENT}
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form

    Fill Assessment Form    ${TEN_DANH_GIA}    ${LOAIDANH_GIA}    ${TY_TRONG}    ${DINH_DANG_THI}    
    ...    ${THOI_GIAN}    ${TONG_DIEM}    ${DIEM_DAT}    ${TRANG_THAI}
    
    ${IS_VISIBLE}=    Is Assessment Button Visible
    Should Be True    ${IS_VISIBLE}    Nút "Thêm bài kiểm tra" không hiển thị sau khi thêm đánh giá thành công

    ${NAME_COURSE_TABLE}=    Get Name Assessment In Table
    Should Be Equal As Strings    ${NAME_COURSE_TABLE}     ${TEN_DANH_GIA}    Tên bài kiểm tra không khớp với tên đã thêm    strip_spaces=True
    ${LOAI_DANH_GIA_TABLE}=    Get Loai Danh Gia In Table
    Should Be Equal As Strings    ${LOAI_DANH_GIA_TABLE}    ${LOAIDANH_GIA}    Loại đánh giá không khớp với loại đã thêm    strip_spaces=True
    ${TY_TRONG_TABLE}=    Get Ty Trong In Table
    Should Be Equal As Strings    ${TY_TRONG_TABLE}    ${TY_TRONG}   Tỷ trọng không khớp với tỷ trọng đã thêm    strip_spaces=True
    ${THOI_GIAN_TABLE}=    Get Thoi Gian In Table  
    Should Be Equal As Strings    ${THOI_GIAN_TABLE}    ${THOI_GIAN}    Thời gian không khớp với thời gian đã thêm    strip_spaces=True
    ${TRANG_THAI_TABLE}=    Get Trang Thai In Table 
    Should Be Equal As Strings    ${TRANG_THAI_TABLE}    ${TRANG_THAI}    Trạng thái không khớp với trạng thái đã thêm    strip_spaces=True 
    
    

Verify Leave Required Fields Empty
    [Documentation]    Test case Bỏ trống các trường bắt buộc
    [Tags]    smoke    Add Assessment

    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form
    Click Button Add Assessment 

    ${IS_VISIBLE}=    Is Assessment Title Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị

Verify Fill Assessment With HighWeight   
    [Documentation]    Nhập tỷ trọng > 100
    [Tags]    smoke    Add Assessment

    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form     
    Fill Assessment Form    Assessment 1    Đánh giá thường xuyên    110    Written Paper    60    100    50    Planned

    ${IS_VISIBLE}=    Is Assessment Button Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị, thêm đánh giá với tỷ trọng > 100 không thành công

Verify Fill Assessment WithInvalidPassScore
    [Documentation]    Điểm đạt > Tổng điểm
    [Tags]    smoke    Add Assessment

    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form     
    Fill Assessment Form    Assessment 1    Đánh giá thường xuyên    20    Written Paper    60    100    110    Planned

    ${IS_VISIBLE}=    Is Assessment Button Visible
    Should Not Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" hiển thị, mặc dù điểm đạt > tổng điểm
   
Verify Fill Assessment WithSpecialDescription
    [Documentation]    Tên đánh giá có ký tự đặc biệt
    [Tags]    smoke    Add Assessment

    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Categories    Học phần
    View Detail Course    ${COURSE_NAME}
    Open Add Assessment Form     
    Fill Assessment Form    @#!%&()_+E13     Đánh giá thường xuyên    20    Written Paper    60    100    50    Planned

    ${IS_VISIBLE}=    Is Assessment Button Visible
    Should Be True    ${IS_VISIBLE}    Tiêu đề "Thêm đánh giá mới" không hiển thị, thêm đánh giá với tên có ký tự đặc biệt không thành công


*** Keywords ***
Set Assessment Data Variables
    [Arguments]    ${list_data}
    ${TEN_DANH_GIA}=     Get From List    ${list_data}    0
    ${LOAIDANH_GIA}=     Get From List    ${list_data}    1
    ${TY_TRONG}=         Get From List    ${list_data}    2
    ${DINH_DANG_THI}=    Get From List    ${list_data}    3
    ${THOI_GIAN}=        Get From List    ${list_data}    4
    ${TONG_DIEM}=        Get From List    ${list_data}    5
    ${DIEM_DAT}=         Get From List    ${list_data}    6
    ${TRANG_THAI}=       Get From List    ${list_data}    7

    Set Suite Variable    ${TEN_DANH_GIA}
    Set Suite Variable    ${LOAIDANH_GIA}
    Set Suite Variable    ${TY_TRONG}
    Set Suite Variable    ${DINH_DANG_THI}
    Set Suite Variable    ${THOI_GIAN}
    Set Suite Variable    ${TONG_DIEM}
    Set Suite Variable    ${DIEM_DAT}
    Set Suite Variable    ${TRANG_THAI}