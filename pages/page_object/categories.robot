*** Settings ***
Library    SeleniumLibrary
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

