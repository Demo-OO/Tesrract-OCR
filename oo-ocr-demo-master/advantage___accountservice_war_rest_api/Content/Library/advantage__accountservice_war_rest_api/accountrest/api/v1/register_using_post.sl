########################################################################################################################
#!!
#! @input account_create_request: accountCreateRequest
#! @input url: The URL for the HTTP call
#! @input authentication_auth_type: Authentication type (Anonymous/Basic/Digest/Bearer)
#! @input request_character_set: Character encoding to be used for the HTTP request body
#! @input request_additional_headers: List containing the headers to use for the request separated by new line (CRLF); header name - value pair will be separated by ":". Format: According to HTTP standard for headers (RFC 2616) Example: 'Accept:text/plain'
#!
#! @output return_result: Response of the operation.
#! @output error_message: Return_result when the return_code is non-zero (e.g. network or other failure).
#! @output status_code: Status code of the HTTP call.
#! @output return_code: '0' if success, '-1' otherwise.
#! @output response_headers: Response headers string from the HTTP Client REST call.
#!
#! @result SUCCESS: Operation succeeded (statusCode is contained in valid_http_status_codes list).
#! @result FAILURE: Operation failed (statusCode is not contained in valid_http_status_codes list).
#!!#
########################################################################################################################
namespace: advantage__accountservice_war_rest_api.accountrest.api.v1
flow:
  name: register_using_post
  inputs:
    - account_create_request: |-
        ${'''
        {
          "accountType": "USER",
          "address": "Za Brumlovkou 5",
          "allowOffersPromotion": true,
          "cityName": "Prague",
          "country": "UNITED_KINGDOM_UK",
          "email": "petr.panuska@mf.com",
          "firstName": "Petr",
          "lastName": "Panuska",
          "loginName": "pepan6",
          "password": "Cloud@123",
          "phoneNumber": "123456",
          "stateProvince": "None",
          "zipcode": "13000"
        }
        '''}
    - url: "${get_sp('advantage___accountservice_war_rest_api_base_url')+'/accountrest/api/v1/register'}"
    - authentication_auth_type: "${get_sp('advantage___accountservice_war_rest_api_auth_type')}"
    - request_character_set: "${get_sp('advantage___accountservice_war_rest_api_character_set')}"
    - request_additional_headers: "${get_sp('advantage___accountservice_war_rest_api_additional_headers')}"
  workflow:
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - method: POST
            - content_type: application/json
            - body: '${account_create_request}'
            - url: '${url}'
            - auth_type: '${authentication_auth_type}'
            - request_character_set: '${request_character_set}'
            - character_set: '${request_character_set}'
            - headers: "${''+request_additional_headers}"
        publish:
          - return_result
          - error_message
          - status_code
          - return_code
          - response_headers
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - return_result: '${return_result}'
    - error_message: '${error_message}'
    - status_code: '${status_code}'
    - return_code: '${return_code}'
    - response_headers: '${response_headers}'
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      http_client_action:
        x: 100
        'y': 150
        navigate:
          c065fdb4-ee98-dfa3-ed11-92d49a5d6fa4:
            targetId: 82aa5059-458e-9ac0-ab96-f51eb6309e02
            port: SUCCESS
    results:
      SUCCESS:
        82aa5059-458e-9ac0-ab96-f51eb6309e02:
          x: 400
          'y': 150
