*** Settings ***
Library  Collections         
Library  RequestsLibrary 
Resource  resources/common.robot


*** Variables ***

${UPDATED_NAME}=  My very first blog
${UPDATED_DESC}=  Very short description
${UPDATED_CONT}=  Very very long updated blog text

*** TestCases ***
Updating blog should return updated blog
    Create Session  localhost  http://localhost:8080
    ${data}=  Generate Blog Data  ${VALID_NAME}  ${VALID_DESC}  ${VALID_CONT}
    ${blog}=  Create blog with custom data  ${data}  localhost
    Verify that blog contains correct values  ${blog}  ${VALID_NAME}  ${VALID_DESC}  ${VALID_CONT}
    ${blog_id}=  Get object id  ${blog}
    ${update_data}=  Generate Blog Data  ${UPDATED_NAME}  ${UPDATED_DESC}  ${UPDATED_CONT}
    ${index}=  Get newest index  localhost
    Update blog post  localhost  ${index}  ${update_data}
    ${updated_blog}=  Get blog  localhost  ${index}
    Verify that blog contains correct values  ${updated_blog}  ${UPDATED_NAME}  ${UPDATED_DESC}  ${UPDATED_CONT}
    ${updated_blog_id}=  Get object id  ${updated_blog}
    Should Be Equal As Integers  ${blog_id}  ${updated_blog_id}



*** Keywords ***
Create blog with custom data
  [Arguments]  ${data}  ${session}
  ${resp}=  Create new blog  ${session}  ${data}
  Verify that '${resp}' status code is '200'
  ${index}=  Get newest index  ${session}
  ${blog}=  Get blog  ${session}  ${index}
  [Return]  ${blog}

Verify that blog contains correct values
  [Arguments]  ${blog}  ${name}  ${desc}  ${content}
  Blog '${blog}' 'name' should be '${name}'
  Blog '${blog}' 'description' should be '${desc}'
  Blog '${blog}' 'content' should be '${content}'

Update blog post
  [Arguments]  ${session}  ${index}  ${data}
  ${headers}=  Create Post Headers
  ${resp}=  Put  ${session}  /blog/${index}/update  data=${data}  headers=${headers}
  Verify that '${resp}' status code is '200'

Get object id
  [Arguments]  ${object}
  ${id}=  Get From Dictionary  ${object}  id
  [Return]  ${id}




