*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${THEMCHUONG_BTN}    //a[contains(., "Thêm chương")]
${HOCPHAN}    //*[@id="id_course"]
${SOCHUONG}    //*[@id="id_chapter_number"]
${TIEUDECHUONG}    //*[@id="id_chapter_title"]
${NOIDUNGCHUONG}    //*[@id="id_content_description"]    
${MUCTIEUHOCTAP}    //*[@id="id_learning_objectives"]
${TIME}    //*[@id="id_duration_hours"]
${PHUONGPHAPDAY}    //*[@id="id_teaching_methods"]
${CLOLIENQUAN}    //*[@id="id_mapped_clos"]
${THEMCHUONGCREATE_BTN}    //button[contains(., 'Thêm chương')]
${HUỶ_BTN}    //button[contains(., 'Huỷ')]
