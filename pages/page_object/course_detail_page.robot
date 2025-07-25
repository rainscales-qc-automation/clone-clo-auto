*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource   ../locator/course_detail_page_locator.robot
Resource   ../locator/form_add_assessment.robot
Resource   ../locator/add_assessment_page_locator.robot

*** Keywords ***
Open Add Assessment Form
    [Documentation]    Chờ nút thêm đánh giá xuất hiện rồi click để mở form
    Wait Until Element Is Visible    ${ADD_ASSESSMENT_BUTTON_LOCATOR}    timeout=10s
    Scroll Element Into View    ${ADD_ASSESSMENT_BUTTON_LOCATOR}
    Sleep    2s
    # Execute Javascript    arguments[0].click()    ${ADD_ASSESSMENT_BUTTON_LOCATOR}
    Click Element    ${ADD_ASSESSMENT_BUTTON_LOCATOR}
    Wait Until Page Contains Element    ${TITLE_ADD_ASSESSMENT_LOCATOR}    timeout=3s


Is Assessment Button Visible
    [Documentation]    Kiểm tra nút thêm đánh giá có hiển thị trên màn hình hay không, trả về Boolean
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight * 0.5)
    Wait Until Element Is Visible    ${ADD_ASSESSMENT_BUTTON_LOCATOR}    timeout=15s
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${ADD_ASSESSMENT_BUTTON_LOCATOR}
    RETURN    ${is_visible}
Get Name Assessment In Table
    [Documentation]    Lấy tên đánh giá trong bảng   
    ${raw_text}=    Get Text    ${NAME_COURSE_TABLE_LOCATOR}
    # Table Should Contain    locator=${NAME_COURSE_TABLE_LOCATOR}    
    ${stripped_text}=    Strip String    ${raw_text}
    RETURN    ${stripped_text}
    

Get Loai Danh Gia In Table
    [Documentation]    Lấy loại đánh giá trong bảng
    ${raw_text}=    Get Text    ${LOAI_DANH_GIA_TABLE_LOCATOR}
    ${stripped_text}=    Strip String    ${raw_text}
    RETURN    ${stripped_text}

Get Ty Trong In Table
    [Documentation]    Lấy tỷ trọng trong bảng
    ${raw_text}=    Get Text    ${TY_TRONG_TABLE_LOCATOR}
    ${stripped_text}=    Strip String    ${raw_text}

    # Tách chuỗi bằng ký tự '%'
    ${parts}=          Split String    ${stripped_text}    %
    # Lấy phần tử đầu tiên của list (chuỗi "33.00")
    ${number_string}=  Get From List    ${parts}    0
    ${integer_string}=  Replace String    ${number_string}    .00    ${EMPTY} 
    # Chuyển chuỗi thành số nguyên
    ${integer_value}=  Convert To Integer    ${integer_string}
    RETURN    ${integer_value}


Get Thoi Gian In Table
    [Documentation]    Lấy thời gian trong bảng
    ${raw_text}=    Get Text    ${THOI_GIAN_TABLE_LOCATOR}
    ${stripped_text}=    Strip String    ${raw_text}
    RETURN    ${stripped_text}

Get Trang Thai In Table  
    [Documentation]    Lấy trạng thái trong bảng
    ${raw_text}=    Get Text    ${TRANG_THAI_TABLE_LOCATOR}
    ${stripped_text}=    Strip String    ${raw_text}
    RETURN    ${stripped_text}