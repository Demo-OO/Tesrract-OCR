########################################################################################################################
#!!
#! @system_property advantage___accountservice_war_rest_api_auth_type: Authentication type 
#!                                                                     (Anonymous/Basic/Digest/Bearer)
#! @system_property advantage___accountservice_war_rest_api_additional_headers: List containing the headers to use for 
#!                                                                              the request separated by new line 
#!                                                                              (CRLF); header name - value pair will be 
#!                                                                              separated by ":". Format: According to 
#!                                                                              HTTP standard for headers (RFC 2616) 
#!                                                                              Example: 'Accept:text/plain'
#! @system_property advantage___accountservice_war_rest_api_character_set: Character encoding to be used for the HTTP 
#!                                                                         request body
#! @system_property advantage___accountservice_war_rest_api_base_url: Base URL for the HTTP calls
#!!#
########################################################################################################################
namespace: ''
properties:
  - advantage___accountservice_war_rest_api_auth_type:
      value: Anonymous
      sensitive: false
  - advantage___accountservice_war_rest_api_additional_headers:
      value: 'Accept: application/json'
      sensitive: false
  - advantage___accountservice_war_rest_api_character_set:
      value: UTF-8
      sensitive: false
  - advantage___accountservice_war_rest_api_base_url:
      value: 'http://www.advantageonlineshopping.com/accountservice'
      sensitive: false
