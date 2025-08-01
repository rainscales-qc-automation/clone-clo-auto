
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

${COURSE_NAME}       Block chain cơ bản

@{LIST_DATA_ASSESSMENT}    Assessment 1    Đánh giá thường xuyên    20    Written Paper    60    100    50    Planned

${ProgramName}    a
${ProgramDescription}    a
${ProgramDepartment}    a
${ProgramStartDate}    12052002
${ProgramEndDate}    12052003
${ProgramVersion}    1
${ProgramPage}    a

${InvalidProgramName}
${InvalidProgramDescription}
${InvalidProgramDepartment}
${InvalidProgramStartDate}
${InvalidProgramEndDate}
${InvalidProgramVersion}
${InvalidProgramPage}