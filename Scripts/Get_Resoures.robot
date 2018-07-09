*** Settings ***
Library         Selenium2Library
Library         Collections
Library         CSV.py
*** Test Cases ***
Get Source
    [Teardown]    Close All Browsers
    Open Browser    http://vtown.vn/    chrome
    ${COMPANY_LABEL}=    Set Variable    //ul[contains(@id,'group')]//li//a
    ${NUMBER_COMPANY}=    Get Matching Xpath Count    ${COMPANY_LABEL}
    ${LIST_COMPANY_NAME}=    Create List    
    ${LIST_COMPANY_LINK}=    Create List    
    :FOR    ${i}    IN RANGE    1    ${number_company}+1
    \    ${company_name}=    Get Element Attribute    xpath=(${COMPANY_LABEL})[${i}]    title
    \    ${company_link}=    Get Element Attribute    xpath=(${COMPANY_LABEL})[${i}]    href
    \    Append To List    ${LIST_COMPANY_NAME}    ${company_name}
    \    Append To List    ${LIST_COMPANY_LINK}    ${company_link}
    
    Log    List Company Name: 
    Log    ${LIST_COMPANY_NAME}
    Create And Write File Txt    ${CURDIR}\\Data\\list_company_name.txt    @{LIST_COMPANY_NAME}
    Log    List Company Link:
    Log    ${LIST_COMPANY_LINK}
    Create And Write File Txt    ${CURDIR}\\Data\\list_company_link.txt    @{LIST_COMPANY_LINK}