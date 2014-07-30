*** Settings ****
Resource  ${ENVIRONMENT}.txt

*** Keywords ***

*** Variables ***

*** Test cases ***

Get method should return 200 OK
    GET  ${SERVER}/
    Response Status Code Should Equal  200