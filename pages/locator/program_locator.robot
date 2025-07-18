*** Variables ***
${TitleProgramText}     xpath://h1[text()='Create New Program']
${ProgramNameInputBox}     id:id_program_name
${ProgramDescriptionInputBox}     id:id_program_description
${ProgramDepartmentInputBox}     id:id_department
${ProgramStartDateInputBox}     id:id_start_date
${ProgramEndDateInputBox}     id:id_end_date
${ProgramVersionInputBox}     id:id_version
${CreateProgrameButton}     xpath=//button[normalize-space()='Create Program']
${ProgramSuccessfulText}    xpath://div[contains(@class, 'alert-success') and contains(., 'Program created successfully!')]
${ProgramButton}     xpath=//a[contains(@class, 'btn-primary') and contains(normalize-space(.), 'Tạo chương trình mới')]

${UpdateProgramButton}     xpath://a[i[@class='fas fa-edit']]
${ProgramErrorMessage}     xpath://strong[text()='This field is required.']
${GotoProgram}     xpath://a[@href='/en/academics/programs/' and normalize-space(.)='Chương trình đào tạo']
${InputSearch}     xpath://input[@name='q' and @placeholder='Search programs...']
${ButtonSearch}     xpath://button[@type='submit' and contains(@class, 'btn-primary')]
${SearchSuccess}     xpath://td[text()='Khoa Luan']
${NoProgram}     xpath://div[contains(text(), 'No programs found.')]