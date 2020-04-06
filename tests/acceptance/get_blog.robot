*** Settings ***
Library    Collections         
Library    RequestsLibrary 
Resource    resources/common.robot


*** Test Cases ****
Get blog information should return correct blog
    Create Session    localhost    http://localhost:8080
    ${data}=    Generate Blog Data    ${VALID_NAME}    ${VALID_DESC}    ${VALID_CONT}
    ${resp}=    Create new blog    localhost    ${data}
    Verify that '${resp}' status code is '200'
    ${index}=    Get newest index    localhost
    ${blog}=  Get blog  localhost    ${index}
    Verify that blog contains correct values    ${blog}    ${VALID_NAME}    ${VALID_DESC}    ${VALID_CONT}
