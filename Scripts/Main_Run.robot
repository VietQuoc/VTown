*** Settings ***
Library         Selenium2Library
Library         Collections
Library         CSV.py
Library         MyUtil.py
Library         String
Resource        Keyword.robot
Force Tags      Run
*** Variables ***
${all}    6, 45
*** Test Cases ***
Test
    @{list_i}=    Split String    ${all}    ,${EMPTY}
    :FOR    ${e}    IN    @{list_i}
    \    Run One    ${e}
    
*** Keywords ***
Run One
    [Arguments]    ${i}
    ${name}=    Set Variable    @{LIST_COMPANY_NAME}[${i}]
    Work Csv File    ${CURDIR}\\Results\\${name}.csv    Tên Công Ty    Mô Tả    Địa Chỉ    Phone    FAX    Ngày Thành Lập    Vốn Điều Lệ    Loại Hình Doanh Nghệp    Kinh Doanh    Hổ Trợ Ngôn Ngữ    Liên Kết    CATEGORY    Tên Hình Ảnh
    ${list}=    Create List    
    ${list}=    Read Data File    ${CURDIR}\\Data\\${name}.txt    1
    ${count}=    Get Length    ${list}
    :FOR    ${lin}    IN RANGE    0    ${count}
    \    Open Browser    @{list}[${lin}]    chrome
    \    Get All Data From Page    ${name}
    \    Close All Browsers