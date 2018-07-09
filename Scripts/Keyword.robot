*** Settings ***
Library         Selenium2Library
Library         Collections
Library         CSV.py
Library         MyUtil.py
*** Variables ***
${TITLE}                //div[contains(@class,'title') and contains(@class,'clearfix')]//h1
${COMPANY_URL}          //div[@class='company-info']//h3//a
@{LIST_COMPANY_NAME}    Hồ Chí Minh    Hà Nội    Bình Dương    Đồng Nai    Hải Phòng     Bắc Ninh     Đà Nẵng    Hưng Yên    Hải Dương     Vĩnh Phúc    Long An    Bà Rịa - Vũng Tàu    Thanh Hóa    Khánh Hòa    Cần Thơ    Quảng Nam    Lâm Đồng    Hà Nam    Nghệ An    Bình Định    Thừa Thiên Huế    Phú Thọ     Bình Thuận    Tiền Giang    Thái Bình    Quảng Ninh    Bắc Giang    Tây Ninh    Ninh Bình    Hà Tĩnh    Bình Phước    Sơn La    Nam Định    Hòa Bình    Đắk Lắk    Quảng Ngãi    Kiên Giang    Đồng Tháp    Bạc Liêu     Thái Nguyên    Hà Tây    Đắk Nông    Cao Bằng	Kon Tum    Gia Lai    Tuyên Quang

${NAME}                 //span[@itemprop='name']
${LOGO}                 //div[contains(@class,'com-info')]//img[@itemprop='logo']
${DESCRIPTION}          //span[@itemprop='description']
${ADDRESS}              //span[@itemprop='streetAddress']
${PHONE}                //span[@itemprop='telephone']
${FAX}                  //span[@itemprop='faxNumber']
${FOUND_DATE}           //span[@itemprop='foundingDate']
${MONEY}                //th[normalize-space()='Vốn điều lệ']/following-sibling::td
${LOAI_HINH}            //th[normalize-space()='Loại hình doanh nghiệp']/following-sibling::td
${KINH_DOANH}           //th[normalize-space()='Kinh doanh']/following-sibling::td
${LANGUAGE}             //span[@itemprop='inLanguage']
${LIEN_KET}             //th[normalize-space()='Liên kết']/following-sibling::td//a
${CATEGORY}             //ul[@class='list-genre']//li//a
*** Keywords ***
Get All Data From Page
    [Arguments]    ${location_name}
    Wait Until Page Contains Element    ${NAME}    
    ${list_input}=    Create List    
    ${main_name}=    Get Text    ${NAME}
    Append To List    ${list_input}    ${main_name}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${DESCRIPTION}        
    ${a}=    Run Keyword If    ${check}    Get Text    ${DESCRIPTION}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${ADDRESS}   
    ${a}=    Run Keyword If    ${check}    Get Text    ${ADDRESS}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${FAX}   
    ${a}=    Run Keyword If    ${check}    Get Text    ${FAX}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${PHONE}   
    ${a}=    Run Keyword If    ${check}    Get Text    ${PHONE}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${FOUND_DATE}   
    ${a}=    Run Keyword If    ${check}    Get Text    ${FOUND_DATE}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${MONEY}   
    ${a}=    Run Keyword If    ${check}    Get Text    ${MONEY}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${LOAI_HINH}   
    ${a}=    Run Keyword If    ${check}    Get Text    ${LOAI_HINH}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${KINH_DOANH}   
    ${a}=    Run Keyword If    ${check}    Get Text    ${KINH_DOANH}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${LANGUAGE}   
    ${a}=    Run Keyword If    ${check}    Get Text    ${LANGUAGE}    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${LIEN_KET}   
    ${a}=    Run Keyword If    ${check}    Get Element Attribute    ${LIEN_KET}    href    ELSE    Set Variable    ${EMPTY}
    Append To List    ${list_input}    ${a}
       
    ${num_cate}=    Get Matching Xpath Count    ${CATEGORY}
    ${category_results}=    Set Variable       
    :FOR    ${ca}    IN RANGE    1    ${num_cate}+1
    \    ${c}=    Get Text    xpath=(${CATEGORY})[${ca}]
    \    ${category_results}=    Set Variable If    '${ca}'!='1'      ${category_results}, ${c}    ${c}
    Append To List    ${list_input}    ${category_results}
    
    ${check}=    Run Keyword And Return Status    Page Should Contain Element    ${LOGO}   
    ${a}=    Run Keyword If    ${check}    Get Element Attribute    ${LOGO}    src
    Run Keyword If    ${check}    Download File    ${a}    ${CURDIR}\\Image\\${main_name}.jpg
    Append To List    ${list_input}    ${main_name}.jpg
    
    Work Csv File    ${CURDIR}\\Results\\${location_name}.csv    @{list_input}

Get Number Location Of Company
    [Arguments]    ${url}    ${location_name}
    
    Wait Until Page Contains Element    ${TITLE}     
    ${title_text}=    Get Text    ${TITLE}
    ${number_company}=    Get Number Company    ${title_text}
    ${number_page}=    Convert Number Company To Number Page    ${number_company}
    ${number_page}=    Set Variable If    '${number_page}'=='0'    1    ${number_page}
    ${list_link_final}=    Create List    
    :FOR    ${i}    IN RANGE    1    ${number_page}+1
    \    Go To    ${url}?Company_page=${i}
    \    ${li}=    Get List Link
    \    ${list_link_final}=    Combine Lists    ${list_link_final}    ${li}
    Create And Write File Txt    ${CURDIR}\\Data\\${location_name}.txt    @{list_link_final}

Get List Link
    Wait Until Page Contains Element    ${COMPANY_URL}
    ${number_link}=    Get Matching Xpath Count    ${COMPANY_URL}
    ${list_link}=    Create List    
    :FOR    ${index}    IN RANGE    1    ${number_link}+1
    \    ${get_link}=    Get Element Attribute    xpath=(${COMPANY_URL})[${index}]    href
    \    Append To List    ${List_link}    ${get_link}
    [Return]    ${list_link}

RUN
    ${LIST_COMPANY_LINK}=    Create List 
    ${LIST_COMPANY_LINK}=    Read Data File    ${CURDIR}\\Data\\list_company_link.txt    1
    ${number_name}=    Get Length    ${LIST_COMPANY_NAME}    
    ${count}=    Get Length    ${LIST_COMPANY_LINK}
    :FOR    ${g}    IN RANGE    0    ${count}
    \    Open Browser    @{LIST_COMPANY_LINK}[${g}]    chrome
    \    Get Number Location Of Company    @{LIST_COMPANY_LINK}[${g}]    @{LIST_COMPANY_NAME}[${g}]
    \    Close All Browsers

