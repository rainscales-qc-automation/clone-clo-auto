*** Settings ***
Library  SeleniumLibrary
Resource    ../locator/common_locator.robot

*** Keywords ***
Click Hide Popup
    Click Element    ${Popup}