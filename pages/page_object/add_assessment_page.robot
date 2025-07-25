*** Settings ***
Library    SeleniumLibrary
Resource   ../locator/add_assessment_page_locator.robot

*** Keywords ***
Is Assessment Title Visible
    [Documentation]    Kiểm tra Title form Thêm đánh giá mới hiển thị, trả về Boolean
    Wait Until Element Is Visible    ${TITLE_ADD_ASSESSMENT_LOCATOR}    timeout=10s
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${TITLE_ADD_ASSESSMENT_LOCATOR}
    RETURN    ${is_visible}

Enter Ten Danh Gia
    [Arguments]    ${TEN_DANH_GIA}
    Input Text    ${TEN_DANH_GIA_LOCATOR}    ${TEN_DANH_GIA}    clear=True

Select Loai Danh Gia Type
    [Arguments]    ${ASSESSMENT_TYPE}
    Select From List By Label    ${LOAIDANH_GIA_LOCATOR}     ${ASSESSMENT_TYPE}

Enter Ty Trong
    [Arguments]    ${TY_TRONG}
    Input Text    ${TYTRONG_LOCATOR}    ${TY_TRONG}    clear=True

Select Dinh Dang Thi
    [Arguments]    ${DINH_DANG_THI}
    Select From List By Label    ${DINHDANGTHI_LOCATOR}    ${DINH_DANG_THI}

Enter Thoi Gian
    [Arguments]    ${THOI_GIAN}
    Input Text    ${THOIGIAN_LOCATOR}    ${THOI_GIAN}    clear=True

Enter Tong Diem
    [Arguments]    ${TONG_DIEM}   
    Input Text    ${TONGDIEM_LOCATOR}    ${TONG_DIEM}    clear=True

Enter Diem Dat
    [Arguments]    ${DIEM_DAT}   
    Input Text    ${DIEMDAT_LOCATOR}    ${DIEM_DAT}    clear=True 

Select Trang Thai
    [Arguments]    ${TRANG_THAI}
    Select From List By Label    ${TRANGTHAI_LOCATOR}    ${TRANG_THAI}

Click Button Add Assessment
    Wait Until Element Is Visible    ${BUTTON_ADD_ASSESSMENT_LOCATOR}    timeout=10s
    Scroll Element Into View    ${BUTTON_ADD_ASSESSMENT_LOCATOR}
   
    # Click Element    ${BUTTON_ADD_ASSESSMENT_LOCATOR}
    # Excute script click button Add Assessment
    Run Keyword And Ignore Error    Click Element    ${BUTTON_ADD_ASSESSMENT_LOCATOR}



Fill Assessment Form
    [Arguments]    ${TEN_DANH_GIA}    ${ASSESSMENT_TYPE}    ${TY_TRONG}    ${DINH_DANG_THI}    ${THOI_GIAN}    ${TONG_DIEM}    ${DIEM_DAT}    ${TRANG_THAI}
    Enter Ten Danh Gia    ${TEN_DANH_GIA}
    Select Loai Danh Gia Type    ${ASSESSMENT_TYPE}
    Enter Ty Trong    ${TY_TRONG}
    Select Dinh Dang Thi    ${DINH_DANG_THI}
    Enter Thoi Gian    ${THOI_GIAN}
    Enter Tong Diem    ${TONG_DIEM}
    Enter Diem Dat    ${DIEM_DAT}
    Select Trang Thai    ${TRANG_THAI}
    Click Button Add Assessment


