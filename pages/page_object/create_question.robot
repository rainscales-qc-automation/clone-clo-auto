*** Settings ***
Library    SeleniumLibrary
Resource    ../../resources/browser_setup.robot
Resource    ../locator/create_question.robot
Resource    ../../pages/page_object/login_page.robot


*** Keywords ***
Login Lecturer And Go To Create Question Page
    [Documentation]    Login as lecturer and navigate to the create question page
    Login User    ${USERNAME_LECTURER}    ${PASSWORD_LECTURER}

    Wait Until Element Is Visible    ${A_CREATE_QUESTION}    10s
    Click Create Question Button
    
Click Create Question Button
    [Documentation]    Click the create question button to open the form
    Click Element    ${A_CREATE_QUESTION}

Verify Dropdown Options
    [Documentation]    Verify that a dropdown contains all expected options
    [Arguments]    ${dropdown_locator}    @{expected_options}
    Wait Until Element Is Visible    ${dropdown_locator}    10s
    @{actual_options}=    Get List Items    ${dropdown_locator}
    FOR    ${expected_option}    IN    @{expected_options}
        Should Contain    ${actual_options}    ${expected_option}
    END


Verify Required Field Error
    [Documentation]    Verify that a required field shows the correct error message
    [Arguments]    ${error_locator}    ${expected_message}=This field is required.
    Wait Until Element Is Visible    ${error_locator}    10s
    ${error_text}=    Get Text    ${error_locator}
    Should Be Equal    ${error_text}    ${expected_message}


Select From Dropdown
    [Documentation]    Select an option from a dropdown with proper scrolling and waiting
    [Arguments]    ${dropdown_locator}    ${option_label}
    Wait Until Element Is Visible    ${dropdown_locator}    10s
    Scroll Element Into View    ${dropdown_locator}
    Sleep    1s
    Select From List By Label    ${dropdown_locator}    ${option_label}
    Sleep    2s


Scrole Button And Click
    [Documentation]    Select an option from a dropdown with proper scrolling and waiting
    [Arguments]    ${butto_locator}
    Scroll Element Into View    ${butto_locator}
    Click Element    ${butto_locator}


Verify Title Create Question Page
    [Documentation]    Verify that the title of the create question page is correct
    Wait Until Element Is Visible    ${CREATE_QUESTION_TITLE}    10s
    ${title}=    Get Text    ${CREATE_QUESTION_TITLE}
    Should Be Equal    ${title}    Create New Question


Verify From Create Question Page Is Displayed
    [Documentation]    Verify that the element from the create question page is correct
    Page Should Contain Element    ${FCQ_H6_TITLE_FROM}
    Page Should Contain Element    ${A_BACK_TO_QUESTION_BANK}
    Page Should Contain Element    ${FCQ_CREATE_QUESTION_BUTTON}


Verify Item Dropdow In From Create Question
    [Documentation]    Verify that the item dropdown in the create question form is correct
    # Wait for form to load
    Wait Until Element Is Visible    ${CREATE_QUESTION_TITLE}    10s

    # Verify all dropdown options
    Verify Dropdown Options    ${FCQ_TYPE_SELECT}              @{FCQ_ODD_TYPE}
    Verify Dropdown Options    ${FCQ_DIFFICULTY_SELECT}        @{FCQ_ODD_DIFFICULTY}
    Verify Dropdown Options    ${FCQ_BLOOM_SELECT}             @{FCQ_ODD_BLOOM_LEVEL}
    Verify Dropdown Options    ${FCQ_STATUS_SELECT}            @{FCQ_ODD_STATUS}
    Verify Dropdown Options    ${FCQ_APPROVAL_STATUS_SELECT}   @{FCQ_ODD_APPROVAL_STATUS}


Verify List Required Field Error
    [Documentation]    Verify that a required field shows the correct error message
    # Wait for form to load and click Create Question button without filling fields
    Wait Until Element Is Visible    ${FCQ_CREATE_QUESTION_BUTTON}    10s
    Scrole Button And Click    ${FCQ_CREATE_QUESTION_BUTTON}

    # Verify required field error messages
    Verify Required Field Error    ${FCQ_COURSE_REQUIRED_ERROR}
    Verify Required Field Error    ${FCQ_CONTENT_REQUIRED_ERROR}
    Verify Required Field Error    ${FCQ_TYPE_REQUIRED_ERROR}
    Verify Required Field Error    ${FCQ_DIFFICULTY_REQUIRED_ERROR}
    Verify Required Field Error    ${FCQ_BLOOM_REQUIRED_ERROR}


Verify List Element Answer Form
    [Documentation]    Verify that the list element answer form is correct
    # Select Multiple Choice from Type dropdown (first option)
    Select From Dropdown    ${FCQ_TYPE_SELECT}    Multiple Choice

    # Verify answer form elements appear
    Wait Until Element Is Visible    ${FAW_FROM}    10s
    Page Should Contain Element    ${FAW_FROM}

    # Verify answer title exists
    Page Should Contain Element    ${FAW_ANSWER_TITLE}

    # Scroll button into view and click
    Scrole Button And Click    ${FAW_BTN_ADD_ANSWER}

    # Verify bonus answer title appears after clicking add button
    Page Should Contain Element    ${FAW_ANSWER_TITLE_BONUS}

    # Log verification results
    Log    Answer form verification completed successfully


Createn And Verify A Simple Question
    [Documentation]    Create and verify a simple question
    Input Text    ${FCQ_CONTENT_TEXTAREA}    abc
    Select From Dropdown    ${FCQ_COURSE_SELECT}    1234 - Abc
    Select From Dropdown    ${FCQ_TYPE_SELECT}    Essay
    Select From Dropdown    ${FCQ_DIFFICULTY_SELECT}    Easy
    Select From Dropdown    ${FCQ_BLOOM_SELECT}    Remember

    Sleep    2s

    Scrole Button And Click    ${FCQ_CREATE_QUESTION_BUTTON}
    Wait Until Element Is Visible    ${FCQ_CREATE_QUESTION_SUCCESS_MESSAGE}    10s
    Page Should Contain Element    ${FCQ_CREATE_QUESTION_SUCCESS_MESSAGE}




