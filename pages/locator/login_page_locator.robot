*** Variables ***

${INPUT_USERNAME}    xpath=//*[@id="id_username"]
${INPUT_PASSWORD}    xpath=//*[@id="id_password"]
${BUTTON_LOGIN}      xpath=//form/button
${MSG_ERROR}    xpath=//div[contains(@class, 'alert-error')]

${TITLE_FORM_LOGIN}    xpath=//*[@class='card-header']//h4