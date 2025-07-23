*** Settings ***

Library    RPA.Excel.Files

*** Variables ***

#Course variables
${TRANGCHU_MENUBAR}    //div[@class='menu-section']/a[contains(., 'Trang chủ')]
${CTDT_MENUBAR}    //a[contains(., 'Chương trình đào tạo')]
${PROGRAM_BTN}    //a[contains(.,'Programs')]
${COURSEMANAGEMENT_BTN}    //a[contains(.,'Quản lý học phần')]
${COURSES_BTN}    //a[contains(., 'Courses')]
${ADDCOURSE_BTN}    //a[contains(., 'Add Course')]
${PROGRAME_SELECT}    //*[@id="id_type"]
${COURSECODE_INPUT}    //*[@id="id_course_code"]
${COURSENAME_INPUT}    //*[@id="id_course_name"]
${CREDITS_INPUT}    //*[@id="id_credits"]
${DESCRIPTION_INPUT}    //*[@id="id_description"]
${TYPE_SELECT}    //*[@id="id_type"]
${CORESUBJECT_CKB}    //*[@id="id_is_core"]
${STATUS_SELECT}    //*[@id="id_status"]
${PREREQUISITE}    //*[@id="id_prerequisite_courses"]    
${CREATECOURSE_BTN}    //button[contains(., 'Create Course')]

${EDITCOURSE_BTN}    //tr[td[contains(., 'BL2')]]//a[contains(@href, '/update/')]
${VIEWCOURSE_BTN}    //tr[td[contains(., 'BLC01')]]//i[contains(@class,'fas fa-eye')]
${CREATENEW_BTN}    //button[contains(.,'Tạo mới')]
${UPDATECOURSE_BTN}    //button[contains(.,'Update Course')]
${UPDATE_SUCCESS_MESSAGE}    //div[@role='alert' and contains(., 'Course updated successfully!')]
#CLO variables
${HOCPHAN_MENUBAR}    //a[contains(.,'Học phần')]
${CLOs_BTN}    //a[contains(., 'CLOs')]
${ADDCLO_BTN}    //a[contains(., 'Add CLO')]
${COURSE_SELECT}    id:id_course
${CLO_CODE}    id:id_clo_code
${DESCRIPTION_CLOs}    id:id_description
${CATEGORY_SELECT}    id:id_category
${LEVEL_SELECT}    id_level
${WEIGHT_INPUT}    id:id_weight
${ASSESSMENT_METHOD_SELECT}    id:id_assessment_method
${CREATECLO_BTN}    //button[contains(., 'Create CLO')]
${REQUIRED_FIELD_ERROR}    //p[contains(.,'This field is required.')]

${LIST_CLO_IN_COURSE}    (//table[contains(@class, 'table ')])[1]/tbody/tr
${VALUE_CLO}    //div[contains(@class,'col mr-2') and contains(.,'CLO đã định nghĩa')]//div[2]
# Data tables
${EXCEL_FILE}    ${CURDIR}/../data_get/CLO.xlsx
${SHEET_NAME_COURSE}    get_data_course
${SHEET_NAME_CLO}    get_data_clo
${COURSE_TABLE_DATA}    //table//tbody/tr/td
${COURSE_TABLE_TITLE}    //table//thead/tr/th