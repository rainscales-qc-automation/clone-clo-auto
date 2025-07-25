*** Settings ***
Library    SeleniumLibrary

Resource    ../pages/page_object/browser_question_page.robot
Resource    ../pages/page_object/dashboard_page.robot
Resource    ../pages/page_object/login_page.robot
Resource    ../resources/browser_setup.robot
Resource    ../pages/page_object/categories.robot

Test Setup       Open Browser To Login Page
Test Teardown     Close Browser And Quit

*** Test Cases ***
TC_BrowserQs_001: Approve Question
    [Documentation]    User Admin Approve Question
    [Tags]    Browser    Approved
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    # Hide Tool Bar Button
    Go To Categories    Duyệt câu hỏi
    Filter Approval Status Pending
    Click Approve Button
    Page Should Contain Element    ${ALERT_MESSAGE_SUCCESS_LOCATOR}
    Element Should Contain    ${ALERT_MESSAGE_SUCCESS_LOCATOR}    Question approved successfully!
    Page Should Contain Element    ${TAG_APPROVED_LOCATOR}
    Element Should Contain    ${TAG_APPROVED_LOCATOR}    Approved

TC_BrowserQs_002: Reject Question
    [Documentation]    User Admin Reject Question
    [Tags]    Browser    Rejected
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    # Hide Tool Bar Button
    Go To Categories    Duyệt câu hỏi
    Filter Approval Status Pending
    Click Reject Button
    Page Should Contain Element    ${ALERT_MESSAGE_SUCCESS_LOCATOR}
    Element Should Contain    ${ALERT_MESSAGE_SUCCESS_LOCATOR}    Question rejected.
    Page Should Contain Element    ${TAG_REJECTED_LOCATOR}
    Element Should Contain    ${TAG_REJECTED_LOCATOR}    Rejected

TC_BrowserQs_003: Filter Course
    [Documentation]    Filter Course: CS301: Cơ sở dữ liệu
    [Tags]    BrowserQuestion    FilterCourse
    Login User   ${USERNAME_ADMIN}    ${PASSWORD_ADMIN}
    # Hide Tool Bar Button
    Go To Categories    Duyệt câu hỏi
    ${course}=    Set Variable    CS301: Cơ sở dữ liệu
    Filter Course    ${course}


***Keywords***