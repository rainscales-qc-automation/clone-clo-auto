*** Settings ***
Library  SeleniumLibrary
Resource   ../locator/program_locator.robot
Resource    ../../pages/page_object/common_page.robot
Resource    ../../resources/variables.robot
Resource    ../pages/page_object/categories.robot





*** Keywords ***
Click Create New Program
    Wait Until Element Is Visible  ${ProgramButton}  timeout=5
    Scroll Element Into View    ${ProgramButton}
    Click Element    ${ProgramButton}
    Input Text  ${ProgramNameInputBox}  ${ProgramName}
    Input Text  ${ProgramDescriptionInputBox}  ${ProgramDescription}
    Input Text  ${ProgramDepartmentInputBox}  ${ProgramDepartment}
    Input Text  ${ProgramStartDateInputBox}  ${ProgramStartDate}
    Input Text  ${ProgramEndDateInputBox}  ${ProgramEndDate}
    Input Text  ${ProgramVersionInputBox}  ${ProgramVersion}

Click Create New Program With Data Incorrect
    Wait Until Element Is Visible  ${ProgramButton}  timeout=5
    Scroll Element Into View    ${ProgramButton}
    Click Element    ${ProgramButton}
    Input Text  ${ProgramNameInputBox}  ${InvalidProgramName}
    Input Text  ${ProgramDescriptionInputBox}  ${InvalidProgramDescription}
    Input Text  ${ProgramDepartmentInputBox}  ${InvalidProgramDepartment}
    Input Text  ${ProgramStartDateInputBox}  ${InvalidProgramStartDate}
    Input Text  ${ProgramEndDateInputBox}  ${InvalidProgramEndDate}
    Input Text  ${ProgramVersionInputBox}  ${InvalidProgramVersion}

Click Submit Button Create New Program
    Wait Until Element Is Visible    ${CreateProgrameButton}    5
    Scroll Element Into View         ${CreateProgrameButton}
    Click Element  ${CreateProgrameButton}


Verify Create Program Successful
    Element Should Be Visible  ${ProgramSuccessfulText}  timeout=5

Verify Create Program Failed
    Element Should Be Visible  ${ProgramErrorMessage}  timeout=5

Go To Program Management Page
    # Element Should Be Visible  ${GotoProgram}  timeout=15
    Go To Categories    Chương trình đào tạo
    # Click Element    ${GotoProgram}

Input Search
    Input Text  ${InputSearch}  Khoa Luan

Click Search 
    Click Element    ${ButtonSearch}

Verify Search Program Successful
    Element Should Be Visible  ${SearchSuccess}  timeout=5

Verify go to Program Successful
    Element Should Be Visible  ${GotoProgram}  timeout=5

Input Invalid data
    Input Text  ${InputSearch}  abcdhf

Verify Search Program Not found
    Element Should Be Visible  ${NoProgram}  timeout=5