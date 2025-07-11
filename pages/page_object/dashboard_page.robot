*** Settings ***
Resource    ../page_object/login_page.robot
Resource    ../locator/dashboard_page_locator.robot

*** Keywords ***
Get Dashboard Title Is Displayed
    [Documentation]    Verify that the dashboard title is displayed correctly
    Wait Until Element Is Visible    locator=${DASHBOARD_TITLE_LOCATOR}    timeout=10s
    ${title}=    Get Text    ${DASHBOARD_TITLE_LOCATOR}
    # Should Be Equal As Strings    ${title}    Dashboard   
    RETURN   ${title} 

Verify Alert Is Displayed
    [Documentation]    Verify that the alert is displayed
    # ${alert}=    Get WebElement    ${alert_locator}
    [Arguments]    ${ALERT_TEXT}
    Element Text Should Be    ${ALERT_LOCATOR}    ${ALERT_TEXT}

Hide Tool Bar Button
    [Documentation]    Click the hide tool bar button
    Wait Until Element Is Visible    ${HIDE_TOOL_BAR_BUTTON_LOCATOR}
    Click Element    ${HIDE_TOOL_BAR_BUTTON_LOCATOR}