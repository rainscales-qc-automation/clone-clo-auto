

*** Variables ***
# Title Thêm đánh giá mới
${TITLE_ADD_ASSESSMENT_LOCATOR}    xpath=//h1[@class='content-title']

${TEN_DANH_GIA_LOCATOR}    id=id_assessment_name
${LOAIDANH_GIA_LOCATOR}    id=id_assessment_type
${TYTRONG_LOCATOR}    id=id_weight_percentage

${DINHDANGTHI_LOCATOR}    id=id_exam_format
${THOIGIAN_LOCATOR}    id=id_duration_minutes
${TONGDIEM_LOCATOR}    id=id_total_marks

${DIEMDAT_LOCATOR}    id=id_passing_score

${TRANGTHAI_LOCATOR}    id=id_status

${BUTTON_ADD_ASSESSMENT_LOCATOR}    xpath=//div[@class='form-group']/button[contains(., 'Thêm đánh giá')]/i
# //div[@class='form-group']/button