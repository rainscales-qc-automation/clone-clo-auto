

*** Variables ***

${ADD_ASSESSMENT_BUTTON_LOCATOR}    xpath=//a[normalize-space()='Thêm bài kiểm tra']

# Locators for the table course detail page

${NAME_COURSE_TABLE_LOCATOR}    xpath=//*[@class='text-decoration-none']/strong
${LOAI_DANH_GIA_TABLE_LOCATOR}    xpath=//span[@data-assessment-type='continuous']
${TY_TRONG_TABLE_LOCATOR}    xpath=//tr[@data-assessment-type='continuous']/td[3]/strong
${THOI_GIAN_TABLE_LOCATOR}    xpath=//tr[@data-assessment-type='continuous']/td[5]
${TRANG_THAI_TABLE_LOCATOR}    xpath=//tr[@data-assessment-type='continuous']/td[6]/span