*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.Netsuite
Library    RPA.Desktop
Library    BuiltIn
# Library    ExcelLibrary
Resource    ../pages/page_object/login_page.robot
Resource    ../pages/page_object/create_course_page.robot
Resource    ../test/login_tests.robot
Resource    ../resources/browser_setup.robot
Resource    ../resources/variables.robot
Variables    ../libs/data_reader.py
Test Setup    Open Browser To Login Page
#Suite Setup    Open Browser To Login Page
Suite Teardown    Close Browser and Quit

*** Test Cases ***
Tcs 01: Func-Course-03: Create Course with fully field
    [Documentation]    Kiểm tra việc nhập giá trị vào các trường của khoá học
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    create course
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go to create course
    FOR    ${COURSE}    IN    @{ROBOT_COURSE_PANDAS}
        Enter Course Detail Form    ${COURSE['PROGRAM_VL']}    ${COURSE['COURSE_CODE_VL']}    ${COURSE['COURSE_NAME_VL']}
        ...    ${COURSE['CREDITS_VL']}    ${COURSE['DESCRIPTION_VL']}    ${COURSE['TYPE_VL']}
        ...    ${COURSE['STATUS_VL']}    ${COURSE['PREREQUISITE_VL']}
        #Wait Until Page Contains    ${COURSE['EXPECTED_RESULT']}    timeout=10s
        Log To Console    message=Đã tạo khoá học: ${COURSE['COURSE_NAME_VL']}
    END

Tcs 02: Func-Course-04: Create course with empty required fields
    [Documentation]    Tạo một khoá học mới bằng cách bỏ trống các trường bắt buộc
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    create course   
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Create Course 
    Empty Required Fields With Course Form

Tcs 11: Func-Course: Create Course with maximum credits value
    [Documentation]    Kiểm tra việc nhập giá trị lớn nhất vào trường tín chỉ của khoá học
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    create course
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go to create course
    FOR    ${COURSE}    IN    @{ROBOT_COURSE_PANDAS}
        Enter Course Detail Form With Maximum Credits    ${COURSE['PROGRAM_VL']}    ${COURSE['COURSE_CODE_VL']}    ${COURSE['COURSE_NAME_VL']}
        ...    ${COURSE['DESCRIPTION_VL']}    ${COURSE['TYPE_VL']}
        ...    ${COURSE['STATUS_VL']}    ${COURSE['PREREQUISITE_VL']}
        #Wait Until Page Contains    ${COURSE['EXPECTED_RESULT']}    timeout=10s
        Log To Console    message=Đã tạo khoá học: ${COURSE['COURSE_NAME_VL']}
    END

Tcs 03: Func-CLO-03: Create CLOs with fully fields
    [Documentation]    Kiểm tra việc nhập giá trị vào các trường của mục tiêu khoá học
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    create clo
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Go To Create CLO
    FOR    ${CLO}    IN    @{ROBOT_CLO_PANDAS}
        Enter Course Learning Outcome Form    ${CLO['COURSE_VL']}    ${CLO['CLO_CODE_VL']}    ${CLO['DESCRIPTION_VL']}
        ...    ${CLO['CATEGORY_VL']}    ${CLO['LEVEL_VL']}    ${CLO['WEIGHT_VL']}
        ...    ${CLO['ASSESSMENT_METHOD_VL']}
        #Wait Until Page Contains    ${COURSE['EXPECTED_RESULT']}    timeout=10s
        Log To Console    message=Đã tạo mục tiêu khoá học: ${CLO['COURSE_VL']}
        
    END

Tcs 04: Func-CLO-04: Create CLOS with empty required fields
    [Documentation]    Tạo một mục tiêu khoá học mới bằng cách bỏ trống các trường bắt buộc
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    create clo
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}  
    Go To Create CLO 
    Empty Required Fields With CLOs

Tcs 05: Get data course table
    [Documentation]    Lấy dữ liệu từ bảng khoá học
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    get course table
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    View Course Name From Table
    Save Course Table Data To Excel

Tcs 06: Edit Course
    [Documentation]    Chỉnh sửa thông tin khoá học đã tạo
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    edit course
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    View Course Name From Table
    Edit Course
    Log To Console    message=Đã chỉnh sửa khoá học

Tcs 08: Compare value CLO in course
    [Documentation]    So sánh giá trị CLO đã định nghĩa và danh sách trong clo trong khoá học
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    compare clo
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    View Course Name From Table
    Click Element    ${VIEWCOURSE_BTN}
    Compare value CLO

# Tcs 07: Delete Course
#     [Documentation]    Xoá khoá học đã tạo
#     [Teardown]    Capture Page Screenshot
#     [Tags]    smoke    delete course
#     Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
#     View Course Name From Table
#     Delete Course
#     Log To Console    message=Đã xoá khoá học
TC 09: Edit All Fields In Course
    [Documentation]    Kiểm tra chỉnh sửa giá trị vào các trường của khoá học
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    create course
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    View Course Name From Table
    Click Element   ${EDITCOURSE_BTN}
    FOR    ${COURSE}    IN    @{ROBOT_COURSE_PANDAS}
        Enter Course Detail Form    ${COURSE['PROGRAM_VL']}    ${COURSE['COURSE_CODE_VL']}    ${COURSE['COURSE_NAME_VL']}
        ...    ${COURSE['CREDITS_VL']}    ${COURSE['DESCRIPTION_VL']}    ${COURSE['TYPE_VL']}
        ...    ${COURSE['STATUS_VL']}    ${COURSE['PREREQUISITE_VL']}
        #Wait Until Page Contains    ${COURSE['EXPECTED_RESULT']}    timeout=10s
        Log To Console    message=Đã tạo khoá học: ${COURSE['COURSE_NAME_VL']}
    END


Tc 10: Get data CLO table
    [Documentation]    Lấy dữ liệu từ bảng CLO
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    get clo table
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    View Course Name From Table
    Click Element    ${CLOs_BTN}
    Save CLO Table Data To Excel

Tcs 12: "Tạo mới" button inactive
    [Documentation]    Kiểm tra nút "Tạo mới" không hoạt động khi nhấp vào
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    create course
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    #Go to create course
    View Course Name From Table
    Click Element   ${VIEWCOURSE_BTN} 
    Scroll Element Into View    ${CREATENEW_BTN}
    Click Button    ${CREATENEW_BTN} 

Tc 13: Find word with valid and invalid Keyword
    [Documentation]    Tìm kiếm từ khoá hợp lệ trong danh sách khoá học
    [Teardown]    Capture Page Screenshot
    [Tags]    smoke    find word
    Login User    ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    Wait Until Element Is Visible    ${HOCPHAN_MENUBAR}    timeout=10s
    Click Element    ${HOCPHAN_MENUBAR}
    FOR    ${element}    IN    @{LIST_FIND_COURSE_KEYWORD}
        Wait Until Element Is Visible    ${FIELD_SEARCH_COURSE}    timeout=10s
        Input Text    ${FIELD_SEARCH_COURSE}    ${element}
        Click Element    ${COURSE_FIND_ICON}
        Wait Until Page Contains    ${element}
        ${found}=    Run Keyword And Return Status    Element Should Be Visible    ${COURSE_NOT_FOUND}
        IF    ${found} 
            Log    Không tìm thấy từ khoá: ${element}
        ELSE
            Log    Từ khoá tìm kiếm: ${element}
        END
    END
    
    

