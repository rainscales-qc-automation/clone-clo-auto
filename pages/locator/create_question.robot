*** Variables ***
# Create Question
# FCQ: Form Create Question
${A_CREATE_QUESTION}           xpath=//a[@href="/en/questionbank/questions/create/"]
${A_BACK_TO_QUESTION_BANK}     xpath=//a[normalize-space()='Back to Question Bank']
${CREATE_QUESTION_TITLE}       xpath=//h1[@class="content-title"]

${FCQ_H6_TITLE_FROM}           xpath=//h6[normalize-space()='Create New Question']
${FCQ_COURSE_LABEL}            xpath=//label[@for="id_course"]
${FCQ_COURSE_SELECT}           xpath=//select[@id="id_course"]

${FCQ_CONTENT_LABEL}           xpath=//label[@for="id_content"]
${FCQ_CONTENT_TEXTAREA}        xpath=//textarea[@id="id_content"]

${FCQ_TYPE_LABEL}              xpath=//label[@for="id_type"]
${FCQ_TYPE_SELECT}             xpath=//select[@id="id_type"]

${FCQ_DIFFICULTY_LABEL}        xpath=//label[@for="id_difficulty"]
${FCQ_DIFFICULTY_SELECT}       xpath=//select[@id="id_difficulty"]

${FCQ_BLOOM_LABEL}             xpath=//label[@for="id_bloom_level"]
${FCQ_BLOOM_SELECT}            xpath=//select[@id="id_bloom_level"]

${FCQ_STATUS_LABEL}            xpath=//label[@for="id_status"]
${FCQ_STATUS_SELECT}           xpath=//select[@id="id_status"]

${FCQ_APPROVAL_STATUS_LABEL}         xpath=//label[@for="id_approval_status"]
${FCQ_APPROVAL_STATUS_SELECT}        xpath=//select[@id="id_approval_status"]

${FCQ_COURSE_REQUIRED_ERROR}         xpath=//p[@id='error_1_id_course']
${FCQ_CONTENT_REQUIRED_ERROR}        xpath=//p[@id='error_1_id_content']
${FCQ_TYPE_REQUIRED_ERROR}           xpath=//p[@id='error_1_id_type']
${FCQ_DIFFICULTY_REQUIRED_ERROR}     xpath=//p[@id='error_1_id_difficulty']
${FCQ_BLOOM_REQUIRED_ERROR}          xpath=//p[@id='error_1_id_bloom_level']

${FCQ_CREATE_QUESTION_BUTTON}               xpath=//button[normalize-space()='Create Question']
${FCQ_CREATE_QUESTION_SUCCESS_MESSAGE}      xpath=//div[normalize-space()='Question created successfully!']

# ODD: List Option Drop Down
@{FCQ_ODD_TYPE}                Multiple Choice    Essay    Practical    True/False    Short Answer    Matching
@{FCQ_ODD_DIFFICULTY}          Easy    Medium    Hard
@{FCQ_ODD_BLOOM_LEVEL}         Remember    Understand    Apply    Analyze    Evaluate    Create
@{FCQ_ODD_STATUS}              Active    Inactive
@{FCQ_ODD_APPROVAL_STATUS}     Pending    Approved    Rejected

# FAW: From Answer
${FAW_FROM}            xpath=//div[@id='answer-formset-container']
${FAW_BTN_ADD_ANSWER}            xpath=//button[@id='add-answer']
${FAW_ANSWER_TITLE}            xpath=//h6[text()='Answer Option 4']
${FAW_ANSWER_TITLE_BONUS}            xpath=//h6[text()='Answer Option 5']
