*** Settings ***
# Library    SeleniumLibrary
Library    SeleniumLibrary


*** Keywords ***
View Detail Course
    [Arguments]    ${COURSE_NAME}
    # Lấy danh sách các hàng trong bảng sản phẩm
    Wait Until Element Is Visible    locator=//table//tr/td[2]
    ${rows}=    Get WebElements    //table//tr/td[2]
    FOR    ${row}    IN    @{rows}
        ${text}=    Get Text    ${row}
        IF    '${COURSE_NAME}' == '${text}'
            ${XPATH_COURSE_NAME}=    Set Variable    //tr[td[contains(., '${COURSE_NAME}')]]//a[contains(@class, 'btn-info')]
            Wait Until Element Is Visible    xpath=${XPATH_COURSE_NAME}
            Click Element    xpath=${XPATH_COURSE_NAME}
            BREAK
        END
    END

    