*** Settings ***
Resource   ../locator/course_locator.robot
Resource    ../../resources/browser_setup.robot
Library    SeleniumLibrary
Library    String
Library    Collections
*** Keywords ***
Select value course
    Select Checkbox    ${CORESUBJECT_CKB}

Scroll to Create Course Button
    Scroll Element Into View    ${CREATECOURSE_BTN}

Enter Value Course Name
    [Arguments]    ${COURSE_NAME}
    Input Text    ${COURSENAME_INPUT}    ${COURSE_NAME}
Enter Value Course Code
    [Arguments]    ${COURSE_CODE}
    Input Text    ${COURSECODE_INPUT}    ${COURSE_CODE}    
Go to create course
    Wait Until Element Is Visible    ${TRANGCHU_MENUBAR}    timeout=10s
    Click Element    ${TRANGCHU_MENUBAR}
    Scroll Element Into View    ${COURSEMANAGEMENT_BTN}
    Click Element    ${COURSEMANAGEMENT_BTN}
    Wait Until Page Contains    All Course
    Click Element    ${PROGRAM_BTN}
    Click Element    ${COURSES_BTN}
    Click Element    ${ADDCOURSE_BTN}

Enter Course Detail Form
    [Arguments]    ${PROGRAM_VL}    ${COURSE_CODE_VL}    ${COURSE_NAME_VL}    ${CREDITS_VL}    
    ...    ${DESCRIPTION_VL}    ${TYPE_VL}    ${STATUS_VL}    ${PREREQUISITE_VL}
    #Select From List By Label    ${PROGRAME_SELECT}
    Select From List By Label    id:id_program    ${PROGRAM_VL}
    Input Text    ${COURSECODE_INPUT}    ${COURSE_CODE_VL}
    Input Text    ${COURSENAME_INPUT}    ${COURSE_NAME_VL}        
    Input Text    ${CREDITS_INPUT}    ${CREDITS_VL}   
    Input Text    ${DESCRIPTION_INPUT}    ${DESCRIPTION_VL}    
    Scroll to Create Course Button
    Click Element    ${TYPE_SELECT}        
    # Select From List By Label    id:id_type   
    Select value course
    Select From List By Label    ${STATUS_SELECT}    ${STATUS_VL}
    Select From List By Label    ${PREREQUISITE}    ${PREREQUISITE_VL}
    Click Element    ${CREATECOURSE_BTN}
Enter Course Detail Form With Maximum Credits
    [Arguments]    ${PROGRAM_VL}    ${COURSE_CODE_VL}    ${COURSE_NAME_VL}        
    ...    ${DESCRIPTION_VL}    ${TYPE_VL}    ${STATUS_VL}    ${PREREQUISITE_VL}
    #Select From List By Label    ${PROGRAME_SELECT}
    Select From List By Label    id:id_program    ${PROGRAM_VL}
    Input Text    ${COURSECODE_INPUT}    ${COURSE_CODE_VL}
    Input Text    ${COURSENAME_INPUT}    ${COURSE_NAME_VL}
    # Input Text    ${CREDITS_INPUT}    ${CREDITS_VL}   
    # ${prev}=    Get Value    ${CREDITS_INPUT}
    # ${prev}=    Convert To Integer    ${prev}

    FOR    ${value}    IN    @{TEST_VALUES}
        Clear Element Text    ${CREDITS_INPUT}
        Input Text    ${CREDITS_INPUT}    ${value}
        #Click Element    ${CREATECOURSE_BTN}
        Sleep    0.5s
        ${is_success}=    Run Keyword And Return Status    Element Should Be Visible    Giá trị hợp lệ
        ${is_error}=      Run Keyword And Return Status    Element Should Be Visible    ${ERROR_MSG}
        Run Keyword If    ${is_success}    Log    ${value} là giá trị hợp lệ
        Run Keyword If    ${is_error}      Log    ${value} là giá trị không hợp lệ
    END
    
    Input Text    ${DESCRIPTION_INPUT}    ${DESCRIPTION_VL}    
    Scroll to Create Course Button
    Click Element    ${TYPE_SELECT}        
    # Select From List By Label    id:id_type   
    Select value course
    Select From List By Label    ${STATUS_SELECT}    ${STATUS_VL}
    Select From List By Label    ${PREREQUISITE}    ${PREREQUISITE_VL}
    Click Element    ${CREATECOURSE_BTN}

Empty Required Fields With Course Form
    Select value course
    Scroll to Create Course Button
    Select From List By Label    ${PREREQUISITE}    BLC01 - Block chain
    Click Button    ${CREATECOURSE_BTN}
    Wait Until Page Contains    This field is required.   timeout=10s
    ${ele}    Get WebElements    //p[contains(.,'This field is required.')]
    ${count}    Get Length    ${ele}
    Log    Số lượng trường bắt buộc phải điền: ${count}

Go To Create CLO
    Wait Until Element Is Visible    ${TRANGCHU_MENUBAR}    timeout=10s
    Click Element    ${TRANGCHU_MENUBAR}
    Scroll Element Into View    ${COURSEMANAGEMENT_BTN}
    Click Element    ${COURSEMANAGEMENT_BTN}
    Wait Until Page Contains    All Course
    Click Element    ${PROGRAM_BTN}
    Click Element    ${COURSES_BTN}
    Click Element    ${CLOs_BTN}
    Click Element    ${ADDCLO_BTN}

Enter Course Learning Outcome Form
    [Arguments]    ${COURSE_VL}    ${CLO_CODE_VL}    ${DESCRIPTION_VL}    
    ...    ${CATEGORY_VL}    ${LEVEL_VL}    ${WEIGHT_VL}    ${ASSESSMENT_METHOD_VL}
    Select From List By Label    ${COURSE_SELECT}    ${COURSE_VL}
    Input Text    ${CLO_CODE}    ${CLO_CODE_VL}
    Input Text    ${DESCRIPTION_CLOs}    ${DESCRIPTION_VL}
    Scroll Element Into View    ${CREATECLO_BTN}
    Select From List By Label    ${CATEGORY_SELECT}    ${CATEGORY_VL}
    Select From List By Label    ${LEVEL_SELECT}    ${LEVEL_VL}
    Input Text    ${WEIGHT_INPUT}    ${WEIGHT_VL}
    Select From List By Label    ${ASSESSMENT_METHOD_SELECT}    ${ASSESSMENT_METHOD_VL}
    Click Element    ${CREATECLO_BTN}

Empty Required Fields With CLOs
    Wait Until Element Is Visible    ${CREATECLO_BTN}
    Scroll Element Into View    ${CREATECLO_BTN}
    Click Button    ${CREATECLO_BTN}
    Wait Until Page Contains    This field is required.   timeout=10s
    ${ele}    Get WebElements    ${REQUIRED_FIELD_ERROR}
    ${count}    Get Length    ${ele}
    Log    Số lượng trường bắt buộc phải điền: ${count}

Go To CLO
    Click Element    ${HOCPHAN_MENUBAR}
    Click Element    ${CLOs_BTN}

View Course Name From Table
    Wait Until Element Is Visible    ${TRANGCHU_MENUBAR}    timeout=10s
    Click Element    ${TRANGCHU_MENUBAR}
    Scroll Element Into View    ${COURSEMANAGEMENT_BTN}
    Click Element    ${COURSEMANAGEMENT_BTN}
    Wait Until Page Contains    All Course
    Click Element    ${PROGRAM_BTN}
    Click Element    ${COURSES_BTN}
    Wait Until Element Is Visible    ${COURSE_TABLE_DATA}    timeout=10s

# Save Course Table Data To Excel
#     ${cols}=    Get Element Count    xpath=//table/thead/tr/th
#     @{headers}=    Create List
#     FOR    ${j}    IN RANGE    1    ${cols}+1
#         ${header}=    Get Text    xpath=//table/thead/tr/th[${j}]
#         Append To List    ${headers}    ${header}
#     END

#     ${rows}=    Get Element Count    xpath=//table/tbody/tr

#     @{all_rows}=    Create List
#     Append To List    ${all_rows}    ${headers}

#     FOR    ${i}    IN RANGE    1    ${rows}+1
#         @{row}=    Create List
#         FOR    ${j}    IN RANGE    1    ${cols}+1
#             ${cell}=    Get Text    xpath=//table/tbody/tr[${i}]/td[${j}]
#             Append To List    ${row}    ${cell}
#         END
#         Append To List    ${all_rows}    ${row}
#     END

    
#     ${file_exist}=    Run Keyword And Return Status    File Should Exist    ${EXCEL_FILE}
#     IF    ${file_exist}
#         Open Workbook    ${EXCEL_FILE}
#     ELSE
#         Create Workbook    ${EXCEL_FILE}
#     END
    
#     Create Worksheet   ${SHEET_NAME_COURSE}    header=${False}
#     Append Rows To Worksheet    ${all_rows}    header=${False}
    
#     Save Workbook    ${EXCEL_FILE}
#     Close Workbook

# Save CLO Table Data To Excel
#     ${cols}=    Get Element Count    xpath=//table/thead/tr/th
#     @{headers}=    Create List
#     FOR    ${j}    IN RANGE    1    ${cols}+1
#         ${header}=    Get Text    xpath=//table/thead/tr/th[${j}]
#         Append To List    ${headers}    ${header}
#     END

#     ${rows}=    Get Element Count    xpath=//table/tbody/tr

#     @{all_rows}=    Create List
#     Append To List    ${all_rows}    ${headers}

#     FOR    ${i}    IN RANGE    1    ${rows}+1
#         @{row}=    Create List
#         FOR    ${j}    IN RANGE    1    ${cols}+1
#             ${cell}=    Get Text    xpath=//table/tbody/tr[${i}]/td[${j}]
#             Append To List    ${row}    ${cell}
#         END
#         Append To List    ${all_rows}    ${row}
#     END

#     ${file_exist}=    Run Keyword And Return Status    File Should Exist    ${EXCEL_FILE}
#     IF    ${file_exist}
#         Open Workbook    ${EXCEL_FILE}
#     ELSE
#         Create Workbook    ${EXCEL_FILE}
#     END
    
#     Create Worksheet   ${SHEET_NAME_CLO}    header=${False}
#     Append Rows To Worksheet    ${all_rows}    header=${False}
    
#     Save Workbook    ${EXCEL_FILE}
#     Close Workbook


Edit Course
    Click Element    ${EDITCOURSE_BTN}
    Wait Until Element Is Visible    ${COURSECODE_INPUT}    timeout=10s
    Scroll Element Into View    ${UPDATECOURSE_BTN}
    Click Button    ${UPDATECOURSE_BTN}    

    
Compare value CLO
    ${value}    Get Text    ${VALUE_CLO}

    ${ele}    Get WebElements    ${LIST_CLO_IN_COURSE}
    ${count}    Get Length    ${ele}

    Should Be Equal As Strings    ${value}    ${count} 
    Log    Giá trị CLO trong khoá học: ${value} = ${count}   
    