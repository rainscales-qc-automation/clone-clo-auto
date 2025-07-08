*** Settings ***
Library    SeleniumLibrary
Resource   ../locator/login_page_locator.robot

*** Keywords ***
Input Username
    [Arguments]    ${USERNAME}
    Input Text    ${INPUT_USERNAME}    ${USERNAME}

Input Password
    [Arguments]    ${PASSWORD}
    Input Text    ${INPUT_PASSWORD}   ${PASSWORD}


Click Login
    Click Button    ${BUTTON_LOGIN}

Is Login Page Displayed
    [Documentation]    Check if the login page is displayed by verifying the title of the form.
    Wait Until Element Is Visible    ${TITLE_FORM_LOGIN}    timeout=5s 
    ${TITLE}=    Get Text    ${TITLE_FORM_LOGIN}
    ${RESULT}=   Run Keyword And Return Status     Should Be Equal    ${TITLE}    Đăng nhập hệ thống    strip_spaces=True

    RETURN    ${RESULT}

Is Error Message Displayed
    # ${error_element}=    Get WebElement    ${msg_error}
    Wait Until Element Is Visible    ${MSG_ERROR}    timeout=5s 
    ${IS_DISPLAYED}=    Run Keyword And Return Status    Element Should Be Visible    ${MSG_ERROR}

    RETURN    ${IS_DISPLAYED}

Login User
    [Arguments]    ${USERNAME}  ${PASSWORD}
    Input Username   ${USERNAME}
    Input Password    ${PASSWORD}
    Click Login
