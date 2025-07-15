
*** Variables ***
${BASE_URL}    https://demo-clo.minds.vn/
${BROWSER}     Chrome

# usernames and passwords for different roles
${USERNAME_ADMIN}    admin
${PASSWORD_ADMIN}    demoadmin

${USERNAME_LECTURER}    lecturer1
${PASSWORD_LECTURER}    demolecturer

${USERNAME_INVALID}    invaliduser
${PASSWORD_INVALID}    invalidpass

${TIMEOUT}     10s

${COURSE_NAME}       Cấu trúc dữ liệu và giải thuật

@{LIST_DATA_ASSESSMENT}    Assessment 1    Đánh giá thường xuyên    20    Written Paper    60    100    50    Planned