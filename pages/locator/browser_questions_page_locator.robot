
***Variables***
#Title "Ngân Hàng Câu hỏi"
${TITLE_QUESTION_BANK_LOCATOR}    xpath=//h1[@class='content-title']

#Button
${ADD_QUESTION_BUTTON_LOCATOR}    xpath=//div[@class='form-group]

#FILTER_LABLE_LOCATOR

${FILTER_LABLE_LOCATOR}    xpath=//label[@for='filter']
${COURSE_LABLE_LOCATOR}    xpath=//label[@for='course_id']
${CLO_LABLE_LOCATOR}    xpath=//label[@for='clo_id']
${QUESTION_TYPE_LABLE_LOCATOR}    xpath=//label[@for='question_type']
${DIFFICULTY_LABLE_LOCATOR}    xpath=//label[@for='difficulty']
${STATUS_LABLE_LOCATOR}    xpath=//label[@for='status']
${APPROVAL_STATUS_LABLE_LOCATOR}    xpath=//label[@for='approval_status']
${TAGS_LABLE_LOCATOR}    xpath=//label[@for='tags']
${SEARCH_QUERY_LABLE_LOCATOR}    xpath=//label[@for='search_query']

#fILTER_ Dropdown
${COURSER_DROPDOWN_LOCATOR}    xpath=//select[@id='course_id']
${CLO_DROPDOWN_LOCATOR}    xpath=//select[@id='clo_id']
${QUESTION_TYPE_DROPDOWN_LOCATOR}    xpath=//select[@id='question_type']
${DIFFICULTY_DROPDOWN_LOCATOR}    xpath=//select[@id='difficulty']
${STATUS_DROPDOWN_LOCATOR}    xpath=//select[@id='status']
${APPROVAL_STATUS_DROPDOWN_LOCATOR}    xpath=//select[@id='approval_status']
${TAGS_DROPDOWN_LOCATOR}    xpath=//select[@id='tags']
${SEARCH_QUERY_INPUT_LOCATOR}    xpath=//input[@id='search_query']


#Option Approval Status
${OPTION_PENDING_STATUS_LOCATOR}    xpath=//option[@value='pending']
${OPTION_APPROVED_STATUS_LOCATOR}    xpath=//option[@value='approved']
${OPTION_REJECTED_STATUS_LOCATOR}    xpath=//option[@value='rejected']


#Button Apply Filter
${APPLY_FILTER_BUTTON_LOCATOR}    xpath=//button[normalize-space(.) = "Apply Filters"]

${APPROVE_BUTTON_LOCATOR}    xpath=//div[contains(@class, "card-body")]//a[contains(@href, "/approve/")][1]
${REJECT_BUTTON_LOCATOR}    xpath=//div[contains(@class, "card-body")]//a[contains(@href, "/reject/")][1]

${TAG_APPROVED_LOCATOR}    xpath=//span[normalize-space(.) = "Approved"]
${TAG_REJECTED_LOCATOR}    xpath=//span[normalize-space(.) = "Rejected"]

${ALERT_MESSAGE_SUCCESS_LOCATOR}    xpath=//div[contains(@class, "alert-success")]
