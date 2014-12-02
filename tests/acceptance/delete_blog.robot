*** Settings ***
Library  Collections         
Library  RequestsLibrary 
Resource  resources/common.robot

*** TestCases ***

Removing blog should return 200
    Create Session  localhost  http://localhost:8080
    Get current number of blogs  localhost
    ${resp}=  Create blog with default values  localhost
    Verify that new blog is created  ${resp}
    ${delete}  ${index}=  Delete newest blog  localhost
    Verify that blog is deleted  localhost  ${delete}  ${index}

Removing blog that doesn't exists should return 404
    Create Session  localhost  http://localhost:8080
    ${blog_num}=  Get number of blogs  localhost
    ${index}=  Return '${blog_num}' incremental by '1'
    ${delete}=  Delete blog  localhost  ${index}
    Verify that '${delete}' statuscode is '404'


*** Keywords ***
Delete newest blog
    [Arguments]  ${session}
    ${index}=  Get newest index  ${session}
    ${resp}=  Delete blog  ${session}  ${index}
    [Return]  ${resp}  ${index}

Delete blog
    [Arguments]  ${session}  ${index}
    ${delete}=  Delete  ${session}  /delete_blog/${index}
    [Return]  ${delete}

Verify that blog is deleted
    [Arguments]  ${session}  ${resp}  ${previous_number_of_blogs}
    Should Be Equal As Strings  ${resp.status_code}  200
    ${cur_len}=  Get number of blogs  localhost
    Should Be Equal As Integers  ${cur_len}  ${previous_number_of_blogs}



