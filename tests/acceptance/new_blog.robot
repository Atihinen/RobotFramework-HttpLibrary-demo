*** Settings ***
Library  Collections         
Library  RequestsLibrary 
Resource  resources/common.robot


*** TestCases ***
New blog should return 200
  Create Session  localhost  http://localhost:8080
  Get current number of blogs  localhost
  ${resp}=  Create blog with default values  localhost
  Verify that new blog is created  ${resp}










