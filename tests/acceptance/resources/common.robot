*** Variables ***
${PREVIOUS_VALUE}=  0
${VALID_NAME}=  My first blog
${VALID_DESC}=  Short description
${VALID_CONT}=  Very long firstime blog text

*** Keywords ***

Get number of blogs
  [Arguments]  ${session}
  ${get}=  Get  ${session}  /
  ${cur_len}=  Get Length  ${get.json()}
  [Return]  ${cur_len}

Get current number of blogs
  [Arguments]  ${session}
  ${cur_len}=  Get number of blogs  ${session}
  ${prev_val}=  Return '${cur_len}' incremental by '1'
  Set Suite Variable  ${PREVIOUS_VALUE}  ${prev_val}

Return '${value}' incremental by '${inc}'
  ${num}=  Convert To Integer  ${value}
  ${plus}=  Convert To Integer  ${inc}
  ${total}=  Evaluate  ${num}+${plus}
  [Return]  ${total}

Create new blog
  [Arguments]  ${session}  ${data}
  ${headers}=  Create Post Headers
  ${resp}=  Post  ${session}  /new_blog  data=${data}  headers=${headers}
  [Return]  ${resp}

Create Post Headers
  ${headers}=  Create Dictionary  Content-Type  application/x-www-form-urlencoded
  [Return]  ${headers}

Generate Blog Data
  [Arguments]  ${name}=Blog  ${description}=Desc  ${content}=Cont
  ${data}=  Create Dictionary  name  ${name}  description  ${description}  content  ${content}
  [Return]  ${data}

Verify that new blog is created
  [Arguments]  ${response}
  Should Be Equal As Strings  ${resp.status_code}  200
  ${new_len}=  Get number of blogs  localhost
  Should Be Equal As Integers  ${PREVIOUS_VALUE}  ${new_len}

Create blog with default values
  [Arguments]  ${session}
  ${data}=  Generate Blog Data
  ${resp}=  Create New Blog  ${session}  ${data}
  [Return]  ${resp} 

Get newest index
  [Arguments]  ${session}
  ${num}=  Get number of blogs  ${session}
  ${ind}=  Evaluate  ${num}-1
  [Return]  ${ind}

Verify that '${resp}' statuscode is '${error_code}'
  ${error_code}=  Convert To Integer  ${error_code}
  Should Be Equal As Strings  ${resp.status_code}  ${error_code}

Get blog
  [Arguments]  ${session}  ${index}
  ${resp}=  Get  ${session}  /blog/${index}
  Verify that '${resp}' statuscode is '200'
  ${jsondata}=  To Json  ${resp.content}
  [Return]  ${jsondata}

Blog '${blog}' '${key}' should be '${value}'
  ${real_value}=  Get From Dictionary  ${blog}  ${key}
  Should Be Equal  ${value}  ${real_value}

Verify that blog contains correct values
  [Arguments]  ${blog}  ${name}  ${desc}  ${content}
  Blog '${blog}' 'name' should be '${name}'
  Blog '${blog}' 'description' should be '${desc}'
  Blog '${blog}' 'content' should be '${content}'
