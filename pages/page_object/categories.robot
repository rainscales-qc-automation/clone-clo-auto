*** Settings ***
Library    SeleniumLibrary
Library    String
Library    ../../libs/custom_keywords.py

Resource    ../locator/categories_locator.robot

*** Keywords ***
Get Title Categories
    [Documentation]    Verify that the dashboard title is displayed correctly
    [Arguments]    ${TITLE_CATEGORIES}

    ${LIST_TITLE_CATEGORIES}=    Get WebElements    ${CATEGORIES_TITLE_LOCATOR}
    FOR    ${E_TITLE}    IN    @{LIST_TITLE_CATEGORIES}
        ${TITLE}=    Get Text    ${E_TITLE}
        IF    '${TITLE}' == '${TITLE_CATEGORIES}'
            RETURN    True
        END
        
    END   
    RETURN   False 


Go To Categories
    [Documentation]    Navigate to the categories page
    [Arguments]    ${TITLE_CATEGORIES}
    ${LIST_TITLE_CATEGORIES}=    Get WebElements    ${CATEGORIES_TITLE_LOCATOR}
    FOR    ${E_TITLE}    IN    @{LIST_TITLE_CATEGORIES}
        ${TITLE}=    Get Text    ${E_TITLE}
        ${TITLE}=    Strip String    ${TITLE}
        ${EXPECTED}=    Strip String    ${TITLE_CATEGORIES}
        IF   '${TITLE}' == '${EXPECTED}'
            Click Element    ${E_TITLE}
            BREAK
        END
        
    END   
