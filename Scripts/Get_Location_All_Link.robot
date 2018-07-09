*** Settings ***
Library         Selenium2Library
Library         Collections
Library         CSV.py
Library         MyUtil.py
Resource        Keyword.robot
*** Variables ***
${TITLE}    //div[contains(@class,'title') and contains(@class,'clearfix')]//h1

*** Test Cases ***
Test
    RUN  

