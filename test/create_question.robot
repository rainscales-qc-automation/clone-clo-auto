*** Settings ***
Library    SeleniumLibrary

Resource    ../resources/browser_setup.robot
Resource    ../pages/page_object/login_page.robot
Resource    ../pages/page_object/create_question.robot
Resource    ../pages/locator/create_question.robot


Test Setup    Open Browser To Login Page
Test Teardown    Close Browser and Quit


*** Test Cases ***
VERIFY FORM CREATE QUESTION
   [Documentation]    Test verify form create question
   [Tags]    question    positive

   Login Lecturer And Go To Create Question Page
   Verify Title Create Question Page
   Verify Element From Create Question Page

   [Teardown]    Close Browser


VERIFY DROPDOWN OPTION CREATE QUESTION FROM
   [Documentation]    Test verify dropdown options in create question form
   [Tags]    question    dropdown    positive

   Login Lecturer And Go To Create Question Page
   Verify Item Dropdow In From Create Question
   Log    All dropdown options verified successfully

   [Teardown]    Close Browser


VERIFY REQUIRED FIELD ERRORS
   [Documentation]    Test verify required field error messages when submitting empty form
   [Tags]    question    validation    negative

   Login Lecturer And Go To Create Question Page
   Verify List Required Field Error
   Log    All required field error messages verified successfully

   [Teardown]    Close Browser


VERIFY ANSWER FORM
   [Documentation]    Test verify answer form appears when Multiple Choice is selected
   [Tags]    question    answer    positive

   Login Lecturer And Go To Create Question Page
   Verify List Element Answer Form

   [Teardown]    Close Browser


CREATE SIMPLE QUESTION FORM
   [Documentation]    Test create a simple question
   [Tags]    question    create    positive

   Login Lecturer And Go To Create Question Page
   Createn And Verify A Simple Question

   [Teardown]    Close Browser
   