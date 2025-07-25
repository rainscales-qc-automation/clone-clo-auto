*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource    ../locator/chapter_locator.robot
*** Keywords ***
Click Button ThemChuong
    Scroll Element Into View    ${THEMCHUONG_BTN}
    Click Element    ${THEMCHUONG_BTN}
Go To Create Chapter
    [Arguments]    ${SOCHUONG_VL}    ${TIEUDECHUONG_VL}    ${NOIDUNGCHUONG_VL}
    ...    ${MUCTIEUHOCTAP_VL}    ${TIME_VL}    ${PHUONGPHAPDAY_VL}    ${CLOLIENQUAN_VL}
    #Select From List By Label    ${HOCPHAN}    ${HOCPHAN_VL}
    Input Text    ${SOCHUONG}    ${SOCHUONG_VL}
    Input Text    ${TIEUDECHUONG}    ${TIEUDECHUONG_VL}
    Input Text    ${NOIDUNGCHUONG}    ${NOIDUNGCHUONG_VL}
    Input Text    ${MUCTIEUHOCTAP}    ${MUCTIEUHOCTAP_VL}
    Input Text    ${TIME}    ${TIME_VL}        
    Input Text    ${PHUONGPHAPDAY}    ${PHUONGPHAPDAY_VL}
    Scroll Element Into View    ${THEMCHUONGCREATE_BTN}
    Select From List By Label    ${CLOLIENQUAN}    ${CLOLIENQUAN_VL}
    Click Element    ${THEMCHUONGCREATE_BTN}
   