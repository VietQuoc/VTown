*** Settings ***
Library         Selenium2Library
Library         Collections
Library         CSV.py
*** Test Cases ***
Get Location For All Company
    ${LIST_COMPANY_NAME}=    Create List    
    ${LIST_COMPANY_LINK}=    Create List 
    ${LIST_COMPANY_LINK}=    Read Data File    ${CURDIR}\\Data\\list_company_link.csv
    ${LIST_COMPANY_NAME}=    Read Data File    ${CURDIR}\\Data\\list_company_name.csv
    
