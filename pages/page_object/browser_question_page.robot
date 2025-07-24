*** Settings ***
Resource    ../locator/browser_questions_page_locator.robot
Resource    ../locator/question_bank_locator.robot


Library    SeleniumLibrary   

*** Keywords ***
Open Browse Question Page
    Click Element    ${BROWSER_QUESTIONS_CATEGORY}

Filter Approval Status Pending
    Click Element    ${APPROVAL_STATUS_DROPDOWN_LOCATOR}
    Click Element    ${OPTION_PENDING_STATUS_LOCATOR}
    Click Button    ${APPLY_FILTER_BUTTON_LOCATOR}

Click Approve Button
    Click Element    ${APPROVE_BUTTON_LOCATOR}

Click Reject Button
    Click Element    ${REJECT_BUTTON_LOCATOR}

Filter Course
    [Arguments]    ${course}
    Click Element    ${COURSER_DROPDOWN_LOCATOR}
    ${course_option}=    Set Variable    //select[@id="course_id"]/option[normalize-space(text())="${course}"]
    Wait Until Element Is Visible    ${course_option}    timeout=10
    Click Element    ${course_option}
    Click Button    ${APPLY_FILTER_BUTTON_LOCATOR}
